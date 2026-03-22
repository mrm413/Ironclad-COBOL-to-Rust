IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  str         PIC X(30).
       77  val         pic 9(02).

       PROCEDURE DIVISION.
           MOVE FUNCTION FORMATTED-DATETIME
                    ("YYYYDDDThhmmss+hhmm", 1, 45296, SYSTEM-OFFSET)
               TO str
           MOVE FUNCTION TEST-FORMATTED-DATETIME
                   ("YYYYDDDThhmmss+hhmm", str) TO val
           IF val not = 0
               DISPLAY "Test 1 failed: " str ' - ' val END-DISPLAY
           END-IF

           MOVE FUNCTION FORMATTED-TIME
                    ("hhmmss.ssZ", 45296, SYSTEM-OFFSET)
               TO str
           MOVE FUNCTION TEST-FORMATTED-DATETIME
                   ("hhmmss.ssZ", str) TO val
           IF val not = 0
               DISPLAY "Test 2 failed: " str ' - ' val END-DISPLAY
           END-IF
           .