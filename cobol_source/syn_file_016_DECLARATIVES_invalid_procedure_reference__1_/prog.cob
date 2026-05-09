IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT GO-FILE   ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS LINE SEQUENTIAL.
       SELECT PERF-FILE ASSIGN       "./TEST-FILE"
                        ORGANIZATION IS LINE SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD GO-FILE.
       01 GO-REC      PIC X(4).
       FD PERF-FILE.
       01 PERF-REC      PIC X(4).
       PROCEDURE        DIVISION.
       DECLARATIVES.
       G01 SECTION.
           USE AFTER ERROR PROCEDURE ON GO-FILE.
       G02.
           DISPLAY "OK".
      *    explicit check both PERFORM and GO TO - silencing its warning
           GO TO GG02.
       P01 SECTION.
           USE AFTER ERROR PROCEDURE ON PERF-FILE.
       P02.
           DISPLAY "OK"
           END-DISPLAY.
      * programs may do this -> nothing happens there with PERF-FILE
           PERFORM PPOK.
      * programs should not do this
      * (the compiler currently cannot distinguish this)
           PERFORM PP02.
       END DECLARATIVES.
       GG01 SECTION.
       GG02.
           OPEN  INPUT GO-FILE.
           CLOSE GO-FILE.
       PP01 SECTION.
       PP02.
           OPEN  INPUT PERF-FILE.
           CLOSE PERF-FILE.
       PP03.
           DISPLAY 'LOG OUTPUT HERE'.
       PPOK.
           STOP RUN.