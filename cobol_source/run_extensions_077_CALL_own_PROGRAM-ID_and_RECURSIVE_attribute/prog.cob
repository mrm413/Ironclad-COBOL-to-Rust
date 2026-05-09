IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       78  own-prog                VALUE 'prog'.
       77  first-call        PIC X VALUE ' '.
       PROCEDURE DIVISION.
       T1.
           IF first-call = SPACE
              MOVE 'X' TO first-call
              CALL own-prog.
           GOBACK.