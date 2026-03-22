IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  POS          PIC 9(4).
       LINKAGE SECTION.
       01  TESTME PIC X ANY LENGTH.
       PROCEDURE        DIVISION USING TESTME.
       main.
           evaluate true
           when TESTME(POS:2) = ", "
                continue
           when TESTME(POS:1) = "," and TESTME(1 + POS:1) = " "
                display 'TESTME' pos 1525
           end-evaluate
           STOP RUN.