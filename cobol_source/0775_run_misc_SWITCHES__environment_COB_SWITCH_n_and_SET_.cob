IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           SWITCH-1 IS SWIT1
             ON  IS SWIT1-ON
             OFF IS SWIT1-OFF
           SWITCH-2 IS SWIT2
             ON  IS SWIT2-ON
             OFF IS SWIT2-OFF
           SWITCH-3
             ON  IS SWIT3-ON
             OFF IS SWIT3-OFF
           SWITCH-4 IS SWIT4
             OFF IS SWIT4-OFF
           SWITCH-31
             ON  IS SWIT31-ON
           SWITCH-36 IS SWIT36
             OFF IS SWIT36-OFF.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           IF SWIT1-ON
              DISPLAY "ON" NO ADVANCING
           ELSE
              DISPLAY "OFF" NO ADVANCING.

           IF SWIT2-ON
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           IF SWIT3-ON
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           IF NOT SWIT4-OFF
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           SET SWIT1 TO OFF.
           SET SWIT2 TO ON.
           IF SWIT1-ON
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           IF SWIT2-ON
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           IF SWIT31-ON
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           IF NOT SWIT36-OFF
              DISPLAY " ON" NO ADVANCING
           ELSE
              DISPLAY " OFF" NO ADVANCING.

           STOP RUN.