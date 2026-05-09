IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  OPTIONAL      FILE-OPT
                   ASSIGN        TO "testfile"
                   ORGANIZATION  IS INDEXED
                   RECORD KEY    IS FOREC
                   FILE STATUS   IS WSFS.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE-OPT.
       01  FOREC             PIC X(80).
       WORKING-STORAGE SECTION.
       01  WSFS              PIC X(2).
       PROCEDURE DIVISION.
      *
      *>   DELETE FILE FILE-OPT
      *>    ON EXCEPTION
      *>     DISPLAY "STATUS DELETE FILE (missing) - EXCEPTION: " WSFS
      *>     END-DISPLAY
      *>    NOT ON EXCEPTION
      *>      IF WSFS NOT = "05"
      *>         DISPLAY "STATUS DELETE FILE (missing): " WSFS
      *>      END-IF
      *>   END-DELETE
           OPEN I-O FILE-OPT
           IF WSFS NOT = "05"
              DISPLAY "STATUS I-O, missing optional file: " WSFS.
           CLOSE FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS CLOSE: " WSFS.
           OPEN I-O FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS I-O, empty file: " WSFS.
           DELETE FILE FILE-OPT
      *>     ON EXCEPTION
              IF WSFS NOT = "41"
                 DISPLAY "STATUS DELETE FILE (opened): " WSFS
              END-IF
      *>    NOT ON EXCEPTION
      *>     DISPLAY "STATUS DELETE FILE (opened) - NO EXCEPTION: " WSFS
      *>   END-DELETE
           CLOSE FILE-OPT
           IF WSFS NOT = "00"
              DISPLAY "STATUS CLOSE #2: " WSFS.
           DELETE FILE FILE-OPT
      *>     ON EXCEPTION
      *>      DISPLAY "STATUS DELETE FILE (closed) - EXCEPTION: " WSFS
      *>      END-DISPLAY
      *>     NOT ON EXCEPTION
              IF WSFS NOT = "00"
                 DISPLAY "STATUS DELETE FILE (closed): " WSFS
              END-IF
      *>   END-DELETE
      *
           STOP RUN.