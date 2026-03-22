identification division.
       program-id. prog.

       data division.
       working-storage section.

       77 my-status  pic 9(05) is special-names crt status.

       77 loop       pic 99.
       77 test-field pic x(5).

       screen section.

       01 screen-example .
          05 message1  value is "status:     " line 1 col 10.
          05 filler    pic 9(05) from  my-status.

          05 message2  value is "test-field: " line 2 col 10.
          05 filler    pic x(5) using test-field.

       procedure division.

           set environment 'COB_SCREEN_EXCEPTIONS' to 'TRUE'
           set environment 'COB_SCREEN_ESC'        to 'TRUE'
           perform varying loop from 1 by 1
                  until loop > 10
              display "screen accept no. "
                      at line 10 col 4
                      loop "/10"
              display screen-example
              accept  screen-example
           end-perform

           goback.