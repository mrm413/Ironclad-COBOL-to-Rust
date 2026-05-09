IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 X1 PIC XX COMP-X VALUE 0.
       01 X2 PIC XX COMP-X VALUE 0.
       01 N1 PIC 9(4) COMP-5 VALUE 0.
       01 N2 PIC 9(4) COMP-5 VALUE 0.
       PROCEDURE DIVISION.
           MOVE  x#0A TO X2.
           DISPLAY "Using PIC XX COMP-X"
           COMPUTE X1 = (x#22 B-LEFT x#05).
           DISPLAY " x#22 B-LEFT  x#05   is " X1.
           COMPUTE X1 = (x#22 B-RIGHT x#02).
           DISPLAY " x#22 B-RIGHT x#02   is " X1.
           COMPUTE X1 = (x#22 B-SHIFT-L x#05).
           DISPLAY " x#22 B-SHIFT-L x#05 is " X1.
           COMPUTE X1 = (x#22 B-SHIFT-R x#02).
           DISPLAY " x#22 B-SHIFT-R x#02 is " X1.
           COMPUTE X1 = (X2 B-LEFT x#05).
           DISPLAY X2 " B-LEFT  x#05   is " X1.
           COMPUTE X1 = (X2 B-RIGHT x#02).
           DISPLAY X2 " B-RIGHT x#02   is " X1.
           MOVE  x#7573 TO X2.
           COMPUTE X1 = (X2 B-SHIFT-LC 4).
           DISPLAY X2 " B-SHIFT-LC 4   is " X1.
           COMPUTE X1 = (X2 B-SHIFT-RC 4).
           DISPLAY X2 " B-SHIFT-RC 4   is " X1.

           MOVE  10 TO N2.
           DISPLAY "Using PIC 9(4) COMP-5"
           COMPUTE N1 = (x#22 B-LEFT x#05).
           DISPLAY " x#22 B-LEFT  x#05   is " N1.
           COMPUTE N1 = (x#22 B-RIGHT x#02).
           DISPLAY " x#22 B-RIGHT x#02   is " N1.
           COMPUTE N1 = (x#22 B-SHIFT-L x#05).
           DISPLAY " x#22 B-SHIFT-L x#05 is " N1.
           COMPUTE N1 = (x#22 B-SHIFT-R x#02).
           DISPLAY " x#22 B-SHIFT-R x#02 is " N1.
           COMPUTE N1 = (N2 B-LEFT x#05).
           DISPLAY N2 " B-LEFT  x#05   is " N1.
           COMPUTE N1 = (N2 B-RIGHT x#02).
           DISPLAY N2 " B-RIGHT x#02   is " N1.
           STOP RUN.