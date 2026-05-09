IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
      ******************************************************************
       WORKING-STORAGE SECTION.
       01  FLDX50   PIC X(50)    VALUE 'X50'.
       01  FLDX10J  PIC X(10)    VALUE '0123'.
       01  FLDNUMD  PIC S9(3)    VALUE -123.
       01  FLDNUMD4 PIC S9(4)    VALUE -123.
       01  FLDNUMB  PIC S9v99    VALUE -1.23 USAGE BINARY.
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.

       PROCEDURE DIVISION.
       MAIN-LINE.

      *>   Test with DISPLAY on error
           PERFORM DO-CHECK
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *>   minimal side-test for performance comparisons
           PERFORM DO-CHECK 20000 TIMES
       >> END-IF
           GOBACK.

       DO-CHECK.
           MOVE "123" TO FLDX50
           IF 123        =  FLDX50     CONTINUE
           ELSE                        DISPLAY '! 123  <> "123"'.
           IF FLDNUMD    =  FLDNUMD4   CONTINUE
           ELSE                        DISPLAY '! 123  <> 0123'.
           IF FLDX50     =  FLDNUMD4   DISPLAY '! "123" = 0123'
           ELSE                        CONTINUE.
           IF FLDNUMD    =  FLDX50     CONTINUE
           ELSE                        DISPLAY '!-123 DISP <> "123"'.
           IF FLDX50     =  FLDNUMB    CONTINUE
           ELSE                        DISPLAY '!-1.23 BIN  <> "123"'.
           IF FLDX10J    =  FLDNUMD4   CONTINUE
           ELSE                        DISPLAY '! "0123" J  <> "0123"'.