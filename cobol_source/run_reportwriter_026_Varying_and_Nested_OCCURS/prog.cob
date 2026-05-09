IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT RP-FILE 
            ASSIGN TO "PRINTOUT"
            ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  RP-FILE REPORT RP.

       WORKING-STORAGE SECTION.
       77  RPT       PIC 99 VALUE 1.
       77  NUM       PIC 9 VALUE 0.
       77  TAG1V     PIC X(5) VALUE "Tag1".
       77  TAG2V     PIC X(5) VALUE "Tag2".
       01  MARKX     PIC X(16) VALUE
                "<1> <2> <3> <4> ".
       01  FILLER REDEFINES MARKX.
           05  MARKIT  PIC X(4) OCCURS 4 TIMES.
       01  DIGX      PIC X(50) VALUE
                "123456789b123456789c123456789d123456789e123456789f".
       01  FILLER REDEFINES DIGX.
           05  DIGS  PIC X(10) OCCURS 5 TIMES.

       REPORT SECTION.
       RD  RP
           CODE IS "VarQ: "
           PAGE LIMIT 10 LINES
                      60 COLUMNS
           HEADING 1
           FIRST DETAIL 4.
       01 HEADING-LINE.
          02  TYPE PAGE HEADING LINE PLUS 1.
            05  COLUMN 1      PIC X(50) VALUE
                "H        1         2         3         4         5".
            05                PIC X(7) VALUE "  Page".
            05                PIC ZZ9  SOURCE PAGE-COUNTER.
          02  TYPE PAGE HEADING LINE PLUS 1.
      *     05  COLUMN 1      PIC X(50) VALUE
      *         "12345678901234567890123456789012345678901234567890".
            05  COLUMN 1      OCCURS 5 TIMES
                  VARYING IX1 FROM 1 BY 1.
                10  H2-DIGS   PIC X(10) SOURCE DIGS (IX1).

       01  RP-DTL1 TYPE DETAIL, LINE + 2.
            03  NUMS  COLUMN 1   PIC 999 OCCURS 3 TIMES STEP 10.
            03  MARK  COLUMN + 2 PIC X(4) SOURCE MARKIT(1).

       01  RP-DTL2 TYPE DETAIL, LINE + 1.
            03  GRPS  COLUMN 1 OCCURS 3 TIMES VARYING IX1 FROM 1.
               05  TAG1        PIC X(5) SOURCE TAG1V.
               05  FILLER      PIC X.
               05  DTL2        OCCURS 3 TIMES VARYING IX2.
                  10  DTL2X    PIC X SOURCE DIGX (IX1:1).
               05  FILLER      PIC X.
               05  TAG2        PIC X(5) SOURCE TAG2V.
               05  FILLER      PIC X.
            03  MRK2  COLUMN + 3    PIC X(4) SOURCE MARKIT(2).

       01  RP-DTL3 TYPE DETAIL, LINE + 1.
            03  NNNS  COLUMN 1, 11, 21, 27 PIC 999.
            03  MRK3  COLUMN PLUS 3 PIC X(4) SOURCE MARKIT(3).

       01  RP-DTL4 TYPE DETAIL, LINE + 1.
            03  NUM4A               PIC 999.
            03  FILLER              PIC X.
            03  NUM4B COLUMN PLUS 7 PIC 999 OCCURS 3 STEP 6.
            03  MRK4  COLUMN + 4    PIC X(4) SOURCE MARKIT(4).

       PROCEDURE DIVISION.
       DECLARATIVES.
       BEFORE-DETAIL SECTION.
           USE BEFORE REPORTING RP-DTL2.
       DOIT-1.
           ADD 1 TO NUM
           DISPLAY "Hello World " NUM
           MOVE '$' TO DTL2 (2, 2).
       END DECLARATIVES.

           OPEN OUTPUT RP-FILE
           INITIATE RP

           MOVE 149 TO NNNS (1), NNNS (2), NNNS (3) NNNS (4)
           MOVE 100 TO NUMS (1), NUMS (2), NUMS (3)

           PERFORM VARYING RPT FROM 1 BY 1
                     UNTIL RPT > 4
               GENERATE RP-DTL1
    
               PERFORM DOIT-NOW
               GENERATE RP-DTL2
    
               MOVE 200 TO NNNS (1), NNNS (2), NNNS (3) NNNS (4)
               GENERATE RP-DTL3
    
               MOVE 400 TO NUM4A
               MOVE 401 TO NUM4B (1)
               MOVE 402 TO NUM4B (2)
               MOVE 403 TO NUM4B (3)
               GENERATE RP-DTL4
           END-PERFORM.

           TERMINATE rp.
           CLOSE RP-FILE.

           STOP RUN.

       DOIT-NOW.
           MOVE ALL '*' TO GRPS(1), GRPS(2), GRPS(3)
           MOVE "WAG1" TO TAG1 (1), TAG1 (2), TAG1 (3)
           MOVE "WAG2" TO TAG2 (1), TAG2 (2), TAG2 (3).