IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           SW1
             ON  IS SWIT1-ON
             OFF IS SWIT1-OFF
           .
           SWITCH B IS SWITCH-B
             ON  IS SWIT2-ON
             OFF IS SWIT2-OFF
           .
           SWITCH 25
             ON  IS SWIT25-ON
             OFF IS SWIT25-OFF
           .
           SWITCH Z
             ON  IS SWIT26-ON
             OFF IS SWIT26-OFF
           .
           USW-31
             ON  IS SWIT31-ON
             OFF IS SWIT31-OFF
           .
           SWITCH-32
             ON  IS SWIT32-ON
             OFF IS SWIT32-OFF
           .
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  SWITCH       PIC 99 VALUE 12.
	   78  Z            VALUE 11.
       PROCEDURE        DIVISION.
           ADD SWITCH 1 GIVING SWITCH
           END-ADD.
           IF SWITCH NOT = 13
              DISPLAY "SWITCH (variable) + 1 WRONG: "
                      SWITCH
              END-DISPLAY
           END-IF.
           ADD SWITCH Z GIVING SWITCH
           END-ADD.
           IF SWITCH NOT = 24
              DISPLAY "SWITCH (variable) + Z WRONG: "
                      SWITCH
              END-DISPLAY
           END-IF.
           IF SWIT1-ON
              DISPLAY "ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY "OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           IF SWIT2-ON
              DISPLAY " ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY " OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           SET SWITCH-B TO OFF
           IF SWIT2-ON
              DISPLAY " ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY " OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           IF SWIT25-ON
              DISPLAY " ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY " OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           IF SWIT26-ON
              DISPLAY " ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY " OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           IF SWIT31-ON
              DISPLAY " ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY " OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           IF SWIT32-ON
              DISPLAY " ON" NO ADVANCING
              END-DISPLAY
           ELSE
              DISPLAY " OFF" NO ADVANCING
              END-DISPLAY
           END-IF.
           STOP RUN.