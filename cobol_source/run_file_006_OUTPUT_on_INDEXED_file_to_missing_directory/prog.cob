IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  FILE0 ASSIGN  TO "./nosubhere/MYFILE0"
                   ORGANIZATION  IS INDEXED
                   RECORD KEY    IS F0REC
                   FILE STATUS   IS WSFS.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE0.
       01  F0REC             PIC X(80).
       WORKING-STORAGE SECTION.
       01  WSFS              PIC X(2).
       PROCEDURE DIVISION.
      *
           OPEN OUTPUT FILE0
           IF WSFS NOT = "30"
              DISPLAY "STATUS OPENO " WSFS.
      *
           STOP RUN.