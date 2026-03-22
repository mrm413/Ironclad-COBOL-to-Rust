IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC 9.
          88 x-wrong-init   value space.
       01 Y             PIC X.
          88 y-wrong-init   value low-value.

       PROCEDURE        DIVISION.
           SET x-wrong-init  TO TRUE.
           SET y-wrong-init  TO TRUE.
           STOP RUN.