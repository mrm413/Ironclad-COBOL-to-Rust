IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 W             PIC X.
       01 X             PIC X.
       01 Y             PIC X.
       01 Z             PIC X.
       PROCEDURE        DIVISION
           USING OPTIONAL W
                          X Y Z.
           DISPLAY NUMBER-OF-CALL-PARAMETERS.
           EXIT PROGRAM.