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
           STOP RUNNN
           COPY "sec-1.inc".
      * Also purposefully in Area A
        COPY "sec-2.inc".