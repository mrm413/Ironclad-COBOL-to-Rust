IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT SORT-IN   ASSIGN "test.txt".
       SELECT SORT-OUT  ASSIGN "result.txt".
       SELECT SORT-WRK  ASSIGN "SORT-WRK".
       DATA             DIVISION.
       FILE             SECTION.
       FD SORT-IN.
       01 IN-REC        PIC X(6).
       FD SORT-OUT.
       01 OUT-REC       PIC X(6).
       SD SORT-WRK.
       01 WRK-REC       PIC X(6).
       PROCEDURE        DIVISION.

      * Special case: write test data in COBOL, see note above
           OPEN OUTPUT SORT-IN.
           WRITE IN-REC FROM SPACES   END-WRITE.
           WRITE IN-REC FROM SPACES   END-WRITE.
           WRITE IN-REC FROM "world " END-WRITE.
           WRITE IN-REC FROM SPACES   END-WRITE.
           WRITE IN-REC FROM "hello " END-WRITE.
           WRITE IN-REC FROM SPACES   END-WRITE.
           WRITE IN-REC FROM SPACES   END-WRITE.
           CLOSE SORT-IN.

           SORT SORT-WRK
                ASCENDING KEY WRK-REC
                USING  SORT-IN
                GIVING SORT-OUT.
             STOP RUN.