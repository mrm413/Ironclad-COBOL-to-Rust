IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  normal-str PIC X(200).

       01  valid-rec.
           03  a PIC XX VALUE "aa".
           03  b PIC XX VALUE "bb".
       01  short-str PIC X(5).
       01  json-len   PIC 99.

       PROCEDURE DIVISION.
           JSON GENERATE short-str FROM valid-rec
               COUNT IN json-len
           IF short-str <> '{"val'
                   OR json-len <> 33
                   OR JSON-CODE <> 1
               DISPLAY "Failed 1: " short-str " " json-len " " JSON-CODE
           END-IF

           JSON GENERATE normal-str FROM valid-rec
                ON EXCEPTION
                    DISPLAY "Failed 2: EXCEPTION "
                        FUNCTION TRIM (normal-str)
                        " " JSON-CODE
                    END-DISPLAY

                NOT ON EXCEPTION
                    IF JSON-CODE <> 0
                        DISPLAY "Failed 2: NOT EXCEPTION "
                            FUNCTION TRIM (normal-str)
                            " " JSON-CODE
                    END-IF
           END-JSON

           JSON GENERATE short-str FROM valid-rec
                NOT EXCEPTION
                    DISPLAY "Failed 3: NOT EXCEPTION "
                        FUNCTION TRIM (normal-str)
                        " " JSON-CODE
                    END-DISPLAY

                EXCEPTION
                    IF JSON-CODE <> 1
                        DISPLAY "Failed 3: ON EXCEPTION "
                            FUNCTION TRIM (normal-str)
                            " " JSON-CODE
                    END-IF
           END-JSON
           .