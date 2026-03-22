IDENTIFICATION       DIVISION.
       PROGRAM-ID.          prog.

       DATA                 DIVISION.
       WORKING-STORAGE      SECTION.
       01  a.
           03  b            PIC X(3) VALUE SPACES.
           03  c            PIC X(3) VALUE SPACES.

       01  x.
           03  y.
               05  z        PIC X VALUE SPACE.

       01  out              PIC X(100).

       PROCEDURE            DIVISION.
           JSON GENERATE out FROM a SUPPRESS b
           IF out <> '{"a":{"c":" "}}'
               DISPLAY 'Test 1 failed: ' out
           END-IF

           JSON GENERATE out FROM x SUPPRESS z
           IF out <> '{"x":{}}'
               DISPLAY 'Test 2 failed: ' out
           END-IF
           .