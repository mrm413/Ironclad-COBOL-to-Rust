IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
       SELECT SYSUT1    ASSIGN TO sysut1.
       DATA             DIVISION.
       FILE             SECTION.
       FD  SYSUT1.
       01  SYSUT1-REC   PIC X(4).
       PROCEDURE        DIVISION.
           OPEN INPUT SYSUT1.
           GOBACK.