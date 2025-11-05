HelpScribble project file.
16
...
0
2
PL/B Database Designer & Builder


2019
FALSE


1
BrowseButtons()
0
FALSE
c:\build\
FALSE
TRUE
16777215
0
16711680
8388736
255
TRUE
TRUE
FALSE
TRUE
150
50
600
500
TRUE
FALSE
1
FALSE
FALSE
Contents
%s Contents
Index
%s Index
Previous
Next
FALSE

19
5
Scribble5
Introduction to A/P System




Writing



FALSE
16
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}{\f2\fnil\fcharset2 Symbol;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Introduction to A/P System\cf0\b0\f1\fs20 
\par 
\par \f0 Welcome to the latest version of the Database Dictionary & Designer for PL/B.  
\par 
\par This tool is designed to help create, update & maintain your fields and file structures for your PL/B software. 
\par 
\par \ul It has the ability to do the following:
\par \pard{\pntext\f2\'B7\tab}{\*\pn\pnlvlblt\pnf2\pnindent0{\pntxtb\'B7}}\fi-200\li200\tx200\ulnone Create multiple Databases for different clients
\par {\pntext\f2\'B7\tab}Create & Update indices based upon Field names rather than Field positions.  Easily update and change a specific index and properties with several clicks of the mouse.  This also includes the ability to Update & Maintain your Aamdex information as well.
\par {\pntext\f2\'B7\tab}Create fields and change their properties (Dim to Form, etc), locations all through an easy to use Windows interface.  No need to determine the position of the fields manually as this is all taken care of via the Database Dictionary Designer.
\par {\pntext\f2\'B7\tab}Generate include files for both the File definitions as well as all the I/O operations (including Prep, Read, ReadKS, etc) all with the simple click of a button.
\par {\pntext\f2\'B7\tab}Copy fields from one table and paste them to another with ease including automatically calculating the positions within the new table.
\par {\pntext\f2\'B7\tab}Print out the PL/B Data Dictionary as a hard copy for others to reference.\f1 
\par }
7
Scribble7
Entering Vendor Terms 




Writing



FALSE
26
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Entering Vendor Term Codes \cf0\b0\f1\fs20 
\par \f0 
\par Before a Vendor can be setup properly,numerus tables must be setup including the Term Codes.
\par 
\par Vendor Terms Cdes are used to determine the Due Date and Discount Dates when an invoice is entered into the system.  This allows the system to prroperly calculate these dates so that entering invocies with the proper default information will be a breeze.
\par 
\par An example of a Term Code would be 2% 10, Net 30.  This means that the vendor will give a 2% discount if the invoice is paid within 10 days.  The Net 30 means that the invoice must be paid within 30 days.
\par 
\par In this example, you might want create a TermCode of 2%10Net30.  The values entered into the fileds will be 2%, 10
\par 
\par When an invoice is entered, the Due Date and Discount Date will be populated based upon the Term Code for each Vendor.
\par 
\par Orher exampes include
\par 
\par Code\tab\tab Description
\par Net30\tab\tab Invoice Due in 30 days
\par COD\tab\tab Paid immediately
\par Net45\tab\tab Invoice Due in 45 days
\par 
\par There's no limits to the amount of Term Codes that can be entered.
\par 
\par \f1 
\par 
\par }
9
Scribble9
Entering Bank Codes




Writing



FALSE
12
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Entering Bank Codes \cf0\b0\f1\fs20 
\par 
\par \f0 Before a Vendor can be setup properly,numerus tables must be setup including the Bank Codes.
\par 
\par Vendor Bank Codes are used when writing checks.  There are some companies that use multiple bank accounts or diferent banks completely. Some companies use different Bank Codes for manual hand-written checks vs. automatic checks that are printed.  It's entirely up to the individual company on how they setup the Bank Codes.  
\par 
\par When checks are either printed or recorded manually within the system, each check will be recorded with the Bank Number.  This allows for a multitude of options including multiple banking and checking accounts.
\par 
\par 
\par }
10
Scribble10
How To Creaate/Update Vendors




Writing



FALSE
11
{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\lang1033\b\fs32 How To Creaate/Update Vendors\f1 
\par 
\par \cf0\b0\f0\fs20 Vendor Maintenance is used to create "New" Vendors and Update existing vendors.
\par 
\par When Creating  new Vendor, click the "New" button.  You can now enter all the specific vendor information.  
\par 
\par You can also specify the default General Ledger Codes that will be used in the A/P Entry program.  
\par \b\f1 
\par }
11
Scribble11
How to Create an A/P Check Run




Writing



FALSE
17
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}{\f2\fnil\fcharset2 Symbol;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 How to Create an A/P Check Run\cf0\b0\f1\fs20 
\par 
\par \f0 The steps required to print checks are very simple once understood.
\par 
\par \pard{\pntext\f2\'B7\tab}{\*\pn\pnlvlblt\pnf2\pnindent0{\pntxtb\'B7}}\fi-200\li200\tx200 Select Invoices to be paid either manually or automatically or both methods.
\par {\pntext\f2\'B7\tab}Run report to determine the total amount of all the checks to be printed (Optional)
\par {\pntext\f2\'B7\tab}Print Checks
\par {\pntext\f2\'B7\tab}Print Check Register (to confirm checks printed)
\par \pard 
\par To automatically select invoices to be paid, use the "Create Check Run" program which will search the Open A/P Invoices to be paid based upon the criteria that's used including Due Date, Invoice Date and Discount Dates among other options.  When this program runs, it will mark these invoices for use by the Check Printing program. Individual invoices that have been marked for printing can then be added, removed or modified through the Manual Check Entry program.
\par 
\par When 
\par 
\par Select the Invoices to be paid using the "Create Check Run" program to automatically select invoices to be paid.  \f1 
\par }
16
Scribble16
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
18
Scribble18
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
19
Scribble19
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
20
Scribble20
Creating the Database




Writing



FALSE
8
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Creating the Database\cf0\b0\f1\fs20 
\par 
\par \f0 Before you can begin to create the Files and Fields include files, you must first create a Database that's used to contain all the tables and  information for a particular database.
\par 
\par \f1 
\par }
21
Scribble21
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
23
Scribble23
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
24
Scribble24
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
25
Scribble25
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
26
Scribble26
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}{\f1\fnil\fcharset0 Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <n\f1 fdfdf\f0 ew topic>\cf0\b0\fs20 
\par 
\par 
\par }
30
Scribble30
Creating Files & Tables




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Creating Tables\cf0\b0\f1\fs20 
\par 
\par 
\par }
40
Scribble40
Creating Fields Within your Files




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Creating Fields Within your Files\cf0\b0\f1\fs20 
\par 
\par 
\par }
50
Scribble50
<new topic>




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 <new topic>\cf0\b0\fs20 
\par 
\par 
\par }
60
Scribble60
Creating & Organizing Indices




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Creating & Organizing Indices\cf0\b0\f1\fs20 
\par 
\par 
\par }
80
Scribble80
Creating & Organizing Aamdex Files




Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\fs32 Creating & Organizing Aamdex Files\cf0\b0\f1\fs20 
\par 
\par 
\par }
0
1
Help File Title=helpfile.hlp
0
8
1 Introduction to A/P System=Scribble5
1 How To...
2 Creating the Database=Scribble20
2 Creating Files & Tables=Scribble30
2 Creating Fields Within your Files=Scribble40
2 Creating & Organizing Indices=Scribble60
1 <new topic>=Scribble25
1 <new topic>=Scribble50
6
*InternetLink
16711680
Courier New
0
10
1
....
0
0
0
0
0
0
*ParagraphTitle
-16777208
Arial
0
11
1
B...
0
0
0
0
0
0
*PopupLink
-16777208
Arial
0
8
1
....
0
0
0
0
0
0
*PopupTopicTitle
16711680
Arial
0
10
1
B...
0
0
0
0
0
0
*TopicText
-16777208
Arial
0
10
1
....
0
0
0
0
0
0
*TopicTitle
16711680
Arial
0
16
1
B...
0
0
0
0
0
0
