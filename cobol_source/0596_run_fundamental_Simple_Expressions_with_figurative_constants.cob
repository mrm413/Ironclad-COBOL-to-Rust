IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
      ******************************************************************
       WORKING-STORAGE SECTION.
       01  FLDX     PIC X        VALUE 'X'.
       01  FLDXX    PIC XX       VALUE SPACES.
       01  FLDX50   PIC X(50)    VALUE 'X50'.
       01  FLDX500  PIC X(500)   VALUE 'X500'.
       01  FLDX32K  PIC X(32000) VALUE 'X'.
       01  FLD1     PIC X        VALUE '1'.
       01  FLD1X    PIC X(32000) VALUE '1'.
       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.
       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.

       PROCEDURE DIVISION.
       MAIN-LINE.

      *>   Test with DISPLAY on error
           PERFORM DO-CHECK
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *>   minimal side-test for performance comparisons
           PERFORM DO-CHECK 20000 TIMES
       >> END-IF
           GOBACK.

       DO-CHECK.
      *> check with 1 byte, comparison algorithm is a direct comparison
           IF FLDX       >  SPACE      CONTINUE
           ELSE                        DISPLAY '! "X" > SPACE'.
           IF FLDX       <  SPACE      DISPLAY '  "X" < SPACE!'.
           IF FLDX       >= SPACE      CONTINUE
           ELSE                        DISPLAY '! "X" >= SPACE'.
           IF FLDX       <= SPACE      DISPLAY '  "X" <= SPACE!'.

           IF SPACE      <  FLDX       CONTINUE
           ELSE                        DISPLAY '! SPACE < "X"'.
           IF SPACE      >  FLDX       DISPLAY '  SPACE > "X"!'.
           IF SPACE      <= FLDX       CONTINUE
           ELSE                        DISPLAY '! SPACE <= "X"'.
           IF SPACE      >= FLDX       DISPLAY '  SPACE >= "X"!'.

           IF FLDX       >  " "        CONTINUE
           ELSE                        DISPLAY '! "X" > " "'.
           IF FLDX       <  " "        DISPLAY '  "X" < " "!'.
           IF FLDX       >= " "        CONTINUE
           ELSE                        DISPLAY '! "X" >= " "'.
           IF FLDX       <= " "        DISPLAY '  "X" <= " "!'.

           IF " "        <  FLDX       CONTINUE
           ELSE                        DISPLAY '! " " < "X"'.
           IF " "        >  FLDX       DISPLAY '  " " > "X"!'.
           IF " "        <= FLDX       CONTINUE
           ELSE                        DISPLAY '! " " <= "X"'.
           IF " "        >= FLDX       DISPLAY '  " " >= "X"!'.


           IF FLDX       >  LOW-VALUE  CONTINUE
           ELSE                        DISPLAY '! "X" > LOW-VALUE'.
           IF FLDX       <  LOW-VALUE  DISPLAY '  "X" < LOW-VALUE!'.
           IF FLDX       >= LOW-VALUE  CONTINUE
           ELSE                        DISPLAY '! "X" >= LOW-VALUE'.
           IF FLDX       <= LOW-VALUE  DISPLAY '  "X" <= LOW-VALUE!'.

           IF LOW-VALUE  <  FLDX       CONTINUE
           ELSE                        DISPLAY '! LOW-VALUE < "X"'.
           IF LOW-VALUE  >  FLDX       DISPLAY '  LOW-VALUE > "X"!'.
           IF LOW-VALUE  <= FLDX       CONTINUE
           ELSE                        DISPLAY '! LOW-VALUE <= "X"'.
           IF LOW-VALUE  >= FLDX       DISPLAY '  LOW-VALUE >= "X"!'.

           IF FLDX       >  x"00"      CONTINUE
           ELSE                        DISPLAY '! "X" > x"00"'.
           IF FLDX       <  x"00"      DISPLAY '  "X" < x"00"!'.
           IF FLDX       >= x"00"      CONTINUE
           ELSE                        DISPLAY '! "X" >= x"00"'.
           IF FLDX       <= x"00"      DISPLAY '  "X" <= x"00"!'.

           IF x"00"      <  FLDX       CONTINUE
           ELSE                        DISPLAY '! x"00" < "X"'.
           IF x"00"      >  FLDX       DISPLAY '  x"00" > "X"!'.
           IF x"00"      <= FLDX       CONTINUE
           ELSE                        DISPLAY '! x"00" <= "X"'.
           IF x"00"      >= FLDX       DISPLAY '  x"00" >= "X"!'.


           IF FLDX       <  HIGH-VALUE CONTINUE
           ELSE                        DISPLAY '! "X" < HIGH-VALUE'.
           IF FLDX       >  HIGH-VALUE DISPLAY '  "X" > HIGH-VALUE!'.
           IF FLDX       <= HIGH-VALUE CONTINUE
           ELSE                        DISPLAY '! "X" <= HIGH-VALUE'.
           IF FLDX       >= HIGH-VALUE DISPLAY '  "X" >= HIGH-VALUE!'.

           IF HIGH-VALUE >  FLDX       CONTINUE
           ELSE                        DISPLAY '! HIGH-VALUE > "X"'.
           IF HIGH-VALUE <  FLDX       DISPLAY '  HIGH-VALUE < "X"!'.
           IF HIGH-VALUE >= FLDX       CONTINUE
           ELSE                        DISPLAY '! HIGH-VALUE >= "X"'.
           IF HIGH-VALUE <= FLDX       DISPLAY '  HIGH-VALUE <= "X"!'.

           IF FLDX       <  x"FF"      CONTINUE
           ELSE                        DISPLAY '! "X" < x"FF"'.
           IF FLDX       >  x"FF"      DISPLAY '  "X" > x"FF"!'.
           IF FLDX       <= x"FF"      CONTINUE
           ELSE                        DISPLAY '! "X" <= x"FF"'.
           IF FLDX       >= x"FF"      DISPLAY '  "X" >= x"FF"!'.

           IF x"FF"      >  FLDX       CONTINUE
           ELSE                        DISPLAY '! x"FF" > "X"'.
           IF x"FF"      <  FLDX       DISPLAY '  x"FF" < "X"!'.
           IF x"FF"      >= FLDX       CONTINUE
           ELSE                        DISPLAY '! x"FF" >= "X"'.
           IF x"FF"      <= FLDX       DISPLAY '  x"FF" <= "X"!'.


           IF FLD1       >  ZERO       CONTINUE
           ELSE                        DISPLAY '! "1" > ZERO'.
           IF FLD1       <  ZERO       DISPLAY '  "1" < ZERO!'.
           IF FLD1       >= ZERO       CONTINUE
           ELSE                        DISPLAY '! "1" >= ZERO'.
           IF FLD1       <= ZERO       DISPLAY '  "1" <= ZERO!'.

           IF ZERO       <  FLD1       CONTINUE
           ELSE                        DISPLAY '! ZERO < "1"'.
           IF ZERO       >  FLD1       DISPLAY '  ZERO > "1"!'.
           IF ZERO       <= FLD1       CONTINUE
           ELSE                        DISPLAY '! ZERO <= "1"'.
           IF ZERO       >= FLD1       DISPLAY '  ZERO >= "1"!'.

           IF FLD1       >  "0"        CONTINUE
           ELSE                        DISPLAY '! "1" > "0"'.
           IF FLD1       <  "0"        DISPLAY '  "1" < "0"!'.
           IF FLD1       >= "0"        CONTINUE
           ELSE                        DISPLAY '! "1" >= "0"'.
           IF FLD1       <= "0"        DISPLAY '  "1" <= "0"!'.

           IF "0"        <  FLD1       CONTINUE
           ELSE                        DISPLAY '! "0" < "1"'.
           IF "0"        >  FLD1       DISPLAY '  "0" > "1"!'.
           IF "0"        <= FLD1       CONTINUE
           ELSE                        DISPLAY '! "0" <= "1"'.
           IF "0"        >= FLD1       DISPLAY '  "0" >= "1"!'.

      *> check with many bytes, needs another comparison algorithm (function)
           IF FLDX32K    >  SPACE      CONTINUE
           ELSE                        DISPLAY '! "X " > SPACE'.
           IF FLDX32K    <  SPACE      DISPLAY '  "X " < SPACE!'.
           IF FLDX32K    >= SPACE      CONTINUE
           ELSE                        DISPLAY '! "X " >= SPACE'.
           IF FLDX32K    <= SPACE      DISPLAY '  "X " <= SPACE!'.

           IF SPACE      <  FLDX32K    CONTINUE
           ELSE                        DISPLAY '! SPACE < "X "'.
           IF SPACE      >  FLDX32K    DISPLAY '  SPACE > "X "!'.
           IF SPACE      <= FLDX32K    CONTINUE
           ELSE                        DISPLAY '! SPACE <= "X "'.
           IF SPACE      >= FLDX32K    DISPLAY '  SPACE >= "X "!'.

           IF FLDX32K    >  "  "       CONTINUE
           ELSE                        DISPLAY '! "X " > " "'.
           IF FLDX32K    <  "  "       DISPLAY '  "X " < " "!'.
           IF FLDX32K    >= "  "       CONTINUE
           ELSE                        DISPLAY '! "X " >= " "'.
           IF FLDX32K    <= "  "       DISPLAY '  "X " <= " "!'.

           IF "  "       <  FLDX32K    CONTINUE
           ELSE                        DISPLAY '! "  " < "X "'.
           IF "  "       >  FLDX32K    DISPLAY '  "  " > "X "!'.
           IF "  "       <= FLDX32K    CONTINUE
           ELSE                        DISPLAY '! "  " <= "X "'.
           IF "  "       >= FLDX32K    DISPLAY '  "  " >= "X "!'.


           IF FLDX32K    >  LOW-VALUE  CONTINUE
           ELSE                        DISPLAY '! "X" > LOW-VALUE'.
           IF FLDX32K    <  LOW-VALUE  DISPLAY '  "X" < LOW-VALUE!'.
           IF FLDX32K    >= LOW-VALUE  CONTINUE
           ELSE                        DISPLAY '! "X" >= LOW-VALUE'.
           IF FLDX32K    <= LOW-VALUE  DISPLAY '  "X" <= LOW-VALUE!'.

           IF LOW-VALUE  <  FLDX32K    CONTINUE
           ELSE                        DISPLAY '! LOW-VALUE < "X"'.
           IF LOW-VALUE  >  FLDX32K    DISPLAY '  LOW-VALUE > "X"!'.
           IF LOW-VALUE  <= FLDX32K    CONTINUE
           ELSE                        DISPLAY '! LOW-VALUE <= "X"'.
           IF LOW-VALUE  >= FLDX32K    DISPLAY '  LOW-VALUE >= "X"!'.

           IF FLDX32K    >  x"00"      CONTINUE
           ELSE                        DISPLAY '! "X " > x"00"'.
           IF FLDX32K    <  x"00"      DISPLAY '  "X " < x"00"!'.
           IF FLDX32K    >= x"00"      CONTINUE
           ELSE                        DISPLAY '! "X " >= x"00"'.
           IF FLDX32K    <= x"00"      DISPLAY '  "X " <= x"00"!'.

           IF x"00"      <  FLDX32K    CONTINUE
           ELSE                        DISPLAY '! x"00" < "X "'.
           IF x"00"      >  FLDX32K    DISPLAY '  x"00" > "X "!'.
           IF x"00"      <= FLDX32K    CONTINUE
           ELSE                        DISPLAY '! x"00" <= "X "'.
           IF x"00"      >= FLDX32K    DISPLAY '  x"00" >= "X "!'.


           IF FLDX32K    <  HIGH-VALUE CONTINUE
           ELSE                        DISPLAY '! "X " < HIGH-VALUE'.
           IF FLDX32K    >  HIGH-VALUE DISPLAY '  "X " > HIGH-VALUE!'.
           IF FLDX32K    <= HIGH-VALUE CONTINUE
           ELSE                        DISPLAY '! "X " <= HIGH-VALUE'.
           IF FLDX32K    >= HIGH-VALUE DISPLAY '  "X " >= HIGH-VALUE!'.

           IF HIGH-VALUE >  FLDX32K    CONTINUE
           ELSE                        DISPLAY '! HIGH-VALUE > "X "'.
           IF HIGH-VALUE <  FLDX32K    DISPLAY '  HIGH-VALUE < "X "!'.
           IF HIGH-VALUE >= FLDX32K    CONTINUE
           ELSE                        DISPLAY '! HIGH-VALUE >= "X "'.
           IF HIGH-VALUE <= FLDX32K    DISPLAY '  HIGH-VALUE <= "X "!'.

           IF FLDX32K    <  x"FF"      CONTINUE
           ELSE                        DISPLAY '! "X " < x"FF"'.
           IF FLDX32K    >  x"FF"      DISPLAY '  "X " > x"FF"!'.
           IF FLDX32K    <= x"FF"      CONTINUE
           ELSE                        DISPLAY '! "X " <= x"FF"'.
           IF FLDX32K    >= x"FF"      DISPLAY '  "X " >= x"FF"!'.

           IF x"FF"      >  FLDX32K    CONTINUE
           ELSE                        DISPLAY '! x"FF" > "X "'.
           IF x"FF"      <  FLDX32K    DISPLAY '  x"FF" < "X "!'.
           IF x"FF"      >= FLDX32K    CONTINUE
           ELSE                        DISPLAY '! x"FF" >= "X "'.
           IF x"FF"      <= FLDX32K    DISPLAY '  x"FF" <= "X "!'.


           IF FLD1X      >  ZERO       CONTINUE
           ELSE                        DISPLAY '! "1 " > ZERO'.
           IF FLD1X      <  ZERO       DISPLAY '  "1 " < ZERO!'.
           IF FLD1X      >= ZERO       CONTINUE
           ELSE                        DISPLAY '! "1 " >= ZERO'.
           IF FLD1X      <= ZERO       DISPLAY '  "1 " <= ZERO!'.

           IF ZERO       <  FLD1X      CONTINUE
           ELSE                        DISPLAY '! ZERO < "1 "'.
           IF ZERO       >  FLD1X      DISPLAY '  ZERO > "1 "!'.
           IF ZERO       <= FLD1X      CONTINUE
           ELSE                        DISPLAY '! ZERO <= "1 "'.
           IF ZERO       >= FLD1X      DISPLAY '  ZERO >= "1 "!'.

           IF FLD1X      >  "0"        CONTINUE
           ELSE                        DISPLAY '! "1 " > "0"'.
           IF FLD1X      <  "0"        DISPLAY '  "1 " < "0"!'.
           IF FLD1X      >= "0"        CONTINUE
           ELSE                        DISPLAY '! "1 " >= "0"'.
           IF FLD1X      <= "0"        DISPLAY '  "1 " <= "0"!'.

           IF "0"        <  FLD1X      CONTINUE
           ELSE                        DISPLAY '! "0" < "1 "'.
           IF "0"        >  FLD1X      DISPLAY '  "0" > "1 "!'.
           IF "0"        <= FLD1X      CONTINUE
           ELSE                        DISPLAY '! "0" <= "1 "'.
           IF "0"        >= FLD1X      DISPLAY '  "0" >= "1 "!'.

      *> special check for SPACE-optimization and extra spaces
           IF FLDX500    >  SPACE      CONTINUE
           ELSE                        DISPLAY '! "X5" > SPACE'.
           IF FLDX500    <  SPACE      DISPLAY '  "X5" < SPACE!'.
           IF FLDX500    >= SPACE      CONTINUE
           ELSE                        DISPLAY '! "X5" >= SPACE'.
           IF FLDX500    <= SPACE      DISPLAY '  "X5" <= SPACE!'.

           IF SPACE      <  FLDX500    CONTINUE
           ELSE                        DISPLAY '! SPACE < "X5"'.
           IF SPACE      >  FLDX500    DISPLAY '  SPACE > "X5"!'.
           IF SPACE      <= FLDX500    CONTINUE
           ELSE                        DISPLAY '! SPACE <= "X5"'.
           IF SPACE      >= FLDX500    DISPLAY '  SPACE >= "X5"!'.

           MOVE SPACES TO FLDXX
           IF FLDXX      =  "    "     CONTINUE
           ELSE                        DISPLAY '! "XX" <> "     "'.
           MOVE ALL "A" TO FLDXX
           IF FLDXX      =  "AA  "     CONTINUE
           ELSE                        DISPLAY '! "AA" <> "AA  "'.
           IF FLDXX      =  "AAA"      DISPLAY '! "AA" = "AAA "'.
           IF FLDXX      =  ALL "A"    CONTINUE
           ELSE                        DISPLAY '! "AA" <> ALL "A"'.
           MOVE "B" TO FLDXX (2:1)
           IF FLDXX      =  ALL "AB"   CONTINUE
           ELSE                        DISPLAY '! "AB" <> ALL "AB"'.

           IF FLDX      <=  ALL "XX"   CONTINUE
           ELSE                        DISPLAY '! "X" > ALL "XX"'.
           IF ALL "XX" NOT > FLDX      CONTINUE
           ELSE                        DISPLAY '! ALL "XX" <= "X"'.

      *> special check for ZERO-optimization and extra spaces
           MOVE ALL ZERO TO FLDX500 FLDX50
           MOVE "1"      TO FLDX500 (500:1) FLDX50(50:1)
           IF FLDX50     >  ZERO       CONTINUE
           ELSE                        DISPLAY '! "000...01" > ZERO'.
           IF FLDX50     <  ZERO       DISPLAY '  "000...01" < ZERO!'.
           IF FLDX50     >= ZERO       CONTINUE
           ELSE                        DISPLAY '! "000...01" >= ZERO'.
           IF FLDX50     <= ZERO       DISPLAY '  "000...01" <= ZERO!'.

           IF ZERO       <  FLDX50     CONTINUE
           ELSE                        DISPLAY '! ZERO < "000...01"'.
           IF ZERO       >  FLDX50     DISPLAY '  ZERO > "000...01"!'.
           IF ZERO       <= FLDX50     CONTINUE
           ELSE                        DISPLAY '! ZERO <= "000...01"'.
           IF ZERO       >= FLDX50     DISPLAY '  ZERO >= "000...01"!'.

           IF FLDX500    >  ZERO       CONTINUE
           ELSE                        DISPLAY '! "000...01" > ZERO'.
           IF FLDX500    <  ZERO       DISPLAY '  "000...01" < ZERO!'.
           IF FLDX500    >= ZERO       CONTINUE
           ELSE                        DISPLAY '! "000...01" >= ZERO'.
           IF FLDX500    <= ZERO       DISPLAY '  "000...01" <= ZERO!'.

           IF ZERO       <  FLDX500    CONTINUE
           ELSE                        DISPLAY '! ZERO < "000...01"'.
           IF ZERO       >  FLDX500    DISPLAY '  ZERO > "000...01"!'.
           IF ZERO       <= FLDX500    CONTINUE
           ELSE                        DISPLAY '! ZERO <= "000...01"'.
           IF ZERO       >= FLDX500    DISPLAY '  ZERO >= "000...01"!'.