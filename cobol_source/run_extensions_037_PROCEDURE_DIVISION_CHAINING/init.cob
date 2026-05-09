IDENTIFICATION   DIVISION.
       PROGRAM-ID.      init.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  VAR.
           03  X            PIC X VALUE 'a'.
           03  ABCD         PIC X(4).
           03  NUM          PIC 9  VALUE 7.
       77  NUM2             PIC 99 VALUE 2.
       PROCEDURE        DIVISION
                        CHAINING VAR.
           DISPLAY '-' VAR NUM2 '-' WITH NO ADVANCING
           END-DISPLAY
           INITIALIZE  VAR NUM2
           DISPLAY '-' VAR NUM2 '-' WITH NO ADVANCING
           MOVE 'XXXX' TO ABCD
           INITIALIZE  VAR NUM2 ALL TO VALUE
           DISPLAY '-' VAR NUM2 '-' WITH NO ADVANCING
           MOVE ALL 'b' TO ABCD
           INITIALIZE  VAR NUM2 ALL TO VALUE THEN TO DEFAULT
           DISPLAY '-' VAR NUM2 '-' WITH NO ADVANCING
           STOP RUN.