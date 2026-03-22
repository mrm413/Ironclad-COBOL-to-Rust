IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TESTME PIC X(1).

       PROCEDURE DIVISION.

          EVALUATE TRUE
            WHEN TESTME IS NOT-DEFINED
              CONTINUE
            WHEN TESTME = 'A'
              CONTINUE
            WHEN OTHER
              IF NOT TESTME IS NOT-DEFINED
              THEN
                CONTINUE
              ELSE
                CONTINUE
              END-IF
          END-EVALUATE
          EVALUATE TRUE
            WHEN TESTME IS 'ABC'
              CONTINUE
            WHEN TESTME = 'B'
              CONTINUE
          END-EVALUATE
          EVALUATE TRUE
            WHEN TESTME IS TESTME
              CONTINUE
            WHEN TESTME = 'C'
              CONTINUE
          END-EVALUATE
          EVALUATE TRUE
            WHEN TESTME NOT = NOT-DEFINED
              CONTINUE
            WHEN TESTME = 'D'
              CONTINUE
          END-EVALUATE
          EVALUATE TRUE
            WHEN TESTME ELSE NOT-DEFINED
              CONTINUE
            WHEN TESTME = 'E'
              CONTINUE
          END-EVALUATE
          EVALUATE broken
            WHEN NOT-DEFINED
              continue
          END-EVALUATE

          GOBACK.