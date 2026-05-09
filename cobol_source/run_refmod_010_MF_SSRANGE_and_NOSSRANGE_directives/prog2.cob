$SET SSRANGE"2"
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x.
           03  y       PIC X VALUE SPACE.
           03  z       PIC X VALUE "!".
       01  n           PIC 9 VALUE 0.
       01  m           PIC 9 VALUE 2.
           
       PROCEDURE DIVISION.
      $IF TEST-ZERO-LEN-REF-MOD DEFINED
           DISPLAY y (1:n)
      $END
           DISPLAY y (1:m)
           GOBACK.