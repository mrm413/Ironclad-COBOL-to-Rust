IDENTIFICATION DIVISION.
       PROGRAM-ID. Move_Basic_P_Pic .
      *>----------------------------------------------------------------
      *>           Additional test cases for MOVE statement
      *> Basic checking of P Picture
      *>   -check lengt content and move
      *>----------------------------------------------------------------
      *>
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *>
       01 P-PIC-1       PIC 99P(4)    .
       01 P-PIC-1-9 REDEFINES P-PIC-1  PIC 9(02)  .
       01 FLD-1         PIC 9(06)     .
       01 FLD-1-RES     PIC 9(06)                 .
      *>
       01 P-PIC-2       PIC S99P(4)   .
       01 P-PIC-2-9 REDEFINES P-PIC-2  PIC S9(02)  .
       01 FLD-2         PIC S9(06)    .
       01 FLD-2-RES     PIC S9(06)    .
      *>
       01 P-PIC-3       PIC P(4)9     .
       01 P-PIC-3-9 REDEFINES P-PIC-3  PIC 9(01)  .
       01 FLD-3         PIC V9(05)    .
       01 FLD-3-RES     PIC V9(05)    .
      *>
       01 P-PIC-4       PIC SP(4)9    .
       01 P-PIC-4-9 REDEFINES P-PIC-4  PIC S9(01)  .
       01 FLD-4         PIC SV9(05)   .
       01 FLD-4-RES     PIC SV9(05)    .
      *>
       01 W01-I         PIC 9(02)     .
      *>
       PROCEDURE DIVISION .
      *>
      *>   Check Length
      *>
           PERFORM CHECK-LENGTH .
      *>
           PERFORM CHECK-CONTENT.
      *>
           PERFORM CHECK-MOVE   .
      *>
           GOBACK .
      *>
       CHECK-CONTENT.
      *>------------
      *>
           MOVE    123456  TO P-PIC-1      .
           IF P-PIC-1-9 NOT = 12
           THEN
                   DISPLAY 'Error C1 VALUE <' P-PIC-1-9 '> != 12' .
      *>
           MOVE    345678  TO P-PIC-2      .
           IF P-PIC-2-9 NOT = 34
           THEN
                   DISPLAY 'Error C2 VALUE <' P-PIC-2-9 '> != 34' .
      *>
           MOVE   -456789  TO P-PIC-2      .
           IF P-PIC-2-9 NOT = -45
           THEN
                   DISPLAY 'Error C3 VALUE <' P-PIC-2-9 '> != -45' .
      *>
           MOVE   0.12345  TO P-PIC-3      .
           IF P-PIC-3-9 NOT = 5
           THEN
                   DISPLAY 'Error C4 VALUE <' P-PIC-3-9 '> != 5' .
      *>
           MOVE   0.56789  TO P-PIC-4      .
           IF P-PIC-4-9 NOT = 9
           THEN
                   DISPLAY 'Error C5 VALUE <' P-PIC-4-9 '> != 9' .
      *>
           MOVE  -0.34567  TO P-PIC-4      .
           IF P-PIC-4-9 NOT = -7
           THEN
                   DISPLAY 'Error C6 VALUE <' P-PIC-4-9 '> != -7' .
      *>
       CHECK-MOVE .
      *>----------
      *>
           MOVE    123456  TO P-PIC-1      .
           MOVE    P-PIC-1 TO FLD-1        .
           MOVE    120000  TO FLD-1-RES    .
           IF FLD-1 NOT = FLD-1-RES
           THEN
               DISPLAY 'M1 <' FLD-1-RES '> != ' FLD-1 .
      *>
           MOVE    001234  TO P-PIC-1      .
           MOVE    P-PIC-1 TO FLD-1        .
           MOVE    000000  TO FLD-1-RES    .
           IF FLD-1 NOT = FLD-1-RES
           THEN
               DISPLAY 'M2 <' FLD-1-RES '> != ' FLD-1 .
      *>-----------------------------------
           MOVE    001234  TO P-PIC-2      .
           MOVE    P-PIC-2 TO FLD-2        .
           MOVE    000000  TO FLD-2-RES    .
           IF FLD-2 NOT = FLD-2-RES
           THEN
               DISPLAY 'M3 <' FLD-2-RES '> != ' FLD-2 .
      *>
           MOVE   -005678  TO P-PIC-2      .
           MOVE    P-PIC-2 TO FLD-2        .
           MOVE    000000  TO FLD-2-RES    .
           IF FLD-2 NOT = FLD-2-RES
           THEN
               DISPLAY 'M4 <' FLD-2-RES '> != ' FLD-2 .
      *>
           MOVE    456789  TO P-PIC-2      .
           MOVE    P-PIC-2 TO FLD-2        .
           MOVE    450000  TO FLD-2-RES    .
           IF FLD-2 NOT = FLD-2-RES
           THEN
               DISPLAY 'M5 <' FLD-2-RES '> != ' FLD-2 .
      *>
           MOVE   -456789  TO P-PIC-2      .
           MOVE    P-PIC-2 TO FLD-2        .
           MOVE   -450000  TO FLD-2-RES    .
           IF FLD-2 NOT = FLD-2-RES
           THEN
               DISPLAY 'M6 <' FLD-2-RES '> != ' FLD-2 .
      *>-----------------------------------
           MOVE   0.12345  TO P-PIC-3      .
           MOVE    P-PIC-3 TO FLD-3        .
           MOVE   0.00005  TO FLD-3-RES    .
           IF FLD-3 NOT = FLD-3-RES
           THEN
               DISPLAY 'M7 <' FLD-3-RES '> != ' FLD-3 .
      *>
           MOVE   0.00010  TO P-PIC-3      .
           MOVE    P-PIC-3 TO FLD-3        .
           MOVE   0.00000  TO FLD-3-RES    .
           IF FLD-3 NOT = FLD-3-RES
           THEN
               DISPLAY 'M8 <' FLD-3-RES '> != ' FLD-3 .
      *>
      *>-----------------------------------
      *>
           MOVE   0.23456  TO P-PIC-4      .
           MOVE    P-PIC-4 TO FLD-4        .
           MOVE   0.00006  TO FLD-4-RES    .
           IF FLD-4 NOT = FLD-4-RES
           THEN
               DISPLAY 'M9 <' FLD-4-RES '> != ' FLD-4 .
      *>
           MOVE   0.02340  TO P-PIC-4      .
           MOVE    P-PIC-4 TO FLD-4        .
           MOVE   0.00000  TO FLD-4-RES    .
           IF FLD-4 NOT = FLD-4-RES
           THEN
               DISPLAY 'M10 <' FLD-4-RES '> != ' FLD-4 .
      *>
           MOVE  -0.12345  TO P-PIC-4      .
           MOVE    P-PIC-4 TO FLD-4        .
           MOVE  -0.00005  TO FLD-4-RES    .
           IF FLD-4 NOT = FLD-4-RES
           THEN
               DISPLAY 'M11 <' FLD-4-RES '> != ' FLD-4 .
      *>
           MOVE  -0.34560  TO P-PIC-4      .
           MOVE    P-PIC-4 TO FLD-4        .
           MOVE   0.00000  TO FLD-4-RES    .
           IF FLD-4 NOT = FLD-4-RES
           THEN
               DISPLAY 'M11 <' FLD-4-RES '> != ' FLD-4 .
      *>
      *>-----------------------------------
      *>
       CHECK-LENGTH.
      *>-----------
      *>
           MOVE LENGTH OF P-PIC-1 TO W01-I .
           IF W01-I NOT = 2
           THEN
               DISPLAY 'Error 1 size <' W01-I '> !=2' .
      *>
           MOVE LENGTH OF P-PIC-2 TO W01-I .
           IF W01-I NOT = 2
           THEN
               DISPLAY 'Error 2 size <' W01-I '> !=2' .
      *>
           MOVE LENGTH OF P-PIC-3 TO W01-I .
           IF W01-I NOT = 1
           THEN
               DISPLAY 'Error 3 size <' W01-I '> !=1' .
      *>

           MOVE LENGTH OF P-PIC-4 TO W01-I .
           IF W01-I NOT = 1
           THEN
               DISPLAY 'Error 4 size <' W01-I '> !=1' .