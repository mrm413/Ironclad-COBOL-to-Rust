IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
      *>   Octal literal is "AB" in ASCII.
       01  ITEM-ALPHA     PIC XX        VALUE %40502.
      *>   Octal literal is 39.
       01  ITEM-NUMERIC   PIC 99 BINARY VALUE %47.
      *>   Octal literal is ASCII 12.
       01  ITEM-NUM       PIC 99        VALUE %30462.
       PROCEDURE        DIVISION.
      *>   Octal literal is "XY".
           DISPLAY %54131.
           IF ITEM-ALPHA NOT = "AB"
              DISPLAY "VALUE %40502 is not ""AB"" (ASCII) but "
                      ITEM-ALPHA
           END-IF
           IF ITEM-NUMERIC NOT = 39
              DISPLAY "VALUE %47 BINARY is not 39 but " ITEM-NUMERIC
           END-IF
           IF ITEM-NUM NOT = 12
              DISPLAY "VALUE %30462 is not 12 (ASCII) but " ITEM-NUM
           END-IF
      *>   Adds octal 23 (decimal 19, as it is an arithmetic expression).
           ADD %23 TO ITEM-NUM.
           IF ITEM-NUM NOT = 31
              DISPLAY "12 + %23 (19) is not 31 but " ITEM-NUM
           END-IF
      *>   Sets the data to octal 30462 (ASCII 12).
           MOVE %30462 TO ITEM-NUM
           IF ITEM-NUM NOT = 12
              DISPLAY "%30462 is not 12 (ASCII) but " ITEM-NUM
           END-IF
      *>   Sets the data to x'4100' (octal 101 -> ASCII A + right-pad NULL)
           MOVE %101 TO ITEM-ALPHA
           IF ITEM-ALPHA NOT = x"4100"
              DISPLAY "%101 is not x""4100"" = Anull (ASCII) but "
                      ITEM-ALPHA
           END-IF


           STOP RUN.