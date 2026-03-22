IDENTIFICATION       DIVISION.
       PROGRAM-ID.          prog.

       DATA                 DIVISION.
       WORKING-STORAGE      SECTION.
       01  out              PIC X(200).
       01  rec.
           03  a            PIC X(3) VALUE 'A'.
           03  b            PIC X(3) VALUE ALL 'B'.
           03  c.
               05  d        PIC X(3) VALUE SPACES.

       PROCEDURE            DIVISION.
           JSON GENERATE out
               FROM rec
               NAME OF a IS 'alpha', d IS 'ABCDEF'
               SUPPRESS c
           IF out <> '{"rec":{"alpha":"A","b":"BBB"}}'
               DISPLAY 'Test 1 failed: ' FUNCTION TRIM (out)
           END-IF
           JSON GENERATE out
               FROM rec
               NAME OF a IS 'alpha', rec IS OMITTED
               SUPPRESS c
           IF out <> '{"alpha":"A","b":"BBB"}'
               DISPLAY 'Test 2 failed: ' FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM d
           IF out <> '{"d":" "}'
               DISPLAY 'Test 3 failed: ' FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM c
           IF out <> '{"c":{"d":" "}}'
               DISPLAY 'Test 4 failed: ' FUNCTION TRIM (out)
           END-IF

           MOVE ALL QUOTES TO d
           JSON GENERATE out FROM d
           IF out <> '{"d":"\"\"\""}'
               DISPLAY 'Test 5 failed: ' FUNCTION TRIM (out)
           END-IF
           .