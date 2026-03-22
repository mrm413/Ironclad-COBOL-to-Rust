IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
       01 Y-A           PIC A.
       01 Y-X           PIC X.
       01 Y-BX          PIC BX.
       01 Y-N           PIC N.
       01 Y-9           PIC 9.
       01 Y-09          PIC 09.
       PROCEDURE        DIVISION.
           MOVE X TO Y-A.
           MOVE X TO Y-X.
           MOVE X TO Y-BX.
           MOVE X TO Y-N.
           MOVE X TO Y-9.
           MOVE X TO Y-09.
           STOP RUN.