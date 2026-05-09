IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT rp-file ASSIGN EXTERNAL PRINTOUT
            ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  rp-file REPORT rp.

       REPORT SECTION.
       RD  RP 
           PAGE LIMIT 10 LINES
           HEADING 1
           FIRST DETAIL 4.
       01 HEADING-LINE.
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE 
                "         1         2         3         4         5".
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE 
                "12345678901234567890123456789012345678901234567890".

       01  RP-DTL1 TYPE DETAIL,  LINE + 1.
            03  NUMS  COLUMN 1   PIC 999 OCCURS 3 TIMES STEP 10.
            03  MARK  COLUMN + 3 PIC X(4).

       01  rp-dtl2 TYPE DETAIL, LINE + 1.
            03  grps  COLUMN 1 OCCURS 3 TIMES.
               05  tag1      PIC X(5).
               05  FILLER    PIC X.
               05  tag2      PIC X(5).
               05  FILLER    PIC XX.

       01  RP-DTL3 TYPE DETAIL, LINE + 1.
            03  NNNS  COLUMN 1, 11, 21, 27 PIC 999.
            03  TAGP  COLUMN PLUS 4 PIC X(4).

       01  RP-DTL4 TYPE DETAIL, LINE + 1.
            03  NUM4A                PIC 999.
            03  NUM4B COLUMN PLUS 8  PIC 999 OCCURS 3 STEP 10.
            03  MRK4  COLUMN + 3     PIC X(4).

       PROCEDURE DIVISION.
           OPEN OUTPUT rp-file
           INITIATE rp

           MOVE 100 TO NUMS (1), NUMS (2), NUMS (3)
           MOVE "<1>" TO MARK.
           GENERATE rp-dtl1

           MOVE ALL '*' TO grps(1), grps(2), grps(3)
           MOVE "Tag1" to tag1 (1), tag1 (2), tag1 (3)
           MOVE "Tag2" to tag2 (1), tag2 (2), tag2 (3)
           GENERATE rp-dtl2

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
           CLOSE rp-file

           STOP RUN.