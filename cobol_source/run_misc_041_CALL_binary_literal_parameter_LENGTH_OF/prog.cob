IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MYOCC        PIC 9(8) COMP.
       01  MYTAB.
           03  MYBYTE   PIC X OCCURS 1 TO 20
                        DEPENDING ON MYOCC.
       PROCEDURE        DIVISION.
           MOVE 9 TO MYOCC.
           CALL "dump" USING BY CONTENT 1
           END-CALL.
           CALL "dump" USING BY CONTENT LENGTH OF MYTAB
           END-CALL.
           CALL "dump" USING BY CONTENT LENGTH OF MYOCC
           END-CALL.
           STOP RUN.