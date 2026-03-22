IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       SCREEN           SECTION.
       *> Valid numbers
       01  v1           VALUE "-" LINE 1.
       01  v2           VALUE "-" LINE + 1.
       01  v3           VALUE "-" LINE - 1.
       01  v4           VALUE "-" LINE 0.

       *> invalid numbers
       01  i1           VALUE "-" LINE +1.
       01  i2           VALUE "-" LINE -1.
       01  i3           VALUE "-" LINE 1.0.
       PROCEDURE        DIVISION.
           STOP RUN.