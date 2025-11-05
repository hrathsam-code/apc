/*			    niocisam.c - native I/O routines for DB/C		*/
/*			 Copyright  1991  Subject, Wills & Company		*/

#include <isam.h>

#ifdef MSDOS
#undef MSDOS
#endif
#ifdef OS2
#undef OS2
#endif
#ifdef UNIX
#undef UNIX
#endif
#ifdef VMS
#undef VMS
#endif
#ifdef RMS
#undef RMS
#endif

/* only one of the following should be on */
#define MSDOS 1
#define OS2 0
#define UNIX 0
#define VMS 0
#define RMS 0

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>

#if MSDOS
#include <stdlib.h>
#include <malloc.h>
#include <sys\types.h>
#include <fcntl.h>
#include <sys\stat.h>
#include <dos.h>
#include <io.h>
#include <share.h>
#endif

#if OS2
#include <stdlib.h>
#include <sys\types.h>
#include <fcntl.h>
#include <os2.h>
#endif

#if UNIX
#if defined(__STDC__)
#include <stdlib.h>
#else
#include <memory.h>
#include <malloc.h>
#endif
#include <sys/types.h>
#include <fcntl.h>
#endif

#if VMS
#include <stdlib.h>
#include <types.h>
#include <file.h>
#endif

#if RMS
#include <stdlib.h>
#include <types.h>
#include <fcntl.h>
#include <unistd.h>
#include <diskio.h>
#include <$inc.h>
#include <$rms.h>
#include <$rmserrors.h>
#include <$rmsinfo.h>
#include <$rmssc386.h>
#endif

/* function prototype */
#if MSDOS | VMS
#define FNCPRO 1
#else
#define FNCPRO 0
#endif

#define DBCNIO
#include "nio.h"

#if MSDOS
#define NEAR near
#else
#define NEAR
#endif

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

#define ERR_NOTOP (-21)  /* file not open */
#define ERR_EXCMF (-25)  /* exceed maximum files open */
#define ERR_BADTP (-27)  /* invalid file type */
#define ERR_NOEOR (-28)  /* no end of record mark or record too long */
#define ERR_BADIX (-33)  /* index file is invalid */
#define ERR_BADKY (-37)  /* invalid key */

#define NIOOPEN     100  /* default number of nio files structures */
#define MAXRECLEN  8192  /* set this to your maximium record length */
#define MAXKEYLN    121  /* C-Isam maximum keylength + 1 */
#define MAXNAME     100  /* do not modify */

/* open modes & lock flag */
#define EXCFLG  0x01
#define LCKFLG  0x02

/* index positioning flags */
#define INVALID    0x01
#define NEXTVALID  0x02
#define ALLVALID   0x04

/* lock modes */
#define NOLOCKS    0x01
#define DOLOCKS    0x02

#if (MAXNAME + 10 + NPARTS * 15 + 2) > 512
#define WORKSIZE (MAXNAME + 10 + NPARTS * 15 + 2)
#else
#define WORKSIZE 512
#endif

struct ntab {
	char typeflg;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;
} ;

struct nitab {				/* file access table */
	char rdflg;			/* flags for read */
	char lckflg;                    /* flags for lock */
	long recnum;			/* last record number */
	struct keydesc kdesc;		/* key descriptor */
	char key[MAXKEYLN];			/* index key */
} ;

struct nctab {				/* file access table */
	char opencnt;			/* open count */
	char openflg;			/* open flag */
	int reclen;			/* record length */
	int handle;			/* c-isam handle */
	int lasthndl;			/* last access */
	long lrucnt;			/* least recently used count */
	char name[MAXNAME];			/* file name */
} ;

struct worktab {
	char name1[MAXNAME];
	char name2[MAXNAME];
	struct keydesc key;
	unsigned char buf[WORKSIZE];
} ;

#if ((MAXNAME * 2) + (16 + NPARTS * 8) + WORKSIZE) > MAXRECLEN
#undef MAXRECLEN
#define MAXRECLEN ((MAXNAME * 2) + (16 + NPARTS * 8) + WORKSIZE)
#endif

/* global declarations */
extern int ioerror;
#if RMS
extern unsigned short int rmsErrno;
extern char __openMode;
#endif

/* global function declarations */
#if FNCPRO
extern int fioclru(void);
extern int miofixname(char *, char *, int);
extern int miogetenv(char *, char *);
extern char NEAR *miogetmem(int);
extern void miofree(char NEAR *);
#else
extern int fioclru();
extern int miofixname();
extern int miogetenv();
extern char NEAR *miogetmem();
extern void miofree();
#endif

/* local declarations */
static int ntabmax;
static int ntabhi = 0;
static struct ntab NEAR *ntable;
static long lrucnt;
static int opencnt;
static int openlmt;
#if MSDOS | OS2
static unsigned char far recbuf[MAXRECLEN + 3];
#else
static unsigned char recbuf[MAXRECLEN + 3];
#endif
#if MSDOS
unsigned char doserror[] = {
	255,      /* 0 = <no error> */
	EINVAL,   /* 1 = <invalid function code> */
	ENOENT,   /* 2 = <file not found> */
	ENOENT,   /* 3 = <path not found> */
	EMFILE,   /* 4 = <too many open files> */
	EACCES,   /* 5 = <access denied> */
	EBADF,    /* 6 = <invalid handle> */
	ENOMEM,   /* 7 = <arena trashed> */
	ENOMEM,   /* 8 = <not enough memory> */
	ENOMEM,   /* 9 = <invalid block> */
	E2BIG,    /* 10 = <bad environment> */
	ENOEXEC,  /* 11 = <bad format> */
	EINVAL,   /* 12 = <invalid access code> */
	EINVAL,   /* 13 = <invalid data> */
	255,      /* 14 = ??????? */
	ENOENT,   /* 15 = <invalid drive> */
	EACCES,   /* 16 = <current directory> */
	EXDEV,    /* 17 = <not same device> */
	ENOENT    /* 18 = <no more files> */
} ;
#endif
#if VMS
static char env[256];
#endif

/* local function declarations */
#if FNCPRO
static int niotouch(int);
static int niomakname(char *, char *, char *);
#else
static int niotouch();
static int niomakname();
#endif

/* return error codes for all routines */
/* -1 = general error */
/* -98 = value of iserrno or errno in ioerror */
/* -99 = fio error in ioerror */

/* nioopen:  return codes */
/* -2 = file not found */
/* -3 = access violation */

int nioopen(name, index, exclusive)
char *name;
int index, exclusive;
{
	static int firstflg;
	int i, j, nnum, handle, len, retval, saverror;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;
	struct worktab *workptr;
	struct dictinfo info;
#if MSDOS
	union REGS regs;
#endif

	workptr = (struct worktab *) recbuf;

/* allocate file table */
	if (!firstflg) {
#if MSDOS
		if (miogetenv("DBC_NIOHANDLE", workptr->buf)) {
			i = atoi(workptr->buf) + 5;
			if (i > 20) {
				regs.x.ax = 0x6700;
				regs.x.bx = i;
				intdos(&regs, &regs);
			}
		}
#endif
		ntabmax = 0;
		if (miogetenv("DBC_NIOOPEN", workptr->buf)) ntabmax = atoi(workptr->buf);
		if (ntabmax <= 0) ntabmax = NIOOPEN;
		ntable = (struct ntab NEAR *) miogetmem(ntabmax * sizeof(struct ntab));
		if (ntable == NULL) return(-99);
		openlmt = 9999;
		if (miogetenv("DBC_NIOLIMIT", workptr->buf)) {
			openlmt = atoi(workptr->buf);
			if (openlmt <= 0) openlmt = 9999;
		}
		firstflg = TRUE;
	}

/* find free ntable */
	for (nnum = 0; nnum < ntabhi && ntable[nnum].typeflg; nnum++) ;
	if (nnum == ntabmax) {
		ioerror = ERR_EXCMF;
		return(-99);
	}

	strcpy(workptr->name1, name);
	miofixname(workptr->name1, ".iif", 0);
	workptr->buf[0] = 0;
	if (opencnt >= openlmt) nioclru();

	handle = -1;
	while (niomakname(workptr->name1, workptr->buf, workptr->name2)) {
#if MSDOS
		do {
			i = _dos_open(workptr->name2, O_RDONLY | SH_DENYNO, &handle);
		} while ((i == 4 || i == 129) && nioclru() != -1);
		if (i) {
			if (i == 2 || i == 3 || i == 15 || i == 18) continue;
			if (i <= 18) errno = doserror[i];
			else if (i == 128) errno = EACCES;
			else if (i == 129) errno = ENFILE;
			else errno = 255;
			if (errno == EACCES) return(-3);
			ioerror = errno;
			return(-98);
		}
		i = MAXNAME + 10 + NPARTS * 15 + 2;
		if (_dos_read(handle, workptr->buf, i, &j)) j = 0;
		_dos_close(handle);
#endif

#if OS2
		do {
			handle = open(workptr->name2, O_RDONLY | O_BINARY);
		} while (handle == -1 && (errno == EMFILE || errno == ENFILE) && nioclru() != -1);
#endif
#if UNIX | VMS
		do {
			handle = open(workptr->name2, O_RDONLY);
		} while (handle == -1 && (errno == EMFILE || errno == ENFILE) && nioclru() != -1);
#endif
#if RMS
		__openMode = $xsmShare | $xobReadWriteAccess;
		do {
			handle = open(workptr->name2, O_RDONLY);
		} while (handle == -1 && (errno == EMFILE || errno == ENFILE) && nioclru() != -1);
		if (handle == -1 && errno == ENOENT && rmsErrno == $eFileBusy) errno = EACCES;
#endif
#if OS2 | UNIX | VMS | RMS
		if (handle == -1) {
			if (errno == ENOENT) continue;
			if (errno == EACCES) return(-3);
			ioerror = errno;
			return(-98);
		}
		i = MAXNAME + 10 + NPARTS * 15 + 2;
		j = read(handle, workptr->buf, i);
		close(handle);
#endif

		break;
	}
	if (handle == -1) return(-2);

	if (j != i || workptr->buf[0] != 'C' || workptr->buf[j - 2] != 0xfa || workptr->buf[j - 1] != 0xfb) {
		ioerror = ERR_BADIX;
		return(-99);
	}

	retval = -99;
	memset((char *) &workptr->key, 0, sizeof(struct keydesc));
	for (i -= 17, j = NPARTS - 1, len = 0; i >= MAXNAME + 10; i -= 15, j--) {
		workptr->buf[i + 15] = 0;
		workptr->key.k_part[j].kp_type = atoi(&workptr->buf[i + 10]);
		workptr->buf[i + 10] = 0;
		workptr->key.k_part[j].kp_leng = atoi(&workptr->buf[i + 5]);
		len += workptr->key.k_part[j].kp_leng;
		workptr->buf[i + 5] = 0;
		workptr->key.k_part[j].kp_start = atoi(&workptr->buf[i]);
	}
	workptr->buf[MAXNAME + 10] = 0;
	workptr->key.k_nparts = atoi(&workptr->buf[MAXNAME + 5]);
	workptr->buf[MAXNAME + 5] = 0;
	workptr->key.k_flags = atoi(&workptr->buf[MAXNAME]);
	workptr->buf[MAXNAME] = 0;

	strcpy(workptr->name1, &workptr->buf[1]);
	miofixname(workptr->name1, "", 1);
	workptr->buf[0] = 0;
	if (!exclusive) i = ISMANULOCK | ISINOUT;
	else i = ISEXCLLOCK | ISINOUT;

	handle = -1;
	while (niomakname(workptr->name1, workptr->buf, workptr->name2)) {
		for (j = 0; j < ntabhi; j++) {
			if (ntable[j].typeflg != 2) continue;
			ncptr = ntable[j].ncptr;
			if (!strcmp(workptr->name2, ncptr->name)) {
				if (((ncptr->openflg & EXCFLG) && !exclusive)
				   || (!(ncptr->openflg & EXCFLG) && exclusive)) {
					return(-3);
				}
				break;
			}
		}
		if (j < ntabhi) {
			niotouch(j);
			handle = ncptr->handle;
			if (handle == -1) {
				ioerror = ERR_NOTOP;
				return(-99);
			}
			break;
		}

		if (opencnt >= openlmt) nioclru();
		do {
			handle = isopen(workptr->name2, i);
		} while (handle == -1 && (iserrno == EMFILE || iserrno == ENFILE) && nioclru() != -1);
		if (handle == -1) {
			if (iserrno == ENOENT) continue;
			if (iserrno == EFLOCKED) return(-3);
			ioerror = iserrno;
			return(-98);
		}

		i = sizeof(struct nctab) - (MAXNAME - (strlen(workptr->name2) + 1)) * sizeof(char);
		ncptr = (struct nctab NEAR *) miogetmem(i);
		if (ncptr == NULL) {
			isclose(handle);
			return(-99);
		}
		memset((char *) ncptr, 0, i);
		opencnt++;
		break;
	}
	if (handle == -1) return(-2);

	if (isindexinfo(handle, &info, 0) == -1) {
		saverror = iserrno;
		retval = -98;
		goto nioopen6;
	}
	if (info.di_recsize > MAXRECLEN) {
		saverror = ERR_NOEOR;
		goto nioopen6;
	}

/* initialize the structure */
	i = sizeof(struct nitab) - (MAXKEYLN - len) * sizeof(char);
	niptr = (struct nitab NEAR *) miogetmem(i);
	if (niptr == NULL) {
		saverror = ioerror;
		goto nioopen6;
	}
	memset((char *) niptr, 0, i);

	for (i = 1; i <= info.di_nkeys; i++) {
		if (isindexinfo(handle, &niptr->kdesc, i) == -1) {
			saverror = iserrno;
			retval = -98;
			goto nioopen5;
		}
		if (workptr->key.k_nparts != niptr->kdesc.k_nparts) continue;
		if ((workptr->key.k_flags & ISDUPS) != (niptr->kdesc.k_flags & ISDUPS)) continue;
		if (memcmp(&workptr->key.k_part[0], &niptr->kdesc.k_part[0], workptr->key.k_nparts * sizeof(struct keypart))) continue;
		break;
	}
	if (i > info.di_nkeys) {  /* index key not found */
		saverror = ERR_BADKY;
		goto nioopen5;
	}

	niptr->rdflg = INVALID;
	niptr->key[0] = 0;
	niptr->recnum = -1;

	if (!ncptr->opencnt) {
		if (exclusive) ncptr->openflg |= EXCFLG;
		ncptr->handle = handle;
		ncptr->lasthndl = -1;
		ncptr->reclen = info.di_recsize;
		ncptr->lrucnt = lrucnt++;
		strcpy(ncptr->name, workptr->name2);
	}
	ncptr->opencnt++;

	ntable[nnum].niptr = niptr;
	ntable[nnum].ncptr = ncptr;
	ntable[nnum].typeflg = 2;

	if (nnum >= ntabhi) ntabhi = nnum + 1;
	return(nnum + 3);

/* C-ISAM native open error cleanup */
nioopen5:
	miofree((char NEAR *) niptr);
nioopen6:
	if (!ncptr->opencnt) {
		miofree((char NEAR *) ncptr);
		isclose(handle);
		opencnt--;
	}

/* restore ioerror and return */
	if (retval == -98 || retval == -99) ioerror = saverror;
	return(retval);
}

int nioclose(handle)
int handle;
{
	int retval;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;

	retval = 0;
	if (!--ncptr->opencnt) {
		if (ncptr->handle != -1) {
			if (ncptr->openflg & LCKFLG) isrelease(ncptr->handle);
			retval = isclose(ncptr->handle);
			opencnt--;
		}
		miofree((char NEAR *) ncptr);
	}
	else if (ncptr->lasthndl == handle) ncptr->lasthndl = -1;
	miofree((char NEAR *) niptr);

	ntable[handle].typeflg = 0;
	if (handle + 1 == ntabhi) ntabhi = handle;
	return(retval);
}

int niordseq(handle, buffer)
int handle;
unsigned char *buffer;
{
	ioerror = ERR_BADTP;
	return(-99);
}

int niowtseq(handle, buffer, length)
int handle;
unsigned char *buffer;
int length;
{
	ioerror = ERR_BADTP;
	return(-99);
}

int niordrec(handle, recnum, buffer)
int handle;
long int recnum;
unsigned char *buffer;
{
	ioerror = ERR_BADTP;
	return(-99);
}

int niowtrec(handle, recnum, buffer, length)
int handle;
long int recnum;
unsigned char *buffer;
int length;
{
	ioerror = ERR_BADTP;
	return(-99);
}

int niordkey(handle, key, buffer)
int handle;
unsigned char *key, *buffer;
{
	int i, j, k, lckflg;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	if (niotouch(handle) == -1) {
		ioerror = iserrno;
		return(-98);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;

	if (niptr->lckflg == DOLOCKS) lckflg = ISLCKW;
	else lckflg = 0;

	i = k = strlen(key);
	if (i || niptr->rdflg != ALLVALID || ncptr->lasthndl != handle) {
		if (i) {
			if (i > niptr->kdesc.k_len) i = niptr->kdesc.k_len;
			memcpy(niptr->key, key, i);
			if (i < niptr->kdesc.k_len) memset(&niptr->key[i], ' ', niptr->kdesc.k_len - i);
			niptr->key[niptr->kdesc.k_len] = 0;
		}
		else if (!niptr->key[0] || niptr->rdflg == NEXTVALID) {
			ioerror = ERR_BADKY;
			return(-99);
		}

		for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
			memcpy(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng);
			j += niptr->kdesc.k_part[i].kp_leng;
		}

		if (ncptr->lasthndl != handle) {
			ncptr->lasthndl = -1;
			if (isstart(ncptr->handle, &niptr->kdesc, 0, buffer, ISEQUAL) == -1) {
				if (iserrno == ENOREC) return(-2);
				ioerror = iserrno;
				return(-98);
			}
			ncptr->lasthndl = handle;
			i = ISCURR;
		}
		else i = ISEQUAL;

		if (!k && (niptr->kdesc.k_flags & ISDUPS)) {
			niptr->rdflg = INVALID;
			if (isread(ncptr->handle, buffer, i) == -1) {
				if (iserrno == ENOREC) return(-2);
				ioerror = iserrno;
				return(-98);
			}
			while (isrecnum < niptr->recnum) {
				if (isread(ncptr->handle, buffer, ISNEXT) == -1) {
					if (iserrno == EENDFILE) {
						niptr->rdflg = NEXTVALID;
						return(-2);
					}
					ioerror = iserrno;
					return(-98);
				}
				for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
					if (memcmp(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng)) break;
					j += niptr->kdesc.k_part[i].kp_leng;
				}
				if (i < niptr->kdesc.k_nparts) return(-2);
			}
			if (isrecnum > niptr->recnum) return(-2);
			i = ISCURR;
		}
	}
	else i = ISCURR;

	niptr->rdflg = INVALID;
	if (isread(ncptr->handle, buffer, i | lckflg) == -1) {
		if (iserrno == ENOREC) return(-2);
		ioerror = iserrno;
		return(-98);
	}

	for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
		memcpy(&niptr->key[j], &buffer[niptr->kdesc.k_part[i].kp_start], niptr->kdesc.k_part[i].kp_leng);
		j += niptr->kdesc.k_part[i].kp_leng;
	}
	if (lckflg) ncptr->openflg |= LCKFLG;
	niptr->rdflg = ALLVALID;
	niptr->recnum = isrecnum;
	i = ncptr->reclen;
	return(i);
}

int niordks(handle, buffer)
int handle;
unsigned char *buffer;
{
	int i, j, lckflg;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	if (niotouch(handle) == -1) {
		ioerror = iserrno;
		return(-98);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;

	if (niptr->lckflg == DOLOCKS) lckflg = ISLCKW;
	else lckflg = 0;

	if (ncptr->lasthndl != handle) {
		if (niptr->key[0]) {
			for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
				memcpy(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng);
				j += niptr->kdesc.k_part[i].kp_leng;
			}
			if ((niptr->kdesc.k_flags & ISDUPS) && niptr->rdflg != INVALID) i = ISGTEQ;
			else i = ISGREAT;
		}
		else i = ISFIRST;
		ncptr->lasthndl = -1;
		if (isstart(ncptr->handle, &niptr->kdesc, 0, buffer, i) == -1) {
			if (iserrno == ENOREC) {
				ncptr->lasthndl = handle;
				return(-2);
			}
			ioerror = iserrno;
			return(-98);
		}
		ncptr->lasthndl = handle;
		if (i == ISGTEQ) {
			niptr->rdflg = INVALID;
			if (isread(ncptr->handle, buffer, ISCURR) == -1) {
				ioerror = iserrno;
				return(-98);
			}
			while (isrecnum <= niptr->recnum) {
				for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
					if (memcmp(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng)) break;
					j += niptr->kdesc.k_part[i].kp_leng;
				}
				if (i < niptr->kdesc.k_nparts) break;
				if (isread(ncptr->handle, buffer, ISNEXT) == -1) {
					if (iserrno == EENDFILE) {
						niptr->rdflg = NEXTVALID;
						return(-2);
					}
					ioerror = iserrno;
					return(-98);
				}
			}
		}
		i = ISCURR;
	}
	else if (niptr->rdflg == INVALID) {
		if (niptr->key[0]) {
			for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
				memcpy(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng);
				j += niptr->kdesc.k_part[i].kp_leng;
			}
			i = ISGREAT;
		}
		else i = ISFIRST;
	}
	else i = ISNEXT;

	niptr->rdflg = INVALID;
	if (isread(ncptr->handle, buffer, i | lckflg) == -1) {
		if (iserrno == ENOREC) return(-2);
		if (iserrno == EENDFILE) {
			niptr->rdflg = NEXTVALID;
			return(-2);
		}
		ioerror = iserrno;
		return(-98);
	}

	for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
		memcpy(&niptr->key[j], &buffer[niptr->kdesc.k_part[i].kp_start], niptr->kdesc.k_part[i].kp_leng);
		j += niptr->kdesc.k_part[i].kp_leng;
	}
	if (lckflg) ncptr->openflg |= LCKFLG;
	niptr->rdflg = ALLVALID;
	niptr->recnum = isrecnum;
	i = ncptr->reclen;
	return(i);
}

int niordkp(handle, buffer)
int handle;
unsigned char *buffer;
{
	int i, j, lckflg;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	if (niotouch(handle) == -1) {
		ioerror = iserrno;
		return(-98);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;

	if (niptr->lckflg == DOLOCKS) lckflg = ISLCKW;
	else lckflg = 0;

	if (ncptr->lasthndl != handle) {
		if (!niptr->key[0]) return(-2);
		for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
			memcpy(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng);
			j += niptr->kdesc.k_part[i].kp_leng;
		}
		i = ISGTEQ;
		ncptr->lasthndl = -1;
		if (isstart(ncptr->handle, &niptr->kdesc, 0, buffer, i) == -1) {
			if (iserrno != ENOREC) {
				ioerror = iserrno;
				return(-98);
			}
			i = ISLAST;
		}
		ncptr->lasthndl = handle;
		if (i == ISGTEQ) {
			if ((niptr->kdesc.k_flags & ISDUPS) && niptr->rdflg != INVALID) {
				niptr->rdflg = INVALID;
				if (isread(ncptr->handle, buffer, ISCURR) == -1) {
					ioerror = iserrno;
					return(-98);
				}
				while (isrecnum < niptr->recnum) {
					for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
						if (memcmp(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng)) break;
						j += niptr->kdesc.k_part[i].kp_leng;
					}
					if (i < niptr->kdesc.k_nparts) break;
					if (isread(ncptr->handle, buffer, ISNEXT) == -1) {
						if (iserrno != EENDFILE) {
							ioerror = iserrno;
							return(-98);
						}
						break;
					}
				}
			}
			i = ISPREV;
		}
	}
	else if (niptr->rdflg == INVALID) {
		if (!niptr->key[0]) return(-2);
		for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
			memcpy(&buffer[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng);
			j += niptr->kdesc.k_part[i].kp_leng;
		}
		if (isread(ncptr->handle, buffer, ISGTEQ) == -1) {
			if (iserrno != ENOREC) {
				ioerror = iserrno;
				return(-98);
			}
			i = ISLAST;
		}
		else i = ISPREV;
	}
	else i = ISPREV;

	niptr->rdflg = INVALID;
	if (isread(ncptr->handle, buffer, i | lckflg) == -1) {
		if (iserrno == ENOREC) return(-2);
		if (iserrno == EENDFILE) {
			niptr->rdflg = NEXTVALID;
			return(-2);
		}
		ioerror = iserrno;
		return(-98);
	}

	for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
		memcpy(&niptr->key[j], &buffer[niptr->kdesc.k_part[i].kp_start], niptr->kdesc.k_part[i].kp_leng);
		j += niptr->kdesc.k_part[i].kp_leng;
	}
	if (lckflg) ncptr->openflg |= LCKFLG;
	niptr->rdflg = ALLVALID;
	niptr->recnum = isrecnum;
	i = ncptr->reclen;
	return(i);
}

int niowtkey(handle, buffer, length)
int handle;
unsigned char *buffer;
int length;
{
	int i, j, n;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	if (niotouch(handle) == -1) {
		ioerror = iserrno;
		return(-98);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;

	if (length < ncptr->reclen) memset(&buffer[length], ' ', ncptr->reclen - length);

/*** DO WE DO A ISSTART TO FORCE CURRENT POSITION FOR THIS HANDLE ***/
	if (iswrcurr(ncptr->handle, buffer) == -1) {
		if (iserrno == EDUPL) return(-2);
		ioerror = iserrno;
		return(-98);
	}

	for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
		memcpy(&niptr->key[j], &buffer[niptr->kdesc.k_part[i].kp_start], niptr->kdesc.k_part[i].kp_leng);
		j += niptr->kdesc.k_part[i].kp_leng;
	}
/*** WE COULD SET ntable[ncptr->lasthndl].niptr->rdflg = ALLVALID ***/
/*** IF NOT EQUAL -1 and ntable[ncptr->lasthndl].openflg == 2 ***/
	if (ncptr->lasthndl == handle) niptr->rdflg = ALLVALID;
	else ncptr->lasthndl = -1;
	niptr->recnum = isrecnum;
	n = length;
	return(n);
}

int nioupd(handle, buffer)
int handle;
unsigned char *buffer;
{
	int i, j, n;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;
	struct keydesc kdesc;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	if (niotouch(handle) == -1) {
		ioerror = iserrno;
		return(-98);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;
	if (!niptr->key[0]) {
		ioerror = ERR_BADKY;
		return(-99);
	}

	if (ncptr->lasthndl == handle && niptr->rdflg == ALLVALID) {
		niptr->rdflg = INVALID;
		if (isrewcurr(ncptr->handle, buffer) == -1) {
			if (iserrno == EDUPL) return(-2);
			if (iserrno != ELOCKED) {
				ioerror = iserrno;
				return(-98);
			}
			if (isread(ncptr->handle, recbuf, ISCURR | ISLCKW) == -1) {
				ioerror = iserrno;
				return(-98);
			}
			if (isrewcurr(ncptr->handle, buffer) == -1) {
				ioerror = iserrno;
				return(-98);
			}
			if (!(ncptr->openflg & LCKFLG)) isrelease(ncptr->handle);
		}
		niptr->rdflg = ALLVALID;
	}
	else {
/*** COULD FORCE ISSTART TO GET A CURRENT RECORD ***/
		niptr->rdflg = INVALID;
		if (isrewrec(ncptr->handle, niptr->recnum, buffer) == -1) {
			if (iserrno != ELOCKED) {
				ioerror = iserrno;
				return(-98);
			}
			isrecnum = niptr->recnum;
			memcpy(&kdesc, &niptr->kdesc, sizeof(struct keydesc));
			kdesc.k_nparts = 0;
			ncptr->lasthndl = -1;
			if (isstart(ncptr->handle, &kdesc, 0, NULL, ISEQUAL) == -1) {
				ioerror = iserrno;
				return(-98);
			}
			if (isread(ncptr->handle, recbuf, ISCURR | ISLCKW) == -1) {
				ioerror = iserrno;
				return(-98);
			}
			if (isrewcurr(ncptr->handle, buffer) == -1) {
				ioerror = iserrno;
				return(-98);
			}
			if (!(ncptr->openflg & LCKFLG)) isrelease(ncptr->handle);
		}
	}

	for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
		memcpy(&niptr->key[j], &buffer[niptr->kdesc.k_part[i].kp_start], niptr->kdesc.k_part[i].kp_leng);
		j += niptr->kdesc.k_part[i].kp_leng;
	}
	n = 0;
	return(n);
}

int niodel(handle, key)
int handle;
unsigned char *key;
{
	int i, j, lckflg;
	struct nitab NEAR *niptr;
	struct nctab NEAR *ncptr;

	handle -= 3;
	if (handle < 0 || handle >= ntabhi || (ntable[handle].typeflg != 1 && ntable[handle].typeflg != 2)) {
		ioerror = ERR_NOTOP;
		return(-99);
	}
	if (niotouch(handle) == -1) {
		ioerror = iserrno;
		return(-98);
	}
	niptr = ntable[handle].niptr;
	ncptr = ntable[handle].ncptr;

	if (ncptr->openflg & EXCFLG) lckflg = 0;
	else lckflg = ISLCKW;

/*** COULD ALSO TRY TO DELETE BY RECORD NUMBER ***/
	i = strlen(key);
	if (i || niptr->rdflg != ALLVALID || ncptr->lasthndl != handle) {
		if (i) {
			if (i > niptr->kdesc.k_len) i = niptr->kdesc.k_len;
			memcpy(niptr->key, key, i);
			if (i < niptr->kdesc.k_len) memset(&niptr->key[i], ' ', niptr->kdesc.k_len - i);
			niptr->key[niptr->kdesc.k_len] = 0;
		}
		else if (!niptr->key[0] || niptr->rdflg == NEXTVALID) {
			ioerror = ERR_BADKY;
			return(-99);
		}

		for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
			memcpy(&recbuf[niptr->kdesc.k_part[i].kp_start], &niptr->key[j], niptr->kdesc.k_part[i].kp_leng);
			j += niptr->kdesc.k_part[i].kp_leng;
		}

		if (ncptr->lasthndl != handle) {
			ncptr->lasthndl = -1;
			if (isstart(ncptr->handle, &niptr->kdesc, 0, recbuf, ISEQUAL) == -1) {
				if (iserrno == ENOREC) return(-2);
				ioerror = iserrno;
				return(-98);
			}
			ncptr->lasthndl = handle;
			i = ISCURR;
		}
		else i = ISEQUAL;
	}
	else i = ISCURR;

	niptr->rdflg = INVALID;
	if (isread(ncptr->handle, recbuf, i | lckflg) == -1) {
		if (iserrno == ENOREC) return(-2);
		ioerror = iserrno;
		return(-98);
	}

	if (isdelcurr(ncptr->handle) == -1) {
		if (lckflg && !(ncptr->openflg & LCKFLG)) isrelease(ncptr->handle);
		ioerror = iserrno;
		return(-98);
	}

	if (lckflg && !(ncptr->openflg & LCKFLG)) isrelease(ncptr->handle);
	for (i = 0, j = 0; i < niptr->kdesc.k_nparts; i++) {
		memcpy(&niptr->key[j], &recbuf[niptr->kdesc.k_part[i].kp_start], niptr->kdesc.k_part[i].kp_leng);
		j += niptr->kdesc.k_part[i].kp_leng;
	}
	niptr->rdflg = NEXTVALID;
	niptr->recnum = isrecnum;
	return(0);
}

int niolck(handle)
int *handle;
{
	int i, j, k;

	for (i = 0, k = 0; handle[i]; i++) {
		j = handle[i] - 3;
		if (j < 0 || j >= ntabhi || ntable[j].typeflg != 2) {
			while (i--) (ntable[handle[i] - 3].niptr)->lckflg = NOLOCKS;
			ioerror = ERR_NOTOP;
			return(-99);
		}
		if ((ntable[j].ncptr)->openflg & EXCFLG) continue;
		(ntable[j].niptr)->lckflg = DOLOCKS;
	}
	return(0);
}

int nioulck()
{
	int i, retval;
	struct nctab NEAR *ncptr;

	retval = 0;
	for (i = 0; i < ntabhi; i++) {
		if (ntable[i].typeflg != 2) continue;
		(ntable[i].niptr)->lckflg = NOLOCKS;
		ncptr = ntable[i].ncptr;
		if (!(ncptr->openflg & LCKFLG)) continue;
		if (isrelease(ncptr->handle)) retval = -1;
		ncptr->openflg &= ~LCKFLG;
	}
	return(retval);
}

int nioclru()
{
	static int depth;
	int i, j, k, n;
	struct nctab NEAR *ncptr;

	if (depth) return(-1);
	i = j = k = -1;
	for (n = 0; n < ntabhi; n++) {
		if (ntable[n].typeflg != 2) continue;
		ncptr = ntable[n].ncptr;
		if (ncptr->handle == -1) continue;
		if (ncptr->openflg & EXCFLG) {
			if (i == -1 || ncptr->lrucnt < (ntable[i].ncptr)->lrucnt) i = n;
		}
		else if (ncptr->openflg & LCKFLG) {
			if (j == -1 || ncptr->lrucnt < (ntable[j].ncptr)->lrucnt) j = n;
		}
		else if (k == -1 || ncptr->lrucnt < (ntable[k].ncptr)->lrucnt) k = n;
	}
	if (k != -1) n = k;
	else if (j != -1) n = j;
	else if (i != -1) n = i;
	else {
		depth++;
		i = fioclru();
		depth--;
		return(i);
	}

	ncptr = ntable[n].ncptr;
	if (ncptr->openflg & LCKFLG) {
		isrelease(ncptr->handle);
		ncptr->openflg &= ~LCKFLG;
	}
	isclose(ncptr->handle);
	ncptr->handle = -1;
	opencnt--;
	return(0);
}

static int niotouch(nnum)
int nnum;
{
	int i, handle;
	struct nctab NEAR *ncptr;

	ncptr = ntable[nnum].ncptr;
	ncptr->lrucnt = lrucnt++;
	if (ncptr->handle != -1) return(0);
	if (opencnt >= openlmt) nioclru();
	if (opencnt >= openlmt) nioclru();  /* yes, try it twice */

	if (ncptr->openflg & EXCFLG) i = ISEXCLLOCK | ISINOUT;
	else i = ISMANULOCK | ISINOUT;

	do {
		handle = isopen(ncptr->name, i);
	} while (handle == -1 && (iserrno == EMFILE || iserrno == ENFILE) && nioclru() != -1);

	if (handle == -1) return(-1);
	ncptr->handle = handle;
	opencnt++;
	return(0);
}

static int niomakname(name, path, dest)
char *name, *path, *dest;
{
	int i, j;
#if VMS
	char c;
#endif

	if (!path[0]) {  /* check for directory or drive specification */
		j = strlen(name);

#if RMS
	/* convert '.' to a '/' */
		for (i = 0; i < j && name[i] != '.'; i++);
		if (name[i] == '.') name[i] = '/';
#endif

	/* remove trailing period from name */
		if (j && name[j - 1] == '.') name[--j] = 0;
		if (!j) return(FALSE);

#if MSDOS | OS2
		for (i = 0; i < j && name[i] != '\\' && name[i] != ':' && name[i] != '/'; i++);
#endif

#if UNIX
		for (i = 0; i < j && name[i] != '/'; i++);
#endif

#if VMS
		for (i = 0; i < j && name[i] != ']' && name[i] != ':' && name[i] != '['; i++);
#endif

#if RMS
		for (i = 0; i < j && name[i] != ':'; i++);
#endif

		if (i == j) miogetenv("DBC_FILEPATH", path);
	}

	i = j = 0;
	while (path[j] == ' ') j++;
	while (path[j] && path[j] != ';') {
		dest[i++] = path[j];
		path[j++] = ' ';
	}
	if (path[j] == ';') path[j] = ' ';
	if (i) {
#if MSDOS | OS2
		if (dest[i - 1] != '\\' && dest[i - 1] != ':' && dest[i - 1] != '/') dest[i++] = '\\';
#endif

#if UNIX
		if (dest[i - 1] != '/') dest[i++] = '/';
#endif

#if VMS
		if (dest[i - 1] != ']' && dest[i - 1] != ':') {
			c = ':';
			for (j = 0; j < i; j++) if (dest[j] == '[') {
				c = ']';
				break;
			}
			dest[i++] = c;
		}
#endif

#if MSDOS | OS2 | UNIX | VMS
		strcpy(&dest[i], name);
#endif

#if RMS
		j = strlen(name);
		if (dest[0] != ':') j++;
		memmove(&dest[j], dest, i + 1);
		if (dest[j] != ':') dest[--j] = ':';
		memcpy(dest, name, j);
#endif
	}
	else {
		if (!path[j]) {
			if (j) return(FALSE);
			path[0] = ' ';
			path[1] = 0;
		}
		strcpy(dest, name);
	}
#if MSDOS | OS2 | VMS
	for (i = 0; dest[i]; i++) dest[i] = toupper(dest[i]);
#endif
	return(TRUE);
}
