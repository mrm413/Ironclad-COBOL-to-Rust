IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY "ok.inc" REPLACING == 01 REPLACE-ME == BY ==
       01  OK PIC XX VALUE "OK". ==
           .

           PERFORM SEC-2
           STOP RUN
           CONTINUE
       SEC-1 SECTION.
           IF OK NOT EQUAL "OK" DISPLAY OK
       SEC-2 SECTION.
           IF OK NOT EQUAL "OK" DISPLAY OK.