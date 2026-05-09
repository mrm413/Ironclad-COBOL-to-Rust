IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  CNT                    PIC  99     VALUE ZERO.
       77  CALCER                 PIC s99v99.
       01  DUMMY-RES              PIC  99.
      *>
       PROCEDURE DIVISION.
      *>  variable setting postponed here to work around "easy"
      *>  optimization to constant
           MOVE 3.5 TO CALCER
           PERFORM 42 TIMES
             ADD   1 TO CNT
    >>D      DISPLAY CNT
      *> directly returns:
      *>    COMPUTE DUMMY-RES = 2 * (CALCER + 2) + 2
      *> performs "felt as forever":
             COMPUTE DUMMY-RES = (CALCER + 2) * 2 + 2
           END-PERFORM

           GOBACK.