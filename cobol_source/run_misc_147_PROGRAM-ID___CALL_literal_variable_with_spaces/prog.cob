IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  MYRTN  PIC X(9) VALUE " SUB  ".

       PROCEDURE DIVISION.
           CALL " SUB " USING 'X'.
           MOVE x'00' TO MYRTN (6:1).
           CALL MYRTN   USING 'Y'.
           CALL "SUB"   USING 'Z'.
           CALL "S U B" USING 'A'.
           MOVE " S U B" TO MYRTN.
           CALL MYRTN   USING 'B'.
           STOP RUN.
       END PROGRAM prog.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. "SUB ".

       DATA DIVISION.
       LINKAGE SECTION.
       01  x  PIC X.

       PROCEDURE DIVISION USING x.
            DISPLAY "SUB GOT " X
            END-DISPLAY.
       END PROGRAM " SUB".

       IDENTIFICATION DIVISION.
       PROGRAM-ID. "S U B".

       DATA DIVISION.
       LINKAGE SECTION.
       01  x  PIC X.

       PROCEDURE DIVISION USING x.
            DISPLAY "S U B  GOT " X
            END-DISPLAY.
       END PROGRAM "S U B".