/* 
	Main Inclusion File for 32 Bit EXTCALL Support Routines
 */ 
 
#define ClearEos() DLLSupClearEos( uarea )
#define ClearLess() DLLSupClearLess( uarea )
#define ClearOver() DLLSupClearOver( uarea )
#define ClearZero() DLLSupClearZero( uarea )

#define SetEos() DLLSupSetEos( uarea )
#define SetLess() DLLSupSetLess( uarea )
#define SetOver() DLLSupSetOver( uarea )
#define SetZero() DLLSupSetZero( uarea )

#define TestEos() DLLSupTestEos( uarea )
#define TestLess() DLLSupTestLess( uarea )
#define TestOver() DLLSupTestOver( uarea )
#define TestZero() DLLSupTestZero( uarea )

#define GetArg( a, b, c, e, f ) DLLSupGetArg( a, b, c, e, f, uarea )
#define SetArg( a, b, c) DLLSupSetArg( a, b, c)

extern INT DLLSupClearEos ( char *U1 );
extern INT DLLSupClearLess ( char *U1 );
extern INT DLLSupClearOver ( char *U1 );
extern INT DLLSupClearZero ( char *U1 );

extern INT DLLSupSetEos ( char *U1 );
extern INT DLLSupSetLess ( char *U1 );
extern INT DLLSupSetOver ( char *U1 );
extern INT DLLSupSetZero ( char *U1 );

extern INT DLLSupTestEos ( char *U1 );
extern INT DLLSupTestLess ( char *U1 );
extern INT DLLSupTestOver ( char *U1 );
extern INT DLLSupTestZero ( char *U1 );

extern INT DLLSupGetArg ( unsigned char **Var, 
			  unsigned char **VarData, 
			  short *VarPL, 
			  short *VarFP, 
			  short *VarLL, 
			  char *U1 );
			  
extern INT DLLSupSetArg ( unsigned char *Var, 
			  unsigned short VarFP, 
			  unsigned short VarLL );
