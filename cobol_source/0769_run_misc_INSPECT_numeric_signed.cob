IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 SEPARATE1     PIC S99 VALUE -11 SIGN LEADING  SEPARATE.
       01 SEPARATE2     PIC S99 VALUE +11 SIGN LEADING  SEPARATE.
       01 TSEPARATE1    PIC S99 VALUE -11 SIGN TRAILING SEPARATE.
       01 TSEPARATE2    PIC S99 VALUE +11 SIGN TRAILING SEPARATE.
       01 NSEPARATE1    PIC S99 VALUE -11.
       01 NSEPARATE2    PIC S99 VALUE +11.
       01 TRAILING1     PIC S99 VALUE -11 SIGN TRAILING.
       01 TRAILING2     PIC S99 VALUE +11 SIGN TRAILING.
       77 CNT           USAGE BINARY-INT.
       PROCEDURE        DIVISION.
           MOVE 0 TO CNT
           INSPECT SEPARATE1  TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T1 - " CNT.
           MOVE 0 TO CNT
           INSPECT SEPARATE2  TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T2 - " CNT.
           MOVE 0 TO CNT
           INSPECT TSEPARATE1 TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T3 - " CNT.
           MOVE 0 TO CNT
           INSPECT TSEPARATE2 TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T4 - " CNT.
           MOVE 0 TO CNT
           INSPECT NSEPARATE1 TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T5 - " CNT.
           MOVE 0 TO CNT
           INSPECT NSEPARATE2 TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T6 - " CNT.
           MOVE 0 TO CNT
           INSPECT TRAILING1  TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T7 - " CNT.
           MOVE 0 TO CNT
           INSPECT TRAILING2  TALLYING CNT FOR ALL "1"
           IF CNT NOT = 2
              DISPLAY "T8 - " CNT.

           INSPECT SEPARATE1  CONVERTING "123" TO "234"
           IF SEPARATE1 NOT = -22
              DISPLAY "C1 - " SEPARATE1
              MOVE -22 TO SEPARATE1.
           INSPECT SEPARATE2  CONVERTING "123" TO "234"
           IF SEPARATE2 NOT = +22
              DISPLAY "C2 - " SEPARATE2
              MOVE +22 TO SEPARATE2.
           INSPECT TSEPARATE1 CONVERTING "123" TO "234"
           IF TSEPARATE1 NOT = -22
              DISPLAY "C3 - " TSEPARATE1
              MOVE -22 TO TSEPARATE1.
           INSPECT TSEPARATE2 CONVERTING "123" TO "234"
           IF TSEPARATE2 NOT = +22
              DISPLAY "C4 - " TSEPARATE2
              MOVE +22 TO TSEPARATE2.
           INSPECT NSEPARATE1 CONVERTING "123" TO "234"
           IF NSEPARATE1 NOT = -22
              DISPLAY "C5 - " NSEPARATE1
              MOVE -22 TO NSEPARATE1.
           INSPECT NSEPARATE2 CONVERTING "123" TO "234"
           IF NSEPARATE2 NOT = +22
              DISPLAY "C6 - " NSEPARATE2
              MOVE +22 TO NSEPARATE2.
           INSPECT TRAILING1  CONVERTING "123" TO "234"
           IF TRAILING1 NOT = -22
              DISPLAY "C7 - " TRAILING1
              MOVE -22 TO TRAILING1.
           INSPECT TRAILING2  CONVERTING "123" TO "234"
           IF TRAILING2 NOT = +22
              DISPLAY "C8 - " TRAILING2
              MOVE +22 TO TRAILING2.

           INSPECT SEPARATE1  REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF SEPARATE1 NOT = -33
              DISPLAY "R1 - " SEPARATE1
              MOVE -33 TO SEPARATE1.
           INSPECT SEPARATE2  REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF SEPARATE2 NOT = +33
              DISPLAY "R2 - " SEPARATE2
              MOVE +33 TO SEPARATE2.
           INSPECT TSEPARATE1 REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF TSEPARATE1 NOT = -33
              DISPLAY "R3 - " TSEPARATE1
              MOVE -33 TO TSEPARATE1.
           INSPECT TSEPARATE2 REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF TSEPARATE2 NOT = +33
              DISPLAY "R4 - " TSEPARATE2
              MOVE +33 TO TSEPARATE2.
           INSPECT NSEPARATE1 REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF NSEPARATE1 NOT = -33
              DISPLAY "R5 - " NSEPARATE1
              MOVE -33 TO NSEPARATE1.
           INSPECT NSEPARATE2 REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF NSEPARATE2 NOT = +33
              DISPLAY "R6 - " NSEPARATE2
              MOVE +33 TO NSEPARATE2.
           INSPECT TRAILING1  REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF TRAILING1 NOT = -33
              DISPLAY "R7 - " TRAILING1
              MOVE -33 TO TRAILING1.
           INSPECT TRAILING2  REPLACING ALL "1" BY "2"
                                            "2" BY "3"
                                            "3" BY "4"
           IF TRAILING2 NOT = +33
              DISPLAY "R8 - " TRAILING2
              MOVE +33 TO TRAILING2.

           STOP RUN.