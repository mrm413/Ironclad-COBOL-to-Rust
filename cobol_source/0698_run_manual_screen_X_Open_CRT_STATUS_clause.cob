identification division.
       program-id. prog-crt3.

       data division.
       working-storage section.

       01 crt3 is special-names crt status.
         05 crt3-1   pic 9.
         05 crt3-2   usage binary-char unsigned.
         05 crt3-3   usage binary-char unsigned.

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
           10 test-crt31        pic 9.
           10 test-crt32        pic 9(3).

       01 linenr                pic 9(2) value 0.

       01 test-result-1         pic 9.
       01 test-result-3         pic 9(3).

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

           move crt3-1 to test-result-1
           display test-result-1 line linenr, column 30

           move crt3-2 to test-result-3
           display test-result-3 line linenr, column 32

           if test-result-1 = test-crt31(loop) and
            test-result-3 = test-crt32(loop)
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