IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 GROUP-1.
          05 FIELD-A           PIC X.
          05 FIELD-B           PIC Z9.
          05 INNER-GROUP.
             10 FIELD-C        PIC X.
          05 FIELD-D           PIC 9.
       01 GROUP-2.
          05 FIELD-A           PIC 9 VALUE 1.
          05 FIELD-B           USAGE BINARY-CHAR VALUE 2.
          05 INNER-GROUP.
             10 FIELD-C        USAGE FLOAT-SHORT VALUE 3.
          05 FIELD-D           PIC X VALUE "A".

       PROCEDURE DIVISION.
       SUBTRACT CORRESPONDING GROUP-2 FROM GROUP-1.
       IF FIELD-A IN GROUP-2 NOT EQUAL 1 THEN
           DISPLAY "BAD FIELD-A " FIELD-A IN GROUP-2
           END-DISPLAY
       END-IF.
       IF FIELD-B IN GROUP-2 NOT EQUAL 2 THEN
           DISPLAY "BAD FIELD-B " FIELD-B IN GROUP-2
           END-DISPLAY
       END-IF.
       IF FIELD-C IN GROUP-2 NOT EQUAL 3 THEN
           DISPLAY "BAD FIELD-C " FIELD-C IN GROUP-2
           END-DISPLAY
       END-IF.
       IF FIELD-D IN GROUP-2 NOT EQUAL "A" THEN
           DISPLAY "BAD FIELD-D " FIELD-D IN GROUP-2
           END-DISPLAY
       END-IF.
       STOP RUN.