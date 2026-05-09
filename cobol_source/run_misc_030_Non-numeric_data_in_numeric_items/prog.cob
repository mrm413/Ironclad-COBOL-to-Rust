IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X.
          03 X-NUM      PIC 9(06) VALUE 123.
       77 NUM           PIC 9(06).
       PROCEDURE        DIVISION.
           MOVE x"0000" TO X (2:2)
           IF X-NUM NUMERIC
              DISPLAY "low-value is numeric" UPON SYSERR.
           MOVE x"01" TO X (3:1)
           IF X-NUM NUMERIC
              DISPLAY "SOH is numeric" UPON SYSERR.
           MOVE X-NUM TO NUM
           DISPLAY "test over"
      *
           GOBACK.