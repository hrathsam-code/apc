/*-----------------------------------------------------------------------------
  EXTCALL tutorial program - 32 bit version.

  Functions that are callable from the 'c' routines:

  char *Var;
  char *Addr;
  short Type;
  short PL;
  short FP;
  short LL;
  int Status;

  (void) ClearEos ();				; Clear EOS flag

  (void) ClearLess ();				; Clear LESS flag

  (void) ClearOver ();				; Clear OVER flag

  (void) ClearZero ();				; Clear ZERO flag

  Type = GetArg ( &Var, &Addr, &PL, &FP, &LL);	; Get Next Argument & Type
	Var = Address of first byte of data item
	Addr = Address of first byte of user data
	PL = Physical length of field
	FP = Dim: Form Pointer
	     Form: Whole Digits in field
	LL = Dim: Logical Length Pointer
	     Form: Fractional Digits in field
	Type = 0: End of Argument List
	       1: Dim variable
	       2: Form variable
	       3: Integer variable
	      99: Other

  Status = SetArg ( Var, FP, LL);		; Set FP & LL
	NOTE: Only valid for DIM field
	Status = 0 if Modifications were made
		 1 if not modifications were made

  (void) SetEos ();				; Set EOS flag

  (void) SetLess ();				; Set LESS flag

  (void) SetOver ();				; Set OVER flag

  (void) SetZero ();				; Set ZERO flag

  Status = TestEos ();				; Test EOS flag

  Status = TestLess ();				; Test LESS flag

  Status = TestOver ();				; Test OVER flag

  Status = TestZero ();				; Test ZERO flag
*/

#include <windows.h>
#include "plbwex32.h"

static int gCurProcessCnt = 0;

/*=============================================================================
 Function:      DLLEntryPoint
 
 Input:     	hDLL       - handle of DLL
 		dwReason   - indicates why DLL called
 		lpReserved - reserved
 		
 Output:       	TRUE
		Note that the retuRn value is used only when
                dwReason = DLL_PROCESS_ATTACH.
 
                Normally the function would return TRUE if DLL initial-
                ization succeeded, or FALSE it it failed.

 This function processes DLL Startup and shutdown.
*/
BOOL WINAPI DLLEntryPoint( HANDLE hDLL, DWORD dwReason, LPVOID lpReserved )
{
 BOOL result = TRUE;
 
  	switch( dwReason )
  	 {
    	case DLL_PROCESS_ATTACH:
    	 	gCurProcessCnt++;
    		break;
    	
    	case DLL_THREAD_ATTACH:
     	case DLL_THREAD_DETACH:
		break;

    	case DLL_PROCESS_DETACH:
    		gCurProcessCnt--;
     		break;
  	 }

  	return( result );
}

/*------------------------------------------------------------------------------
  dspNAME0 will take a list of variables passed to the routine and 
  give some information about those variables.
*/

static int Function1 ( char * uarea )
{
char	*Var;
char	*VarAddr;
short	VarType;
short	VarFP;
short	VarLL;
short	VarPL;

	while ( ( VarType = GetArg ( &Var, &VarAddr, &VarPL, &VarFP, &VarLL ) ) > 0 )
	{
		switch ( VarType )
		{
			case 1:
				MessageBox( NULL, "Argument was a Dim", "EXTCALL Test", MB_ICONASTERISK + MB_OK);
				break;
			case 2:
				MessageBox( NULL, "Argument was a Form", "EXTCALL Test", MB_ICONASTERISK + MB_OK);
				break;
			case 3:
				MessageBox( NULL, "Argument was an Integer", "EXTCALL Test", MB_ICONASTERISK + MB_OK);
				break;
			default:
				MessageBox( NULL, "Argument was Other", "EXTCALL Test", MB_ICONASTERISK + MB_OK);
		}
	}
	return ( VarType );
}

/*-----------------------------------------------------------------------------
*/

static int Function2 ( char * uarea )
{
	MessageBox( NULL, "NAME1:....:", "EXTCALL Test", MB_ICONASTERISK + MB_OK);
	return ( 0 );			
}

/*-----------------------------------------------------------------------------
*/

static int Function3 ( char * uarea )
{
	MessageBox( NULL, "NAME2:....:", "EXTCALL Test", MB_ICONASTERISK + MB_OK);
	return ( 1 );	/* Return an error code */
}

/*-----------------------------------------------------------------------------
*/

static int Function4 ( char * uarea )
{
char	*Var;
char	*VarAddr;
short	VarType;
short	VarFP;
short	VarLL;
short	VarPL;
int	retval = 0;

	VarType = GetArg ( &Var, &VarAddr, &VarPL, &VarFP, &VarLL );
	retval = SetArg ( Var, VarPL, VarPL );
	return ( retval );
}

/*=============================================================================
 Function:      extcall
 
 Input:     	function - pointer to logical string used in EXTCALL
 		uarea    - pointer to Databus program user area
 		
 Output:       	Routine dependent

 This function is the main entry point for the external routine.
*/
INT extcall( char *function, char *uarea )
{
  int	retval = 0;

	ClearOver ();
	switch ( *function )
	{
		case '1':
			retval = Function1 ( uarea );
			break;
		case '2':
			retval = Function2 ( uarea );
			break;
		case '3':
			retval = Function3 ( uarea );
			break;
		case '4':
			retval = Function4 ( uarea );
			break;
		default:
			SetOver ();
	}
	return ( retval );
 }
