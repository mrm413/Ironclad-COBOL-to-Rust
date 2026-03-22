IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P             PIC 99.
       PROCEDURE        DIVISION USING P.
           DISPLAY 'P: ' P WITH NO ADVANCING.
           STOP RUN RETURNING P.