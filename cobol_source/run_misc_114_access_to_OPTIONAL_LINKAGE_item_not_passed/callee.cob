IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 X.
          05 Y          PIC X(4).
       PROCEDURE        DIVISION USING OPTIONAL X.
           IF Y NOT = '9876'
              DISPLAY Y.
           GOBACK.