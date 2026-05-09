IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT RP-FILE ASSIGN EXTERNAL PRINTOUT
            ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  RP-FILE REPORT RP.

       WORKING-STORAGE SECTION.
       01  DIGX      PIC X(50) VALUE
                "123456789b123456789c123456789d123456789e123456789f".
       01  FILLER REDEFINES DIGX.
           05  DIGS  PIC X(10) OCCURS 5 TIMES.

       01 error-messages.
          05 bad-ending           pic x(50) value
             "Should have exactly 3 digits !".
          05 bad-param            pic x(50) value
             "Bad param!".
      *
       78 test-date value 123.
    *
       01 floating-data.
          05 dbl        usage float-long      value -3.40282e+038.
          05 flt        usage float-short     value 3.40282e+038.

       REPORT SECTION.
       RD  RP 
           CODE IS "Hi-Q: "
           PAGE LIMIT 10 LINES 
                      50 COLUMNS
           HEADING 1
           FIRST DETAIL 4.
       01 HEADING-LINE.
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE 
                "         1         2         3         4         5".
          02 TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE
                "12345678901234567890123456789012345678901234567890".
      *     05  COLUMN 1      OCCURS 5 TIMES
      *           VARYING IDX1 FROM 1 BY 1.
      *         10  FILLER    PIC X(10) SOURCE DIGS (IDX1).

       01  RP-DTL1 TYPE DETAIL, LINE + 1.
            03  NUMS  COLUMN 1   PIC 999 OCCURS 3 TIMES STEP 10.
            03  MARK  COLUMN + 2 PIC X(4).

       01  RP-DTL2 TYPE DETAIL, LINE + 1.
            03  GRPS  COLUMN 1 OCCURS 3 TIMES.
               05  TAG1      PIC X(5).
               05  DTL2      PIC X.
               05  TAG2      PIC X(5).
               05  FILLER    PIC XX.
      *     03  MRK2  COLUMN + 2    PIC X(4).
            03  MRK2  COLUMN  42    PIC X(4).

       01  RP-DTL3 TYPE DETAIL, LINE + 1.
            03  NNNS  COLUMN 1, 11, 21, 27 PIC 999.
            03  TAGP  COLUMN PLUS 3 PIC X(4).

       01  RP-DTL4 TYPE DETAIL, LINE + 1.
            03  NUM4A               PIC 999.
            03  NUM4B COLUMN PLUS 7 PIC 999 OCCURS 3.
            03  MRK4  COLUMN + 2    PIC X(4).

       PROCEDURE DIVISION.
       DECLARATIVES.
       BEFORE-DETAIL SECTION.
           USE BEFORE REPORTING RP-DTL2.
       DOIT-1.
           DISPLAY "Hello World"
           MOVE '_' TO DTL2 (2).
       END DECLARATIVES.

           OPEN OUTPUT RP-FILE
           INITIATE RP

           MOVE 169 TO NNNS (1), NNNS (2), NNNS (3) NNNS (4)
           MOVE "NOT" TO TAGP.
           MOVE "NOW" TO MRK4.

           MOVE 100 TO NUMS (1), NUMS (2), NUMS (3)
           MOVE "<1>" TO MARK.
           GENERATE rp-dtl1

           MOVE ALL '*' TO GRPS(1), GRPS(2), GRPS(3)
           MOVE "Tag1" TO TAG1 (1), TAG1 (2), TAG1 (3)
           MOVE "Tag2" TO TAG2 (1), TAG2 (2), TAG2 (3)
           MOVE "<2>" TO MRK2.
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