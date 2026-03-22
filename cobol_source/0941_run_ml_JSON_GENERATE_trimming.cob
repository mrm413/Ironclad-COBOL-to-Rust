IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  str                     PIC X(3) VALUE "ab".
       01  num-edited              PIC 99.99 VALUE "01.00".
       01  leading-zeroes          PIC 9(5) VALUE 5.
       01  decimal-nums.
           03  decimal-num         PIC 99V999 PACKED-DECIMAL VALUE 0.12.
           03  decimal-num-2       PIC 99V9 VALUE 0.1.
       01  signed-decimal-num      PIC S999 COMP-X VALUE -1.
       01  comp-5-item             PIC 9(10) COMP-5 VALUE 5.
       01  index-item              INDEX.
       01  float-short-item        FLOAT-SHORT VALUE 100.
       01  float-long-item         FLOAT-LONG VALUE 123.0E-10.
       01  just-item               PIC X(10) JUST.
       01  integer-with-p          PIC 999PPP VALUE 10000.
       01  decimal-with-p          PIC VPP99 VALUE 0.0004.

       01  out                     PIC X(300).

       PROCEDURE DIVISION.
           JSON GENERATE out FROM str
           IF out <> '{"str":"ab"}'
               DISPLAY "Failed 1: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM num-edited
           IF out <> '{"num-edited":"01.00"}'
               DISPLAY "Failed 2: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM leading-zeroes
           IF out <> '{"leading-zeroes":5}'
               DISPLAY "Failed 3: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM decimal-nums
           IF out <> '{"decimal-nums":{"decimal-num":0.120,'-
                     '"decimal-num-2":0.1}}'
               DISPLAY "Failed 4: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM signed-decimal-num
           IF out <> '{"signed-decimal-num":-1}'
               DISPLAY "Failed 5: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM comp-5-item
           IF out <> '{"comp-5-item":5}'
               DISPLAY "Failed 6: " FUNCTION TRIM (out)
           END-IF

           SET index-item TO 500
           JSON GENERATE out FROM index-item
           IF out <> '{"index-item":500}'
               DISPLAY "Failed 7: " FUNCTION TRIM (out)
           END-IF

           *> JSON GENERATE out FROM float-short-item
           *> IF out <> '{"float-short-item":1E+02}'
           *>     DISPLAY "Failed 8: " FUNCTION TRIM (out)
           *> END-IF

           *> JSON GENERATE out FROM float-long-item
           *> IF out <> '{"float-long-item":123E-10}'
           *>     DISPLAY "Failed 9: " FUNCTION TRIM (out)
           *> END-IF

           MOVE "blah " TO just-item
           JSON GENERATE out FROM just-item
           IF out <> '{"just-item":"blah "}'
               DISPLAY "Failed 10: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM integer-with-p
           IF out <> '{"integer-with-p":10000}'
               DISPLAY "Failed 11: " FUNCTION TRIM (out)
           END-IF

           JSON GENERATE out FROM decimal-with-p
           IF out <> '{"decimal-with-p":0.0004}'
               DISPLAY "Failed 12: " FUNCTION TRIM (out)
           END-IF
           .