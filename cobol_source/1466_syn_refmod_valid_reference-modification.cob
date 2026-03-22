IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(4) VALUE "abcd".
       77 VAR           PIC 9 VALUE 1.
       PROCEDURE        DIVISION.
           DISPLAY X(1:1) ":" X(1:2) ":" X(1:3) ":" X(1:4) ":" X(1:).
           DISPLAY X(2:1) ":" X(2:2) ":" X(2:3) ":" X(2:).
           DISPLAY X(3:1) ":" X(3:2) ":" X(3:).
           DISPLAY X(4:1) ":" X(4:).
           DISPLAY X(1:4)
           DISPLAY X(VAR:4)
           DISPLAY X(4:)
           DISPLAY X(4:VAR)
           STOP RUN.