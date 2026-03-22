IDENTIFICATION DIVISION.
       PROGRAM-ID . MoveTestCobMove .
      *>----------------------------------------------------------------
      *> This programm cover the cob_move function for numeric
      *> data types except numeric edited
      *>----------------------------------------------------------------
      *>
       ENVIRONMENT DIVISION.
       DATA DIVISION .
       WORKING-STORAGE  SECTION.

       01 ALL-SRC .
          05 FIELD-02 BINARY-C-LONG  SIGNED  .
          05 FIELD-03 BINARY-C-LONG UNSIGNED .
          05 FIELD-04 BINARY-CHAR  SIGNED  .
          05 FIELD-05 BINARY-CHAR UNSIGNED .
          05 FIELD-06 BINARY-DOUBLE  SIGNED  .
          05 FIELD-07 BINARY-DOUBLE UNSIGNED .
          05 FIELD-08 BINARY-INT .
          05 FIELD-09 BINARY-LONG  SIGNED  .
          05 FIELD-10 BINARY-LONG UNSIGNED .
          05 FIELD-11 BINARY-LONG-LONG .
          05 FIELD-12 BINARY-SHORT  SIGNED  .
          05 FIELD-13 BINARY-SHORT UNSIGNED .
          05 FIELD-14 FLOAT-DECIMAL-16 .
          05 FIELD-15 FLOAT-DECIMAL-34 .
          05 FIELD-16 FLOAT-LONG .
          05 FIELD-17 FLOAT-SHORT .
          05 FIELD-18 SIGNED-INT .
          05 FIELD-19 SIGNED-LONG .
          05 FIELD-20 SIGNED-SHORT .
          05 FIELD-21 UNSIGNED-INT .
          05 FIELD-22 UNSIGNED-LONG .
          05 FIELD-23 UNSIGNED-SHORT .
          05 FIELD-24            COMP-1 .
          05 FIELD-25            COMP-2 .
          05 FIELD-26 PIC  9(10) COMP-6 .
          05 FIELD-50 PIC S9(09) BINARY            .
          05 FIELD-51 PIC S9(09) COMP .
          05 FIELD-52 PIC S9(09)V99 COMP-3 .
          05 FIELD-53 PIC S9(09) COMP-4 .
          05 FIELD-54 PIC S9(09) COMP-5 .
          05 FIELD-55 PIC S9(09) COMP-X .
          05 FIELD-56 PIC S9(09)V99 DISPLAY .
      *>
       01 EXPTD-RESULT PIC 9(09)     .
      *>
       01 ALL-DST .
          05 FIELD-02 BINARY-C-LONG  SIGNED  .
          05 FIELD-03 BINARY-C-LONG UNSIGNED .
          05 FIELD-04 BINARY-CHAR  SIGNED  .
          05 FIELD-05 BINARY-CHAR UNSIGNED .
          05 FIELD-06 BINARY-DOUBLE  SIGNED  .
          05 FIELD-07 BINARY-DOUBLE UNSIGNED .
          05 FIELD-08 BINARY-INT .
          05 FIELD-09 BINARY-LONG  SIGNED  .
          05 FIELD-10 BINARY-LONG UNSIGNED .
          05 FIELD-11 BINARY-LONG-LONG .
          05 FIELD-12 BINARY-SHORT  SIGNED  .
          05 FIELD-13 BINARY-SHORT UNSIGNED .
          05 FIELD-14 FLOAT-DECIMAL-16 .
          05 FIELD-15 FLOAT-DECIMAL-34 .
          05 FIELD-16 FLOAT-LONG .
          05 FIELD-17 FLOAT-SHORT .
          05 FIELD-18 SIGNED-INT .
          05 FIELD-19 SIGNED-LONG .
          05 FIELD-20 SIGNED-SHORT .
          05 FIELD-21 UNSIGNED-INT .
          05 FIELD-22 UNSIGNED-LONG .
          05 FIELD-23 UNSIGNED-SHORT .
          05 FIELD-24            COMP-1 .
          05 FIELD-25            COMP-2 .
          05 FIELD-26 PIC 9(10)  COMP-6 .
          05 FIELD-50 PIC S9(09) BINARY            .
          05 FIELD-51 PIC S9(09) COMP .
          05 FIELD-52 PIC S9(09)V99 COMP-3 .
          05 FIELD-53 PIC S9(09) COMP-4 .
          05 FIELD-54 PIC S9(09) COMP-5 .
          05 FIELD-55 PIC S9(09) COMP-X .
          05 FIELD-56 PIC S9(09)V99 DISPLAY .

      *>
       PROCEDURE DIVISION .
      *>
           INITIALIZE ALL-SRC REPLACING NUMERIC BY 1 .
           PERFORM TEST-PASS-1 .
      *>
           INITIALIZE ALL-DST REPLACING NUMERIC BY 2 .
           PERFORM TEST-PASS-2 .
      *>
           MOVE  3        TO FIELD-02 OF ALL-SRC .
           MOVE  3        TO EXPTD-RESULT        .
           MOVE  FIELD-02 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  4        TO FIELD-03 OF ALL-SRC .
           MOVE  4        TO EXPTD-RESULT        .
           MOVE  FIELD-03 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  5        TO FIELD-04 OF ALL-SRC .
           MOVE  5        TO EXPTD-RESULT        .
           MOVE  FIELD-04 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  6        TO FIELD-05 OF ALL-SRC .
           MOVE  6        TO EXPTD-RESULT        .
           MOVE  FIELD-05 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  7        TO FIELD-06 OF ALL-SRC .
           MOVE  7        TO EXPTD-RESULT        .
           MOVE  FIELD-06 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  8        TO FIELD-07 OF ALL-SRC .
           MOVE  8        TO EXPTD-RESULT        .
           MOVE  FIELD-07 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  9        TO FIELD-08 OF ALL-SRC .
           MOVE  9        TO EXPTD-RESULT        .
           MOVE  FIELD-08 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  10       TO FIELD-09 OF ALL-SRC .
           MOVE  10       TO EXPTD-RESULT        .
           MOVE  FIELD-09 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  11       TO FIELD-10 OF ALL-SRC .
           MOVE  11       TO EXPTD-RESULT        .
           MOVE  FIELD-10 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  12       TO FIELD-11 OF ALL-SRC .
           MOVE  12       TO EXPTD-RESULT        .
           MOVE  FIELD-11 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  13       TO FIELD-12 OF ALL-SRC .
           MOVE  13       TO EXPTD-RESULT        .
           MOVE  FIELD-12 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  14       TO FIELD-13 OF ALL-SRC .
           MOVE  14       TO EXPTD-RESULT        .
           MOVE  FIELD-13 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  15       TO FIELD-14 OF ALL-SRC .
           MOVE  15       TO EXPTD-RESULT        .
           MOVE  FIELD-14 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  16       TO FIELD-15 OF ALL-SRC .
           MOVE  16       TO EXPTD-RESULT        .
           MOVE  FIELD-15 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  17       TO FIELD-16 OF ALL-SRC .
           MOVE  17       TO EXPTD-RESULT        .
           MOVE  FIELD-16 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  18       TO FIELD-17 OF ALL-SRC .
           MOVE  18       TO EXPTD-RESULT        .
           MOVE  FIELD-17 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  19       TO FIELD-18 OF ALL-SRC .
           MOVE  19       TO EXPTD-RESULT        .
           MOVE  FIELD-18 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  20       TO FIELD-19 OF ALL-SRC .
           MOVE  20       TO EXPTD-RESULT        .
           MOVE  FIELD-19 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  21       TO FIELD-20 OF ALL-SRC .
           MOVE  21       TO EXPTD-RESULT        .
           MOVE  FIELD-20 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  22       TO FIELD-21 OF ALL-SRC .
           MOVE  22       TO EXPTD-RESULT        .
           MOVE  FIELD-21 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  23       TO FIELD-22 OF ALL-SRC .
           MOVE  23       TO EXPTD-RESULT        .
           MOVE  FIELD-22 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  24       TO FIELD-23 OF ALL-SRC .
           MOVE  24       TO EXPTD-RESULT        .
           MOVE  FIELD-23 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  25       TO FIELD-24 OF ALL-SRC .
           MOVE  25       TO EXPTD-RESULT        .
           MOVE  FIELD-24 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  26       TO FIELD-25 OF ALL-SRC .
           MOVE  26       TO EXPTD-RESULT        .
           MOVE  FIELD-25 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  27       TO FIELD-26 OF ALL-SRC .
           MOVE  27       TO EXPTD-RESULT        .
           MOVE  FIELD-26 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  50       TO FIELD-50 OF ALL-SRC .
           MOVE  50       TO EXPTD-RESULT        .
           MOVE  FIELD-50 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  51       TO FIELD-51 OF ALL-SRC .
           MOVE  51       TO EXPTD-RESULT        .
           MOVE  FIELD-51 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  52       TO FIELD-52 OF ALL-SRC .
           MOVE  52       TO EXPTD-RESULT        .
           MOVE  FIELD-52 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  53       TO FIELD-53 OF ALL-SRC .
           MOVE  53       TO EXPTD-RESULT        .
           MOVE  FIELD-53 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  54       TO FIELD-54 OF ALL-SRC .
           MOVE  54       TO EXPTD-RESULT        .
           MOVE  FIELD-54 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  55       TO FIELD-55 OF ALL-SRC .
           MOVE  55       TO EXPTD-RESULT        .
           MOVE  FIELD-55 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           MOVE  56       TO FIELD-56 OF ALL-SRC .
           MOVE  56       TO EXPTD-RESULT        .
           MOVE  FIELD-56 OF ALL-SRC
             TO  FIELD-02 OF ALL-DST
                 FIELD-03 OF ALL-DST
                 FIELD-04 OF ALL-DST
                 FIELD-05 OF ALL-DST
                 FIELD-06 OF ALL-DST
                 FIELD-07 OF ALL-DST
                 FIELD-08 OF ALL-DST
                 FIELD-09 OF ALL-DST
                 FIELD-10 OF ALL-DST
                 FIELD-11 OF ALL-DST
                 FIELD-12 OF ALL-DST
                 FIELD-13 OF ALL-DST
                 FIELD-14 OF ALL-DST
                 FIELD-15 OF ALL-DST
                 FIELD-16 OF ALL-DST
                 FIELD-17 OF ALL-DST
                 FIELD-18 OF ALL-DST
                 FIELD-19 OF ALL-DST
                 FIELD-20 OF ALL-DST
                 FIELD-21 OF ALL-DST
                 FIELD-22 OF ALL-DST
                 FIELD-23 OF ALL-DST
                 FIELD-24 OF ALL-DST
                 FIELD-25 OF ALL-DST
                 FIELD-26 OF ALL-DST
                 FIELD-50 OF ALL-DST
                 FIELD-51 OF ALL-DST
                 FIELD-52 OF ALL-DST
                 FIELD-53 OF ALL-DST
                 FIELD-54 OF ALL-DST
                 FIELD-55 OF ALL-DST
                 FIELD-56 OF ALL-DST .
           PERFORM TEST-PASS-3        .
      *>
           GOBACK .
      *>
       TEST-PASS-1.
      *>----------
      *>
         IF FIELD-02 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-02 <' FIELD-02 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-03 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-03 <' FIELD-03 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-04 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-04 <' FIELD-04 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-05 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-05 <' FIELD-05 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-06 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-06 <' FIELD-06 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-07 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-07 <' FIELD-07 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-08 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-08 <' FIELD-08 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-09 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-09 <' FIELD-09 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-10 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-10 <' FIELD-10 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-11 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-11 <' FIELD-11 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-12 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-12 <' FIELD-12 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-13 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-13 <' FIELD-13 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-14 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-14 <' FIELD-14 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-15 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-15 <' FIELD-15 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-16 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-16 <' FIELD-16 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-17 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-17 <' FIELD-17 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-18 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-18 <' FIELD-18 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-19 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-19 <' FIELD-19 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-20 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-20 <' FIELD-20 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-21 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-21 <' FIELD-21 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-22 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-22 <' FIELD-22 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-23 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-23 <' FIELD-23 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-24 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-24 <' FIELD-24 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-25 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-25 <' FIELD-25 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-26 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-26 <' FIELD-26 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-50 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-50 <' FIELD-50 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-51 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-51 <' FIELD-51 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-52 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-52 <' FIELD-52 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-53 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-53 <' FIELD-52 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-54 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-54 <' FIELD-54 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-55 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-55 <' FIELD-55 OF
                ALL-SRC '> != 1' .
      *>
         IF FIELD-56 OF ALL-SRC    IS NOT = 1
            THEN
                DISPLAY 'PASS ONE: FIELD-56 <' FIELD-56 OF
                ALL-SRC '> != 1' .
      *>
       TEST-PASS-2.
      *>----------
      *>
         IF FIELD-02 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-02 <' FIELD-02 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-03 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-03 <' FIELD-03 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-04 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-04 <' FIELD-04 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-05 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-05 <' FIELD-05 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-06 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-06 <' FIELD-06 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-07 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-07 <' FIELD-07 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-08 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-08 <' FIELD-08 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-09 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-09 <' FIELD-09 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-10 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-10 <' FIELD-10 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-11 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-11 <' FIELD-11 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-12 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-12 <' FIELD-12 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-13 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-13 <' FIELD-13 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-14 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-14 <' FIELD-14 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-15 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-15 <' FIELD-15 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-16 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-16 <' FIELD-16 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-17 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-17 <' FIELD-17 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-18 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-18 <' FIELD-18 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-19 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-19 <' FIELD-19 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-20 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-20 <' FIELD-20 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-21 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-21 <' FIELD-21 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-22 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-22 <' FIELD-22 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-23 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-23 <' FIELD-23 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-24 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-24 <' FIELD-24 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-25 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-25 <' FIELD-25 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-26 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-26 <' FIELD-26 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-50 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-50 <' FIELD-50 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-51 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-51 <' FIELD-51 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-52 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-52 <' FIELD-52 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-53 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-53 <' FIELD-52 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-54 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-54 <' FIELD-54 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-55 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-55 <' FIELD-55 OF
                ALL-DST '> != 2' .
      *>
         IF FIELD-56 OF ALL-DST    IS NOT = 2
            THEN
                DISPLAY 'PASS TWO: FIELD-56 <' FIELD-56 OF
                ALL-DST '> != 2' .
      *>
       TEST-PASS-3.
      *>----------
      *>
         IF FIELD-02 OF ALL-DST    IS NOT =  EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-02 <' FIELD-02 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-03 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-03 <' FIELD-03 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-04 OF ALL-DST    IS NOT =  EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-04 <' FIELD-04 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .

      *>
         IF FIELD-05 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-05 <' FIELD-05 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-06 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-06 <' FIELD-06 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-07 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-07 <' FIELD-07 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-08 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-08 <' FIELD-08 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-09 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-09 <' FIELD-09 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-10 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-10 <' FIELD-10 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-11 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-11 <' FIELD-11 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-12 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-12 <' FIELD-12 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-13 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-13 <' FIELD-13 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-14 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-14 <' FIELD-14 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-15 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-15 <' FIELD-15 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-16 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-16 <' FIELD-16 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-17 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-17 <' FIELD-17 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-18 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-18 <' FIELD-18 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-19 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-19 <' FIELD-19 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-20 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-20 <' FIELD-20 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-21 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-21 <' FIELD-21 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-22 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-22 <' FIELD-22 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-23 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-23 <' FIELD-23 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-24 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-24 <' FIELD-24 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-25 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-25 <' FIELD-25 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-26 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-26 <' FIELD-26 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-50 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-50 <' FIELD-50 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-51 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-51 <' FIELD-51 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-52 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-52 <' FIELD-52 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-53 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-53 <' FIELD-52 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-54 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-54 <' FIELD-54 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-55 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-55 <' FIELD-55 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .
      *>
         IF FIELD-56 OF ALL-DST    IS NOT = EXPTD-RESULT
            THEN
                DISPLAY 'PASS THREE: FIELD-56 <' FIELD-56 OF
                ALL-DST '> != <' EXPTD-RESULT '>' .