IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 GET-VALUE.
       COPY "copy.inc" REPLACING ==TEST-VAR==     BY ==TEST-AVR==
                                 == 02 TEST-EE == BY == 02 TEST-FF ==.
       PROCEDURE DIVISION.
           DISPLAY TEST-AVR.
           STOP RUN.