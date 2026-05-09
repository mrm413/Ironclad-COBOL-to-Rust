IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  RETURN-DISP  PIC S9(08).
       PROCEDURE        DIVISION.
           CALL 'prog1' END-CALL
           IF RETURN-CODE NOT = -1
              MOVE RETURN-CODE TO RETURN-DISP
              DISPLAY 'RETURN-CODE ' RETURN-DISP
                      ' INSTEAD OF -1'
              END-DISPLAY
           END-IF
           CALL 'prog2' END-CALL
           IF RETURN-CODE NOT = 2
              MOVE RETURN-CODE TO RETURN-DISP
              DISPLAY 'RETURN-CODE ' RETURN-DISP
                      ' INSTEAD OF 2'
              END-DISPLAY
           END-IF
           STOP RUN.