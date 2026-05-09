identification division.
       program-id. prog-crt4.

       data division.
       working-storage section.

       01 crt4 pic 9(4) is special-names crt status.

       01 test-tab.
         05 test-01 pic x(20) value "Function key 01 1001".
         05 test-02 pic x(20) value "Function key 02 1002".
         05 test-03 pic x(20) value "Function key 03 1003".
         05 test-04 pic x(20) value "Function key 04 1004".
         05 test-05 pic x(20) value "Function key 05 1005".
         05 test-06 pic x(20) value "Prev-page key   2001".
         05 test-07 pic x(20) value "Next-page key   2002".

       01 test-rab-r redefines test-tab.
         05 test-data occurs 7 times.
           10 test-name         pic x(16).
           10 test-crt4         pic 9(4).

       01 linenr                pic 9(2) value 0.

       01 test-result-4         pic 9(4).

       01 return-value          pic 9 value 0.

       77 loop                  pic 9(2).
       77 test-field            pic x.


       procedure division.

       set environment 'COB_SCREEN_EXCEPTIONS' to 'TRUE'
       set environment 'COB_SCREEN_ESC'        to 'TRUE'

       perform forever
         display spaces with blank screen

         move 0 to return-value
         perform varying loop from 1 by 1 until loop > 7
           compute linenr = loop + 5

           display "Please press " line linenr, column 1
           display test-name(loop) line linenr, column 14

           move spaces to test-field
           accept test-field
            line linenr column 30

           display crt4 line linenr, column 30

           if crt4 = test-crt4(loop)
             display "passed" line linenr, column 36
           else
             move 1 to return-value
             display "failed" line linenr, column 36
           end-if
         end-perform

         if return-value = 0
           exit perform
         end-if

         display "Try again? (Y/n) " line 20, column 1
         move "Y" to test-field
         accept test-field line 20, column 18
         if not (test-field = "Y" or "y")
           exit perform
         end-if
       end-perform

       goback returning return-value
       .