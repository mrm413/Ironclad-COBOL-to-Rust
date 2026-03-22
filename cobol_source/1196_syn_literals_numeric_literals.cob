IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog3.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
       PROCEDURE        DIVISION.

           *> Valid literals, depending on numeric literal size
           DISPLAY 1,0076, +100000,03, +1,0, -0078,
               +,1234567890123456789012345678901234
               ,123456789012345678901234567890123450
           END-DISPLAY

           *> Invalid literals
           DISPLAY 1,03,0     END-DISPLAY
           DISPLAY --123      END-DISPLAY
           DISPLAY -123-      END-DISPLAY
           DISPLAY -123-456   END-DISPLAY
           DISPLAY -123-4,56  END-DISPLAY
           DISPLAY -12,3-456  END-DISPLAY
           DISPLAY -12,3-4,56 END-DISPLAY
           DISPLAY 1000003+   END-DISPLAY
           DISPLAY 1,000003+  END-DISPLAY
           DISPLAY ,3+        END-DISPLAY
           DISPLAY 3,+        END-DISPLAY

           STOP RUN.