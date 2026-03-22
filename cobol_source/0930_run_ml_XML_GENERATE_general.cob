IDENTIFICATION       DIVISION.
       PROGRAM-ID.          prog.

       DATA                 DIVISION.
       WORKING-STORAGE      SECTION.
       01  namespace-str    PIC X(100)
                            VALUE 'http://www.w3.org/1999/xhtml'.
       01  prefix-str       PIC X(100) VALUE 'pre'.

       01  out              PIC X(200).
       01  rec.
           03  a            PIC X(3) VALUE 'A'.
           03  b            PIC X(3) VALUE ALL 'B'.
           03  c.
               05  d        PIC X(3) VALUE SPACES.

       01  0SpecialTAGName  PIC X(3) VALUE "abc".

       01  employee.
           05 id            PIC 9(1)  value 1.
           05 name          PIC X(10) value "Someone".
           05 dept          PIC X(10) value "Marketing".

       PROCEDURE            DIVISION.
           XML GENERATE out
               FROM rec
               WITH XML-DECLARATION
               NAME OF a IS 'alpha', d IS 'ABCDEF';
               TYPE OF a IS ATTRIBUTE
               SUPPRESS WHEN SPACES
           IF out <> '<?xml version="1.0"?>' & X'0A'
                   & '<rec alpha="A"><b>BBB</b></rec>'
               DISPLAY 'Test 1 failed: ' FUNCTION TRIM (out)
           END-IF

           XML GENERATE out FROM d
           IF out <> '<d> </d>'
               DISPLAY 'Test 2 failed: ' FUNCTION TRIM (out)
           END-IF

           XML GENERATE out FROM c, WITH ATTRIBUTES.
           IF out <> '<c d=" "/>'
               DISPLAY 'Test 3 failed: ' FUNCTION TRIM (out)
           END-IF

           MOVE ALL 'A' TO a
           MOVE ALL 'C' TO c
           XML GENERATE out FROM rec, TYPE OF a IS CONTENT,
               b IS CONTENT, d IS CONTENT
           IF out <> '<rec>AAABBB<c>CCC</c></rec>'
               DISPLAY 'Test 4 failed: ' FUNCTION TRIM (out)
           END-IF

           XML GENERATE out FROM rec, TYPE OF a IS CONTENT, d IS CONTENT
           IF out <> '<rec>AAA<b>BBB</b><c>CCC</c></rec>'
               DISPLAY 'Test 5 failed: ' FUNCTION TRIM (out)
           END-IF

           XML GENERATE out FROM c, NAMESPACE namespace-str,
               NAMESPACE-PREFIX prefix-str
           IF out <> '<pre:c xmlns:pre="http://www.w3.org/1999/xhtml">'-
                   '<pre:d>CCC</pre:d></pre:c>'
               DISPLAY 'Test 6 failed: ' FUNCTION TRIM (out)
                   " " XML-CODE
           END-IF

           MOVE SPACES TO namespace-str, prefix-str
           XML GENERATE out FROM c, NAMESPACE namespace-str,
               NAMESPACE-PREFIX prefix-str
           IF out <> '<c><d>CCC</d></c>'
               DISPLAY 'Test 7 failed: ' FUNCTION TRIM (out)
           END-IF

           MOVE ALL "&" TO d
           XML GENERATE out FROM d
           IF out <> '<d>&amp;&amp;&amp;</d>'
               DISPLAY 'Test 8 failed: ' FUNCTION TRIM (out)
           END-IF

           *> Test the case of the id in the DATA DIVISION is preserved.
           XML GENERATE out FROM 0specialtagname
           IF out <> '<_0SpecialTAGName>abc</_0SpecialTAGName>'
               DISPLAY 'Test 9 failed: ' FUNCTION TRIM (out)
           END-IF
           .

           *> Another test with mixed attributes and values
           XML GENERATE out FROM EMPLOYEE TYPE OF ID IS ATTRIBUTE
           IF out <> '<employee id="1">'-
                     '<name>Someone</name>'-
                     '<dept>Marketing</dept>'-
                     '</employee>'
               DISPLAY 'Test 10 failed: ' FUNCTION TRIM (out)
           END-IF
           .