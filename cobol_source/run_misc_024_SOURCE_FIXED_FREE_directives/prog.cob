IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       >>SOURCE FREE
   DATA             DIVISION.
   WORKING-STORAGE  SECTION.
   >>SOURCE FIXED
       PROCEDURE        DIVISION.                                       FIXED
             DISPLAY "OK" NO ADVANCING
             END-DISPLAY.
       >>SOURCE FREE
                                                                        DISPLAY
   "OK"
 NO ADVANCING
   END-DISPLAY.
   >>SET SOURCEFORMAT "FIXED"
             DISPLAY "OK" NO ADVANCING                                  FIXED
             END-DISPLAY.
       >>SET SOURCEFORMAT "FREE"
                                                                        DISPLAY
   "OK"
 NO ADVANCING
   END-DISPLAY.
             STOP RUN.