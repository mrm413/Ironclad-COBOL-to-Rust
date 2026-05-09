IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(8) VALUE "AABABCAB".
       01 Y             PIC X VALUE "Y".
       01 N             PIC S9(5) VALUE -11122.
       PROCEDURE        DIVISION.
           EXAMINE X REPLACING ALL "A" BY "X"
           IF X NOT = "XXBXBCXB"
              DISPLAY "Should be XXBXBCXB but is " X.
           EXAMINE X REPLACING LEADING "X" BY "Y"
           IF X NOT = "YYBXBCXB"
              DISPLAY "Should be YYBXBCXB but is " X.
           EXAMINE X REPLACING FIRST "B" BY "C"
           IF X NOT = "YYCXBCXB"
              DISPLAY "Should be YYCXBCXB but is " X.
           EXAMINE X REPLACING UNTIL FIRST "B" BY "Z"
           IF X NOT = "ZZZZBCXB"
              DISPLAY "Should be ZZZZBCXB but is " X.
           EXAMINE N REPLACING ALL 1 BY 3
           IF N NOT = -33322
              DISPLAY "Should be -33322 but is " N.
           STOP RUN.