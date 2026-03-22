IDENTIFICATION DIVISION.
       PROGRAM-ID. progv.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT RP-FILE ASSIGN EXTERNAL PRINTOUT
            ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  RP-FILE REPORT RP.

       WORKING-STORAGE SECTION.
       01  MAXCOL    PIC 99 VALUE 50.
       01  MYCODE    PIC X(6) VALUE "Hi-Q:".
       01  DIGX      PIC X(50) VALUE
                "123456789b123456789c123456789d123456789e123456789f".
       01  FILLER REDEFINES DIGX.
           05  DIGS  PIC X(10) OCCURS 5 TIMES.

       REPORT SECTION.
       RD  RP 
           CODE IS MYCODE *> variable
           PAGE LIMIT 10 LINES 
                      MAXCOL COLUMNS *> variable
           HEADING 1
           FIRST DETAIL 4.
       01 HEADING-LINE.
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE 
                "         1         2         3         4         5".
          02 TYPE PAGE HEADING LINE PLUS 1.
      *     05  COLUMN 1      PIC X(50) VALUE 
      *         "12345678901234567890123456789012345678901234567890".
            05  COLUMN 1      OCCURS 5 TIMES
                  VARYING IDX1 FROM 1 BY 1. 
                10  FILLER    PIC X(10) SOURCE DIGS (IDX1).

       01  RP-DTL1 TYPE DETAIL, LINE + 1.
            03  NUMS  COLUMN 1   PIC 999 OCCURS 3 TIMES STEP 10.
            03  MARK  COLUMN + 3 PIC X(4).

       01  RP-DTL2 TYPE DETAIL, LINE + 1.
            03  GRPS  COLUMN 1 OCCURS 3 TIMES.
               05  TAG1      PIC X(5).
               05  FILLER    PIC X.
               05  TAG2      PIC X(5).
               05  FILLER    PIC XX.

       01  RP-DTL3 TYPE DETAIL, LINE + 1.
            03  NNNS  COLUMN 1, 11, 21, 27 PIC 999.
            03  TAGP  COLUMN PLUS 4 PIC X(4).

       01  RP-DTL4 TYPE DETAIL, LINE + 1.
            03  NUM4A               PIC 999.
            03  NUM4B COLUMN 11     PIC 999 OCCURS 3 STEP 10.
            03  MRK4  COLUMN + 3    PIC X(4).

       PROCEDURE DIVISION.
           OPEN OUTPUT RP-FILE
           INITIATE RP

           MOVE 100 TO NUMS (1), NUMS (2), NUMS (3)
           MOVE "<1>" TO MARK.
           GENERATE rp-dtl1

           MOVE ALL '*' TO GRPS(1), GRPS(2), GRPS(3)
           MOVE "Tag1" TO TAG1 (1), TAG1 (2), TAG1 (3)
           MOVE "Tag2" TO TAG2 (1), TAG2 (2), TAG2 (3)
           GENERATE RP-DTL2

           MOVE 200 TO NNNS (1), NNNS (2), NNNS (3) NNNS (4)
           MOVE "<3>" TO TAGP.
           GENERATE RP-DTL3.

           MOVE 400 TO NUM4A
           MOVE 401 TO NUM4B (1)
           MOVE 402 TO NUM4B (2)
           MOVE 403 TO NUM4B (3)
           MOVE "<4>" TO MRK4.
           GENERATE RP-DTL4

           TERMINATE rp
           CLOSE RP-FILE

           STOP RUN.