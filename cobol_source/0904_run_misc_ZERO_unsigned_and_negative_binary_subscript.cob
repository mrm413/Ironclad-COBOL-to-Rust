IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       77  UBIN        PIC  9(8) BINARY.
       77  SBIN        PIC S9(8) BINARY.
       77  UNUP        PIC  9(8).
       77  SNUP        PIC S9(8).
       77  UCHR        BINARY-CHAR UNSIGNED.
       77  SCHR        BINARY-CHAR SIGNED.

       01  TSTREC.
           05       PIC X(4) OCCURS 300 TIMES VALUE ZERO.
           05  TSTX PIC X(4) OCCURS   3 TIMES.
           05  TSTY PIC X(4) OCCURS 300 TIMES.

       PROCEDURE DIVISION.
           MOVE ALL 'A' TO TSTX(1).
           MOVE ALL 'B' TO TSTX(2).
           MOVE ALL 'C' TO TSTX(3).
           MOVE ALL '1' TO TSTY(1).
           MOVE ALL '2' TO TSTY(2).
           MOVE ALL '3' TO TSTY(3).
           MOVE 0  TO UNUP.
           DISPLAY "UNUP: " UNUP " is :" TSTY(UNUP) ":" UPON CONSOLE.
           MOVE 0  TO SNUP.
           DISPLAY "SNUP: " SNUP " is :" TSTY(SNUP) ":" UPON CONSOLE.
           MOVE 0  TO SBIN.
           DISPLAY "SBIN: " SBIN " is :" TSTY(SBIN) ":" UPON CONSOLE.
           MOVE -1 TO SBIN.
           DISPLAY "SBIN: " SBIN " is :" TSTY(SBIN) ":" UPON CONSOLE.
           MOVE 'xxx'   TO TSTY(SBIN).
           DISPLAY "SBIN: " SBIN " is :" TSTY(SBIN) ":" UPON CONSOLE.
      * The following would often core dump
           MOVE 0 TO UBIN.
           DISPLAY "UBIN: " UBIN " is :" TSTY(UBIN) ":" UPON CONSOLE.
           MOVE 'yyy'   TO TSTY(UBIN).
           MOVE 1 TO UBIN.
           DISPLAY "UBIN: " UBIN " is :" TSTY(UBIN) ":" UPON CONSOLE.
           MOVE 0 TO UCHR.
           DISPLAY "UCHR: " UCHR " is :" TSTY(UCHR) ":" UPON CONSOLE.
           MOVE -1 TO SCHR.
           DISPLAY "SCHR: " SCHR " is :" TSTY(SCHR) ":" UPON CONSOLE.
           MOVE 'zzz' TO TSTY (129).
           MOVE 129 TO UCHR.
           DISPLAY "UCHR: " UCHR " is :" TSTY(UCHR) ":" UPON CONSOLE.
           STOP RUN.