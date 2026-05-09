IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"
            REPLACING LEADING TEST BY "FIRST"
                      LEADING "NORM" BY SECOND.
       PROCEDURE        DIVISION.
           STOP RUN.