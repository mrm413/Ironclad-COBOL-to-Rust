IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  x.
           03  y       PIC X OCCURS 5 TIMES VALUE SPACE.
           03  z       PIC X VALUE "!".
       01  idx         PIC 99 VALUE 6.
           
       PROCEDURE DIVISION.
      $SET NOSSRANGE
           DISPLAY y (idx)
      *> Note: MF says "sets BOUND"
      $SET SSRANGE
           DISPLAY y (idx)
           .