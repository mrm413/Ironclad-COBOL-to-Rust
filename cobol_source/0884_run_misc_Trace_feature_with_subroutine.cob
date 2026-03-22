IDENTIFICATION DIVISION.
       PROGRAM-ID. callsub.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NUM-A     PIC 9(3) VALUE 399.
       01 NUM-B     PIC 9(3) VALUE 211.
       01 RSLT      PIC 9(5)V99.

       LINKAGE SECTION.
       01  n PIC 99.

       PROCEDURE DIVISION USING n.
       MAIN-10.
           ADD 1 TO n.
           COMPUTE RSLT = ((NUM-A / (100.55 + -0.550))
                         -  (NUM-B / (10.11 * 10 - 1.1)))
                             * (220 / 2.2) * n.
       END PROGRAM callsub.