IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  U1           PIC   99   USAGE COMP-6 VALUE 95.
       01  U2           PIC   99   USAGE COMP-6 VALUE 95.
       01  U3           PIC  999   USAGE COMP-6 VALUE 195.
       01  U4           PIC  999   USAGE COMP-6 VALUE 195.
       01  U1-32        PIC  9(32) USAGE COMP-6 VALUE 195.
       01  U2-32        PIC  9(32) USAGE COMP-6 VALUE 195.
       01  U1-32D       PIC  9(18)V9(12) USAGE COMP-6
           VALUE 48894655646195.551388132.
       01  U2-32D       PIC  9(18)V9(12) USAGE COMP-6
           VALUE 48894655646195.551388132.
       01  U3-32D       PIC  9(14)V9(13) USAGE COMP-6
           VALUE 48894655646195.551388132.
       01  U4-32D       PIC  9(14)V9(13) USAGE COMP-6
           VALUE 48894655646195.551388131.
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.
       PROCEDURE        DIVISION.
       MAIN.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 30000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
           IF U1     <>  U2     DISPLAY "U1 <> U2".
           IF U3     <>  U4     DISPLAY "U3 <> U4".
           IF U1     >=  U3     DISPLAY "U1 >= U3".
           IF U1-32  <>  U2-32  DISPLAY "U1-32 <> U2-32".
           IF U1-32  >=  U2-32D DISPLAY "U1-32 >= U1-32D".
           IF U1-32D <>  U2-32D DISPLAY "U1-32D <> U2-32D".
           IF U1-32D <=  U3     DISPLAY "U1-32 <= U3".
           IF U2-32D <>  U3-32D DISPLAY "U2-32D <> U3-32D".
           IF U2-32D <=  U4-32D DISPLAY "U2-32D <= U4-32D".
           IF U4-32D >=  U2-32D DISPLAY "U4-32D >= U2-32D".