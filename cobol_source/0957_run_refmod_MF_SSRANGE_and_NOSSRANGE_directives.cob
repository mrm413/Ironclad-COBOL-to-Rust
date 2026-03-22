$SET NOSSRANGE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x.
           03  y       PIC X VALUE SPACE.
           03  z       PIC X VALUE "!".
       01  n           PIC 9 VALUE 0.
       01  m           PIC 9 VALUE 2.
           
       PROCEDURE DIVISION.
           DISPLAY y (1:m) NO ADVANCING
           DISPLAY y (1:n) no ADVANCING
           GOBACK.