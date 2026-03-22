IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X.

       LINKAGE          SECTION.
       01 Y             BASED.
          03  Z         PIC X.

       PROCEDURE        DIVISION.
           SET ADDRESS OF X TO NULL.
           SET ADDRESS OF Z TO NULL.
           STOP RUN.