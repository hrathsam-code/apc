;=============================================================================;
;       CREATED BY:  Chiron Software & Services, Inc.                         ;
;                    4 Norfolk Lane                                           ;
;                    Bethpage, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ADOMACRO.INC                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/10/2000 AT 12:53PM                                          ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/10/2000   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

.Microsoft Access Driver={Microsoft Access Driver (*.mdb)};DBQ=physical path to .mdb file
.SQL Server DRIVER={SQL Server};SERVER=path to server
.Oracle DRIVER={Microsoft ODBC for Oracle};SERVER=path to server
.Microsoft Excel Driver={Microsoft Excel Driver (*.xls)};DBQ=physical path to .xls file; DriverID=278
.Microsoft Excel 97 Driver={Microsoft Excel Driver (*.xls)};DBQ=physical path to .xls file;DriverID=790
.Paradox Driver={Microsoft Paradox Driver (*.db)};DBQ=physical path to .db file;DriverID=26
.Text Driver={Microsoft Text Driver (*.txt;*.csv)};DBQ=physical path to .txt file
.Microsoft Visual FoxPro? (with a database container) Driver= {MicrosoftVisualFoxProDriver};SourceType=DBC;SourceDb=physical path to .dbc file
.Microsoft Visual FoxPro (without a database container) Driver= {MicrosoftVisualFoxProDriver};SourceType=DBF;SourceDb=physical path to .dbf file
.
.=============================================================================
. Initialize the ADO Database Connections.  This is REQUIRED before any ADO
. I/O Operations can be performed
.
. Arguments : NONE
.
ADO_Routines		   EQUATE						 1
                   MMODE             BLANKOFF
                   MDELM             ", =" Use a semicolon or comma
COMM
EOFFLAG            INTEGER           1
ADORecordCount     form              10

ADOCMD             DIM               200
AffectRecords      FORM              "1"
VAR500             DIM               500
#QUOTE             INIT              34
ADOSERVER          DIM               100
ADO_Value          DIM               35
#ADO_Index          FORM              4
#SQLString          DIM               60000
#SQLFields          DIM               30000
#SQLValues          DIM               30000
#ClassID            DIM               150
#ObjectID           form              10
#ADOOpenFlag        FORM              1
#TempString         DIM               10000
.
.
.=============================================================================
ADOInit       MACRO             &ADOCMD
.              %IFNDEF           ADODBCONN
.ADODBCONN     Automation
.              %ENDIF
              SETMODE           *MCURSOR=*WAIT

              TRAP                   NoADODBCONN if Object                   ;If an Object error occurs, then we know that DB Connection doesn't exist
..HR 11.11.2015              GETPROP                ADODBCONN,ClassID=#ClassID
              GETPROP                ADODBCONN,ClassID=#ClassID
..hf 8.4.2016              GETPROP                ADODBCONN,OBjectID=#ObjectID
;
; ADODBCONN is actually created if the above ADODBCONN object isn't yet created, thus generating an Object error
;
              IF                (#ADOOpenFlag != 1)
              ADODBCONN.Open    using &ADOCMD
              ENDIF
              SET               #ADOOpenFlag
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Open the respective Table on the SQL Database.  The only field that is passed
. to this routine is the Table Name
.
. Arguments : ADO Table Name
.
ADOOpen       MACRO             &Table_Name,&IOOptions=
.
. If the ADO Connection Object hasn't yet been created (ADODBCONN),
. then we'll know it because this variable hasn't yet been created.
. If that's the case, then ......
.
. perform the ADOINIT function!!!!!
.
         %IFNDEF           ADODBCONN
           ADOINIT
         %ENDIF
.
. If the internal ADO Table has not yet been created, then create it.  If it's
. already DEFINED, then do not define it again AND...Do not cause an error
.
              %IFNDEF           &Table_Name|ADO
&Table_Name|ADO automation
              %ENDIF

              SETMODE           *MCURSOR=*WAIT
              Create            &Table_Name|ADO,Class="ADODB.RecordSet"        //HR 3.14.2016   Was !ADODB.RecordSet
              SetProp           &Table_Name|ADO,*ActiveConnection=ADODBCONN

....              SetProp           &Table_Name|ADO,*LockType="4"       .Open with Locking Type of Batch Optimistic
..wtf!!!              SetProp           &Table_Name|ADO,*LockType="1"       .Open with Read-Onlly
..test              SetProp           &Table_Name|ADO,*CursorType="1"     .Open using Dynamic Cursor
....              SetProp           &Table_Name|ADO,*LockType="2"       .Open with Locking Type of Pessimistic

              SetProp           &Table_Name|ADO,*CursorType="2"               //"1"            //2"            .Open using Dynamic Curs                   %IF               MDEFAULT(&ADO_Variable) = 0             //They've entered something
              SetProp           &Table_Name|ADO,*CursorLocation="2"         //3= Client   .Open with Client Side

              %IF               MDEFAULT(&IOOptions) = 0             //They've entered something
              SetProp           &Table_Name|ADO,*LockType="&IOOptions"              //"3" Optimistic          //4"    //"       .Open with Locking Type of Optimistic
              %ELSE
              SetProp           &Table_Name|ADO,*LockType="3"              //"3" Optimistic          //4"    //"       .Open with Locking Type of Optimistic
              %ENDIF

.              &Table_Name|ADO.Open USING "P2TRMAST"
.              &Table_Name|ADO.Open USING "Select * from [InvoiceAttachment$]"
..              &Table_Name|ADO.Open USING "[InvoiceAttachment$A1:Z10]"
              &Table_Name|ADO.Open USING "&Table_Name"
..              &Table_Name|ADO.Open USING "P2Cash"
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Close the respective ADO Table on the SQL Database.  The only field that is passed
. to this routine is the Table Name
.
. Arguments : ADO Table Name
.
ADOClose      MACRO             &Table_Name
              SETMODE           *MCURSOR=*WAIT
              &Table_Name|ADO.Close
              Destroy           &Table_Name|ADO            //HR 8/13/2003
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Close the Connection ADO Object.  This is used AFTER all of the other ADO Automation
. objects have been Closed/Destroyed.
.
.
ADOInitClose  MACRO             &Table_Name
              SETMODE           *MCURSOR=*WAIT
              Destroy           ADODBCONN            //HR 8/13/2003
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Add/Write a record to the respective ADO Table on the SQL Database.  The fields
. that are required are the Table Name, as well as a "pair" of fields and or data
. The fields required are the Internal SQL Field (for the table) and the "internal"
. variable/literal that we are going to set on the SQL Database.
. This routine allows for literals as well as variables to be assigned to the
. appropriate table
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to update the SQL Internal Field
.
ADOWrite           MACRO             &Table_Name,&Table_Field1,&KeyVar1:
                                                 &Table_Field2=,&KeyVar2=:
                                                 &Table_Field3=,&KeyVar3=:
                                                 &Table_Field4=,&KeyVar4=:
                                                 &Table_Field5=,&KeyVar5=:
                                                 &Table_Field6=,&KeyVar6=:
                                                 &Table_Field7=,&KeyVar7=:
                                                 &Table_Field8=,&KeyVar8=:
                                                 &Table_Field9=,&KeyVar9=:
                                                 &Table_Field10=,&KeyVar10=:
                                                 &Table_Field11=,&KeyVar11=:
                                                 &Table_Field12=,&KeyVar12=:
                                                 &Table_Field13=,&KeyVar13=:
                                                 &Table_Field14=,&KeyVar14=:
                                                 &Table_Field15=,&KeyVar15=:
                                                 &Table_Field16=,&KeyVar16=:
                                                 &Table_Field17=,&KeyVar17=:
                                                 &Table_Field18=,&KeyVar18=:
                                                 &Table_Field19=,&KeyVar19=:
                                                 &Table_Field20=,&KeyVar20=:
                                                 &Table_Field21=,&KeyVar21=:
                                                 &Table_Field22=,&KeyVar22=:
                                                 &Table_Field23=,&KeyVar23=:
                                                 &Table_Field24=,&KeyVar24=:
                                                 &Table_Field25=,&KeyVar25=:
                                                 &Table_Field26=,&KeyVar26=:
                                                 &Table_Field27=,&KeyVar27=:
                                                 &Table_Field28=,&KeyVar28=:
                                                 &Table_Field29=,&KeyVar29=:
                                                 &Table_Field30=,&KeyVar30=:
                                                 &Table_Field31=,&KeyVar31=:
                                                 &Table_Field32=,&KeyVar32=:
                                                 &Table_Field33=,&KeyVar33=:
                                                 &Table_Field34=,&KeyVar34=:
                                                 &Table_Field35=,&KeyVar35=:
                                                 &Table_Field36=,&KeyVar36=:
                                                 &Table_Field37=,&KeyVar37=:
                                                 &Table_Field38=,&KeyVar38=:
                                                 &Table_Field39=,&KeyVar39=:
                                                 &Table_Field40=,&KeyVar40=:
                                                 &Table_Field41=,&KeyVar41=:
                                                 &Table_Field42=,&KeyVar42=:
                                                 &Table_Field43=,&KeyVar43=:
                                                 &Table_Field44=,&KeyVar44=:
                                                 &Table_Field45=,&KeyVar45=:
                                                 &Table_Field46=,&KeyVar46=:
                                                 &Table_Field47=,&KeyVar47=:
                                                 &Table_Field48=,&KeyVar48=:
                                                 &Table_Field49=,&KeyVar49=:
                                                 &Table_Field50=,&KeyVar50=:
                                                 &Table_Field51=,&KeyVar51=:
                                                 &Table_Field52=,&KeyVar52=:
                                                 &Table_Field53=,&KeyVar53=:
                                                 &Table_Field54=,&KeyVar54=:
                                                 &Table_Field55=,&KeyVar55=:
                                                 &Table_Field56=,&KeyVar56=:
                                                 &Table_Field57=,&KeyVar57=:
                                                 &Table_Field58=,&KeyVar58=:
                                                 &Table_Field59=,&KeyVar59=:
                                                 &Table_Field60=,&KeyVar60=:
                                                 &Table_Field61=,&KeyVar61=:
                                                 &Table_Field62=,&KeyVar62=:
                                                 &Table_Field63=,&KeyVar63=:
                                                 &Table_Field64=,&KeyVar64=:
                                                 &Table_Field65=,&KeyVar65=:
                                                 &Table_Field66=,&KeyVar66=:
                                                 &Table_Field67=,&KeyVar67=:
                                                 &Table_Field68=,&KeyVar68=:
                                                 &Table_Field69=,&KeyVar69=:
                                                 &Table_Field70=,&KeyVar70=:
                                                 &Table_Field71=,&KeyVar71=:
                                                 &Table_Field72=,&KeyVar72=:
                                                 &Table_Field73=,&KeyVar73=:
                                                 &Table_Field74=,&KeyVar74=:
                                                 &Table_Field75=,&KeyVar75=:
                                                 &Table_Field76=,&KeyVar76=:
                                                 &Table_Field77=,&KeyVar77=:
                                                 &Table_Field78=,&KeyVar78=:
                                                 &Table_Field79=,&KeyVar79=:
                                                 &Table_Field80=,&KeyVar80=:
                                                 &Table_Field81=,&KeyVar81=:
                                                 &Table_Field82=,&KeyVar82=:
                                                 &Table_Field83=,&KeyVar83=:
                                                 &Table_Field84=,&KeyVar84=:
                                                 &Table_Field85=,&KeyVar85=:
                                                 &Table_Field86=,&KeyVar86=:
                                                 &Table_Field87=,&KeyVar87=:
                                                 &Table_Field88=,&KeyVar88=:
                                                 &Table_Field89=,&KeyVar89=:
                                                 &Table_Field90=,&KeyVar90=:
                                                 &Table_Field91=,&KeyVar91=:
                                                 &Table_Field92=,&KeyVar92=:
                                                 &Table_Field93=,&KeyVar93=:
                                                 &Table_Field94=,&KeyVar94=:
                                                 &Table_Field95=,&KeyVar95=:
                                                 &Table_Field96=,&KeyVar96=:
                                                 &Table_Field97=,&KeyVar97=:
                                                 &Table_Field98=,&KeyVar98=:
                                                 &Table_Field99=,&KeyVar99=

                   CLEAR             #ADO_Index,#SQLFields,#SQLValues,#SQLString

                   CreateSQLString   &KeyVar1,&Table_Field1
                   CreateSQLString   &KeyVar2,&Table_Field2
                   CreateSQLString   &KeyVar3,&Table_Field3
                   CreateSQLString   &KeyVar4,&Table_Field4
                   CreateSQLString   &KeyVar5,&Table_Field5
                   CreateSQLString   &KeyVar6,&Table_Field6
                   CreateSQLString   &KeyVar7,&Table_Field7
                   CreateSQLString   &KeyVar8,&Table_Field8
                   CreateSQLString   &KeyVar9,&Table_Field9
                   CreateSQLString   &KeyVar10,&Table_Field10
                   CreateSQLString   &KeyVar11,&Table_Field11
                   CreateSQLString   &KeyVar12,&Table_Field12
                   CreateSQLString   &KeyVar13,&Table_Field13
                   CreateSQLString   &KeyVar14,&Table_Field14
                   CreateSQLString   &KeyVar15,&Table_Field15
                   CreateSQLString   &KeyVar16,&Table_Field16
                   CreateSQLString   &KeyVar17,&Table_Field17
                   CreateSQLString   &KeyVar18,&Table_Field18
                   CreateSQLString   &KeyVar19,&Table_Field19
                   CreateSQLString   &KeyVar20,&Table_Field20
                   CreateSQLString   &KeyVar21,&Table_Field21
                   CreateSQLString   &KeyVar22,&Table_Field22
                   CreateSQLString   &KeyVar23,&Table_Field23
                   CreateSQLString   &KeyVar24,&Table_Field24
                   CreateSQLString   &KeyVar25,&Table_Field25
                   CreateSQLString   &KeyVar26,&Table_Field26
                   CreateSQLString   &KeyVar27,&Table_Field27
                   CreateSQLString   &KeyVar28,&Table_Field28
                   CreateSQLString   &KeyVar29,&Table_Field29
                   CreateSQLString   &KeyVar30,&Table_Field30
                   CreateSQLString   &KeyVar31,&Table_Field31
                   CreateSQLString   &KeyVar32,&Table_Field32
                   CreateSQLString   &KeyVar33,&Table_Field33
                   CreateSQLString   &KeyVar34,&Table_Field34
                   CreateSQLString   &KeyVar35,&Table_Field35
                   CreateSQLString   &KeyVar36,&Table_Field36
                   CreateSQLString   &KeyVar37,&Table_Field37
                   CreateSQLString   &KeyVar38,&Table_Field38
                   CreateSQLString   &KeyVar39,&Table_Field39
                   CreateSQLString   &KeyVar40,&Table_Field40
                   CreateSQLString   &KeyVar41,&Table_Field41
                   CreateSQLString   &KeyVar42,&Table_Field42
                   CreateSQLString   &KeyVar43,&Table_Field43
                   CreateSQLString   &KeyVar44,&Table_Field44
                   CreateSQLString   &KeyVar45,&Table_Field45
                   CreateSQLString   &KeyVar46,&Table_Field46
                   CreateSQLString   &KeyVar47,&Table_Field47
                   CreateSQLString   &KeyVar48,&Table_Field48
                   CreateSQLString   &KeyVar49,&Table_Field49
                   CreateSQLString   &KeyVar50,&Table_Field50
                   CreateSQLString   &KeyVar51,&Table_Field51
                   CreateSQLString   &KeyVar52,&Table_Field52
                   CreateSQLString   &KeyVar53,&Table_Field53
                   CreateSQLString   &KeyVar54,&Table_Field54
                   CreateSQLString   &KeyVar55,&Table_Field55
                   CreateSQLString   &KeyVar56,&Table_Field56
                   CreateSQLString   &KeyVar57,&Table_Field57
                   CreateSQLString   &KeyVar58,&Table_Field58
                   CreateSQLString   &KeyVar59,&Table_Field59
                   CreateSQLString   &KeyVar60,&Table_Field60
                   CreateSQLString   &KeyVar61,&Table_Field61
                   CreateSQLString   &KeyVar62,&Table_Field62
                   CreateSQLString   &KeyVar63,&Table_Field63
                   CreateSQLString   &KeyVar64,&Table_Field64
                   CreateSQLString   &KeyVar65,&Table_Field65
                   CreateSQLString   &KeyVar66,&Table_Field66
                   CreateSQLString   &KeyVar67,&Table_Field67
                   CreateSQLString   &KeyVar68,&Table_Field68
                   CreateSQLString   &KeyVar69,&Table_Field69
                   CreateSQLString   &KeyVar70,&Table_Field70
                   CreateSQLString   &KeyVar71,&Table_Field71
                   CreateSQLString   &KeyVar72,&Table_Field72
                   CreateSQLString   &KeyVar73,&Table_Field73
                   CreateSQLString   &KeyVar74,&Table_Field74
                   CreateSQLString   &KeyVar75,&Table_Field75
                   CreateSQLString   &KeyVar76,&Table_Field76
                   CreateSQLString   &KeyVar77,&Table_Field77
                   CreateSQLString   &KeyVar78,&Table_Field78
                   CreateSQLString   &KeyVar79,&Table_Field79
                   CreateSQLString   &KeyVar80,&Table_Field80
                   CreateSQLString   &KeyVar81,&Table_Field81
                   CreateSQLString   &KeyVar82,&Table_Field82
                   CreateSQLString   &KeyVar83,&Table_Field83
                   CreateSQLString   &KeyVar84,&Table_Field84
                   CreateSQLString   &KeyVar85,&Table_Field85
                   CreateSQLString   &KeyVar86,&Table_Field86
                   CreateSQLString   &KeyVar87,&Table_Field87
                   CreateSQLString   &KeyVar88,&Table_Field88
                   CreateSQLString   &KeyVar89,&Table_Field89
                   CreateSQLString   &KeyVar90,&Table_Field90
                   CreateSQLString   &KeyVar91,&Table_Field91
                   CreateSQLString   &KeyVar92,&Table_Field92
                   CreateSQLString   &KeyVar93,&Table_Field93
                   CreateSQLString   &KeyVar94,&Table_Field94
                   CreateSQLString   &KeyVar95,&Table_Field95
                   CreateSQLString   &KeyVar96,&Table_Field96
                   CreateSQLString   &KeyVar97,&Table_Field97
                   CreateSQLString   &KeyVar98,&Table_Field98
                   CreateSQLString   &KeyVar99,&Table_Field99

.                   DEBUG
                   RESET             #SQLValues
                   RESET             #SQLFields
                   PACK              #SQLString FROM "INSERT INTO &Table_Name (",#SQLFields,") ":
                                                    "VALUES (",#SQLValues,")"
                   SETMODE           *MCURSOR=*WAIT
                   ADODBCONN.Execute using #SQLString
                   SETMODE           *MCURSOR=*ARROW
                   MEND
;==============================================================================
. Read the respective ADO Table on the SQL Database.  The only fields that are required
. are the SQL Database Table name, the Fieldname within the ADO Table that we are going
. to match against, and then literal/variable that we are searching for.
.
.
. ADOREAD     SQL Field,"1"     or     ADOREAD     SQL Field,Item
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to find the SQL Internal Field
.
ADORead       MACRO             &Table_Name,&Table_Field,&KeyVar
              SETMODE           *MCURSOR=*WAIT
              PACK              ADOCMD FROM "&Table_Field='",&KeyVar,"'"
.
. If we're not already at the Beginning of the file...then get there!!!
.
              GetProp           &Table_Name|ADO,*BOF=EOFFLAG
              if                (EOFFLAG = 0)
                &Table_Name|ADO.MoveFirst
              ENDIF
              TRAP                   ADOERROR IF OBJECT
              &Table_Name|ADO.FIND     USING ADOCMD
              TRAPCLR                OBJECT
              GetProp           &Table_Name|ADO,*EOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              else
                SETFLAG           NOT OVER
              endif
              SETMODE           *MCURSOR=*ARROW
              MEND
;==============================================================================
. Read the respective ADO Table on the SQL Database.  The only fields that are required
. are the SQL Database Table name, the Fieldname within the ADO Table that we are going
. to match against, and then literal/variable that we are searching for.
.
.
. ADOREAD2     SQL Field,"1"     or     ADOREAD     SQL Field,Item
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to find the SQL Internal Field
.
ADORead2           MACRO             &Table_Name,&SqlString:
                                                 &Table_Field1,&KeyVar1:
                                                 &Table_Field2=,&KeyVar2=:
                                                 &Table_Field3=,&KeyVar3=:
                                                 &Table_Field4=,&KeyVar4=:
                                                 &Table_Field5=,&KeyVar5=:
                                                 &Table_Field6=,&KeyVar6=:
                                                 &Table_Field7=,&KeyVar7=:
                                                 &Table_Field8=,&KeyVar8=:
                                                 &Table_Field9=,&KeyVar9=:
                                                 &Table_Field10=,&KeyVar10=:
                                                 &Table_Field11=,&KeyVar11=:
                                                 &Table_Field12=,&KeyVar12=:
                                                 &Table_Field13=,&KeyVar13=:
                                                 &Table_Field14=,&KeyVar14=:
                                                 &Table_Field15=,&KeyVar15=:
                                                 &Table_Field16=,&KeyVar16=:
                                                 &Table_Field17=,&KeyVar17=:
                                                 &Table_Field18=,&KeyVar18=:
                                                 &Table_Field19=,&KeyVar19=:
                                                 &Table_Field20=,&KeyVar20=:
                                                 &Table_Field21=,&KeyVar21=:
                                                 &Table_Field22=,&KeyVar22=:
                                                 &Table_Field23=,&KeyVar23=:
                                                 &Table_Field24=,&KeyVar24=:
                                                 &Table_Field25=,&KeyVar25=:
                                                 &Table_Field26=,&KeyVar26=:
                                                 &Table_Field27=,&KeyVar27=:
                                                 &Table_Field28=,&KeyVar28=:
                                                 &Table_Field29=,&KeyVar29=:
                                                 &Table_Field30=,&KeyVar30=:
                                                 &Table_Field31=,&KeyVar31=:
                                                 &Table_Field32=,&KeyVar32=:
                                                 &Table_Field33=,&KeyVar33=:
                                                 &Table_Field34=,&KeyVar34=:
                                                 &Table_Field35=,&KeyVar35=:
                                                 &Table_Field36=,&KeyVar36=:
                                                 &Table_Field37=,&KeyVar37=:
                                                 &Table_Field38=,&KeyVar38=:
                                                 &Table_Field39=,&KeyVar39=


.
. If we're not already at the Beginning of the file...then get there!!!
.
&Table_Name|RS     AUTOMATION

                   SETMODE           *MCURSOR=*WAIT
                   ADODBCONN.Execute giving &Table_NameRS using SQLString
                   GetProp           &Table_Name|RS,*EOF=EOFFLAG
                   if                (EOFFLAG != 0)
                     SETFLAG           OVER
                   else
                     SETFLAG           NOT OVER
                   endif
                   SETMODE           *MCURSOR=*ARROW
                   MEND
.=============================================================================
. Read Key Sequentially through the respective ADO Table on the SQL Database.
. The only field that is required is he SQL Database Table name.  That is because
. once a READKS has been performed, we can MOVEFROMADO any variables from the SQL
. database
.
. ADOREADKS   ADO Table
.
. Arguments : ADO Table Name
.
ADOReadKS     MACRO             &Table_Name
              SETMODE           *MCURSOR=*WAIT
              &Table_Name|ADO.MoveNext
              GetProp           &Table_Name|ADO,*EOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              else
                SETFLAG           NOT OVER
              endif
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Read Key Previous through the respective ADO Table on the SQL Database.
. The only field that is required is he SQL Database Table name.  That is because
. once a READKP has been performed, we can MOVEFROMADO any variables from the SQL
. database if the OVER flag has not been set.
.
. ADOREADKS     ITEMMAST
.
. Arguments : ADO Table Name
.
ADOReadKP     MACRO             &Table_Name
              SETMODE           *MCURSOR=*WAIT
              &Table_Name|ADO.MovePrevious
              GetProp           &Table_Name|ADO,*BOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              else
                SETFLAG           NOT OVER
              endif
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Deletes the current record from the respective ADO Table on the SQL Database.
. The only parameter that is required is he SQL Database Table name.  That is because
. we are already pointing to an existing record
.
. Arguments : ADO Table Name
.
ADODelete     MACRO             &Table_Name
              &Table_Name|ADO.Delete     giving AffectRecords
              &Table_Name|ADO.Update
              MEND
.=============================================================================
. Moves a field TO the respective ADO Table to an internal PL/B variable
. The parameters that are required is he SQL Database Table name, the field name
. within the Table as well as the Internal PL/B variable within your program.
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to find the SQL Internal Field
.
MoveToADO     MACRO             &Table_Name,&KeyVar,&Table_Field
              setprop           &Table_Name|ADO.Fields("&Table_Field"),*Value="&KeyVar"
              MEND
.=============================================================================
. Moves a field TO the respective ADO Table to an internal PL/B variable
. The parameters that are required is he SQL Database Table name, the field name
. within the Table as well as the Internal PL/B variable within your program.
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to find the SQL Internal Field
.

CreateSQLString    MACRO             &ADO_Variable=,&ADO_Field=
                   %IF               MDEFAULT(&ADO_Variable) = 0             //They've entered something
                   INCR              #ADO_Index
                   IF                (#SQLFields = "")
                   ELSE
                     APPEND            ", ",#SQLFields
                   ENDIF

                   APPEND            "&ADO_Field",#SQLFields
                   IF                (#SQLValues = "")
                   ELSE
                     APPEND            ", ",#SQLValues
                   ENDIF
                   APPEND            "'",#SQLValues
                   %IF               DTYPEBASE(&ADO_Variable) = 32
                    MOVE              &ADO_Variable,#TempString
                    CHOP              #TempString,#TempString
                    scan              singlequote,#TempString
                    if                equal
.                      debug
                      splice            singleQuote2,#TempString,1
                      reset             #TempString
                      APPEND            #TempString,#SQLValues
                    else
                      APPEND            #TempString,#SQLValues
                    endif
                   %ELSE
                    APPEND            &ADO_Variable,#SQLValues
                   %ENDIF
                   APPEND            "'",#SQLValues
                   %ENDIF
                   MEND
.=============================================================================
. Moves a field FROM the respective ADO Table to an internal PL/B variable
. The parameters that are required is he SQL Database Table name, the field name
. within the Table as well as the Internal PL/B variable within your program.
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to find the SQL Internal Field
.
MoveFromADO   MACRO             &Table_Name,&Table_Field,&KeyVar
              TRAP              Null|&id if Object

.             %IF               &Table_Field
                Getprop           &Table_Name|ADO.Fields("&Table_Field"),*Value=&KeyVar
.              %ELSE
.                Getprop           &Table_Name|ADO.Fields("&Table_Field"),*Value=&KeyVar
.              %ENDIF

              TRAPCLR           Object
              GOTO              #Mend|&id
Null|&id
              noreturn
              CLEAR             &KeyVar             //Was Move 0 to
#Mend|&id
              MEND
;==============================================================================
. Moves a field FROM the respective ADO Table to an internal PL/B variable
. The parameters that are required is he SQL Database Table name, the field name
. within the Table as well as the Internal PL/B variable within your program.
.
. Arguments : ADO Table Name
.             SQL Internal Field Name within the ADO Table Name
.             Literal or Variable to find the SQL Internal Field
.
MoveFromADO2  MACRO             &Table_Name,&Table_Field,&KeyVar
              TRAP              Null|&id if Object

                %IF               DTYPEBASE(&KeyVar) = 32
              CLEAR             &KeyVar
              FILL              " ",&KeyVar
                %ELSE
              CLEAR             &KeyVar
                %ENDIF

              GETPROP           &Table_Name|RS.Fields("&Table_Field"),*Value=&KeyVar

              TRAPCLR           Object
              GOTO              #Mend|&id
Null|&id
              noreturn
...              CLEAR             &KeyVar             //Was Move 0 to
                   %IF               DTYPEBASE(&KeyVar) = 32
                   FILL              " ",&KeyVar
                   %ELSE
                   CLEAR             &KeyVar
                   %ENDIF
#Mend|&id
                %IF               DTYPEBASE(&KeyVar) = 32
              SETLPTR            &KeyVar
                %ENDIF

              MEND
.=============================================================================
. Moves to the FIRST record within the respective ADO Table on the SQL Database.
. The only field that is passed to this routine is the Table Name.  When you issue
. this command, the system will be pointing to the FIRST RECORD ALREADY!!!!!!
. If the OVER flag is set, there are NO records wtihn this Table!!!!
.
. Arguments : ADO Table Name
.
ADOGotoTOF    MACRO             &Table_Name
              &Table_Name|ADO.MoveFirst
              GetProp           &Table_Name|ADO,*EOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              ELSE
                SETFLAG           NOT OVER
              ENDIF
              MEND
.=============================================================================
. Moves to the LAST record within the respective ADO Table on the SQL Database.
. The only field that is passed to this routine is the Table Name.  When you issue
. this command, the system will be pointing to the LAST RECORD ALREADY!!!!!!
. If the OVER flag is set, there are NO records wtihn this Table!!!!
.
. Arguments : ADO Table Name
.
ADOGotoEOF    MACRO             &Table_Name
              GetProp           &Table_Name|ADO,*BOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              ELSE
                SETFLAG           NOT OVER
              ENDIF
              &Table_Name|ADO.MoveLast
              MEND
.=============================================================================
. Checks to see if we're at the End of the File.  This simply checks the
. EOF flag within the SQL Database to see if we're PAST the last valid record!!
.
. Arguments : ADO Table Name
.
ADOAtEOF      MACRO             &Table_Name
              GetProp           &Table_Name|ADO,*EOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              ELSE
                SETFLAG           NOT OVER
              ENDIF
              MEND
.=============================================================================
. Checks to see if we're at the Beginning of the File.  This simply checks the
. BOF flag within the SQL Database to see if we're PAST the FIRST valid record!!
.
. Arguments : ADO Table Name
.
ADOAtBOF      MACRO             &Table_Name
              GetProp           &Table_Name|ADO,*BOF=EOFFLAG
              if                (EOFFLAG != 0)
                SETFLAG           OVER
              ELSE
                SETFLAG           NOT OVER
              ENDIF
              MEND
.=============================================================================
. Updates the respective ADO Table.  Any fields that were updated manually with the
. MOVETOSQL command will need to issue the ADOUPDATE command in order to write
. out these changes to the Table!
.
. Arguments : ADO Table Name
.
ADOUPDATE     MACRO             &Table_Name
              SETMODE           *MCURSOR=*WAIT
              &Table_Name|ADO.Update
              SETMODE           *MCURSOR=*ARROW
              MEND
.=============================================================================
. Addes the respective ADO Table.  Any fields that were updated manually with the
. MOVETOADO command will need to issue the ADOUPDATE command in order to write
. out these changes to the Table!
.
. Arguments : ADO Table Name
.
ADOADD        MACRO             &Table_Name
              SETMODE           *MCURSOR=*WAIT
              &Table_Name|ADO.AddNew
              SETMODE           *MCURSOR=*ARROW
              MEND

              GOTO                 #S
.=============================================================================
              %IFNDEF           ADODBCONN
ADODBCONN     Automation

NoADODBConn
              TRAPCLR                Object
              Create            ADODBCONN,Class="ADODB.Connection"        //HR 3.14.2016   Was !ADODB.RecordSet

              RETURN
              %ENDIF
.=============================================================================
ADOERROR
             DEBUG
             GETINFO             EXCEPTION,VAR500
             STOP

#S
