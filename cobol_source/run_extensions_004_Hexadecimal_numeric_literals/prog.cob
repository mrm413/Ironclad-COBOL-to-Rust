IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-1           PIC 9(8) VALUE H"012345".
       01 X-2           PIC 9(8) VALUE H"FFFFFF".
       PROCEDURE        DIVISION.
           DISPLAY X-1
           END-DISPLAY.
           DISPLAY X-2
           END-DISPLAY.
           STOP RUN.