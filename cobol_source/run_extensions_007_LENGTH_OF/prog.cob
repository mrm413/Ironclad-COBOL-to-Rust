IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X             PIC X(2).
       01 G.
         02 Y           PIC X(2) OCCURS 10.
         02 G-GROUP.
         03 G-SGROUP.
         04 G1          PIC X(05).
         04 G2          PIC X(06).
         04 G3          PIC X(22).
         03 FILLER      PIC XX OCCURS 5.
       66 RENAME-STD-G  RENAMES G-GROUP.
       66 RENAME-STD-SG RENAMES G-SGROUP.
       66 RENAME-STD    RENAMES G1 THROUGH G3.
       66 RENAME-G      RENAMES G.
       01 L             PIC s9(4)v99.
       01 I             PIC 9(2) VALUE 10.
       78 I-LEN         VALUE LENGTH OF I.
      * TODO: check size of FILLER here
       01 TSTDISP.
         02 FILLER OCCURS 5000.
           10 T1        PIC X(11).
           10 T2        PIC X(22).
       78 var-length-l      value length of '00128'.
       78 var-length-x      value length of x'a0'.
       78 var-length-z      value length of z'a0'.
      *78 var-length-n      value length of n'001'.
       PROCEDURE        DIVISION.
           move var-length-l TO L
           IF L NOT = 5
              DISPLAY "Length '00128'" L
              END-DISPLAY
           END-IF
           move var-length-x TO L
           IF L NOT = 1
              DISPLAY "Length x'a0'" L
              END-DISPLAY
           END-IF
           move var-length-z TO L
           IF L NOT = 3
              DISPLAY "Length z'a0'" L
              END-DISPLAY
           END-IF
      *    What does MF reports here?
      *>   move var-length-n TO L
      *>   IF L NOT = 3
      *>      DISPLAY "Length n'001'" L
      *>      END-DISPLAY
      *>   END-IF
           MOVE LENGTH OF X  TO L
           IF L NOT = 2
              DISPLAY "Length 1 " L
              END-DISPLAY
           END-IF
           MOVE LENGTH OF X  TO L
           IF L NOT = 2
              DISPLAY "Length 1a " L LENGTH X
              END-DISPLAY
           END-IF
           MOVE LENGTH OF Y  TO L
           IF L NOT = 2
              DISPLAY "Length 2 " L
              END-DISPLAY
           END-IF
           IF L NOT = 2
              DISPLAY "Length 2a " L LENGTH OF Y
              END-DISPLAY
           END-IF
           MOVE LENGTH OF Y(1) TO L
           IF L NOT = 2
              DISPLAY "Length 3 " L
              END-DISPLAY
           END-IF
           MOVE LENGTH Y(1) TO L
           IF L NOT = 2
              DISPLAY "Length 3a " L LENGTH OF Y(1)
              END-DISPLAY
           END-IF
           IF I-LEN NOT = 2
              DISPLAY "Length 4 " I-LEN
              END-DISPLAY
           END-IF
           IF LENGTH OF L + 2 NOT = 8
              ADD 2 TO LENGTH OF L GIVING L
              DISPLAY "Length 5 + 2" L
              END-DISPLAY
           END-IF
           IF LENGTH L + 2 NOT = 8
              ADD 2 TO LENGTH L GIVING L
              DISPLAY "Length 5a + 2 " L
              END-DISPLAY
           END-IF
           MOVE 0 TO L
           PERFORM LENGTH OF L TIMES
              ADD 1 TO L
           END-PERFORM
           PERFORM LENGTH L TIMES
              ADD 1 TO L
           END-PERFORM
           IF L NOT = 12
              DISPLAY "Length 6 " L
              END-DISPLAY
           END-IF
           MOVE 0 TO L
           PERFORM VARME
                   VARYING I FROM LENGTH OF I
                             BY   LENGTH OF X
                   UNTIL   I > LENGTH OF L
           IF ((L NOT = 3) OR
               (I NOT = 8)    )
              DISPLAY "Length 7 " L " - " I
              END-DISPLAY
           END-IF
           MOVE 0 TO L
           PERFORM VARME
                   VARYING I FROM LENGTH I
                             BY   LENGTH X
                   UNTIL   I > LENGTH L
           IF ((L NOT = 3) OR
               (I NOT = 8)    )
              DISPLAY "Length 7a " L " - " I
              END-DISPLAY
           END-IF
           MOVE LENGTH OF RENAME-STD-SG  TO L
           IF L NOT = 33
              DISPLAY "Length 8a " L
              END-DISPLAY
           END-IF
           MOVE LENGTH OF RENAME-STD-G  TO L
           IF L NOT = 43
              DISPLAY "Length 8b " L
              END-DISPLAY
           END-IF
           MOVE LENGTH OF RENAME-STD  TO L
           IF L NOT = 33
              DISPLAY "Length 8c " L
              END-DISPLAY
           END-IF
           MOVE LENGTH OF RENAME-G  TO L
           IF L NOT = 63
              DISPLAY "Length 8d " L
              END-DISPLAY
           END-IF
           *> one display test
           DISPLAY LENGTH OF TSTDISP WITH NO ADVANCING
           END-DISPLAY
           STOP RUN.
       VARME.
           ADD 1 TO L
           .