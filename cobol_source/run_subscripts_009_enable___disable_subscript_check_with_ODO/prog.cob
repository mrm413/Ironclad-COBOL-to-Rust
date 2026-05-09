IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 TAB.
         02 X           PIC X OCCURS 4 TO 6 DEPENDING ON N
	                      VALUE "A".
       01 N             PIC 9 VALUE 5.
       PROCEDURE        DIVISION.
           MOVE "B" TO X (6)
	   IF X (6) NOT EQUAL TO "B" THEN
	      DISPLAY "Got X (6) = " X (6) ", expected B"
	   END-DISPLAY
           STOP RUN.