IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X.
          03 X-NUM      PIC 9(06) PACKED-DECIMAL VALUE 123.
       77 NUM           PIC 9(06).
       PROCEDURE        DIVISION.
           MOVE x"0A" TO X (2:1)
           IF X-NUM NUMERIC
              DISPLAY "bad prog".
           MOVE X-NUM TO NUM
           DISPLAY "test over"
      *
           GOBACK.