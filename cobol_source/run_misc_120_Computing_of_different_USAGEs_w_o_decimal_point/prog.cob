IDENTIFICATION DIVISION.
       PROGRAM-ID. 'prog'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       77  BCL-A           BINARY-C-LONG    VALUE 1.
       77  BCL-B           BINARY-C-LONG    VALUE 10.
       77  BCL-RES         BINARY-C-LONG.
      *
       77  BC-A            BINARY-CHAR      VALUE 1.
       77  BC-B            BINARY-CHAR      VALUE 10.
       77  BC-RES          BINARY-CHAR.
      *
       77  BD-A            BINARY-DOUBLE    VALUE 1.
       77  BD-B            BINARY-DOUBLE    VALUE 10.
       77  BD-RES          BINARY-DOUBLE.
      *
       77  BL-A            BINARY-LONG      VALUE 1.
       77  BL-B            BINARY-LONG      VALUE 10.
       77  BL-RES          BINARY-LONG.
      *
       77  C-A     PIC S99 COMP             VALUE 1.
       77  C-B     PIC S99 COMP             VALUE 10.
       77  C-RES   PIC S99 COMP.
      *
       77  C1-A            COMP-1           VALUE 1.
       77  C1-B            COMP-1           VALUE 10.
       77  C1-RES          COMP-1.
      *
       77  C2-A            COMP-2           VALUE 1.
       77  C2-B            COMP-2           VALUE 10.
       77  C2-RES          COMP-2.
      *
       77  C3-A    PIC S99 COMP-3           VALUE 1.
       77  C3-B    PIC S99 COMP-3           VALUE 10.
       77  C3-RES  PIC S99 COMP-3.
      *
       77  C5-A    PIC S99 COMP-5           VALUE 1.
       77  C5-B    PIC S99 COMP-5           VALUE 10.
       77  C5-RES  PIC S99 COMP-5.
      *
       77  C6-A    PIC  99 COMP-6           VALUE 1.
       77  C6-B    PIC  99 COMP-6           VALUE 10.
       77  C6-RES  PIC  99 COMP-6.
      *
       77  CN9-A   PIC  99 COMP-N           VALUE 1.
       77  CN9-B   PIC  99 COMP-N           VALUE 10.
       77  CN9-RES PIC  99 COMP-N.
      *
       77  CNX-A   PIC  X  COMP-N           VALUE 1.
       77  CNX-B   PIC  X  COMP-N           VALUE 10.
       77  CNX-RES PIC  X  COMP-N.
      *
       77  CX9-A   PIC  99 COMP-X           VALUE 1.
       77  CX9-B   PIC  99 COMP-X           VALUE 10.
       77  CX9-RES PIC  99 COMP-X.
      *
       77  CXX-A   PIC  X  COMP-X           VALUE 1.
       77  CXX-B   PIC  X  COMP-X           VALUE 10.
       77  CXX-RES PIC  X  COMP-X.
      *
       77  D-A     PIC  S99                 VALUE 1.
       77  D-B     PIC  S99                 VALUE 10.
       77  D-RES   PIC  S99.
      *
       77  FD16-A          FLOAT-DECIMAL-16 VALUE 1.
       77  FD16-B          FLOAT-DECIMAL-16 VALUE 10.
       77  FD16-RES        FLOAT-DECIMAL-16.
      *
       77  FD34-A          FLOAT-DECIMAL-34 VALUE 1.
       77  FD34-B          FLOAT-DECIMAL-34 VALUE 10.
       77  FD34-RES        FLOAT-DECIMAL-34.
      *
       77  FL-A            FLOAT-LONG       VALUE 1.
       77  FL-B            FLOAT-LONG       VALUE 10.
       77  FL-RES          FLOAT-LONG.
      *
       77  FS-A            FLOAT-SHORT      VALUE 1.
       77  FS-B            FLOAT-SHORT      VALUE 10.
       77  FS-RES          FLOAT-SHORT.
      *
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.
      *
       PROCEDURE DIVISION.
       MAIN.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 20000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
      *
           INITIALIZE
               BCL-A BCL-B
               BC-A BC-B
               BD-A BD-B
               BL-A BL-B
               C-A C-B
               C1-A C1-B
               C2-A C2-B
               C3-A C3-B
               C5-A C5-B
               C6-A C6-B
               CN9-A CN9-B
               CNX-A CNX-B
               CX9-A CX9-B
               CXX-A CXX-B
               D-A D-B
               FD16-A FD16-B
               FD34-A FD34-B
               FL-A FL-B
               FS-A FS-B
              ALL TO VALUE.
      *
           ADD  BCL-B  TO BCL-A.
           MOVE BCL-A  TO BCL-RES.
           IF BCL-RES NOT = 11
              DISPLAY 'ERROR BINARY-C-LONG + BINARY-C-LONG'.
           MOVE 1     TO BCL-A.
           ADD  10    TO BCL-A.
           MOVE BCL-A  TO BCL-RES.
           IF BCL-RES NOT = 11
              DISPLAY 'ERROR BINARY-C-LONG + NUM'.
           MOVE 11    TO BCL-A.
           SUBTRACT BCL-B FROM BCL-A.
           MOVE BCL-A  TO BCL-RES.
           IF BCL-RES NOT = 1
              DISPLAY 'ERROR BINARY-C-LONG - BINARY-C-LONG'.
           MOVE 11    TO BCL-A.
           SUBTRACT 10   FROM BCL-A.
           MOVE BCL-A  TO BCL-RES.
           IF BCL-RES NOT = 1
              DISPLAY 'ERROR BINARY-C-LONG - NUM'.
      *
           ADD  BC-B  TO BC-A.
           MOVE BC-A  TO BC-RES.
           IF BC-RES NOT = 11
              DISPLAY 'ERROR BINARY-CHAR + BINARY-CHAR'.
           MOVE 1     TO BC-A.
           ADD  10    TO BC-A.
           MOVE BC-A  TO BC-RES.
           IF BC-RES NOT = 11
              DISPLAY 'ERROR BINARY-CHAR + NUM'.
           MOVE 11    TO BC-A.
           SUBTRACT BC-B FROM BC-A.
           MOVE BC-A  TO BC-RES.
           IF BC-RES NOT = 1
              DISPLAY 'ERROR BINARY-CHAR - BINARY-CHAR'.
           MOVE 11    TO BC-A.
           SUBTRACT 10   FROM BC-A.
           MOVE BC-A  TO BC-RES.
           IF BC-RES NOT = 1
              DISPLAY 'ERROR BINARY-CHAR - NUM'.
      *
           ADD  BD-B  TO BD-A.
           MOVE BD-A  TO BD-RES.
           IF BD-RES NOT = 11
              DISPLAY 'ERROR BINARY-DOUBLE + BINARY-DOUBLE'.
           MOVE 1     TO BD-A.
           ADD  10    TO BD-A.
           MOVE BD-A  TO BD-RES.
           IF BD-RES NOT = 11
              DISPLAY 'ERROR BINARY-DOUBLE + NUM'.
           MOVE 11    TO BD-A.
           SUBTRACT BD-B FROM BD-A.
           MOVE BD-A  TO BD-RES.
           IF BD-RES NOT = 1
              DISPLAY 'ERROR BINARY-DOUBLE - BINARY-DOUBLE'.
           MOVE 11    TO BD-A.
           SUBTRACT 10   FROM BD-A.
           MOVE BD-A  TO BD-RES.
           IF BD-RES NOT = 1
              DISPLAY 'ERROR BINARY-DOUBLE - NUM'.
      *
           ADD  BL-B  TO BL-A.
           MOVE BL-A  TO BL-RES.
           IF BL-RES NOT = 11
              DISPLAY 'ERROR BINARY-LONG + BINARY-LONG'.
           MOVE 1     TO BL-A.
           ADD  10    TO BL-A.
           MOVE BL-A  TO BL-RES.
           IF BL-RES NOT = 11
              DISPLAY 'ERROR BINARY-LONG + NUM'.
           MOVE 11    TO BL-A.
           SUBTRACT BL-B FROM BL-A.
           MOVE BL-A  TO BL-RES.
           IF BL-RES NOT = 1
              DISPLAY 'ERROR BINARY-LONG - BINARY-LONG'.
           MOVE 11    TO BL-A.
           SUBTRACT 10   FROM BL-A.
           MOVE BL-A  TO BL-RES.
           IF BL-RES NOT = 1
              DISPLAY 'ERROR BINARY-LONG - NUM'.
      *
           ADD  C-B  TO C-A.
           MOVE C-A  TO C-RES.
           IF C-RES NOT = 11
              DISPLAY 'ERROR COMP + COMP'.
           MOVE 1     TO C-A.
           ADD  10    TO C-A.
           MOVE C-A  TO C-RES.
           IF C-RES NOT = 11
              DISPLAY 'ERROR COMP + NUM'.
           MOVE 11    TO C-A.
           SUBTRACT C-B FROM C-A.
           MOVE C-A  TO C-RES.
           IF C-RES NOT = 1
              DISPLAY 'ERROR COMP - COMP'.
           MOVE 11    TO C-A.
           SUBTRACT 10   FROM C-A.
           MOVE C-A  TO C-RES.
           IF C-RES NOT = 1
              DISPLAY 'ERROR COMP - NUM'.
      *
           ADD  C1-B  TO C1-A.
           MOVE C1-A  TO C1-RES.
           IF C1-RES NOT = 11
              DISPLAY 'ERROR COMP-1 + COMP-1'.
           MOVE 1     TO C1-A.
           ADD  10    TO C1-A.
           MOVE C1-A  TO C1-RES.
           IF C1-RES NOT = 11
              DISPLAY 'ERROR COMP-1 + NUM'.
           MOVE 11    TO C1-A.
           SUBTRACT C1-B FROM C1-A.
           MOVE C1-A  TO C1-RES.
           IF C1-RES NOT = 1
              DISPLAY 'ERROR COMP-1 - COMP-1'.
           MOVE 11    TO C1-A.
           SUBTRACT 10   FROM C1-A.
           MOVE C1-A  TO C1-RES.
           IF C1-RES NOT = 1
              DISPLAY 'ERROR COMP-1 - NUM'.
      *
           ADD  C2-B  TO C2-A.
           MOVE C2-A  TO C2-RES.
           IF C2-RES NOT = 11
              DISPLAY 'ERROR COMP-2 + COMP-2'.
           MOVE 1     TO C2-A.
           ADD  10    TO C2-A.
           MOVE C2-A  TO C2-RES.
           IF C2-RES NOT = 11
              DISPLAY 'ERROR COMP-2 + NUM'.
           MOVE 11    TO C2-A.
           SUBTRACT C2-B FROM C2-A.
           MOVE C2-A  TO C2-RES.
           IF C2-RES NOT = 1
              DISPLAY 'ERROR COMP-2 - COMP-2'.
           MOVE 11    TO C2-A.
           SUBTRACT 10   FROM C2-A.
           MOVE C2-A  TO C2-RES.
           IF C2-RES NOT = 1
              DISPLAY 'ERROR COMP-2 - NUM'.
      *
           ADD  C3-B  TO C3-A.
           MOVE C3-A  TO C3-RES.
           IF C3-RES NOT = 11
              DISPLAY 'ERROR COMP-3 + COMP-3'.
           MOVE 1     TO C3-A.
           ADD  10    TO C3-A.
           MOVE C3-A  TO C3-RES.
           IF C3-RES NOT = 11
              DISPLAY 'ERROR COMP-3 + NUM'.
           MOVE 11    TO C3-A.
           SUBTRACT C3-B FROM C3-A.
           MOVE C3-A  TO C3-RES.
           IF C3-RES NOT = 1
              DISPLAY 'ERROR COMP-3 - COMP-3'.
           MOVE 11    TO C3-A.
           SUBTRACT 10   FROM C3-A.
           MOVE C3-A  TO C3-RES.
           IF C3-RES NOT = 1
              DISPLAY 'ERROR COMP-3 - NUM'.
      *
           ADD  C5-B  TO C5-A.
           MOVE C5-A  TO C5-RES.
           IF C5-RES NOT = 11
              DISPLAY 'ERROR COMP-5 + COMP-5'.
           MOVE 1     TO C5-A.
           ADD  10    TO C5-A.
           MOVE C5-A  TO C5-RES.
           IF C5-RES NOT = 11
              DISPLAY 'ERROR COMP-5 + NUM'.
           MOVE 11    TO C5-A.
           SUBTRACT C5-B FROM C5-A.
           MOVE C5-A  TO C5-RES.
           IF C5-RES NOT = 1
              DISPLAY 'ERROR COMP-5 - COMP-5'.
           MOVE 11    TO C5-A.
           SUBTRACT 10   FROM C5-A.
           MOVE C5-A  TO C5-RES.
           IF C5-RES NOT = 1
              DISPLAY 'ERROR COMP-5 - NUM'.
      *
           ADD  C6-B  TO C6-A.
           MOVE C6-A  TO C6-RES.
           IF C6-RES NOT = 11
              DISPLAY 'ERROR COMP-6 + COMP-6'.
           MOVE 1     TO C6-A.
           ADD  10    TO C6-A.
           MOVE C6-A  TO C6-RES.
           IF C6-RES NOT = 11
              DISPLAY 'ERROR COMP-6 + NUM'.
           MOVE 11    TO C6-A.
           SUBTRACT C6-B FROM C6-A.
           MOVE C6-A  TO C6-RES.
           IF C6-RES NOT = 1
              DISPLAY 'ERROR COMP-6 - COMP-6'.
           MOVE 11    TO C6-A.
           SUBTRACT 10   FROM C6-A.
           MOVE C6-A  TO C6-RES.
           IF C6-RES NOT = 1
              DISPLAY 'ERROR COMP-6 - NUM'.
      *
           ADD  CN9-B  TO CN9-A.
           MOVE CN9-A  TO CN9-RES.
           IF CN9-RES NOT = 11
              DISPLAY 'ERROR COMP-N + COMP-N'.
           MOVE 1     TO CN9-A.
           ADD  10    TO CN9-A.
           MOVE CN9-A  TO CN9-RES.
           IF CN9-RES NOT = 11
              DISPLAY 'ERROR COMP-N + NUM'.
           MOVE 11    TO CN9-A.
           SUBTRACT CN9-B FROM CN9-A.
           MOVE CN9-A  TO CN9-RES.
           IF CN9-RES NOT = 1
              DISPLAY 'ERROR COMP-N - COMP-N'.
           MOVE 11    TO CN9-A.
           SUBTRACT 10   FROM CN9-A.
           MOVE CN9-A  TO CN9-RES.
           IF CN9-RES NOT = 1
              DISPLAY 'ERROR COMP-N - NUM'.
      *
           ADD  CNX-B  TO CNX-A.
           MOVE CNX-A  TO CNX-RES.
           IF CNX-RES NOT = 11
              DISPLAY 'ERROR COMP-N + COMP-N'.
           MOVE 1     TO CNX-A.
           ADD  10    TO CNX-A.
           MOVE CNX-A  TO CNX-RES.
           IF CNX-RES NOT = 11
              DISPLAY 'ERROR COMP-N + NUM'.
           MOVE 11    TO CNX-A.
           SUBTRACT CNX-B FROM CNX-A.
           MOVE CNX-A  TO CNX-RES.
           IF CNX-RES NOT = 1
              DISPLAY 'ERROR COMP-N - COMP-N'.
           MOVE 11    TO CNX-A.
           SUBTRACT 10   FROM CNX-A.
           MOVE CNX-A  TO CNX-RES.
           IF CNX-RES NOT = 1
              DISPLAY 'ERROR COMP-N - NUM'.
      *
           ADD  CX9-B  TO CX9-A.
           MOVE CX9-A  TO CX9-RES.
           IF CX9-RES NOT = 11
              DISPLAY 'ERROR COMP-X + COMP-X'.
           MOVE 1     TO CX9-A.
           ADD  10    TO CX9-A.
           MOVE CX9-A  TO CX9-RES.
           IF CX9-RES NOT = 11
              DISPLAY 'ERROR COMP-X + NUM'.
           MOVE 11    TO CX9-A.
           SUBTRACT CX9-B FROM CX9-A.
           MOVE CX9-A  TO CX9-RES.
           IF CX9-RES NOT = 1
              DISPLAY 'ERROR COMP-X - COMP-X'.
           MOVE 11    TO CX9-A.
           SUBTRACT 10   FROM CX9-A.
           MOVE CX9-A  TO CX9-RES.
           IF CX9-RES NOT = 1
              DISPLAY 'ERROR COMP-X - NUM'.
      *
           ADD  CXX-B  TO CXX-A.
           MOVE CXX-A  TO CXX-RES.
           IF CXX-RES NOT = 11
              DISPLAY 'ERROR COMP-X + COMP-X'.
           MOVE 1     TO CXX-A.
           ADD  10    TO CXX-A.
           MOVE CXX-A  TO CXX-RES.
           IF CXX-RES NOT = 11
              DISPLAY 'ERROR COMP-X + NUM'.
           MOVE 11    TO CXX-A.
           SUBTRACT CXX-B FROM CXX-A.
           MOVE CXX-A  TO CXX-RES.
           IF CXX-RES NOT = 1
              DISPLAY 'ERROR COMP-X - COMP-X'.
           MOVE 11    TO CXX-A.
           SUBTRACT 10   FROM CXX-A.
           MOVE CXX-A  TO CXX-RES.
           IF CXX-RES NOT = 1
              DISPLAY 'ERROR COMP-X - NUM'.
      *
           ADD  D-B  TO D-A.
           MOVE D-A  TO D-RES.
           IF D-RES NOT = 11
              DISPLAY 'ERROR DISPLAY + DISPLAY'.
           MOVE 1     TO D-A.
           ADD  10    TO D-A.
           MOVE D-A  TO D-RES.
           IF D-RES NOT = 11
              DISPLAY 'ERROR DISPLAY + NUM'.
           MOVE 11    TO D-A.
           SUBTRACT D-B FROM D-A.
           MOVE D-A  TO D-RES.
           IF D-RES NOT = 1
              DISPLAY 'ERROR DISPLAY - DISPLAY'.
           MOVE 11    TO D-A.
           SUBTRACT 10   FROM D-A.
           MOVE D-A  TO D-RES.
           IF D-RES NOT = 1
              DISPLAY 'ERROR DISPLAY - NUM'.
      *
           ADD  FD16-B  TO FD16-A.
           MOVE FD16-A  TO FD16-RES.
           IF FD16-RES NOT = 11
              DISPLAY 'ERROR FLOAT-DECIMAL-16 + FLOAT-DECIMAL-16'.
           MOVE 1     TO FD16-A.
           ADD  10    TO FD16-A.
           MOVE FD16-A  TO FD16-RES.
           IF FD16-RES NOT = 11
              DISPLAY 'ERROR FLOAT-DECIMAL-16 + NUM'.
           MOVE 11    TO FD16-A.
           SUBTRACT FD16-B FROM FD16-A.
           MOVE FD16-A  TO FD16-RES.
           IF FD16-RES NOT = 1
              DISPLAY 'ERROR FLOAT-DECIMAL-16 - FLOAT-DECIMAL-16'.
           MOVE 11    TO FD16-A.
           SUBTRACT 10   FROM FD16-A.
           MOVE FD16-A  TO FD16-RES.
           IF FD16-RES NOT = 1
              DISPLAY 'ERROR FLOAT-DECIMAL-16 - NUM'.
      *
           ADD  FD34-B  TO FD34-A.
           MOVE FD34-A  TO FD34-RES.
           IF FD34-RES NOT = 11
              DISPLAY 'ERROR FLOAT-DECIMAL-34 + FLOAT-DECIMAL-34'.
           MOVE 1     TO FD34-A.
           ADD  10    TO FD34-A.
           MOVE FD34-A  TO FD34-RES.
           IF FD34-RES NOT = 11
              DISPLAY 'ERROR FLOAT-DECIMAL-34 + NUM'.
           MOVE 11    TO FD34-A.
           SUBTRACT FD34-B FROM FD34-A.
           MOVE FD34-A  TO FD34-RES.
           IF FD34-RES NOT = 1
              DISPLAY 'ERROR FLOAT-DECIMAL-34 - FLOAT-DECIMAL-34'.
           MOVE 11    TO FD34-A.
           SUBTRACT 10   FROM FD34-A.
           MOVE FD34-A  TO FD34-RES.
           IF FD34-RES NOT = 1
              DISPLAY 'ERROR FLOAT-DECIMAL-34 - NUM'.
      *
           ADD  FL-B  TO FL-A.
           MOVE FL-A  TO FL-RES.
           IF FL-RES NOT = 11
              DISPLAY 'ERROR FLOAT-LONG + FLOAT-LONG'.
           MOVE 1     TO FL-A.
           ADD  10    TO FL-A.
           MOVE FL-A  TO FL-RES.
           IF FL-RES NOT = 11
              DISPLAY 'ERROR FLOAT-LONG + NUM'.
           MOVE 11    TO FL-A.
           SUBTRACT FL-B FROM FL-A.
           MOVE FL-A  TO FL-RES.
           IF FL-RES NOT = 1
              DISPLAY 'ERROR FLOAT-LONG - FLOAT-LONG'.
           MOVE 11    TO FL-A.
           SUBTRACT 10   FROM FL-A.
           MOVE FL-A  TO FL-RES.
           IF FL-RES NOT = 1
              DISPLAY 'ERROR FLOAT-LONG - NUM'.
      *
           ADD  FS-B  TO FS-A.
           MOVE FS-A  TO FS-RES.
           IF FS-RES NOT = 11
              DISPLAY 'ERROR FLOAT-SHORT + FLOAT-SHORT'.
           MOVE 1     TO FS-A.
           ADD  10    TO FS-A.
           MOVE FS-A  TO FS-RES.
           IF FS-RES NOT = 11
              DISPLAY 'ERROR FLOAT-SHORT + NUM'.
           MOVE 11    TO FS-A.
           SUBTRACT FS-B FROM FS-A.
           MOVE FS-A  TO FS-RES.
           IF FS-RES NOT = 1
              DISPLAY 'ERROR FLOAT-SHORT - FLOAT-SHORT'.
           MOVE 11    TO FS-A.
           SUBTRACT 10   FROM FS-A.
           MOVE FS-A  TO FS-RES.
           IF FS-RES NOT = 1
              DISPLAY 'ERROR FLOAT-SHORT - NUM'.