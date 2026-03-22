IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x PIC 9 VALUE 0.
       01  y PIC 9 VALUE 0.

       PROCEDURE DIVISION.
           DIVIDE x BY y GIVING y
           IF FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
           NOT = 'EC-SIZE-ZERO-DIVIDE'
              DISPLAY 'Wrong/missing exception: '
                      FUNCTION EXCEPTION-STATUS
              END-DISPLAY
           END-IF
           SET LAST EXCEPTION TO OFF
           IF FUNCTION EXCEPTION-STATUS NOT = SPACES
              DISPLAY 'Exception is not empty after reset: '
                      FUNCTION EXCEPTION-STATUS
              END-DISPLAY
           END-IF
           MOVE 0 TO y
           COMPUTE y = x - 1 / y + 6.5
           IF FUNCTION TRIM(FUNCTION EXCEPTION-STATUS)
           NOT = 'EC-SIZE-ZERO-DIVIDE'
              DISPLAY 'Wrong/missing exception: '
                      FUNCTION EXCEPTION-STATUS
              END-DISPLAY
           END-IF
           .