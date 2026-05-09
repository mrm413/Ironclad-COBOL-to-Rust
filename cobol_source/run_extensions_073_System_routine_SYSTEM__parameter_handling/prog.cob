IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       77  test-no                    PIC 9 VALUE 0.
       77  chaining-param             PIC X(20).
       77  chaining-param-2           PIC X(20).
      *
       PROCEDURE DIVISION CHAINING chaining-param, chaining-param-2.
      *
       main.
           EVALUATE chaining-param ALSO chaining-param-2
              WHEN SPACES  ALSO SPACES
                 DISPLAY "started without options - closing"
              WHEN "1"     ALSO SPACES
              WHEN '"1"'   ALSO SPACES
              WHEN "a v"   ALSO SPACES
              WHEN '"a v"' ALSO SPACES
                 DISPLAY "  called with -"
                         function trim (chaining-param) "-"
              WHEN "a"    ALSO "v"
                 DISPLAY "  called with -"
                         FUNCTION TRIM (chaining-param) "-"
                         " and with -"
                         FUNCTION TRIM (chaining-param-2) "-"
              WHEN "start" ALSO SPACES
                 MOVE 'prog 1'         TO chaining-param
                 PERFORM callme
                 MOVE 'prog "1"'       TO chaining-param
                 PERFORM callme
                 MOVE '"prog" 1'       TO chaining-param
                 PERFORM callme
                 MOVE '"prog" "1"'     TO chaining-param
                 PERFORM callme
                 MOVE 'prog a v'       TO chaining-param
                 PERFORM callme
                 MOVE 'prog "a v"'     TO chaining-param
                 PERFORM callme
                 MOVE '"prog" a v'     TO chaining-param
                 PERFORM callme
                 MOVE '"prog" "a v"'   TO chaining-param
                 PERFORM callme
                 MOVE '"prog" "a" "v"' TO chaining-param
                 PERFORM callme
                 DISPLAY "tests finished"
              WHEN OTHER
                 DISPLAY "called with unexpected -"
                         FUNCTION TRIM (chaining-param) "-"
           END-EVALUATE
           STOP RUN.
      *
       callme.
           ADD  1 TO test-no.
           DISPLAY "Test #" test-no ":"
           DISPLAY "  CALL 'SYSTEM' with "
                   FUNCTION TRIM (chaining-param) ":"
           CALL "SYSTEM" USING FUNCTION TRIM (chaining-param)
           DISPLAY "  --> return of the given CALL 'SYSTEM': "
                   return-code.