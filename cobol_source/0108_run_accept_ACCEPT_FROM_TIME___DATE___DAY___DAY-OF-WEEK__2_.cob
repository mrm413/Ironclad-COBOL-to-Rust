IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       *> one byte longer to make sure there is no garbage in
       01  WS-YYYYMMDD   PIC X(9).
       01  WS-YYYYDDD    PIC X(8).
       01  WS-DAYOFWEEK  PIC X(2).
       01  WS-DATE-TODAY.
           05  WS-TODAYS-YY            PIC 9(02) VALUE 0.
           05  WS-TODAYS-MM            PIC 9(02) VALUE 0.
           05  WS-TODAYS-DD            PIC 9(02) VALUE 0.
       01  WS-DATE-TODAY-9  REDEFINES WS-DATE-TODAY PIC 9(06).

       01  WS-DATE.
           05  WS-DATE-MM              PIC 9(02) VALUE 0.
           05  FILLER                  PIC X(01) VALUE '/'.
           05  WS-DATE-DD              PIC 9(02) VALUE 0.
           05  FILLER                  PIC X(01) VALUE '/'.
           05  WS-DATE-YY              PIC 9(02) VALUE 0.

       01  WS-TIME-NOW.
           05  WS-NOW-HH               PIC 9(02) VALUE 0.
           05  WS-NOW-MM               PIC 9(02) VALUE 0.
           05  WS-NOW-SS               PIC 9(02) VALUE 0.
           05  WS-NOW-HS               PIC 9(02) VALUE 0.
       01  WS-TIME-NOW-9  REDEFINES WS-TIME-NOW PIC 9(08).

       01  WS-TIME.
           05  WS-TIME-HH              PIC 9(02) VALUE 0.
           05  FILLER                  PIC X(01) VALUE ':'.
           05  WS-TIME-MM              PIC 9(02) VALUE 0.
           05  FILLER                  PIC X(01) VALUE ':'.
           05  WS-TIME-SS              PIC 9(02) VALUE 0.

       01  WS-MICROSECOND-TIME.
           05 WS-TIME-MICRO            PIC 9(14).

       PROCEDURE DIVISION.
           PERFORM RUN-TEST.
           PERFORM RUN-VALIDATION.
       >> IF CHECK-PERF IS DEFINED
      *>   included performance check
           PERFORM RUN-TEST 50000 TIMES
       >> END-IF
           GOBACK.

        RUN-TEST.
            ACCEPT WS-DATE-TODAY-9      FROM DATE.
            ACCEPT WS-TIME-NOW-9        FROM TIME.
            ACCEPT WS-TIME-MICRO        FROM MICROSECOND-TIME.

        RUN-VALIDATION.
      *>   actual verification
           MOVE WS-TODAYS-YY TO WS-DATE-YY
           MOVE WS-TODAYS-MM TO WS-DATE-MM
           MOVE WS-TODAYS-DD TO WS-DATE-DD
           MOVE WS-NOW-HH    TO WS-TIME-HH
           MOVE WS-NOW-MM    TO WS-TIME-MM
           MOVE WS-NOW-SS    TO WS-TIME-SS
           DISPLAY 'PROCESS DATE/TIME : ' WS-DATE ' ' WS-TIME
                   WITH NO ADVANCING UPON SYSOUT
           END-DISPLAY
           DISPLAY ' MICROSECOND-TIME '
                   WITH NO ADVANCING UPON SYSOUT
           END-DISPLAY
           DISPLAY WS-MICROSECOND-TIME
                   WITH NO ADVANCING UPON SYSOUT
           END-DISPLAY
           DISPLAY '.' UPON SYSOUT.
      *>   Bigger fields return 8/12 depending on std
      *>   CHECKME: we may should limit to 6 depending on std, too
           ACCEPT WS-TIME-MICRO FROM TIME
           DISPLAY 'PROCESS BIG TIME : '
                   WITH NO ADVANCING UPON SYSOUT
           DISPLAY WS-MICROSECOND-TIME UPON SYSOUT.
           ACCEPT WS-YYYYMMDD   FROM DATE YYYYMMDD
           IF WS-YYYYMMDD not = "20150405"
              DISPLAY 'Wrong date DATE YYYYMMDD: ' WS-YYYYMMDD
                      ' expected: 20150405'
                      UPON SYSERR.
           ACCEPT WS-YYYYDDD    FROM DAY  YYYYDDD
           IF WS-YYYYDDD  not = "2015095"
              DISPLAY 'Wrong date YYYYDDD:  '      WS-YYYYDDD
                      ' expected: 2015095'
                      UPON SYSERR.
           ACCEPT WS-DAYOFWEEK    FROM DAY-OF-WEEK
           IF WS-DAYOFWEEK  not = "7"
              DISPLAY 'Wrong date DAYOFWEEK: '     WS-DAYOFWEEK
                      ' expected: 7'
                      UPON SYSERR.
       *>
           PERFORM 500 TIMES
              ACCEPT WS-DATE-TODAY        FROM DATE
              ACCEPT WS-TIME-NOW          FROM TIME
              ACCEPT WS-MICROSECOND-TIME  FROM MICROSECOND-TIME
           END-PERFORM
           MOVE WS-TODAYS-YY TO WS-DATE-YY
           MOVE WS-TODAYS-MM TO WS-DATE-MM
           MOVE WS-TODAYS-DD TO WS-DATE-DD
           MOVE WS-NOW-HH    TO WS-TIME-HH
           MOVE WS-NOW-MM    TO WS-TIME-MM
           MOVE WS-NOW-SS    TO WS-TIME-SS
           DISPLAY 'PROCESS DATE/TIME : ' WS-DATE ' ' WS-TIME
                   WITH NO ADVANCING UPON SYSOUT
           END-DISPLAY
           DISPLAY ' MICROSECOND-TIME '
                   WITH NO ADVANCING UPON SYSOUT
           END-DISPLAY
           DISPLAY WS-MICROSECOND-TIME
                   WITH NO ADVANCING UPON SYSOUT
           END-DISPLAY
           DISPLAY '.' UPON SYSOUT.