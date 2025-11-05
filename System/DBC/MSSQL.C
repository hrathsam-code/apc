/***********************************************************************/
/*                            DB/C interpreter                         */
/*              (c) Copyright  1991  Subject, Wills & Company          */
/*            DB/C release 7.0 - Microsoft SQL Server Interface        */
/***********************************************************************/

/*********** MS-DOS Compile/Link Instructions **********/
/* Compile with Microsoft C 5.1 or later               */
/*       cl -AL -Oati -Gs -c mssql.c                   */
/* then replace sqlnull with mssql in the file DBCLINK */
/*       link /E @dbclink,.\dbc.exe,,rldblib;          */
/***********End MS-DOS Compile/Link Instructions *******/

/*********** OS/2 Compile/Link Instructions *********************************/
/* Compile with Microsoft C 6.0ax or later                                  */
/* cl -Alfu -Gs2 -Zp -Oati -c -MD -DDLL -DOS2=1 mssql.c                     */
/* link /NOD/NOI mssql+crtdll,dbcsql.dll,,doscalls dbcdll pdblib,dbcsql.def */
/**/
       /* DBCSQL.DEF */
/*===========================*/
/* LIBRARY DBCSQL            */
/* PROTMODE                  */
/* CODE LOADONCALL           */
/* DATA LOADONCALL NONSHARED */
/* EXPORTS                   */
/*      _dbcsqlx             */
/*      _dbcsqlm             */
/*===========================*/
/*********** End OS/2 Compile/Link Instructions *****************************/

#include <stdio.h>
#include <memory.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define DBMSDOS
#include "j:\sqlp\dblib\include\sqlfront.h"
#include "j:\sqlp\dblib\include\sqldb.h"


int err_handler( DBPROCESS * dbproc, int severity, int dberr, int oserr, char *dberrstr, char *oserrstr);
int msg_handler( DBPROCESS * dbproc, DBINT msgno, int msgstate, int severity, char * msgtext);

/* Defines */
#define llhh(p) (*(unsigned int *)(p))
/* CNLEN should be in NETCONS.H - I am using the value from pg 847 of Microsoft LAN Manager Programmer's Referemnce */
#define CNLEN 15
/* MAXCURSORS = maxium number of cursors allowed */
#define MAXCURSORS 20

/* Struct definitions */
struct SCURSTAB {
	DBPROCESS * cursor;
	char	name[32];
};

/* Function Prototypes */
int dbcsqlx(unsigned char *, unsigned char **, unsigned char **);
char * dbcsqlm(long);
static void build(unsigned char **);
static void makeform(unsigned char *, unsigned char *);
static void cvtvar(unsigned char *, unsigned char *);
static void chkvar(unsigned char *);
static int chktyp(unsigned char *);
static DBPROCESS * getcurs(unsigned char *);

/* External declarations */
extern void death(int);
#if OS2
extern void _loadds setflags(short, short, short, short);
#else
extern int near equal, near less, near over, near eos;
#endif

/* Static Variables */
static LOGINREC *dbclogin; /* Login pointer*/
static DBPROCESS *defproc; /* Default Connection */
static char server[CNLEN+1];
static char far buffer[8200];
static int formp, lenp, phylen, headlen;
static struct SCURSTAB curstab[MAXCURSORS];
static char message[101];

/* Global Routines */
int dbcsqlx(adr1, adr2, adr3)  /* sqlexec verb */
unsigned char * adr1;
unsigned char ** adr2;
unsigned char ** adr3;
{
	int len, col;
	RETCODE retcode;
	DBCHAR * ptr, * command;
	DBPROCESS * cursor;

	buffer[0] = 0xf0;
	buffer[5] = 0x00; buffer[6] = 0x20;
	cvtvar(adr1, buffer);
	command = &buffer[7];
	command[llhh(&buffer[3])] = 0;
	if (!buffer[1] && !buffer[2]) command[0] = 0;
	cursor = getcurs(buffer);

	if (!strnicmp(command, "CONNECT", 7)) {
		dberrhandle(err_handler);
		dbmsghandle(msg_handler);
		server[0] = 0;
		if (dbclogin != NULL) dbexit();
		dbclogin = dblogin();
		if (dbclogin == NULL) retcode = FAIL;
		else {
			if (adr2[0] != NULL) {
				cvtvar(adr2[0], buffer);
				command[llhh(&buffer[3])] = 0;
				if (!buffer[1] && !buffer[2]) command[0] = 0;
				DBSETLUSER(dbclogin, command);
				if (adr2[1] != NULL) {
					cvtvar(adr2[1], buffer);
					command[llhh(&buffer[3])] = 0;
					if (!buffer[1] && !buffer[2]) command[0] = 0;
					DBSETLPWD(dbclogin, command);
					if (adr2[2] != NULL) {
						cvtvar(adr2[2], buffer);
						command[llhh(&buffer[3])] = 0;
						if (!buffer[1] && !buffer[2]) command[0] = 0;
						memcpy(server, command, (int) llhh(&buffer[3]));
					}
				}
			}
			defproc = dbopen(dbclogin, server);
			if (defproc == NULL) {
				retcode = FAIL;
			}
		}
	}
	else if (!strnicmp(command, "DISCONNECT", 10)) {
		dbexit(); /* close all connections */
		retcode = SUCCEED;
	}
	else if (cursor == NULL) retcode = FAIL;
	else if (!strnicmp(command, "FETCH", 5)) {
		if ((retcode = dbnextrow(cursor)) != NO_MORE_ROWS) {
			for (col = 1; adr3[col - 1] != NULL; col++) {
				ptr = dbdata(cursor, col);
				if (ptr != NULL) {
					len = (int) dbdatlen(cursor, col);
					strncpy(&command[7], ptr, len);
					command[0] = 0xf0;
					command[1] = 1;
					command[2] = 0;
					command[3] = command[5] = (char) (len & 0xff);
					command[4] = command[6] = (char) ((len >> 8) & 0xff);
				}
				else {
					command[0] = command[1] = command[2] = 0;
				}
				cvtvar(command, adr3[col - 1]);
			}
		}
	}
	else { /* Not intercepted so pass through to SQL Server */
		build(adr2);
		retcode = dbcmd(cursor, command);
		if (retcode != FAIL) {
			retcode = dbsqlexec(cursor);
			if (retcode != FAIL) {
				retcode = dbresults(cursor);
			}
		}
	}
	if (retcode == NO_MORE_ROWS) return(100);
	return((retcode != FAIL) ? 0 : 1); /* CODE GOES HERE for proper error value */
}

char * dbcsqlm(code)  /* sqlmsg verb */
long code;
{
	return(message);
}

/* subroutine to do variable substitution */
static void build(arglist)
unsigned char *arglist[];
{
	int len, cmdpos, argnum, i, j, lenstr, restlen;
	char work[508];

	len = llhh(&buffer[3]);

	len += 7;
	for (cmdpos = 7, argnum = 0; cmdpos < len; cmdpos++) {
		if (buffer[cmdpos] == ':') {
			/* convert arglist[num] to a strptr */
			work[0] = 0xf0; work[6] = 0x01; work[5] = 0xfc;
			cvtvar(arglist[argnum], work);
			/* set lenstr = length of strptr */
			lenstr = llhh(&work[3]);
			if (!llhh(&work[1])) lenstr = work[7] = 0;

			/* set i = next non-numeric in buffer after cmdpos */
			for (i = cmdpos + 1; isdigit(buffer[i]); i++);

			j = 8200 - (len + lenstr);
			restlen = len - i + 1;
			if (j < 0) {
				restlen += j;
				len = 8200;
			}
			else len += (lenstr - (i - cmdpos));
			memmove(&buffer[cmdpos + lenstr], &buffer[i], restlen);

			memcpy(&buffer[cmdpos], &work[7], lenstr);
			cmdpos += lenstr - 1;
			argnum++;
		}
	}
}

static void makeform(nvar, formvar)  /* make a form variable from the numeric variable at nvar */
/* set formp, lenp, phylen, headlen */
unsigned char * nvar;
unsigned char * formvar;
{
	int i, j, k, lft, rgt, zeroflg;
	unsigned char work[36], *ptr;
	long int lwork;
	double y;

	if (*nvar == 252) {  /* its an integer variable */
		lft = nvar[1];
		memcpy((unsigned char *) &lwork, &nvar[2], 4);
		ltoa(lwork, work, 10);
		i = strlen(work);
		if (i < lft) {
			memset(&formvar[1], ' ', lft - i);
			memcpy(&formvar[lft - i + 1], work, i);
		}
		else memcpy(&formvar[1], &work[i - lft], lft);
	}
	else if (*nvar >= 248 && *nvar <= 251) {  /* its a float variable */
		zeroflg = TRUE;
		lft = ((nvar[0] << 3) & 0x18) | (nvar[1] >> 5);
		rgt = nvar[1] & 0x1f;
		memcpy((unsigned char *) &y, &nvar[2], 8);
		ptr = (unsigned char *)fcvt(y, rgt, &j, &k);
		i = (j < 0 ? 0 : j);
		if (lft) {
			if (i < lft) {
				if (k) k = lft - i;
				memset(&formvar[1], ' ', lft - i);
				if (i) {
					memcpy(&formvar[lft - i + 1], ptr, i);
					zeroflg = FALSE;
				}
				else if (!rgt) formvar[lft] = '0';
			}
			else {
				memcpy(&formvar[1], &ptr[i - lft], lft);
				k = 0;
			}
		}
		ptr += i;
		if (rgt) {
			formvar[++lft] = '.';
			if (j < 0) {
				memset(&formvar[lft + 1], '0', -j);
				lft -= j;
				rgt += j;
			}
			while (rgt--) {
				if (*ptr != '0') zeroflg = FALSE;
				formvar[++lft] = *ptr++;
			}
		}
		if (!zeroflg && k) formvar[k] = '-';
	}
	else if ((*nvar & 0xe0) == 0x80) {  /* form variable */
		lft = nvar[0] & 0x1f;
		memcpy(&formvar[1], &nvar[1], lft);
	}
	else return;

	formvar[0] = (unsigned char) (0x80 | lft);
	formp = headlen = 1;
	phylen = lenp = lft;
}

static void cvtvar(src, dest)  /* move one variable to another variable */
/* all flags affected */
unsigned char *src, *dest;
{
	int i, j, n, m;
	int stype, dtype;
	int srcformp, srclenp, srcphylen, srcsp, destphylen, destsp;
	int numflg, zeroflg, lessflg, rd, rs;
	unsigned char c, *ptr, wrk1[64], wrk2[32];
	long x1;
	double y1;

	if (src[0] < 128) {  /* small dim */
		stype = 1;
		srcformp = src[0];
		srcsp = srcformp + 2;
		srclenp = src[1];
		srcphylen = src[2];
	}
	else if ((src[0] & 0xe0) == 128) stype = 3;  /* form */
	else if (src[0] == 240) {  /* big dim */
		stype = 2;
		srcformp = (src[2] << 8) + src[1];
		srcsp = srcformp + 6;
		srclenp = (src[4] << 8) + src[3];
		srcphylen = (src[6] << 8) + src[5];
	}
	else if (src[0] == 252) stype = 4;  /* integer */
	else if (src[0] >= 248 && src[0] <= 251) stype = 5;  /* float */
	else return;

	if (dest[0] < 128) {  /* small dim */
		dtype = 1;
		destphylen = dest[2];
		destsp = 3;
	}
	else if ((dest[0] & 0xe0) == 128) dtype = 3;  /* form */
	else if (dest[0] == 240) {  /* big dim */
		dtype = 2;
		destphylen = (dest[6] << 8) + dest[5];
		destsp = 7;
	}
	else if (dest[0] == 252) dtype = 4;  /* integer */
	else if (dest[0] >= 248 && dest[0] <= 251) dtype = 5;  /* float */
	else return;

	if (dtype < 3) {  /* destination is char var */
#if OS2
		setflags(0, 2, 2, 2);
#else
		eos = FALSE;
#endif
		if (stype < 3) {
			if (!srcformp) {
				if (dtype == 1) dest[0] = 0;
				else dest[1] = dest[2] = 0;
				return;
			}
			n = srclenp - srcformp + 1;
		}
		else {  /* number variable */
			if (stype > 3) {  /* int or form */
				makeform(src, wrk2);
				src = wrk2;
			}
			n = src[0] & 0x1f;
			srcsp = 1;
		}
		if (destphylen < n) {
#if OS2
			setflags(1, 2, 2, 2);
#else
			eos = TRUE;
#endif
			n = destphylen;
		}
		if (dtype == 1) {  /* small dim var */
			dest[0] = 1;
			dest[1] = (unsigned char) n;
		}
		else {  /* large dim var */
			dest[1] = 1;
			dest[2] = 0;
			dest[3] = (unsigned char) n;
			dest[4] = (unsigned char) (n >> 8);
		}
		memcpy(&dest[destsp], &src[srcsp], n);
		return;
	}

	/* destination is some sort of numeric variable */
	if (stype < 3) {  /* source is char var */
		if (!chktyp(src)) {
#if OS2
			setflags(1, 2, 2, 2);
#else
			eos = TRUE;
#endif
			return;
		}
#if OS2
		setflags(FALSE, 2, 2, 2);
		numflg = FALSE;
#else
		eos = numflg = FALSE;
#endif
		n = srclenp - srcformp + 1;
		if (n > 31) n = 31;
	}

	if (dtype == 3) {  /* destination is a form variable */
		if (stype > 2) {  /* source is number var */
			if (stype > 3) {  /* int or form */
				makeform(src, wrk2);
				src = wrk2;
			}
			numflg = TRUE;
			n = src[0] & 0x1f;
			srcsp = 1;
		}
		memcpy(&wrk1[2], &src[srcsp], n);
		if (wrk1[++n] == '.') n--;  /* n=length of src & truncate trailing . */
		wrk1[1] = ' ';  /* wrk1[0] is not used, [1]=extra space for rounding */
		for (i = 0; i < n && wrk1[++i] != '.'; );  /* see if rounding will take phylenace */
		rs = n - i;  /* rs is number of right dec digits in src */
		m = dest[0] & 0x1f;  /* m is total length of dest */
		for (i = 0; i < m && dest[++i] != '.'; );
		rd = m - i;  /* rd is number of right dec digits in dest */
		if (rd < rs) {  /* must round the source */
			c = wrk1[n - rs + rd + 1];  /* c is rounding digit */
			if (c == '5') {
				j = rs - rd - 1;
				i = n - rs + rd + 2;
				while (j--) if (wrk1[i++] != '0') c = '6';
				if (c == '5') {  /* digits to right were zero */
					i = 0;
					while (wrk1[++i] == ' ');
					if (wrk1[i] != '-') c = '6';
				}
			}
			if (c > '5') {  /* round source */
				for (i = n - rs + rd; i > 0; i--) {
					if ((c = wrk1[i]) == '.') continue;
					else if (c >= '0' && c < '9') {
						wrk1[i] = c + 1;
						break;
					}
					else if (c == '9') wrk1[i] = '0';
					else if (c == ' ') {
						wrk1[i] = '1';
						break;
					}
					else if (c == '-') {
						wrk1[i--] = '1';
						if (i != 0) wrk1[i] = '-';
						break;
					}
				}
			}
			/* make the source shorter by however many digits we rounded */
			if (rd == 0) n = n - rs - 1;  /* drop dec point too */
			else n = n - rs + rd;
			rs = rd;
		}
		/* suppress leading zero in source */
		for (i = 1; i <= n; i++) {
			if (wrk1[i] == ' ') continue;
			else if (wrk1[i] == '-') {
				if (wrk1[i+1] == ' ' || wrk1[i+1] == '0') {
					wrk1[i+1] = '-';
				}
				else break;
			}
			else if (wrk1[i] != '0') break;
			wrk1[i] = ' ';
		}
		/* move characters from right to left */
		i = n;
		j = n = m;  /* save length of dest in n */
		lessflg = FALSE;
		zeroflg = TRUE;
		while (m--) {
			if (rd > rs) {
				dest[j--] = '0';
				if (!(--rd)) {  /* skip over dec pt */
					m--;
					j--;
				}
			}
			else if (i > 0) {
				c = dest[j--] = wrk1[i--];
				if (c == '-') {
					if (zeroflg) dest[j+1] = ' ';  /* rounded to 0 */
					else lessflg = TRUE;
				}
				if (zeroflg && c > '0' && c <= '9') zeroflg = FALSE;
			}
			else dest[j--] = ' ';
		}
		if (dest[n] == ' ') dest[n] = '0';
		if (numflg) {
#if OS2
			setflags(2, 0, lessflg, zeroflg);
#else
			over = FALSE;
			less = lessflg;
			equal = zeroflg;
#endif
		}
		if (i > 0 && wrk1[i] != ' ') {
			if (numflg) {
#if OS2
				setflags(2, 2, 2, 1);
#else
				over = TRUE;
#endif
				while (i > 0) if (wrk1[i--] == '-') {
#if OS2
					setflags(2, 2, 1, 2);
#else
					less = TRUE;
#endif
					break;
				}
			}
#if OS2
			else setflags(1, 2, 2, 2);
#else
			else eos = TRUE;
#endif
		}
		/* remove all leading zeros */
		for (i = 1; i < n && (dest[i] == '0' || dest[i] == ' ' || dest[i] == '-'); i++) {
			if (dest[i] == '-') {
				if (dest[i + 1] == '0' || dest[i + 1] == ' ') dest[i + 1] = '-';
				else break;
			}
			dest[i] = ' ';
		}
		return;
	}
	if (dtype == 4) {  /* destination is an integer variable */
		if (stype < 4) {  /* source is dim or form variable */
			if (stype == 3) {  /* source is a form variable */
				srcsp = 1;
				n = src[0] & 0x1f;
			}
			ptr = &src[srcsp + n];
			c = *ptr;
			*ptr = 0;
			x1 = atol(&src[srcsp]);
			*ptr = c;
		}
		else if (stype == 4) x1 = * (long *) &src[2];
		else if (stype == 5) x1 = (long) (* (double *) &src[2]);
		* (long *) &dest[2] = x1;
#if OS2
		setflags(2, (x1 != 0) , (x1 < 0) , 0);
#else
		equal = less = over = FALSE;
		if (!x1) equal = TRUE;
		else if (x1 < 0) less = TRUE;
#endif
		return;
	}
	if (dtype == 5) {  /* destination is a float variable */
		if (stype < 4) {  /* source is dim or form variable */
			if (stype == 3) {  /* source is a form variable */
				srcsp = 1;
				n = src[0] & 0x1f;
			}
			ptr = &src[srcsp + n];
			c = *ptr;
			*ptr = 0;
			y1 = atof(&src[srcsp]);
			*ptr = c;
		}
		else if (stype == 4) y1 = (double) (* (long *) &src[2]);
		else if (stype == 5) y1 = * (double *) &src[2];
		* (double *) &dest[2] = y1;
#if OS2
		setflags(2, (y1 == (double) 0), (y1 < (double) 0), 0);
#else
		equal = less = over = FALSE;
		if (y1 == (double) 0) equal = TRUE;
		else if (y1 < (double) 0) less = TRUE;
#endif
		return;
	}
}


static void chkvar(adr)  /* set formp, lenp, phylen and headlen */
unsigned char * adr;
{
	register int i;

	i = adr[0];
	if (i < 128) {  /* small dim */
		formp = i;
		lenp = adr[1];
		phylen = adr[2];
		headlen = 3;
	}
	else if (i < 160) {  /* form */
		formp = headlen = 1;
		phylen = lenp = i - 128;
	}
	else if (i == 240) {  /* large dim */
		formp = llhh(&adr[1]);
		lenp = llhh(&adr[3]);
		phylen = llhh(&adr[5]);
		headlen = 7;
	}
	else if (i == 252) {  /* integer */
		formp = lenp = -1;
		phylen = 4;
		headlen = 2;
	}
	else if (i >= 248 && i <= 251) {  /* float */
		formp = lenp = -1;
		phylen = 8;
		headlen = 2;
	}
	else formp = lenp = phylen = headlen = -1;
}

static int chktyp(s)  /* s is char variable, return TRUE or FALSE if valid number */
/* no flags affected */
unsigned char *s;
{
	int i, j, state;
	unsigned char c;

	chkvar(s);
	if (!formp) return(FALSE);
	i = formp + headlen - 1;
	j = lenp - formp + 1;
	if (j > 31) return(FALSE);
	if (j == 1 && s[i] == '.') return(FALSE);  /* "." */
	if (j == 2 && s[i] == '-' && s[i + 1] == '.') return(FALSE);  /* "-." */
	for (state = 0; j--; i++) {
		c = s[i];
		if (!state) {
			if (c == ' ') continue;
			else if (c == '-' || c >= '0' && c <= '9') state = 1;
			else if (c == '.') state = 2;
			else return(FALSE);
		}
		else if (state == 1) {
			if (c >= '0' && c <= '9') continue;
			else if (c == '.') state = 2;
			else return(FALSE);
		}
		else if (state == 2) {
			if (c >= '0' && c <= '9') continue;
			else return(FALSE);
		}
	}
	if (c == '-' || state == 0) return(FALSE);
	return(TRUE);
}

/* Routine to scan command strptr for the keyword USING */
/* If found the next word that follows USING is the CURSOR NAME */
/* If the cursor exists then a pointer is returned */
/* If the cursor does not exist then it is created and returned */
/* If USING is not specified then the default cursor 'defproc' is returned */
/* If a cursor cannot be allocated then NULL is returned */
static DBPROCESS * getcurs(unsigned char * strbuf)
{
	int i, upos, cpos, cursnum, namelen;
	DBPROCESS * cursptr;
	char * strptr;

	strptr = &strbuf[7];

	for (upos = 0; upos < strlen(strptr); upos++) {
		if ((strptr[upos] == 'u' || strptr[upos] == 'U') &&
			(!strnicmp(&strptr[upos], "USING", 5))) break;
	}
	if (upos == strlen(strptr)) cursptr = defproc;
	else {
		for (cpos = upos + 5; strptr[cpos] && strptr[cpos] != ' '; cpos++);
		while(strptr[cpos] == ' ') cpos++;
		if (!strptr[i]) cursptr = NULL;
		else {
			for (cursnum = 0; cursnum < MAXCURSORS; cursnum++) {
				if (curstab[cursnum].name[0] && !strncmp(&strptr[cpos], curstab[cursnum].name, strlen(curstab[cursnum].name))) {
					cursptr = curstab[cursnum].cursor;
					break;
				}
			}
			if (cursnum == MAXCURSORS) { /* create cursor */
				for (cursnum = 0; cursnum < MAXCURSORS && curstab[cursnum].name[0]; cursnum++);
				if (cursnum == MAXCURSORS) cursptr = NULL;
				else {
					cursptr = dbopen(dbclogin, server);
					if (cursptr != NULL) {
						for (i = cpos, namelen = 0; i < strlen(strptr) && strptr[i] != ' '; i++) {
							curstab[cursnum].name[namelen++] = toupper(strptr[i]);
						}
						curstab[cursnum].name[namelen] = 0;
						curstab[cursnum].cursor = cursptr;
						memmove(&strptr[upos], &strptr[i], strlen(&strptr[i]));
						i = llhh(&strbuf[3]) - (namelen + 6);
						llhh(&strbuf[3]) = i;
						strptr[i] = 0;
					}
				}
			}
		}
	}
	return(cursptr);
}

int err_handler(dbproc, severity, dberr, oserr, dberrstr, oserrstr)
DBPROCESS * dbproc;
int severity;
int dberr;
int oserr;
char *dberrstr;
char *oserrstr;
{
	strncpy(message, dberrstr, 100);
	return(INT_CANCEL);
}

int msg_handler( DBPROCESS * dbproc, DBINT msgno, int msgstate, int severity, char * msgtext)
{
	strncpy(message, msgtext, 100);
	return(0);
}
