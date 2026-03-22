IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       01  NUM9    PIC 9(6).
       PROCEDURE DIVISION.
           MOVE SPACES TO NUM9
           DISPLAY "NUM9 value SPACES is " NUM9 "." UPON SYSOUT
           MOVE LOW-VALUES TO NUM9
           IF NUM9 = LOW-VALUES
              DISPLAY "9(6) tests OK for LOW-VALUES" UPON SYSOUT
           ELSE
              DISPLAY "9(6) Does NOT test OK for LOW-VALUES"
                 UPON SYSOUT
              IF NUM9 = ZERO
                 DISPLAY "9(6) tests as ZERO instead of LOW-VALUES"
                    UPON SYSOUT
              END-IF
           END-IF.
           MOVE HIGH-VALUES TO NUM9
           IF NUM9 = HIGH-VALUES
              DISPLAY "9(6) tests OK for HIGH-VALUES" UPON SYSOUT
           ELSE
              DISPLAY "9(6) Does NOT test OK for HIGH-VALUES"
                 UPON SYSOUT
              IF NUM9 = ZERO
                 DISPLAY "9(6) tests as ZERO instead of HIGH-VALUES"
                    UPON SYSOUT
              END-IF
           END-IF.
           STOP RUN.