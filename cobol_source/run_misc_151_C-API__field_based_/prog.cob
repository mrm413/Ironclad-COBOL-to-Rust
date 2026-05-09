IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  BINFLD5     PIC  9(5) COMP-5  VALUE  1280.
       01  BINFLD5S    PIC S9(5) BINARY  VALUE  1024.
       01  BINFLD9     PIC  9(9) BINARY  VALUE  2560.
       01  COMP3       PIC  9(8) COMP-3  VALUE  4096.
       01  COMP3V99    PIC S9(7)V99 COMP-3  VALUE  12.50.
       01  PIC9        PIC S9(8) DISPLAY VALUE  8192.
       01  NE          PIC Z(4)9.99-.
       01  CHRX        PIC  X(9)         VALUE 'Hello'.
      *01  CHRN        PIC  N(9)         VALUE N'Hello'.
       01  GRPX.
           05  FILLER  PIC  X(9)         VALUE 'Hello'.
           05  FILLER  PIC  X(9)         VALUE 'World'.
       PROCEDURE DIVISION.
           MOVE -512.77 TO NE.
           CALL "CAPI" USING 2560 BY VALUE 16.
           CALL "CAPI" USING BINFLD5, NE.
           CALL "CAPI" USING BINFLD5S.
           CALL "CAPI" USING BINFLD9.
           MOVE  512.77 TO NE.
           CALL "CAPI" USING COMP3, NE.
           CALL "CAPI" USING PIC9 BINFLD5S CHRX GRPX.
           CALL "CAPI" USING COMP3, NE, CHRX.
           CALL "CAPI" USING BINFLD5, NE.
           MOVE "Hello!" TO CHRX.
           CALL "CAPI" USING BY VALUE BINFLD5, CHRX.
           CALL "CAPI" USING BY VALUE BINFLD5, CHRX.
           CALL "CAPI" USING LENGTH OF GRPX.
           CALL "CAPI" USING BY VALUE GRPX LENGTH OF GRPX.
           CALL "CAPI" USING "Fred Fish", COMP3.
           CALL "CAPI" USING COMP3V99.
      *    CALL "CAPI" USING CHRN.
           CALL "CAPI" .
           DISPLAY "COMP3    is now " COMP3 ";".
           DISPLAY "COMP4    is now " BINFLD5 ";".
           DISPLAY "BINFLD5S is now " BINFLD5S ";".
           DISPLAY "CHRX     is now " CHRX ";".
           DISPLAY "NE       is now " NE ";".
           STOP RUN.