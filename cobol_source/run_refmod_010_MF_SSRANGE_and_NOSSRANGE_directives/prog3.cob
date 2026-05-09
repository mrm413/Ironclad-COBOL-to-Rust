$SET SSRANGE"3"
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x.
           03  y       PIC X VALUE SPACE.
           03  z       PIC X VALUE "!".
       01  n           PIC 9 VALUE 0.
       01  m           PIC 9 VALUE 2.
           
       PROCEDURE DIVISION.
           DISPLAY y (1:n) NO ADVANCING
           DISPLAY y (1:m)
           GOBACK.