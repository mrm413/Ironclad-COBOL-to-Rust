IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 G1.
         02 X           PIC X.
         02 A           REDEFINES X PIC 99.
       01 G2.
         02 X           PIC X.
         02 A           REDEFINES X PIC 9 OCCURS 2.
       01 EXT-X         PIC X EXTERNAL.
       01 EXT-X-REDEF   REDEFINES EXT-X PIC 99.
      *> other than the above EXTERNAL one, this is explicit "fine" 
      *> by COBOL standard (01, non-external) - only warn upon explicit request
       01 WRK-X2        PIC X.
       01 FILLER        REDEFINES WRK-X2 PIC X(4).
          88 WRK-X2-BADDY VALUE "99".
       PROCEDURE        DIVISION.
           STOP RUN.