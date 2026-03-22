IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "ok.inc".

       PROCEDURE DIVISION.
       MAIN SECTION.
           PERFORM SEC-1.
           PERFORM SEC-2.
      * Directive purposefully in Area A
        REPLACE ==RUNNN== BY ==RUN==.
           PERFORM SEC-3.
           STOP RUN
           COPY "sec-1.inc".
       COPY "sec-2.inc".
       SEC-3 SECTION.
           DISPLAY KO NO ADVANCING.