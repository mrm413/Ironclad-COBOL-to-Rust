IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X value '1'.
       01 X             PIC X value '2'.
       01 G             REDEFINES X PIC 9.
       PROCEDURE        DIVISION.
           IF G NOT = 2
              DISPLAY 'G IS ' G.
           STOP RUN.