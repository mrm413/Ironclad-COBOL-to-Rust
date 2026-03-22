IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       78  DOGGY     VALUE "Barky".
       01  MYREC.
          05  FLD1   PIC 9(2).
          05  FLD2   PIC X(7).
          05  FLD3   PIC X(2) OCCURS 5 TIMES.
          05  FLD4   PIC X(4).
          05  FLD5   PIC X(4).
       01  PICX      PIC XXX VALUE 'Abc'.
       78  HUN       VALUE 10 * (10 + LENGTH OF PICX) + 12.35-2+3.
       78  HUN2      VALUE HUN * (10 + LENGTH OF PICX) -4.
       01  THEDOG    PIC X(6) VALUE DOGGY.
       78  DIV1      VALUE 100 / 3.
       78  NUM2      VALUE 1 + 2 * 3.
       LINKAGE SECTION.
       01  XMYREC.
          05  XFLD1   PIC 9(2).
          05  XFLD2   PIC X(7).
             78  XPOS3    VALUE NEXT.
          05  XFLD3   PIC X(2) OCCURS 5 TIMES.
             78  XPOS4    VALUE NEXT.
          05  XFLD4   PIC X(4).
          05  XFLD5   PIC X(4).
       78  XSTRT4     VALUE START OF XFLD4.
      *
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "DIV1 is " DIV1.
           DISPLAY "HUN  is " HUN.
           DISPLAY "HUN2 is " HUN2.
           MOVE NUM2 TO FLD1
           IF FLD1 = 9
             DISPLAY "NUM2 is " NUM2 " left to right precedence."
           ELSE
             DISPLAY "NUM2 is " NUM2 " normal precedence."
           END-IF.
           DISPLAY "XFLD3 starts at " XPOS3.
           DISPLAY "XFLD4 starts at " XSTRT4.
           DISPLAY "XFLD4 starts at " XPOS4.
           DISPLAY "Your Dog's name is " DOGGY ";".
           DISPLAY "The Dog's name is " THEDOG ";".
           STOP RUN.