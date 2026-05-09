identification division.
       program-id. prog.

       data division.
       working-storage section.
      *------------------------
       77 counter             pic s9(4) binary value zero.
      * FLOAT-LONG
       77 doubleValue         COMP-2 value 2.
       77 lastDoubleValue     COMP-2.

      ******************************************************************
       procedure division.
       main section.
           perform varying counter from 1 by 1 until
                           counter > 1060
      *>      display 'counter: ' counter ', value: ' doubleValue
              compute doubleValue = doubleValue * 2
                   ON SIZE ERROR
                      display 'SIZE ERROR raised'
                              with no advancing upon syserr
                      end-display
                      display 'SIZE ERROR, last value = ' doubleValue
                              upon sysout
                      end-display
                      exit perform
               not ON SIZE ERROR
                      if doubleValue > lastdoubleValue
                         move doubleValue to lastdoubleValue
                      else
                         display 'math ERROR, last value > current: '
                                 lastdoubleValue ' > ' doubleValue
                                 upon syserr
                         end-display
                         exit perform
                      end-if
              end-compute
           end-perform
           if not (counter >= 1023 and <=1025)
              display ' '                   upon syserr
              display 'counter is ' counter upon syserr
           end-if

           goback.