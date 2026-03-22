IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 INPUT-REC.
       COPY "copy.inc"
          REPLACING 'POST' BY IN.
       PROCEDURE        DIVISION.
           DISPLAY WS-IN IN-A IN-WS NO ADVANCING.
           IF WS-IN EQUALS IN-A
       COPY "proc.inc"
          REPLACING VAR       BY IN-A IN INPUT-REC
                    ==VAR-2== BY ==IN-WS (1:1)==.
           END-IF.
           STOP RUN.