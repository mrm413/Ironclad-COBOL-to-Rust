IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  CS-FULL            PICTURE 9(4) COMPUTATIONAL SYNCHRONIZED.
       77  CS                 PIC 9(4) COMP SYNC.
       77  CSL                PIC 9(4) COMP SYNC LEFT.
       77  CSR                PIC 9(4) COMP SYNC RIGHT.
       PROCEDURE        DIVISION.
           MOVE 1 TO CS-FULL, CS, CSL, CSR.
           STOP RUN.