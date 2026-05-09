IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-X           PIC XXXX VALUE "0001".
       01 X-9           PIC 9999 COMP VALUE 1.
       PROCEDURE        DIVISION.
         IF X-X NOT = X-9
            DISPLAY "NG X-X <> X-9".
         IF X-9 NOT = X-X
            DISPLAY "NG X-9 <> X-X".
         STOP RUN.