IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 X1  PIC X  COMP-X VALUE 0.
       01 X2  PIC X  COMP-X VALUE 0.
       01 X3  PIC X  COMP-X VALUE 0.
       01 XX1 PIC XX COMP-X VALUE 0.
       01 XX2 PIC XX COMP-X VALUE 0.
       01 XX3 PIC XX COMP-X VALUE 0.
       PROCEDURE DIVISION.
           MOVE 2 TO XX2 X2
           MOVE 4 TO XX3 X3.

           DISPLAY "Test using PIC XX COMP-X"
           COMPUTE XX1 = (XX2 B-OR XX3).
           DISPLAY XX2 " B-OR  " XX3 " is " XX1.
           MOVE 3 TO XX3.
           COMPUTE XX1 = (XX2 B-XOR XX3).
           DISPLAY XX2 " B-XOR " XX3 " is " XX1.
           MOVE 3 TO XX2
           MOVE 1 TO XX1.
           IF (XX2 B-AND XX1) = XX1
                DISPLAY XX2 " B-AND " XX1 " = " XX1 " TRUE"
            ELSE
                DISPLAY XX2 " B-AND " XX1 " = " XX1 " FALSE"
           END-IF.
           COMPUTE XX1 = (XX2 B-XOR XX3) + 1 .
           DISPLAY "(" XX2 " B-XOR " XX3 ") + 1 is " XX1.
           COMPUTE XX1 = XX2 B-XOR (XX3 + 1).
           DISPLAY XX2 " B-XOR (" XX3 " + 1) is " XX1.
           MOVE  x#09 TO XX3.
           MOVE  x#0E TO XX2.
           COMPUTE XX1 = XX2 B-AND XX3 .
           DISPLAY XX2 " B-AND " XX3 " is " XX1.
           COMPUTE XX1 = (x#05 B-OR x#22).
           DISPLAY "x#05 B-OR x#22 is " XX1.
           COMPUTE XX1 = B-NOT XX2 .
           DISPLAY "B-NOT " XX2 " is " XX1.
           COMPUTE XX1 = B-NOT x#22 .
           DISPLAY "B-NOT x#22 is " XX1.

           DISPLAY "  -----"
           DISPLAY "Test using PIC X COMP-X"
           COMPUTE X1 = (X2 B-OR X3).
           DISPLAY X2 " B-OR  " X3 " is " X1.
           MOVE 3 TO X3.
           COMPUTE X1 = (X2 B-XOR X3).
           DISPLAY X2 " B-XOR " X3 " is " X1.
           MOVE 3 TO X2
           MOVE 1 TO X1.
           IF (X2 B-AND X1) = X1
                DISPLAY X2 " B-AND " X1 " = " X1 " TRUE"
            ELSE
                DISPLAY X2 " B-AND " X1 " = " X1 " FALSE"
           END-IF.
           COMPUTE X1 = (X2 B-XOR X3) + 1 .
           DISPLAY "(" X2 " B-XOR " X3 ") + 1 is " X1.
           COMPUTE X1 = X2 B-XOR (X3 + 1).
           DISPLAY X2 " B-XOR (" X3 " + 1) is " X1.
           MOVE  x#09 TO X3.
           MOVE  x#0E TO X2.
           COMPUTE X1 = X2 B-AND X3 .
           DISPLAY X2 " B-AND " X3 " is " X1.
           COMPUTE X1 = B-NOT X2 .
           DISPLAY "B-NOT " X2 " is " X1.
           COMPUTE X1 = B-NOT x#22 .
           DISPLAY "B-NOT x#22 is " X1.
           STOP RUN.