IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4).
       01 Y             PIC X(8).
       01 Z             PIC 9(4).
       PROCEDURE        DIVISION.
           DISPLAY "TEST_ENV" UPON ENVIRONMENT-NAME
           END-DISPLAY.
           ACCEPT X FROM ENVIRONMENT-VALUE
           END-ACCEPT.
           DISPLAY "(" X ")"
           END-DISPLAY.
           DISPLAY "RXW" UPON ENVIRONMENT-VALUE
           END-DISPLAY.
           ACCEPT X FROM ENVIRONMENT-VALUE
           END-ACCEPT.
           DISPLAY "(" X ")"
           END-DISPLAY.
           ACCEPT Y FROM ARGUMENT-VALUE
           END-ACCEPT.
           DISPLAY "(" Y ")"
           END-DISPLAY.
           ACCEPT Z FROM ARGUMENT-NUMBER
           END-ACCEPT.
           DISPLAY "(" Z ")"
           END-DISPLAY.
           STOP RUN.