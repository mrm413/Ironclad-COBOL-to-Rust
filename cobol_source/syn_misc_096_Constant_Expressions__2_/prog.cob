IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA  DIVISION.
       WORKING-STORAGE SECTION.
       78  const1    value 115.
       01  const2    CONSTANT 200.
       78  const3    value const2.
       78  const4    value const2 + const1.
       77  othervar  PIC X(const1).
       01  var       PIC X(const2).

       PROCEDURE DIVISION.

           IF const1 = const2
           OR const2 = const1
           OR const3 = const4
           OR const4 = const3
              DISPLAY 'no way' END-DISPLAY
           END-IF

           EVALUATE const1
           WHEN  15
           WHEN 115
               display '1'
           WHEN  < 16
               move othervar (1:8)
                 to var (17:8)
           WHEN  > 16
               display othervar
      *> actually WHEN OTHER is also FALSE in this case (115 = 16),
      *> but this is too complex to check
           WHEN OTHER
               display othervar
           END-EVALUATE

           STOP RUN.