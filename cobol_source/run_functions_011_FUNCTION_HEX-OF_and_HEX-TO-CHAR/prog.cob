IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X.
         03       PIC     X  VALUE SPACE.
         03       PIC   9(3) VALUE 12.
       01  Y      PIC   X(4) VALUE "HI.".
       01  BIN    PIC   9(9) BINARY VALUE 12.
       01  PAC    PIC   9(5) COMP-3 VALUE 1234.
       01  N9     PIC   9(2) USAGE NATIONAL VALUE 12.
       01  NX     PIC   N(2) VALUE N"!".
       01  HEXX   PIC   X(10).
           88 HEXX-FILLER VALUE ALL "-".
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==,
               ==END-DISPLAY== BY ==END-DISPLAY END-IF==.
       PROCEDURE        DIVISION.
       MAIN.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 300000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (X) DELIMITED BY SIZE INTO HEXX.
      *> Discover if running ASCII or EBCDIC
       >>IF   CHARSET = 'ASCII'
           IF HEXX NOT = "20303132--"
       >>ELIF CHARSET = 'EBCDIC'
           IF HEXX NOT = "40F0F1F2--"
       >>ELSE
           IF 1 = 1 DISPLAY 'CHARSET UNKNOWN! PLEASE REPORT!'
       >>END-IF
              DISPLAY "UNEXPECTED HEX-VALUE OF '0012': " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (Y) DELIMITED BY SIZE INTO HEXX.
       >>IF   CHARSET = 'ASCII'
           IF HEXX NOT = "48492E20--"
       >> ELSE
           IF HEXX NOT = "C8C94B40--"
       >> END-IF
              DISPLAY "UNEXPECTED HEX-VALUE OF 'HI! ': " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (BIN) DELIMITED BY SIZE INTO HEXX.
           IF HEXX NOT = "0000000C--"
              DISPLAY "UNEXPECTED HEX-VALUE OF BIN 12: " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (PAC) DELIMITED BY SIZE INTO HEXX.
           IF HEXX NOT = "01234F----"
              DISPLAY "UNEXPECTED HEX-VALUE OF PACKED 1234: " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (z"01") DELIMITED BY SIZE INTO HEXX.
       >>IF   CHARSET = 'ASCII'
           IF HEXX NOT = "303100----"
       >> ELSE
           IF HEXX NOT = "F0F100----"
       >> END-IF
              DISPLAY "UNEXPECTED HEX-VALUE OF z'01': " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (' ') DELIMITED BY SIZE INTO HEXX.
       >>IF   CHARSET = 'ASCII'
           IF HEXX NOT = "20--------"
       >> ELSE
           IF HEXX NOT = "40--------"
       >> END-IF
              DISPLAY "UNEXPECTED HEX-VALUE OF ' ': " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (n' ') DELIMITED BY SIZE INTO HEXX.
           IF HEXX NOT = "0020------"
              DISPLAY "UNEXPECTED HEX-VALUE OF n' ': " HEXX.

       *>  FIXME: Failing with "3132------" -> missing padding
       *>         -> codegen issue for initialization / move
       *>            and libcob issue at least for MOVE
       *>  SET  HEXX-FILLER TO TRUE
       *>  STRING FUNCTION HEX-OF (N9) DELIMITED BY SIZE INTO HEXX.
       *>  IF HEXX NOT = "00310032--"
       *>     DISPLAY "UNEXPECTED HEX-VALUE OF N9: " HEXX.

       *>  FIXME: Failing with "00212020--" -> bad padding
       *>         -> codegen issue for initialization / move
       *>            and libcob issue at least for MOVE
       *>  SET  HEXX-FILLER TO TRUE
       *>  STRING FUNCTION HEX-OF (NX) DELIMITED BY SIZE INTO HEXX.
       *>  IF HEXX NOT = "00210020--"
       *>     DISPLAY "UNEXPECTED HEX-VALUE OF NX: " HEXX.

       *>  setting up test data:
           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-OF (z"01") DELIMITED BY SIZE INTO HEXX.

           IF FUNCTION HEX-TO-CHAR (HEXX(1:6)) NOT = z"01"
              DISPLAY "UNEXPECTED CHAR VALUE, does not match z'01': "
                      HEXX (1:6).
           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-TO-CHAR ("3132")
                  DELIMITED BY SIZE INTO HEXX.
           IF NOT (HEXX (1:2) = x"3132" AND HEXX (3:) = "--------")
              DISPLAY "UNEXPECTED CHAR VALUE, expected 12-* got: " HEXX.

           SET  HEXX-FILLER TO TRUE
           STRING FUNCTION HEX-TO-CHAR ("3132")
                  DELIMITED BY SIZE INTO HEXX.
           IF NOT (HEXX (1:2) = x"3132" AND HEXX (3:) = "--------")
              DISPLAY "UNEXPECTED CHAR VALUE, expected 12-* got: " HEXX.