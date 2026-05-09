IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  T01-ALL.
           05 T01-REC OCCURS 10.
              10 T01-SOMEBER                PIC X(500) VALUE SPACES.
              10 T01-ENTRY.
                 15 T01-TAB OCCURS 2200.
                    20 T01-NAME             PIC  X(020).
                    20 T01-DETREC.
                       25 T01-DETTAB OCCURS 47.
                          30 T01-SHL        PIC  X(001) value 'A'.
                          30 T01-LEN        USAGE BINARY-INT VALUE 0.
                          30 T01-CODE1      PIC S999 COMP-5.
                          30 T01-CODE2      PIC S999 COMP-5  VALUE 0.
                          30 T01-CODE3      PIC S999 COMP-5  VALUE 42.
                          30 T01-PREF       PIC  X(001).
                          30 T01-TXT1       PIC  X(020) VALUE ALL ' '.
                          30 T01-TXT2       PIC  X(020).
                          30 T01-TXT3       PIC  X(020) VALUE ALL '3'.
                       25 T02-DETTAB OCCURS 33.
                          30 T02-LEN        USAGE BINARY-INT SIGNED.
                          30 T02-CODE1      PIC S999 COMP-5.
                          30 T02-CODE2      PIC S999 COMP-5  VALUE 0.
                          30 T02-SHL        PIC  X(001) value 'B'.
                          30 T02-PREF       PIC  X(001).
                          30 T02-TXT1       PIC  X(030) VALUE SPACES.
                          30 T02-TXT2       PIC  X(030) VALUE ALL SPACE.
                          30 T02-TXT3       PIC  X(030) VALUE ALL ZERO.
       PROCEDURE DIVISION.
       INIT-RTN.
         MOVE ALL HIGH-VALUE TO T01-TAB (5,55)
         MOVE ALL LOW-VALUE  TO T01-TAB (10,400)
         MOVE SPACES TO T01-REC (2) T01-REC (4)
         INITIALIZE T01-REC (2) TO DEFAULT
         INITIALIZE T01-REC (4) WITH FILLER ALL TO VALUE
         GOBACK.