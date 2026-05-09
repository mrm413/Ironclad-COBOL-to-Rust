identification division.
       program-id. prog.

       data division.
       working-storage section.

       01 my-cur is special-names cursor.
          05 my-row pic  9(3) value 0.
          05 my-col pic  9(3) value 0.

       77 loop      pic 99.
       77 cursor-moves-here pic x(20).

       screen section.

       01 screen-example .
          05 message1  value is "row (view only)   is " line 1 col 10.
          05 filler    pic 9(3) from  my-row.

          05 message2  value is "col (adjust only) is " line 2 col 10.
          05 filler    pic 9(3) using my-col.

          05 filler    pic x(20) using cursor-moves-here line 3 col 14.

       procedure division.

           perform varying loop from 1 by 1
                  until loop > 10
              display "screen accept no. "
                      at line 10 col 4
                      loop "/10"
              display screen-example
              accept  screen-example
           end-perform

           goback.