IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x PIC 9 VALUE 1.
       01  y PIC 9.

       PROCEDURE DIVISION.
      *    raise exception checked in previous test
      *    as it may interfere with the expected exception
           DIVIDE x BY y GIVING y
           DIVIDE x BY 0.1 GIVING y
           IF FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
           NOT = 'EC-SIZE-OVERFLOW'
              DISPLAY 'Wrong/missing exception: '
                      FUNCTION EXCEPTION-STATUS
              END-DISPLAY
           END-IF
           .