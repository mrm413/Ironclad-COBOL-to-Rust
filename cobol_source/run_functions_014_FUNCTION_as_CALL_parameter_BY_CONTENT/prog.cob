IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       PROCEDURE DIVISION.
       PROG-MAIN.
           CALL "subprog" USING BY CONTENT
                                FUNCTION CONCATENATE("Abc" "D")
           STOP RUN.
           END PROGRAM prog.

       *> *****************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. subprog.

       DATA DIVISION.
       LINKAGE SECTION.
       01 TESTING PIC X ANY LENGTH.

       PROCEDURE DIVISION USING TESTING.
       SUBPROG-MAIN.
           DISPLAY TESTING
           GOBACK.
       END PROGRAM subprog.