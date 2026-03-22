>>DEFINE MYDOG AS "Piper"
       >>DEFINE MYNUM1 AS 11
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  MYREC.
          05  FLD1   PIC 9(2).
          05  FLD2   PIC X(7).
          05  FLD3   PIC X(2) OCCURS 5 TIMES.
          05  FLD4   PIC X(4).
          05  FLD5   PIC X(4).
       01  PICX      PIC XXX VALUE 'Abc'.
       01  CAT       CONSTANT  'Cat '.
       01  DOG       CONSTANT  'Dog '.
       01  YARD      CONSTANT  CAT & "& " & DOG.
       78  HUN       VALUE 10 * (10 + LENGTH OF PICX) + 12.35-2+3.
       78  HUN2      VALUE HUN * (10 + LENGTH OF PICX) -4.
       78  DIV1      VALUE 100 / 3.
       78  NUM2      VALUE 1 + 2 * 3.
       01  CON3      CONSTANT (((1 + 2) * NUM2) - 4).
       01  CON4      CONSTANT AS 3.1416 + CON3.
       01  CON5      CONSTANT 1 + 2 * 3.
       01  DOGNAME   CONSTANT FROM MYDOG.
       01  NUM1      CONSTANT FROM MYNUM1.
       01  CON6      CONSTANT AS CON5 + NUM1.
       >> IF NUM2 DEFINED  *> optional passed from command line
       01  NUM2      CONSTANT FROM MYNUM2.
       >> END-IF
      *
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "CAT  is '" CAT "'".
           DISPLAY "Yard is '" YARD "'".
           DISPLAY "DIV1 is " DIV1.
           DISPLAY "HUN  is " HUN.
           DISPLAY "HUN2 is " HUN2.
           MOVE NUM2 TO FLD1
           IF FLD1 = 9
             DISPLAY "78 VALUE has simple left to right precedence."
           ELSE
             DISPLAY "78 VALUE is " NUM2 " normal precedence."
           END-IF.
           MOVE CON5 TO FLD1
           IF FLD1 = 7
             DISPLAY "01 CONSTANT has normal operator precedence."
           ELSE
             DISPLAY "01 CONSTANT is " CON5 " left to right precedence."
           END-IF.
           DISPLAY "CON3 is " CON3.
           DISPLAY "CON4 is " CON4 " vs " 3.141596
                   " & " -2.189 " & " +12.
           DISPLAY "CON6 is " CON6 "."
           DISPLAY "My Dog's name is " DOGNAME ";".
           STOP RUN.