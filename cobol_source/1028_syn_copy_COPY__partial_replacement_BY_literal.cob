IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"
            REPLACING LEADING "TEST" BY "FIRST"
                      LEADING "NORM" BY "SECOND"
                      LEADING "X" BY "".
       COPY "copy2.inc"
            REPLACING TRAILING "FIRST" BY "VAR1"
                      TRAILING "SECND" BY "VAR2"
                      TRAILING "Y" BY "".
       PROCEDURE        DIVISION.
           DISPLAY FIRST-VAR  NO ADVANCING END-DISPLAY.
           DISPLAY SECOND-VAR NO ADVANCING END-DISPLAY.
           DISPLAY X          NO ADVANCING END-DISPLAY.
           DISPLAY TEST-VAR1  NO ADVANCING END-DISPLAY.
           DISPLAY TEST-VAR2  NO ADVANCING END-DISPLAY.
           DISPLAY Y          NO ADVANCING END-DISPLAY.
           STOP RUN.