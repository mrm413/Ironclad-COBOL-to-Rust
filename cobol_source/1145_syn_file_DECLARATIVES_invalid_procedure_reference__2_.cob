IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TEST-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS LINE SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD TEST-FILE.
       01 TEST-REC      PIC X(4).
       PROCEDURE        DIVISION.
       DECLARATIVES.
       P01 SECTION.
           USE AFTER ERROR PROCEDURE ON TEST-FILE.
       P02.
           DISPLAY "OK"
           END-DISPLAY.
       END DECLARATIVES.
       PP01 SECTION.
       PP02.
           OPEN  INPUT TEST-FILE.
           CLOSE TEST-FILE.
           PERFORM P02.
           GO TO P02.
           STOP RUN.