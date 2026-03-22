IDENTIFICATION DIVISION.
       PROGRAM-ID. PROG.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ARR-ARRAY.
           03  ARR-ENTRY       OCCURS 6 TIMES.
               05 ARR-FLD1             PIC X(10)
                   VALUE 'RIGHT' JUSTIFIED RIGHT.
               05 ARR-FLD2             PIC X(10)
                   VALUE 'LEFT'.
               05  ARR-FLD3        OCCURS 6 TIMES.
                   10 ARR-FLD4             PIC X(10)
                       VALUE 'RIGHT' JUSTIFIED RIGHT.
                   10 ARR-FLD5             PIC X(10)
                       VALUE 'LEFT'.

       01  CNTR                        PIC S9(4)  COMP.
       01  CNTR2                       PIC S9(4)  COMP.

       77  ELE                         PIC X(10)
                   VALUE 'RIGHT' JUSTIFIED RIGHT.
       77  ELE2                        PIC X(10)
                   VALUE 'R' JUSTIFIED RIGHT.
       77  ELE3                        PIC X(10)
                   VALUE 'RRRRRRRRR' JUSTIFIED RIGHT.
       77  ELE4                        PIC X(10)
                   VALUE 'RRRRRRRRRR' JUSTIFIED RIGHT.
       77  ELE5                        PIC X(1003)
                   VALUE 'RRR' JUSTIFIED RIGHT.

       PROCEDURE DIVISION.

           >>IF JUSTIFY EQUAL 'JUSTIFY'
               PERFORM 1000-JUSTIFY-IS-RIGHT THRU 1000-EXIT.
           >>ELSE
               PERFORM 2000-JUSTIFY-IS-OFF   THRU 2000-EXIT.
           >>END-IF

           IF ELE4 NOT EQUAL 'RRRRRRRRRR'
               DISPLAY 'ELE4 NOT INITIALIZED CORRECTLY' ELE4
           END-IF.

           STOP RUN.


       1000-JUSTIFY-IS-RIGHT.

           IF ELE NOT EQUAL '     RIGHT'
               DISPLAY 'ELE NOT INITIALIZED CORRECTLY ' ELE
           END-IF.

           IF ELE2 NOT EQUAL '         R'
               DISPLAY 'ELE2 NOT INITIALIZED CORRECTLY ' ELE2
           END-IF.

           IF ELE3 NOT EQUAL ' RRRRRRRRR'
               DISPLAY 'ELE3 NOT INITIALIZED CORRECTLY ' ELE3
           END-IF.

           IF ELE5 (1:1000) NOT EQUAL SPACES
           OR ELE5 (1001:)  NOT EQUAL "RRR"
               DISPLAY 'ELE5 NOT INITIALIZED CORRECTLY ' ELE5
           END-IF.

           IF ARR-FLD1 (2) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD1 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (2) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD1 (6) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD1 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (2,3) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD4 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (2,3) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (6,6) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD4 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (6,6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

           MOVE ALL 'X'                TO ARR-ARRAY.
           MOVE ALL 'X'                TO ELE.

           INITIALIZE ELE       WITH FILLER ALL TO VALUE.
           INITIALIZE ARR-ARRAY WITH FILLER ALL TO VALUE.

           IF ELE NOT EQUAL '     RIGHT'
               DISPLAY 'ELE NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD1 (2) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD1 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (2) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD1 (6) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD1 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (2,3) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD4 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (2,3) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (6,6) NOT EQUAL '     RIGHT'
               DISPLAY 'ARR-FLD4 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (6,6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

       1000-EXIT.  EXIT.


       2000-JUSTIFY-IS-OFF.

           IF ELE NOT EQUAL 'RIGHT     '
               DISPLAY 'ELE NOT INITIALIZED CORRECTLY ' ELE
           END-IF.

           IF ELE2 NOT EQUAL 'R         '
               DISPLAY 'ELE2 NOT INITIALIZED CORRECTLY ' ELE2
           END-IF.

           IF ELE3 NOT EQUAL 'RRRRRRRRR '
               DISPLAY 'ELE3 NOT INITIALIZED CORRECTLY ' ELE3
           END-IF.

           IF ELE5 (1:3) NOT EQUAL "RRR"
           OR ELE5 (4:)  NOT EQUAL SPACES
               DISPLAY 'ELE5 NOT INITIALIZED CORRECTLY ' ELE5
           END-IF.

           IF ARR-FLD1 (2) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD1 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (2) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD1 (6) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD1 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (2,3) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD4 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (2,3) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (6,6) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD4 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (6,6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

           MOVE ALL 'X'                TO ARR-ARRAY.
           MOVE ALL 'X'                TO ELE.

           INITIALIZE ELE       WITH FILLER ALL TO VALUE.
           INITIALIZE ARR-ARRAY WITH FILLER ALL TO VALUE.

           IF ELE NOT EQUAL 'RIGHT     '
               DISPLAY 'ELE NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD1 (2) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD1 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (2) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (2) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD1 (6) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD1 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD2 (6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD2 (6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (2,3) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD4 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (2,3) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (2,3) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD4 (6,6) NOT EQUAL 'RIGHT     '
               DISPLAY 'ARR-FLD4 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

           IF ARR-FLD5 (6,6) NOT EQUAL 'LEFT      '
               DISPLAY 'ARR-FLD5 (6,6) NOT INITIALIZED CORRECTLY'
           END-IF.

       2000-EXIT.  EXIT.


       END PROGRAM PROG.