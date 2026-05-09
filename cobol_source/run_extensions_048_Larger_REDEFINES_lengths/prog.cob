IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Z            PIC 99.
       01  XMAIN        PIC X(8).
       01  XMAINRED REDEFINES XMAIN.
           03  FILLER         PIC X(4).
           03  XMAIN03.
               05  XMAIN0501  PIC X(4).
               05  XMAIN0502 REDEFINES XMAIN0501 PIC X(5).
       01 USE-VARS.
          05 USE-VALUE                PIC 9
                                      VALUE ZERO.
             88 USE-ACTIVE-FIRST      VALUE 1.
             88 USE-ACTIVE-SECOND     VALUE 2.
          05 USE-FIRST.
             10 FIRST-DATA.
                20 FIRST-DATA-VAR     PIC X(033).
             10 FIRST-VARIANT-A REDEFINES FIRST-DATA.
                20 PART-A-FIRST       PIC X(33211).
             10 FIRST-VARIANT-B REDEFINES FIRST-DATA.
                20 PART-B-FIRST       PIC X(24561).
             10 FIRST-VARIANT-C REDEFINES FIRST-DATA.
                20 PART-C-FIRST       PIC X(3421).
         05 USE-SECOND REDEFINES USE-FIRST.
            10 SECOND-HEADER.
               20 SECOND-DATA         PIC 9(015).
               20 SECOND-CONTROL-SUM  PIC 9(015)V9(003).
            10 SECOND-VARIANT-A REDEFINES SECOND-HEADER.
               20 PART-A-SECOND       PIC X(27241).
            10 SECOND-VARIANT-B REDEFINES SECOND-HEADER.
               20 PART-B-SECOND       PIC X(3879).
       PROCEDURE        DIVISION.
           MOVE    LENGTH OF XMAIN       TO Z.
           IF Z NOT = 8
              DISPLAY "Test 1 " Z.
           MOVE    LENGTH OF XMAINRED    TO Z.
           IF Z NOT = 9
              DISPLAY "Test 2 " Z.
           MOVE    LENGTH OF XMAIN03     TO Z.
           IF Z NOT = 5
              DISPLAY "Test 3 " Z.
           MOVE    LENGTH OF XMAIN0501   TO Z.
           IF Z NOT = 4
              DISPLAY "Test 4 " Z.
           MOVE    LENGTH OF XMAIN0502   TO Z.
           IF Z NOT = 5
              DISPLAY "Test 5 " Z.
           IF LENGTH OF USE-FIRST  NOT = 33211
              DISPLAY LENGTH OF USE-FIRST   END-DISPLAY.
           IF LENGTH OF USE-SECOND NOT = 27241
              DISPLAY LENGTH OF USE-SECOND  END-DISPLAY.
           STOP RUN.