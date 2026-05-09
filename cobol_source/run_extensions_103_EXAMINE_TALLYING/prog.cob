IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(8) VALUE "AABABCAB".
       01 N             PIC S9(5)V9(2) VALUE -11122.55.
       01 T             PIC X(10) VALUE "    8     ".
       PROCEDURE        DIVISION.
           EXAMINE X TALLYING ALL "A"
           IF TALLY NOT = 4
              DISPLAY "Should be 4 but is " TALLY.
           EXAMINE X TALLYING LEADING "A"
           IF TALLY NOT = 2
              DISPLAY "Should be 2 but is " TALLY.
           EXAMINE X TALLYING UNTIL FIRST "C"
           IF TALLY NOT = 5
              DISPLAY "Should be 5 but is " TALLY.
           EXAMINE X TALLYING ALL "A" REPLACING BY "Z"
           IF TALLY NOT = 4
              DISPLAY "Should be 4 but is " TALLY.
           IF X NOT = "ZZBZBCZB"
              DISPLAY "Should be ZZBZBCZB but is " X.
           EXAMINE X TALLYING LEADING "Z" REPLACING BY "A"
           IF TALLY NOT = 2
              DISPLAY "Should be 2 but is " TALLY.
           IF X NOT = "AABZBCZB"
              DISPLAY "Should be AABZBCZB but is " X.
           EXAMINE X TALLYING UNTIL FIRST "C" REPLACING BY "X"
           IF TALLY NOT = 5
              DISPLAY "Should be 5 but is " TALLY.
           IF X NOT = "XXXXXCZB"
              DISPLAY "Should be XXXXXCZB but is " X.
           EXAMINE X TALLYING UNTIL FIRST "Y" REPLACING BY "Y"
           IF TALLY NOT = 8
              DISPLAY "Should be 8 but is " TALLY.
           IF X NOT = "YYYYYYYY"
              DISPLAY "Should be YYYYYYYY but is " X.
           EXAMINE N TALLYING UNTIL FIRST 5 REPLACING BY 8
           IF N NOT = -88888.55
              DISPLAY "Should be -88888.55 but is " N.
      *    Re-mod is forbidden here (at least on GCOS):
      *    EXAMINE N TALLYING LEADING T (5:1)
      *    IF TALLY NOT = 5
      *       DISPLAY "Should be 5 but is " TALLY.
           STOP RUN.