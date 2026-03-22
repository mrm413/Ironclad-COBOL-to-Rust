IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  first-call        PIC X VALUE ' '.
       PROCEDURE DIVISION.
       T2.
           IF first-call NOT = SPACE
              GOBACK.
           MOVE 'X' TO first-call
       COPY "cllprg.cpy".
           GOBACK.