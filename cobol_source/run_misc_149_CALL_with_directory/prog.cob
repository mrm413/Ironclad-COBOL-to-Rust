IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  MYRTN  PIC X(9) VALUE "DIR/SUB".

       PROCEDURE DIVISION.
      *> doesn't exist there...
           CALL "SUB" USING '0'
              ON EXCEPTION CONTINUE.
      *> go by variable
           CALL MYRTN     USING 'X'.
           CALL "DIR/SUB" USING 'Y'.
      *> as it is already loaded - should work as-is
           CALL "SUB" USING 'Z'.
           CANCEL "SUB"
      *> the following will only show if physical cancel is not off...
           CALL "SUB" USING '0'
              ON EXCEPTION CONTINUE.
           STOP RUN.