IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 VAL           PIC X(5) VALUE "43512".
       01 TBL           REDEFINES VAL PIC X OCCURS 5.
       PROCEDURE        DIVISION.
           SORT TBL ASCENDING
           IF VAL NOT = "12345" DISPLAY VAL.
           STOP RUN.