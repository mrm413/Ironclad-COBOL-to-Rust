IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.
       01 A             REDEFINES X PIC X VALUE "A".
       01 G             REDEFINES X.
         02 B           PIC X VALUE "A".
       01 Y             REDEFINES X PIC X.
         88 C           VALUE "A".
       PROCEDURE        DIVISION.
           INITIALIZE G ALL TO VALUE *> the reason that this extension is useful
           STOP RUN.