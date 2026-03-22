IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT TST-FILE1 ASSIGN       TO CARD-PUNCH  "F1".
       SELECT TST-FILE2 ASSIGN       TO CARD-READER "F2".
       SELECT TST-FILE3 ASSIGN       TO CASSETTE    "F3".
       SELECT TST-FILE4 ASSIGN       TO INPUT       "F4".
       SELECT TST-FILE5 ASSIGN       TO INPUT-OUTPUT.
       SELECT TST-FILE6 ASSIGN       TO MAGNETIC-TAPE.
       SELECT TST-FILE7 ASSIGN       TO OUTPUT      "F7".
       DATA             DIVISION.
       FILE             SECTION.
       FD TST-FILE1.
       01 TST1-REC      PIC X(4).
       FD TST-FILE2.
       01 TST2-REC      PIC X(4).
       FD TST-FILE3.
       01 TST3-REC      PIC X(4).
       FD TST-FILE4.
       01 TST4-REC      PIC X(4).
       FD TST-FILE5.
       01 TST5-REC      PIC X(4).
       FD TST-FILE6.
       01 TST6-REC      PIC X(4).
       FD TST-FILE7.
       01 TST7-REC      PIC X(4).
       PROCEDURE        DIVISION.
           OPEN  INPUT TST-FILE1.
           CLOSE TST-FILE1.
           OPEN  INPUT TST-FILE2.
           CLOSE TST-FILE2.
           OPEN  INPUT TST-FILE3.
           CLOSE TST-FILE3.
           OPEN  INPUT TST-FILE4.
           CLOSE TST-FILE4.
           OPEN  INPUT TST-FILE5.
           CLOSE TST-FILE5.
           OPEN  INPUT TST-FILE6.
           CLOSE TST-FILE6.
           OPEN  INPUT TST-FILE7.
           CLOSE TST-FILE7.
           STOP RUN.