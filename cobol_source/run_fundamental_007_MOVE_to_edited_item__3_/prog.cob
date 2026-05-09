IDENTIFICATION DIVISION.
       PROGRAM-ID . DisplayToAlphaEdited.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 SRC-FIELD              PIC 9(06).
      *>
       01 DST-FIELD-1            PIC 0XXXXXX.
       01 DST-FIELD-2            PIC BXXXXXX.
       01 DST-FIELD-3            PIC /XXXXXX.
       01 DST-FIELD-4            PIC XXXXXX0.
       01 DST-FIELD-5            PIC XXXXXXB.
       01 DST-FIELD-6            PIC XXXXXX/.
       01 DST-FIELD-7            PIC XXX0XXX.
       01 DST-FIELD-8            PIC XXXBXXX.
       01 DST-FIELD-9            PIC XXX/XXX.
       01 DST-FIELD-10           PIC XB0XB0/.
       01 DST-FIELD-11           PIC 0AA.
       01 DST-FIELD-12           PIC BXA.
       01 DST-FIELD-13           PIC /99.
       01 DST-FIELD-14           PIC 990.
       01 DST-FIELD-15           PIC XAB.
       01 DST-FIELD-16           PIC XA/.
      *>
       01 EXPT-FIELD-1  CONSTANT AS '0123456' .
       01 EXPT-FIELD-2  CONSTANT AS ' 123456' .
       01 EXPT-FIELD-3  CONSTANT AS '/123456' .
       01 EXPT-FIELD-4  CONSTANT AS '1234560' .
       01 EXPT-FIELD-5  CONSTANT AS '123456 ' .
       01 EXPT-FIELD-6  CONSTANT AS '123456/' .
       01 EXPT-FIELD-7  CONSTANT AS '1230456' .
       01 EXPT-FIELD-8  CONSTANT AS '123 456' .
       01 EXPT-FIELD-9  CONSTANT AS '123/456' .
       01 EXPT-FIELD-10 CONSTANT AS '1 02 0/' .
       01 EXPT-FIELD-11 CONSTANT AS '012' .
       01 EXPT-FIELD-12 CONSTANT AS ' 12' .
       01 EXPT-FIELD-13 CONSTANT AS '/00' .
       01 EXPT-FIELD-14 CONSTANT AS '560' .
       01 EXPT-FIELD-15 CONSTANT AS '12 ' .
       01 EXPT-FIELD-16 CONSTANT AS '12/' .
       PROCEDURE DIVISION.
       TEST-RUNNER.
      *> done twice to already check for later compile-time optimization
           MOVE '123456'
             TO DST-FIELD-1  DST-FIELD-2  DST-FIELD-3
                DST-FIELD-4  DST-FIELD-5  DST-FIELD-6
                DST-FIELD-7  DST-FIELD-8  DST-FIELD-9
                DST-FIELD-10 DST-FIELD-11 DST-FIELD-12
                DST-FIELD-12 DST-FIELD-14 DST-FIELD-15
                DST-FIELD-16 SRC-FIELD
           PERFORM DO-TEST.
      *> done twice to already check for later compile-time optimization
           MOVE SRC-FIELD
             TO DST-FIELD-1  DST-FIELD-2  DST-FIELD-3
                DST-FIELD-4  DST-FIELD-5  DST-FIELD-6
                DST-FIELD-7  DST-FIELD-8  DST-FIELD-9
                DST-FIELD-10 DST-FIELD-11 DST-FIELD-12
                DST-FIELD-12 DST-FIELD-14 DST-FIELD-15
                DST-FIELD-16
           PERFORM DO-TEST.
           GOBACK.
       DO-TEST.
           IF DST-FIELD-1 NOT =  EXPT-FIELD-1
              DISPLAY '1: <' DST-FIELD-1 '> != <' EXPT-FIELD-1 '>'.
           IF DST-FIELD-2 NOT =  EXPT-FIELD-2
              DISPLAY '2: <' DST-FIELD-2 '> != <' EXPT-FIELD-2 '>'.
           IF DST-FIELD-3 NOT =  EXPT-FIELD-3
              DISPLAY '3: <' DST-FIELD-3 '> != <' EXPT-FIELD-3 '>'.
           IF DST-FIELD-4 NOT =  EXPT-FIELD-4
              DISPLAY '4: <' DST-FIELD-4 '> != <' EXPT-FIELD-4 '>'.
           IF DST-FIELD-5 NOT =  EXPT-FIELD-5
              DISPLAY '5: <' DST-FIELD-5 '> != <' EXPT-FIELD-5 '>'.
           IF DST-FIELD-6 NOT =  EXPT-FIELD-6
              DISPLAY '6: <' DST-FIELD-6 '> != <' EXPT-FIELD-6 '>'.
           IF DST-FIELD-7 NOT =  EXPT-FIELD-7
              DISPLAY '7: <' DST-FIELD-7 '> != <' EXPT-FIELD-7 '>'.
           IF DST-FIELD-8 NOT =  EXPT-FIELD-8
              DISPLAY '8: <' DST-FIELD-8 '> != <' EXPT-FIELD-8 '>'.
           IF DST-FIELD-9 NOT =  EXPT-FIELD-9
              DISPLAY '9: <' DST-FIELD-9 '> != <' EXPT-FIELD-9 '>'.
           IF DST-FIELD-10 NOT =  EXPT-FIELD-10
              DISPLAY '10: <' DST-FIELD-10 '> != <' EXPT-FIELD-10 '>'.
           IF DST-FIELD-11 NOT =  EXPT-FIELD-11
              DISPLAY '11: <' DST-FIELD-11 '> != <' EXPT-FIELD-11 '>'.
           IF DST-FIELD-12 NOT =  EXPT-FIELD-12
              DISPLAY '12: <' DST-FIELD-12 '> != <' EXPT-FIELD-12 '>'.
           IF DST-FIELD-13 NOT =  EXPT-FIELD-13
              DISPLAY '13: <' DST-FIELD-13 '> != <' EXPT-FIELD-13 '>'.
           IF DST-FIELD-14 NOT =  EXPT-FIELD-14
              DISPLAY '14: <' DST-FIELD-14 '> != <' EXPT-FIELD-14 '>'.
           IF DST-FIELD-15 NOT =  EXPT-FIELD-15
              DISPLAY '15: <' DST-FIELD-15 '> != <' EXPT-FIELD-15 '>'.
           IF DST-FIELD-16 NOT =  EXPT-FIELD-16
              DISPLAY '16: <' DST-FIELD-16 '> != <' EXPT-FIELD-16 '>'.