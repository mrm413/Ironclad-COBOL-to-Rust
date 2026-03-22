IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  normal-str PIC X(200).

       01  valid-rec.
           03  a      PIC XX VALUE "aa".
           03  b      PIC XX VALUE "bb".
       01  short-str  PIC X(5).
       01  short-str2 PIC X(22).
       01  xml-len    PIC 99.

       01  valid-namespace    CONSTANT "http://www.w3.org/1999/xhtml".
       01  invalid-namespace  CONSTANT X"00".
       01  invalid-prefix     PIC XXX VALUE "#<>".
       01  invalid-content    PIC X(3) VALUE X"8AFF00".
       01  count-in-too-small PIC 9.

       PROCEDURE DIVISION.
           MOVE ALL 'A' TO short-str
           XML GENERATE short-str FROM valid-rec
               COUNT IN xml-len
           IF  XML-CODE   <> 400
            OR short-str  <> "<vali"
            OR xml-len    <> 42
      *> FIXME: should be
      *>    OR short-str  <> "AAAAA"
      *>    OR xml-len    <> 0
              DISPLAY "Failed 1a: " short-str  " " xml-len " " XML-CODE
           END-IF
           MOVE ALL 'B' TO short-str2
           XML GENERATE short-str2 FROM valid-rec
               COUNT IN xml-len
           IF  XML-CODE   <> 400
            OR short-str2 <> "<valid-rec><a>aa</a><b"
            OR xml-len    <> 42
      *> FIXME: should be
      *>    OR short-str2 <> "<valid-rec><a>aa</a>BB"
      *>    OR xml-len    <> 20
              DISPLAY "Failed 1b: " short-str2 " " xml-len " " XML-CODE
           END-IF

           XML GENERATE normal-str FROM valid-rec
               NAMESPACE invalid-namespace
           IF XML-CODE <> 416
              DISPLAY "Failed 2: " FUNCTION TRIM (normal-str)
                       " " XML-CODE
           END-IF

           XML GENERATE normal-str FROM invalid-content
           IF  XML-CODE <> 417
            OR normal-str <> '<hex.invalid-content>8aff00</hex.'-
                            'invalid-content>'
              DISPLAY "Failed 3: " FUNCTION TRIM (normal-str)
                      " " XML-CODE
           END-IF

           XML GENERATE normal-str FROM valid-rec
               NAMESPACE "http://www.w3.org/1999/xhtml"
               NAMESPACE-PREFIX invalid-prefix
           IF  XML-CODE <> 419
              DISPLAY "Failed 4: " FUNCTION TRIM (normal-str)
                       " " XML-CODE
           END-IF

           XML GENERATE normal-str FROM valid-rec
                ON EXCEPTION
                    DISPLAY "Failed 5: EXCEPTION "
                        FUNCTION TRIM (normal-str)
                        " " XML-CODE
                    END-DISPLAY
                    *> The END-DISPLAY is important! Otherwise the DISPLAY will
                    *> take the NOT ON EXCEPTION.

                NOT ON EXCEPTION
                    IF XML-CODE <> 0
                        DISPLAY "Failed 5: NOT EXCEPTION "
                            FUNCTION TRIM (normal-str)
                            " " XML-CODE
                    END-IF
           END-XML

           XML GENERATE short-str FROM valid-rec
                NOT EXCEPTION
                    DISPLAY "Failed 6: NOT EXCEPTION "
                        FUNCTION TRIM (normal-str)
                        " " XML-CODE
                    END-DISPLAY

                EXCEPTION
                    IF XML-CODE <> 400
                        DISPLAY "Failed 6: ON EXCEPTION "
                            FUNCTION TRIM (normal-str)
                            " " XML-CODE
                    END-IF
           END-XML
           .