.------------------------------------------------------------------------------
.     Name: DateRoutines.pls
. Language: PL/B
.   Author: Brian C. Swing & Stuart Elliott
.           Judicial Information Services
.           Clay County
.           Liberty, MO
.     Date: Aug 09, 2001
.  Purpose: Date Routines -
.     CalDateToDays - Computes a linearized date from a Gregorian calendar date.
.                           Originally written in Cobol by KEN WEISS JR.
.                           Can be located on a FTP site (ftp.bw.edu) at /pub/MCS/kweiss.
.     LinearDateToCalDate - Computes a Gregorian calendar date from a linearized date.
.                           Originally written in Cobol by KEN WEISS JR.
.                           Can be located on a FTP site (ftp.bw.edu) at /pub/MCS/kweiss.
.     DowFromLinearDate - Computes a day of week from a linearized date.
.                           Originally written in Cobol by KEN WEISS JR.
.                           Can be located on a FTP site (ftp.bw.edu) at /pub/MCS/kweiss.
.     ComputedDate - Computes a date in the future or past from a certain date.
.                    Can set a couple of switches so that it doesn't fall on
.                    a work day or holiday.
.Revisions:
.------------------------------------------------------------------------------
.------------------------------------------------------------------------------
. * tests the date routines
mm dim  2
dd dim  2
yy dim  4
nmm form  2
ndd form  2
nyy form  4
ldate form 10
ldate2 form 10
form10 form 10
ans dim  1
form01  form 1
form05  form 5
work09  dim  9
work08  dim  8
work08a dim  8
.     trap Esc if esc
           goto              #end
     loop
        keyin *zf,*kcon:
              *p01:05,"mm:",mm:
              *p01:06,"dd:",dd:
              *p01:07,"ccyy:",yy:
              *p01:08,"## of days:",form05;
        display *p01:09,mm,"/",dd,"/",yy;
        pack work08 with yy,mm,dd
        rep " 0" in work08
        call ComputedDate using work08,form05,"Y","Y",work08a,form01,work09
        unpack work08a into yy,mm,dd
        display *p01:10,"day of week: ",work09,"(",form01,")":
                *p01:11,"       date: ",mm,"/",dd,"/",yy;
        keyin ans;
     repeat
Esc
     stop
.------------------------------------------------------------------------------
.------------------------------------------------------------------------------
linearDate form              ^
inDate   dim  8    // ccyymmdd
outDate  dim  8    // ccyymmdd
OutDate2 DIM  ^
month    form 2    // mm
day      form 2    // dd
year     form 4    // ccyy
days2Add form 5
workDay  dim  1      // fall on work day 'Y'es or 'N'o
hldayChk dim  1      // make sure it doesn't fall on a holiday, 'Y'es, 'N'o

holdp    form .5
hold0    form 10
hold0p   form 10.5
hold2    form 10
hold4    form 10
hold00   form 10
hold1    form 10
hold11   form 10
hold22   form 10
hold3    form 10
hold33   form 10
hold44   form 10
hold55   form 10
hold66   form 10
hold77   form 10

..HR 10.31.2011  dayOfWeek form 1    // 1=Sunday, 2=Monday, ..., 6=Friday, 7=Saturday  see below
dayOfWeek form ^    // 1=Sunday, 2=Monday, ..., 6=Friday, 7=Saturday  see below
weekDay   dim  9(7),("Sunday"),("Monday"),("Tuesday"):
                     ("Wednesday"),("Thursday"),("Friday"),("Saturday")
..HR 10.31.2011  dowString dim  9
dowString dim  ^

wrkMM     form 2    // working month
wrkDD     form 2    // working day
wrkYear   form 4    // working year
wrkDate   dim  8    // working date ccyymmdd

wrkDow    form 1    // working day of week, 1=sun, 2=mon, ...,7=sat
wrkLinear form 10   // working linear date
wrkLinear2 form 10  // working linear date
wrkString dim  9    // working dow string

nwork01   form 1
nwork02   form 2
nwork10   form 10
work35    dim  35

easter    dim  8
easterMM  form 2

form1     form 5
form2     form 5
form3     form 5
form4     form 5
form5     form 5
form6     form 5
nccyy     form 4
.------------------------------------------------------------------------------
. Computes a linearized date from a Gregorian calendar date
. Where day 1 equals January 1, 1900
. Input parameters:
.   inDate     - ccyymmdd
. Output parameters:
.   linearDate - a ten-digit value

CalDateToDays ROUTINE inDate,linearDate
           unpack            inDate into year,month,day
           calc              hold0 = month - 14
           calc              hold00 = hold0 / 12
           calc              hold1 = 1461 * (year + 4800 + hold00)
           calc              hold11 = hold1 / 4

           calc              hold2 = 367 * (month - 2 - 12 * hold00)
           calc              hold22 = hold2 / 12

           calc              hold3 = year + 4900 + hold00
           calc              hold33 =  hold3 / 100
           calc              hold4 = hold33 * 3
           calc              hold44 = hold4 / 4

           calc              linearDate = day - 2447095 + hold11 + hold22 - hold44 - 1
. *
           return
.------------------------------------------------------------------------------
. Computes a Gregorian calendar date from a linearized date
. Where day 1 equals January 1, 1900
. Input parameter is:
.   linearDate - a ten-digit value
. Output parameters:
.   outDate    - ccyymmdd

LinearDateToCalDate ROUTINE linearDate,outDate2
           ADD               "1",linearDate
     calc hold00 = linearDate + 2483589
     calc hold11 = 4 * hold00 / 146097

     calc hold2 = (hold11 * 146097 + 3) / 4
     calc hold22 = hold00 - hold2
     calc hold33 = (4000 * (hold22 + 1)) / 1461001

     calc hold4 = (hold33 * 1461) / 4
     calc hold44 = hold22 - hold4 + 31
     calc hold55 = (hold44 * 80) / 2447
     calc hold66 = (hold55 * 2447) / 80
     calc day = hold44 - hold66
     calc hold77 = hold55 / 11

     calc month = hold55 + 2 - 12 * hold77
     calc year = 100 * (hold11 - 49) + hold33 + hold77
     pack outDate2 with year,month,day
     rep " 0" in outDate2
. *
     return
.------------------------------------------------------------------------------
. Computes a day of week from a linearized date
. Where day 1 is Sunday, day 2 is Monday, day 7 is Saturday
. Input parameters:
.   linearDate - a ten-digit value
. Output parameters:
.   dayOfWeek - single-digitvalue
.   dowString - string variable of day of week

DowFromLinearDate ROUTINE linearDate,dayOfWeek,dowString
     divide "7" into linearDate giving hold0p
     move hold0p to holdp                // determine the remainder
     calc dayOfWeek = holdp * 7          // ''
     add "1" to dayOfWeek
     move weekDay(dayOfWeek) to dowString
. *
     return
.------------------------------------------------------------------------------
. Computes a date in the future or past from a certain date.
. Can make sure it doesn't fall on a weekend day or holiday
. Input parameters:
.   inDate    - starting date, ccyymmdd
.   days2Add  - number of days to add or subtract
.   workDay   - must fall on work day, 'Y'es or 'N'o
.   hldayChk  - make sure it doesn't fall on a holiday,
.               'Y'es (exclude holidays), 'N'o (include holidays)
. Output parameters:
.   outDate   - calculated date, ccyymmdd
.   dayOfWeek - day of week single-digit value
.   dowString - string variable of day of week
.------------------------------------------------------------------------------
. Holidays that are looked at:
.    New Years
.    Martin Luther King Jr.
.    Lincoln's Birthday
.    President's Day
.    President Truman's Birthday (Commented Out)
.    Easter
.    Memorial Day
.    Independence Day
.    Labor Day
.    Columbus Day
.    Veterans Day
.    Thanksgiving
.    Day after Thanksgiving
.    Christmas
.------------------------------------------------------------------------------

valid    form 1   // valid date
ComputedDate procedure using inDate,days2Add,workDay,hldayChk:
                             outDate,wrkDow,wrkString
. * get the linear date
     call CalDateToDays using inDate,wrkLinear
. * add # of days to linear date
     add days2Add to wrkLinear
. * get the Gregorian calendar date for the linear date
     call LinearDateToCalDate using wrkLinear,outDate
     call DowFromLinearDate using wrkLinear,wrkDow,wrkString

. * work day option
     if (workDay = "Y")   // make sure it falls on work day
        if (dayOfWeek = 1 | dayOfWeek = 7)
           if (dayOfWeek = 1)   // fell on sunday, add 1
              add "1" to wrkLinear
           else                  // fell on saturday, add 2
              add "2" to wrkLinear
           endif
.         * get the Gregorian calendar date for the linear date
           call LinearDateToCalDate using wrkLinear,outDate
           call DowFromLinearDate using wrkLinear,wrkDow,wrkString
        endif
     endif
. * 1=sun,2=mon,...,6=fri,7=sat
. * holiday option
     if (hldayChk = "Y")
        loop
           unpack outDate into wrkYear,wrkMM,wrkDD
           move wrkYear to nccyy
           call ComputeEaster
           clear valid
           select using wrkMM
           when "1"    // january holidays
.             * new years day (Jan 1)
              if (wrkDD = 1)
                 call IncrementToNextWorkday
                 set valid
              else
.                * martin luther king (3rd Mon in Jan)
.                * determine what day it falls on
                 pack wrkDate with wrkYear,"01","01"
                 call CalDateToDays using wrkDate,nwork10
                 call DowFromLinearDate using nwork10,nwork01,work35
                 if (nwork01 = 1 | nwork01 = 2)    // sunday or monday
                    calc nwork02 = 16 - (nwork01 - 1)
                 else                              // tuesday, wednesday, ...
                    calc nwork02 = 21 - (nwork01 - 3)
                 endif
.                * see if it falls on the same day
                 if (nwork02 = wrkDD)              // increment if it does
                    call IncrementToNextWorkday
                    set valid
                 endif
              endif
           when "2"    // feburary
.             * lincoln's birthday (Feb 12)
              if (wrkDD = 12)
                 call IncrementToNextWorkday
                 set valid
              else
.                * President's Day (3rd Mon in Feb)
.                * determine what day it falls on
                 pack wrkDate with wrkYear,"02","01"
                 call CalDateToDays using wrkDate,nwork10
                 call DowFromLinearDate using nwork10,nwork01,work35
                 if (nwork01 = 1 | nwork01 = 2)    // sunday or monday
                    calc nwork02 = 16 - (nwork01 - 1)
                 else                              // tuesday, wednesday, ...
                    calc nwork02 = 21 - (nwork01 - 3)
                 endif
.                * see if it falls on the same day
                 if (nwork02 = wrkDD)              // increment if it does
                    call IncrementToNextWorkday
                    set valid
                 endif
              endif
           when "3"    // march
.             * easter
.             if (ndx = easterMM)
.                unpack easter into ccyy,nwork02
.                * see if it falls on the same day
.                if (nwork02 = wrkDD)              // increment if it does
.                   call IncrementToNextWorkday
.                   set valid
.                endif
.             endif
           when "4"    // april
.             * easter
.              if (ndx = easterMM)
.                 unpack easter into ccyy,nwork02
..                * see if it falls on the same day
.                 if (nwork02 = wrkDD)              // increment if it does
.                    call IncrementToNextWorkday
.                    set valid
.                 endif
.              endif
           when "5"    // may
.             * truman's birthday (May 8)
              if (wrkDD = 8)
..                 call IncrementToNextWorkday
..                 set valid
              else
.                * memorial day (last Mon in May)
.                * determine what day it falls on
                 pack wrkDate with wrkYear,"05","01"
                 call CalDateToDays using wrkDate,nwork10
                 call DowFromLinearDate using nwork10,nwork01,work35
                 if (nwork01 >= 1 & nwork01 <= 6)    // sunday through friday
                    calc nwork02 = 30 - (nwork01 - 1)
                 else                                // saturday
                    move "31" to nwork02
                 endif
.                * see if it falls on the same day
                 if (nwork02 = wrkDD)                // increment if it does
                    call IncrementToNextWorkday
                    set valid
                 endif
              endif
           when "6"    // june
           when "7"    // july
.             * independence day (July 4)
              if (wrkDD = 4)
                 call IncrementToNextWorkday
                 set valid
              endif
           when "8"    // august
           when "9"    // sepetember
.             * labor day (1st Mon in Sept)
.             * determine what day it falls on
              pack wrkDate with wrkYear,"09","01"
              call CalDateToDays using wrkDate,nwork10
              call DowFromLinearDate using nwork10,nwork01,work35
              if (nwork01 = 1 | nwork01 = 2)    // sunday or monday
                 calc nwork02 = 2 - (nwork01 - 1)
              else                              // tuesday, wednesday, ...
                 calc nwork02 = 7 - (nwork01 - 3)
              endif
.             * see if it falls on the same day
              if (nwork02 = wrkDD)              // increment if it does
                 call IncrementToNextWorkday
                 set valid
              endif
           when "10"   // october
.             * columbus day (2nd Mon in oct)
.             * determine what day it falls on
              pack wrkDate with wrkYear,"10","01"
              call CalDateToDays using wrkDate,nwork10
              call DowFromLinearDate using nwork10,nwork01,work35
              if (nwork01 = 1 | nwork01 = 2)    // sunday or monday
                 calc nwork02 = 9 - (nwork01 - 1)
              else                            // tuesday, wednesday, ...
                 calc nwork02 = 14 - (nwork01 - 3)
              endif
.             * see if it falls on the same day
              if (nwork02 = wrkDD)            // increment if it does
                 call IncrementToNextWorkday
                 set valid
              endif
           when "11"   // november
.             * veteran's day (Nov 11)
              if (wrkDD = 11)
                 call IncrementToNextWorkday
                 set valid
              else
.                * thanksgiving day (4th Thur in Nov)
.                * determine what day it falls on
                 pack wrkDate with wrkYear,"11","01"
                 call CalDateToDays using wrkDate,nwork10
                 call DowFromLinearDate using nwork10,nwork01,work35
                 if (nwork01 >= 1 & nwork01 <= 5)    // sunday through thursday
                    calc nwork02 = 26 - (nwork01 - 1)
                 else                            // friday or saturday
                    calc nwork02 = 28 - (nwork01 - 6)
                 endif
.                * see if it falls on the same day
                 if (nwork02 = wrkDD)            // increment if it does
                    call IncrementToNextWorkday
                    set valid
                 endif
.                * day after thanksgiving
                 add "1" to nwork02
                 if (nwork02 = wrkDD)            // increment if it does
                    call IncrementToNextWorkday
                    set valid
                 endif
              endif
           when "12"   // december
.             * christmas day (Dec 25)
              if (wrkDD = 25)
                 call IncrementToNextWorkday
                 set valid
              endif
           endselect
        while (valid)   // date is ok
        repeat
     endif

. *
     return
.------------------------------------------------------------------------------
. * increment wrkLinear to next day
IncrementToNextWorkday
     add "1" to wrkLinear
.    * get the Gregorian calendar date for the linear date
     call LinearDateToCalDate using wrkLinear,outDate
     call DowFromLinearDate using wrkLinear,wrkDow,wrkString
. * work day option
     if (workDay = "Y")   // make sure it falls on work day
        if (wrkDow = 1 | wrkDow = 7)
           if (wrkDow = 1)   // fell on sunday, add 1
              add "1" to wrkLinear
           else                  // fell on saturday, add 2
              add "2" to wrkLinear
           endif
.         * get the Gregorian calendar date for the linear date
           call LinearDateToCalDate using wrkLinear,outDate
           call DowFromLinearDate using wrkLinear,wrkDow,wrkString
        endif
     endif
. *
     return
.------------------------------------------------------------------------------
. Algorithm was copied from web site http://aa.usno.navy.mil/faq/docs/easter.html
. The algorithm is due to J.-M. Oudin (1940) and is reprinted in
. the Explanatory Supplement to the Astronomical Almanac,
. ed. P. K. Seidelmann (1992). See Chapter 12, "Calendars", by L. E. Doggett
. * compute easter
ComputeEaster
     calc form1 = nccyy / 100
     calc form2 = nccyy - 19 * (nccyy / 19)
     calc form5 = (form1 - 17) / 25
     calc form3 = form1 - form1 / 4 - (form1 - form5) / 3 + 19 * form2 + 15
     calc form3 = form3 - 30 * (form3 / 30)
     calc form3 = form3 - (form3 / 28) * (1 - (form3 / 28) * (29 / (form3 + 1)) * ((21 - form2) / 11))
     calc form4 = nccyy + nccyy / 4 + form3 + 2 - form1 + form1 / 4
     calc form4 = form4 - 7 * (form4 / 7)
     calc form6 = form3 - form4
     calc nmm = 3 + (form6 + 40) / 44
     calc ndd = form6 + 28 - 31 * (nmm / 4)
     pack easter with nccyy,nmm,ndd
     rep " 0" in easter
     move nmm to easterMM
. *
     return
.------------------------------------------------------------------------------
.------------------------------------------------------------------------------
#end
