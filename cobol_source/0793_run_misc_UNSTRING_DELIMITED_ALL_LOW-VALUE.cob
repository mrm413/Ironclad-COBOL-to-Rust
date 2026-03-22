IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  G.
           03 FILLER    PIC XXX VALUE "ABC".
           03 FILLER    PIC XX  VALUE LOW-VALUES.
           03 FILLER    PIC XXX VALUE "DEF".
       01  A            PIC XXX.
       01  B            PIC XXX.
       PROCEDURE        DIVISION.
           UNSTRING G DELIMITED BY ALL LOW-VALUES
                      INTO A B
           END-UNSTRING.
           IF A NOT = "ABC"
              DISPLAY A.
           IF B NOT = "DEF"
              DISPLAY B.
           STOP RUN.