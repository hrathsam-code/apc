#include <stdio.h>
#include <stddef.h>
#include <memory.h>
#include <fcntl.h>
#include <types.h>
#include <stat.h>
#include <io.h>
#include <errno.h>

/*************** DEFINES ***************/
#define RECSIZE	512  /* DO NOT MAKE RECSIZE BIGGER THAN 8192 */
#define MAXOPEN 20

/*************** File table ************/
struct ntab {
	int	fd;
	long	filepos;
	char	openflg;
};

/*************** Global Variables ***************/
static int ntabhi = 0;
static struct ntab ntable[MAXOPEN];

extern int nioopen(unsigned char *, int, int);
extern int nioclose(int);
extern int niordseq(int, unsigned char *);
extern int niowtseq(int, unsigned char *, int);
extern int niordrec(int, long, unsigned char *);
extern int niowtrec(int, long, unsigned char *, int);
extern int niordkey(int, unsigned char *, unsigned char *);
extern int niordks(int, unsigned char *);
extern int niordkp(int, unsigned char *);
extern int niowtkey(int, unsigned char *, int);
extern int nioupd(int, unsigned char *);
extern int niodel(int, unsigned char *);
extern int niolck(int *);
extern int nioulck(void);

/*************** Code Section ***************/
int nioopen(name, index, exclusive)
unsigned char *name;
int index;
int exclusive;
{
	int handle;

/* find free ntable */
	for (handle = 0; handle < ntabhi && ntable[handle].openflg; handle++) ;
	if (handle == MAXOPEN) {
		errno = ENFILE;
		return(-1);
	}

	ntable[handle].fd = open(name, O_RDWR | O_BINARY); /* open the file read/write */
	if (ntable[handle].fd == -1) {
		/* open failed */
		if (errno == ENOENT) return(-2); /* file not found */
		else return(-1); /* some other error */
	}
	ntable[handle].openflg = 1;
	ntable[handle].filepos = 0L;
	if (handle >= ntabhi) ntabhi = handle + 1;
	return(handle + 1); /* return file handle */
}

int nioclose(handle)
int handle;
{
	handle--;
	if (handle < 0 || handle >= ntabhi || !ntable[handle].openflg) {
		errno = EBADF;
		return(-1);
	}

	/* reset open flag */
	ntable[handle].openflg = 0;

	return(close(ntable[handle].fd));
}

int niordseq(handle, buffer)
int handle;
unsigned char *buffer;
{
	int nbytes;

	handle--;
	if (handle < 0 || handle >= ntabhi || !ntable[handle].openflg) {
		errno = EBADF;
		return(-1);
	}

	nbytes = read(ntable[handle].fd, buffer, RECSIZE);
	if (nbytes > 0) {
		ntable[handle].filepos += nbytes;
		return(nbytes); /* Successful Read */
	}
	if (nbytes == 0) return(-2); /* Read at EOF */
	return(-1); /* Some other error has occured */
}

int niowtseq(handle, buffer, length)
int handle;
unsigned char *buffer;
int length;
{
	int obytes;

	handle--;
	if (handle < 0 || handle >= ntabhi || !ntable[handle].openflg) {
		errno = EBADF;
		return(-1);
	}

	obytes = write(ntable[handle].fd, buffer, length);
	if (obytes == length) {
		ntable[handle].filepos += obytes;
		return(obytes); /* Successful Read */
	}
	return(-1); /* Bad Write */
}

int niordrec(handle, recnum, buffer)
int handle;
long recnum;
unsigned char *buffer;
{
	int nbytes;
	long offset;

	handle--;
	if (handle < 0 || handle >= ntabhi || !ntable[handle].openflg) {
		errno = EBADF;
		return(-1);
	}

	offset = recnum * RECSIZE;
	if (lseek(ntable[handle].fd, offset, 0) == -1L) return(-1);
	ntable[handle].filepos = offset;

	nbytes = read(ntable[handle].fd, buffer, RECSIZE);
	if (nbytes > 0) {
		ntable[handle].filepos += nbytes;
		return(nbytes); /* Successful Read */
	}
	if (nbytes == 0) return(-2); /* Read at EOF */
	return(-1); /* Some other error has occured */
}

int niowtrec(handle, recnum, buffer, length)
int handle;
long recnum;
unsigned char *buffer;
int length;
{
	long offset;
	int obytes;

	handle--;
	if (handle < 0 || handle >= ntabhi || !ntable[handle].openflg) {
		errno = EBADF;
		return(-1);
	}

	offset = recnum * RECSIZE;
	if (lseek(ntable[handle].fd, offset, 0) == -1L) return(-1);
	ntable[handle].filepos = offset;

	if (length < RECSIZE) memset(&buffer[length], ' ', RECSIZE - length);
	obytes = write(ntable[handle].fd, buffer, RECSIZE);
	if (obytes == RECSIZE) {
		ntable[handle].filepos += obytes;
		return(obytes); /* Successful Read */
	}
	return(-1); /* Bad Write */
}

int niordkey(handle, key, buffer)
int handle;
unsigned char *key;
unsigned char *buffer;
{
	return(-1);
}

int niordks(handle, buffer)
int handle;
unsigned char *buffer;
{
	return(-1);
}

int niordkp(handle, buffer)
int handle;
unsigned char *buffer;
{
	return(-1);
}

int niowtkey(handle, buffer, length)
int handle;
unsigned char *buffer;
int length;
{
	return(-1);
}

int nioupd(handle, buffer)
int handle;
unsigned char *buffer;
{
	return(-1);
}

int niodel(handle, key)
int handle;
unsigned char *key;
{
	return(-1);
}

int niolck(handle)
int *handle;
{
	return(-1);
}

int nioulck()
{
	return(-1);
}
