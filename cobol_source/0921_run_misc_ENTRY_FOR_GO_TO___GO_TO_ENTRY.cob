IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 JUMP-ENTRY    PIC 9  VALUE 6.
          88 EXT-MODUS  VALUES 3, 4.
       LINKAGE SECTION.
       PROCEDURE DIVISION.
           GO TO ENTRY 'STMT05'.
       MAIN.
           GO TO ENTRY 'STMT01'
                       'STMT02'
                       'STMT03'
                       'STMT04'
                       'STMT05'
           DEPENDING ON JUMP-ENTRY
           DISPLAY 'NOT JUMPED'
           GOBACK.
       ENTRY FOR GO TO 'STMT01'
           DISPLAY 'STMT01'
       ENTRY FOR GO TO 'STMT02'
           PERFORM 3 TIMES
       ENTRY FOR GO TO 'STMT03'
              DISPLAY 'STMT03'
       ENTRY FOR GO TO 'STMT04'  DISPLAY 'STMT04'
              IF EXT-MODUS EXIT PERFORM END-IF
           END-PERFORM
       ENTRY FOR GO TO 'STMT05'
           DISPLAY 'STMT05'
           SUBTRACT 1 FROM JUMP-ENTRY
           GO TO MAIN.