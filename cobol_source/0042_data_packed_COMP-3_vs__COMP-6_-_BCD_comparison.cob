IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77  PD-03       PIC  S9(03)V99 COMP-3   VALUE 737.
       77  PD-04       PIC  S9(04)V99 COMP-3   VALUE 737.
       77  PD-05       PIC  S9(05)V99 COMP-3   VALUE 737.
       77  PD-06       PIC  S9(06)V99 COMP-3   VALUE 737.
       77  PD-07       PIC  S9(07)V99 COMP-3   VALUE 737.
       77  PD-08       PIC  S9(08)V99 COMP-3   VALUE 737.
       77  PD-09       PIC  S9(09)V99 COMP-3   VALUE 737.
       77  PD-10       PIC  S9(10)V99 COMP-3   VALUE 737.
       77  PD-11       PIC  S9(11)V99 COMP-3   VALUE 737.
       77  PD-12       PIC  S9(12)V99 COMP-3   VALUE 737.
       77  PD-13       PIC  S9(13)V99 COMP-3   VALUE 737.
       77  PD-14       PIC  S9(14)V99 COMP-3   VALUE 737.
       77  PD-15       PIC  S9(15)V99 COMP-3   VALUE 737.
       77  PD-16       PIC  S9(16)V99 COMP-3   VALUE 737.
       77  PD-17       PIC  S9(17)V99 COMP-3   VALUE 737.
       77  PD-18       PIC  S9(18)V99 COMP-3   VALUE 737.
       77  PD-19       PIC  S9(19)V99 COMP-3   VALUE 737.
       77  PD-20       PIC  S9(20)V99 COMP-3   VALUE 737.
       77  PD-21       PIC  S9(21)V99 COMP-3   VALUE 737.
       77  PD-22       PIC  S9(22)V99 COMP-3   VALUE 737.
       77  PD-23       PIC  S9(23)V99 COMP-3   VALUE 737.
       77  PD-24       PIC  S9(24)V99 COMP-3   VALUE 737.
       77  PD-25       PIC  S9(25)V99 COMP-3   VALUE 737.
       77  PD-26       PIC  S9(26)V99 COMP-3   VALUE 737.
       77  PD-27       PIC  S9(27)V99 COMP-3   VALUE 737.
       77  PD-28       PIC  S9(28)V99 COMP-3   VALUE 737.
       77  PD-29       PIC  S9(29)V99 COMP-3   VALUE 737.
       77  PD-30       PIC  S9(30)V99 COMP-3   VALUE 737.
       77  PD-31       PIC  S9(31)V99 COMP-3   VALUE 737.
       77  PD-32       PIC  S9(32)V99 COMP-3   VALUE 737.
       77  PD-33       PIC  S9(33)V99 COMP-3   VALUE 737.
       77  PD-34       PIC  S9(34)V99 COMP-3   VALUE 737.
       77  PD-35       PIC  S9(35)V99 COMP-3   VALUE 737.
       77  PD-36       PIC  S9(36)V99 COMP-3   VALUE 737.

       77  CD-03       PIC   9(03)V99 COMP-6   VALUE 737.
       77  CD-04       PIC   9(04)V99 COMP-6   VALUE 737.
       77  CD-05       PIC   9(05)V99 COMP-6   VALUE 737.
       77  CD-06       PIC   9(06)V99 COMP-6   VALUE 737.
       77  CD-07       PIC   9(07)V99 COMP-6   VALUE 737.
       77  CD-08       PIC   9(08)V99 COMP-6   VALUE 737.
       77  CD-09       PIC   9(09)V99 COMP-6   VALUE 737.
       77  CD-10       PIC   9(10)V99 COMP-6   VALUE 737.
       77  CD-11       PIC   9(11)V99 COMP-6   VALUE 737.
       77  CD-12       PIC   9(12)V99 COMP-6   VALUE 737.
       77  CD-13       PIC   9(13)V99 COMP-6   VALUE 737.
       77  CD-14       PIC   9(14)V99 COMP-6   VALUE 737.
       77  CD-15       PIC   9(15)V99 COMP-6   VALUE 737.
       77  CD-16       PIC   9(16)V99 COMP-6   VALUE 737.
       77  CD-17       PIC   9(17)V99 COMP-6   VALUE 737.
       77  CD-18       PIC   9(18)V99 COMP-6   VALUE 737.
       77  CD-19       PIC   9(19)V99 COMP-6   VALUE 737.
       77  CD-20       PIC   9(20)V99 COMP-6   VALUE 737.
       77  CD-21       PIC   9(21)V99 COMP-6   VALUE 737.
       77  CD-22       PIC   9(22)V99 COMP-6   VALUE 737.
       77  CD-23       PIC   9(23)V99 COMP-6   VALUE 737.
       77  CD-24       PIC   9(24)V99 COMP-6   VALUE 737.
       77  CD-25       PIC   9(25)V99 COMP-6   VALUE 737.
       77  CD-26       PIC   9(26)V99 COMP-6   VALUE 737.
       77  CD-27       PIC   9(27)V99 COMP-6   VALUE 737.
       77  CD-28       PIC   9(28)V99 COMP-6   VALUE 737.
       77  CD-29       PIC   9(29)V99 COMP-6   VALUE 737.
       77  CD-30       PIC   9(30)V99 COMP-6   VALUE 737.
       77  CD-31       PIC   9(31)V99 COMP-6   VALUE 737.
       77  CD-32       PIC   9(32)V99 COMP-6   VALUE 737.
       77  CD-33       PIC   9(33)V99 COMP-6   VALUE 737.
       77  CD-34       PIC   9(34)V99 COMP-6   VALUE 737.
       77  CD-35       PIC   9(35)V99 COMP-6   VALUE 737.
       77  CD-36       PIC   9(36)V99 COMP-6   VALUE 737.
      *
       01  U4-32D       PIC  9(14)V9(13) USAGE COMP-6
           VALUE 48894655646195.551388131.
       01  UP-32D       PIC  9(14)V9(13) USAGE PACKED-DECIMAL
           VALUE 48894655646195.551388131.
       01  SP-32D       PIC S9(14)V9(13) USAGE PACKED-DECIMAL
           VALUE 48894655646195.551388131.
       01  NP-32D       PIC S9(14)V9(13) USAGE PACKED-DECIMAL
           VALUE -48894655646195.551388131.

       01  PACKED-ZEROS.
           05  PZ-01-X.
               10  PZ-01               PIC 9(38)       COMP-6.
           05  PZ-02-X.
               10  PZ-02               PIC S9(38)      COMP-3.
           05  PZ-03-X.
               10  PZ-03               PIC S9(38)      COMP-3.
           05  PZ-04-X.
               10  PZ-04               PIC S9(38)      COMP-3.
           05  PZ-05-X.
               10  PZ-05               PIC S9(38)      COMP-3.
           05  PZ-06-X.
               10  PZ-06               PIC S9(38)      COMP-3.

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
           PERFORM DO-CHECK 10000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
           IF PD-03 <> CD-03  DISPLAY "PD-03 <> CD-03".
           IF PD-04 <> CD-04  DISPLAY "PD-04 <> CD-04".
           IF PD-05 <> CD-05  DISPLAY "PD-05 <> CD-05".
           IF PD-06 <> CD-06  DISPLAY "PD-06 <> CD-06".
           IF PD-07 <> CD-07  DISPLAY "PD-07 <> CD-07".
           IF PD-08 <> CD-08  DISPLAY "PD-08 <> CD-08".
           IF PD-09 <> CD-09  DISPLAY "PD-09 <> CD-09".
           IF PD-10 <> CD-10  DISPLAY "PD-10 <> CD-10".
           IF PD-11 <> CD-11  DISPLAY "PD-11 <> CD-11".
           IF PD-12 <> CD-12  DISPLAY "PD-12 <> CD-12".
           IF PD-13 <> CD-13  DISPLAY "PD-13 <> CD-13".
           IF PD-14 <> CD-14  DISPLAY "PD-14 <> CD-14".
           IF PD-15 <> CD-15  DISPLAY "PD-15 <> CD-15".
           IF PD-16 <> CD-16  DISPLAY "PD-16 <> CD-16".
           IF PD-17 <> CD-17  DISPLAY "PD-17 <> CD-17".
           IF PD-18 <> CD-18  DISPLAY "PD-18 <> CD-18".
           IF PD-19 <> CD-19  DISPLAY "PD-19 <> CD-19".
           IF PD-20 <> CD-20  DISPLAY "PD-20 <> CD-20".
           IF PD-21 <> CD-21  DISPLAY "PD-21 <> CD-21".
           IF PD-22 <> CD-22  DISPLAY "PD-22 <> CD-22".
           IF PD-23 <> CD-23  DISPLAY "PD-23 <> CD-23".
           IF PD-24 <> CD-24  DISPLAY "PD-24 <> CD-24".
           IF PD-25 <> CD-25  DISPLAY "PD-25 <> CD-25".
           IF PD-26 <> CD-26  DISPLAY "PD-26 <> CD-26".
           IF PD-27 <> CD-27  DISPLAY "PD-27 <> CD-27".
           IF PD-28 <> CD-28  DISPLAY "PD-28 <> CD-28".
           IF PD-29 <> CD-29  DISPLAY "PD-29 <> CD-29".
           IF PD-30 <> CD-30  DISPLAY "PD-30 <> CD-30".
           IF PD-31 <> CD-31  DISPLAY "PD-31 <> CD-31".
           IF PD-32 <> CD-32  DISPLAY "PD-32 <> CD-32".
           IF PD-33 <> CD-33  DISPLAY "PD-33 <> CD-33".
           IF PD-34 <> CD-34  DISPLAY "PD-34 <> CD-34".
           IF PD-35 <> CD-35  DISPLAY "PD-35 <> CD-35".
           IF PD-36 <> CD-36  DISPLAY "PD-36 <> CD-36".

           IF PD-03 <> CD-36  DISPLAY "PD-03 <> CD-36".
           IF PD-04 <> CD-35  DISPLAY "PD-04 <> CD-35".
           IF PD-05 <> CD-34  DISPLAY "PD-05 <> CD-34".
           IF PD-06 <> CD-33  DISPLAY "PD-06 <> CD-33".
           IF PD-07 <> CD-32  DISPLAY "PD-07 <> CD-32".
           IF PD-08 <> CD-31  DISPLAY "PD-08 <> CD-31".
           IF PD-09 <> CD-30  DISPLAY "PD-09 <> CD-30".
           IF PD-10 <> CD-29  DISPLAY "PD-10 <> CD-29".
           IF PD-11 <> CD-28  DISPLAY "PD-11 <> CD-28".
           IF PD-12 <> CD-27  DISPLAY "PD-12 <> CD-27".
           IF PD-13 <> CD-26  DISPLAY "PD-13 <> CD-26".
           IF PD-14 <> CD-25  DISPLAY "PD-14 <> CD-25".
           IF PD-15 <> CD-24  DISPLAY "PD-15 <> CD-24".
           IF PD-16 <> CD-23  DISPLAY "PD-16 <> CD-23".
           IF PD-17 <> CD-22  DISPLAY "PD-17 <> CD-22".
           IF PD-18 <> CD-21  DISPLAY "PD-18 <> CD-21".
           IF PD-19 <> CD-20  DISPLAY "PD-19 <> CD-20".
           IF PD-20 <> CD-19  DISPLAY "PD-20 <> CD-19".
           IF PD-21 <> CD-18  DISPLAY "PD-21 <> CD-18".
           IF PD-22 <> CD-17  DISPLAY "PD-22 <> CD-17".
           IF PD-23 <> CD-16  DISPLAY "PD-23 <> CD-16".
           IF PD-24 <> CD-15  DISPLAY "PD-24 <> CD-15".
           IF PD-25 <> CD-14  DISPLAY "PD-25 <> CD-14".
           IF PD-26 <> CD-13  DISPLAY "PD-26 <> CD-13".
           IF PD-27 <> CD-12  DISPLAY "PD-27 <> CD-12".
           IF PD-28 <> CD-11  DISPLAY "PD-28 <> CD-11".
           IF PD-29 <> CD-10  DISPLAY "PD-29 <> CD-10".
           IF PD-30 <> CD-09  DISPLAY "PD-30 <> CD-09".
           IF PD-31 <> CD-08  DISPLAY "PD-31 <> CD-08".
           IF PD-32 <> CD-07  DISPLAY "PD-32 <> CD-07".
           IF PD-33 <> CD-06  DISPLAY "PD-33 <> CD-06".
           IF PD-34 <> CD-05  DISPLAY "PD-34 <> CD-05".
           IF PD-35 <> CD-04  DISPLAY "PD-35 <> CD-04".
           IF PD-36 <> CD-03  DISPLAY "PD-36 <> CD-03".

           IF PD-03 <> PD-36  DISPLAY "PD-03 <> PD-36".
           IF PD-04 <> PD-35  DISPLAY "PD-04 <> PD-35".
           IF PD-05 <> PD-34  DISPLAY "PD-05 <> PD-34".
           IF PD-06 <> PD-33  DISPLAY "PD-06 <> PD-33".
           IF PD-07 <> PD-32  DISPLAY "PD-07 <> PD-32".
           IF PD-08 <> PD-31  DISPLAY "PD-08 <> PD-31".
           IF PD-09 <> PD-30  DISPLAY "PD-09 <> PD-30".
           IF PD-10 <> PD-29  DISPLAY "PD-10 <> PD-29".
           IF PD-11 <> PD-28  DISPLAY "PD-11 <> PD-28".
           IF PD-12 <> PD-27  DISPLAY "PD-12 <> PD-27".
           IF PD-13 <> PD-26  DISPLAY "PD-13 <> PD-26".
           IF PD-14 <> PD-25  DISPLAY "PD-14 <> PD-25".
           IF PD-15 <> PD-24  DISPLAY "PD-15 <> PD-24".
           IF PD-16 <> PD-23  DISPLAY "PD-16 <> PD-23".
           IF PD-17 <> PD-22  DISPLAY "PD-17 <> PD-22".
           IF PD-18 <> PD-21  DISPLAY "PD-18 <> PD-21".
           IF PD-19 <> PD-20  DISPLAY "PD-19 <> PD-20".
           IF PD-20 <> PD-19  DISPLAY "PD-20 <> PD-19".
           IF PD-21 <> PD-18  DISPLAY "PD-21 <> PD-18".
           IF PD-22 <> PD-17  DISPLAY "PD-22 <> PD-17".
           IF PD-23 <> PD-16  DISPLAY "PD-23 <> PD-16".
           IF PD-24 <> PD-15  DISPLAY "PD-24 <> PD-15".
           IF PD-25 <> PD-14  DISPLAY "PD-25 <> PD-14".
           IF PD-26 <> PD-13  DISPLAY "PD-26 <> PD-13".
           IF PD-27 <> PD-12  DISPLAY "PD-27 <> PD-12".
           IF PD-28 <> PD-11  DISPLAY "PD-28 <> PD-11".
           IF PD-29 <> PD-10  DISPLAY "PD-29 <> PD-10".
           IF PD-30 <> PD-09  DISPLAY "PD-30 <> PD-09".
           IF PD-31 <> PD-08  DISPLAY "PD-31 <> PD-08".
           IF PD-32 <> PD-07  DISPLAY "PD-32 <> PD-07".
           IF PD-33 <> PD-06  DISPLAY "PD-33 <> PD-06".
           IF PD-34 <> PD-05  DISPLAY "PD-34 <> PD-05".
           IF PD-35 <> PD-04  DISPLAY "PD-35 <> PD-04".
           IF PD-36 <> PD-03  DISPLAY "PD-36 <> PD-03".

           IF CD-03 <> CD-36  DISPLAY "CD-03 <> CD-36".
           IF CD-04 <> CD-35  DISPLAY "CD-04 <> CD-35".
           IF CD-05 <> CD-34  DISPLAY "CD-05 <> CD-34".
           IF CD-06 <> CD-33  DISPLAY "CD-06 <> CD-33".
           IF CD-07 <> CD-32  DISPLAY "CD-07 <> CD-32".
           IF CD-08 <> CD-31  DISPLAY "CD-08 <> CD-31".
           IF CD-09 <> CD-30  DISPLAY "CD-09 <> CD-30".
           IF CD-10 <> CD-29  DISPLAY "CD-10 <> CD-29".
           IF CD-11 <> CD-28  DISPLAY "CD-11 <> CD-28".
           IF CD-12 <> CD-27  DISPLAY "CD-12 <> CD-27".
           IF CD-13 <> CD-26  DISPLAY "CD-13 <> CD-26".
           IF CD-14 <> CD-25  DISPLAY "CD-14 <> CD-25".
           IF CD-15 <> CD-24  DISPLAY "CD-15 <> CD-24".
           IF CD-16 <> CD-23  DISPLAY "CD-16 <> CD-23".
           IF CD-17 <> CD-22  DISPLAY "CD-17 <> CD-22".
           IF CD-18 <> CD-21  DISPLAY "CD-18 <> CD-21".
           IF CD-19 <> CD-20  DISPLAY "CD-19 <> CD-20".
           IF CD-20 <> CD-19  DISPLAY "CD-20 <> CD-19".
           IF CD-21 <> CD-18  DISPLAY "CD-21 <> CD-18".
           IF CD-22 <> CD-17  DISPLAY "CD-22 <> CD-17".
           IF CD-23 <> CD-16  DISPLAY "CD-23 <> CD-16".
           IF CD-24 <> CD-15  DISPLAY "CD-24 <> CD-15".
           IF CD-25 <> CD-14  DISPLAY "CD-25 <> CD-14".
           IF CD-26 <> CD-13  DISPLAY "CD-26 <> CD-13".
           IF CD-27 <> CD-12  DISPLAY "CD-27 <> CD-12".
           IF CD-28 <> CD-11  DISPLAY "CD-28 <> CD-11".
           IF CD-29 <> CD-10  DISPLAY "CD-29 <> CD-10".
           IF CD-30 <> CD-09  DISPLAY "CD-30 <> CD-09".
           IF CD-31 <> CD-08  DISPLAY "CD-31 <> CD-08".
           IF CD-32 <> CD-07  DISPLAY "CD-32 <> CD-07".
           IF CD-33 <> CD-06  DISPLAY "CD-33 <> CD-06".
           IF CD-34 <> CD-05  DISPLAY "CD-34 <> CD-05".
           IF CD-35 <> CD-04  DISPLAY "CD-35 <> CD-04".
           IF CD-36 <> CD-03  DISPLAY "CD-36 <> CD-03".

      *    SETTING UP DATA FOR COMPARE WITH NEGATIVE PACKED ZERO

           MOVE LOW-VALUES             TO PZ-01-X.
           MOVE LOW-VALUES             TO PZ-02-X
           MOVE X'0C'                  TO PZ-02-X(20:1).
           MOVE LOW-VALUES             TO PZ-03-X
           MOVE X'0D'                  TO PZ-03-X(20:1).
      *>   note: we previously checked x'10' here, which is "outside"
      *>         of the actual digits; behaviour is undefined there
      *>         and may very between dialects -> so only check actual digits
           MOVE LOW-VALUES             TO PZ-04-X
           MOVE X'01'                  TO PZ-04-X(1:1).
           MOVE X'0D'                  TO PZ-04-X(20:1).
           MOVE LOW-VALUES             TO PZ-05-X
           MOVE X'010D'                TO PZ-05-X(19:2).
           MOVE LOW-VALUES             TO PZ-06-X
           MOVE X'1D'                  TO PZ-06-X(20:1).

           IF PZ-01 <> PZ-02  DISPLAY "PZ-01 <> PZ-02".
           IF PZ-01 <> PZ-03  DISPLAY "PZ-01 <> PZ-03".
           IF PZ-02 <> PZ-03  DISPLAY "PZ-02 <> PZ-03".
           IF PZ-02 <= PZ-04  DISPLAY "PZ-02 <= PZ-04".
           IF PZ-02 <= PZ-05  DISPLAY "PZ-02 <= PZ-05".
           IF PZ-02 <= PZ-06  DISPLAY "PZ-02 <= PZ-05".
      *
           IF U4-32D <>  UP-32D DISPLAY "U4-32D <> UP-32D".
           IF U4-32D <>  SP-32D DISPLAY "U4-32D <> SP-32D".
           IF U4-32D <=  NP-32D DISPLAY "U4-32D <= NP-32D".