IDENTIFICATION   DIVISION.
       FUNCTION-ID.     WITHPAR.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 PAR-IN        PIC 9.
       01 PAR-OUT       PIC 9.
       PROCEDURE DIVISION USING PAR-IN RETURNING PAR-OUT.
           ADD 1 TO PAR-IN GIVING PAR-OUT END-ADD.
           GOBACK.
       END FUNCTION WITHPAR.

       IDENTIFICATION   DIVISION.
       FUNCTION-ID.     WITHOUTPAR.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 PAR           PIC 9.
       PROCEDURE DIVISION RETURNING PAR.
           MOVE 1 TO PAR.
           GOBACK.
       END FUNCTION WITHOUTPAR.

       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       REPOSITORY.
           FUNCTION     WITHPAR
           FUNCTION     WITHOUTPAR.
       PROCEDURE        DIVISION.
           IF WITHPAR(1) NOT = 2
              DISPLAY WITHPAR(1)
              END-DISPLAY
           END-IF.
           IF WITHOUTPAR NOT = 1
              DISPLAY WITHOUTPAR
              END-DISPLAY
           END-IF.
           STOP RUN.
       END PROGRAM prog.