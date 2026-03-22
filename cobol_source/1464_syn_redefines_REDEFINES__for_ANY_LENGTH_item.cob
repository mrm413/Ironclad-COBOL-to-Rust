IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 X             PIC X ANY LENGTH.
       01 Y REDEFINES X PIC X.
       01 N             PIC 9 ANY NUMERIC.
       01 M REDEFINES N PIC 9.
       PROCEDURE        DIVISION USING X N.
           STOP RUN.