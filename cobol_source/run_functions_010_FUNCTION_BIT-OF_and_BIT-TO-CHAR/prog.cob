IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  PAC    PIC   9(4) VALUE 12 COMP-3.
       01  TXT    PIC   X(4) VALUE "HI.".
       01  BITX   PIC   X(34).
           88 BITX-FILLER VALUE ALL "-".
       PROCEDURE        DIVISION.
           SET  BITX-FILLER TO TRUE
           STRING FUNCTION BIT-OF (PAC) DELIMITED BY SIZE INTO BITX.
           IF BITX NOT = "000000000000000100101111----------"
              DISPLAY "UNEXPECTED BIT-VALUE OF PAC 0012: " BITX.

           SET  BITX-FILLER TO TRUE
           STRING FUNCTION BIT-OF (TXT) DELIMITED BY SIZE INTO BITX.
      *> Discover if running ASCII or EBCDIC
       >>IF   CHARSET = 'ASCII'
           IF BITX NOT = "01001000010010010010111000100000--"
       >>ELIF CHARSET = 'EBCDIC'
           IF BITX NOT = "11001000110010010100101101000000--"
       >>ELSE
           IF 1 = 1 DISPLAY 'CHARSET UNKNOWN! PLEASE REPORT!'
       >>END-IF
              DISPLAY "UNEXPECTED BIT-VALUE OF 'HI. ': " BITX.

           SET  BITX-FILLER TO TRUE
           STRING FUNCTION BIT-OF (z"01") DELIMITED BY SIZE INTO BITX.
       >>IF   CHARSET = 'ASCII'
           IF BITX NOT = "001100000011000100000000----------"
       >>ELSE
           IF BITX NOT = "111100001111000100000000----------"
       >>END-IF

           IF FUNCTION BIT-TO-CHAR (BITX(1:24)) NOT = z"01"
              DISPLAY "UNEXPECTED CHAR VALUE, does not match z'01': "
                      BITX (1:24).
           SET  BITX-FILLER TO TRUE
           STRING FUNCTION BIT-TO-CHAR ("0011000100110010")
                  DELIMITED BY SIZE INTO BITX.
           IF NOT (BITX (1:2) = x"3132" AND
                   BITX (3: ) = "--------------------------------")
              DISPLAY "UNEXPECTED CHAR VALUE, expected 12-* got: " BITX.

           STOP RUN.