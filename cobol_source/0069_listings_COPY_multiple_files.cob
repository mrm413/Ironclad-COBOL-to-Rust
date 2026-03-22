IDENTIFICATION DIVISION.
       PROGRAM-ID. tstcpybk.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      *
       SOURCE-COMPUTER. LINUX.
       OBJECT-COMPUTER. LINUX.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           COPY "copy-sl-1.inc".
           COPY "copy-sl-2.inc".

       DATA DIVISION.
       FILE SECTION.
           COPY "copy-fd-1.inc".
           COPY "copy-fd-2.inc".

       WORKING-STORAGE SECTION.
       01  HEADER BASED.
           03 FILLER         PIC X(016)     VALUE 'FCSI CodeWerks:'.
           03 FILLER         PIC X(064)     VALUE
              'Name:tstcpybk.cbl  Version:1.7.1  Date:2017-03-15'.
           03 FILLER         PIC X(002)     VALUE LOW-VALUES.
      *
       77  GLOB              PIC 99         GLOBAL.
      *
           COPY "copy-ws-1.inc".
           COPY "copy-ws-2.inc".

       PROCEDURE DIVISION.
       MAIN-PROCEDURE SECTION.
       MAIN-PROCEDURE-0000.
           CONTINUE.
       MAIN-PROCEDURE-EXIT.
           STOP RUN.