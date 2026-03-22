IDENTIFICATION       DIVISION.
       PROGRAM-ID.          prog.

       DATA                 DIVISION.
       WORKING-STORAGE      SECTION.
       01  a.
           03  b            PIC X(3) VALUE SPACES.
           03  c            PIC X(3) VALUE SPACES.

       01  p.
           03  q            PIC 9(3) VALUE ZERO.
           03  r            PIC X(3) VALUE "abc".

       01  x.
           03  y.
               05  z        PIC X VALUE SPACE.

       01  out              PIC X(100).

       PROCEDURE            DIVISION.
           XML GENERATE out FROM a SUPPRESS WHEN SPACES
           IF out <> '<a/>'
               DISPLAY 'Test 1 failed: ' out
           END-IF

           XML GENERATE out FROM a SUPPRESS b WHEN SPACES
           IF out <> '<a><c> </c></a>'
               DISPLAY 'Test 2 failed: ' out
           END-IF

           XML GENERATE out FROM a SUPPRESS EVERY NONNUMERIC WHEN SPACES
           IF out <> '<a/>'
               DISPLAY 'Test 3 failed: ' out
           END-IF

           XML GENERATE out FROM p
               WITH ATTRIBUTES
               SUPPRESS EVERY ATTRIBUTE WHEN ZERO
           IF out <> '<p r="abc"/>'
               DISPLAY 'Test 4 failed: ' out
           END-IF

           XML GENERATE out FROM a
               SUPPRESS c WHEN LOW-VALUES, c WHEN SPACES,
                    c WHEN LOW-VALUES,
                    EVERY ELEMENT WHEN SPACES
           IF out <> '<a><c> </c></a>'
               DISPLAY 'Test 5 failed: ' out
           END-IF

           MOVE HIGH-VALUES TO b
           MOVE LOW-VALUES TO c
           XML GENERATE out FROM a
               SUPPRESS EVERY ELEMENT WHEN HIGH-VALUES OR LOW-VALUES
                   OR ZEROES OR SPACES
           IF out <> '<a/>'
               DISPLAY 'Test 6 failed: ' out
           END-IF

           XML GENERATE out FROM x SUPPRESS z WHEN SPACE
           IF out <> '<x/>'
               DISPLAY 'Test 7 failed: ' out
           END-IF
           .