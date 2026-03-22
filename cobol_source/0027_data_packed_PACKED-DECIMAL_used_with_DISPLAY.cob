IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-99          PIC 99   USAGE PACKED-DECIMAL.
       01 X-S99         PIC S99  USAGE PACKED-DECIMAL.
       01 X-999         PIC 999  USAGE PACKED-DECIMAL.
       01 X-S999        PIC S999 USAGE PACKED-DECIMAL.
       01 B-P1234       USAGE BINARY-LONG VALUE 1234.
       01 B-N1234       USAGE BINARY-LONG VALUE -1234.
       PROCEDURE        DIVISION.
           MOVE    0 TO X-99
           DISPLAY X-99.
           MOVE   99 TO X-99
           DISPLAY X-99.
           MOVE    0 TO X-S99
           DISPLAY X-S99.
           MOVE   -1 TO X-S99
           DISPLAY X-S99.
           MOVE    0 TO X-999
           DISPLAY X-999.
           MOVE  123 TO X-999
           DISPLAY X-999.
           MOVE    0 TO X-S999
           DISPLAY X-S999.
           MOVE -123 TO X-S999
           DISPLAY X-S999.
           MOVE B-P1234 TO X-S999
           DISPLAY X-S999.
           MOVE B-N1234 TO X-S999
           DISPLAY X-S999.
           MOVE B-N1234 TO X-999
           DISPLAY X-999.
           STOP RUN.