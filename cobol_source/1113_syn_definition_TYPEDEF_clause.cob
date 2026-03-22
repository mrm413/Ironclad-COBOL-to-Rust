IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 AUSGABE-FILE-NAME-T     PIC X(50) IS TYPEDEF.
       01 DETAIL-NO-T             PIC 9999  IS TYPEDEF.
       01 AUSGABE-FILE-NAME-2T              IS TYPEDEF.
          05 FILLER    PIC 9999.
          05 DETAIL-NO TYPE TO DETAIL-NO-T.
      *
       01  MESSAGE-TEXT-2T IS TYPEDEF.
         02 AUSGABE-FILE-NAME     TYPE AUSGABE-FILE-NAME-T.
         02 FILLER REDEFINES AUSGABE-FILE-NAME.
             05 FILLER PIC 9999.
         02 AUSGABE-FILE-NAME-2   TYPE AUSGABE-FILE-NAME-2T.
         02 FILLER                TYPE AUSGABE-FILE-NAME-T.
      *
       01  MESSAGE-TEXT-2 EXTERNAL TYPE MESSAGE-TEXT-2T.
      
       77 OUTPUT-NAME TYPE TO DETAIL-NO-T GLOBAL.

       01 Z-MESSAGE-T2 TYPE AUSGABE-FILE-NAME-2T.
       01 Z-MESSAGE-T3.
          49 MT3                    TYPE MESSAGE-TEXT-2T.
          49 MT3-REN  REDEFINES MT3 TYPE MESSAGE-TEXT-2T.

       77 CALCULUS             PIC S9(15)V9(03) IS TYPEDEF.

       01 SOME-STRUCT          IS TYPEDEF.
          02 SOME-DATA         PIC 9.
          02 SOME-VALUES       OCCURS 3.
             03 OTHER-DATA     PIC X.
             03 OTHER-VALUES   OCCURS 2 PIC 9.
       77 SOME2-DATA           PIC 9.      *> temporary variant until solved...
       01 SOME-STRUCT2         IS TYPEDEF.
      *>  02 SOME2-DATA        PIC 9.      TODO!
          02 SOME2-VALUES      OCCURS 1 TO 6 DEPENDING ON SOME2-DATA
                               DESCENDING KEY SB SA
                               INDEXED BY SOME2-INDEX.
             05 SA             PIC X VALUE x'12'.
             05 SB             PIC 9 VALUE 0.
             05 SDATA          PIC X(12).

       01 MY-TEST.
          02 AMOUNT            TYPE CALCULUS.
          02 FILLER            OCCURS 100.
             05 GRP-AMOUNT     TYPE CALCULUS.
          02 MY-NAME           TYPE SOME-STRUCT  OCCURS 5.
          02 MY-NAME2          TYPE SOME-STRUCT2.
       01 MY-TEST2             TYPE SOME-STRUCT2.
       LINKAGE SECTION.
       01 MY-STORE             TYPE CALCULUS.

       PROCEDURE DIVISION USING MY-STORE.
           DISPLAY AUSGABE-FILE-NAME OF MESSAGE-TEXT-2
           DISPLAY DETAIL-NO         OF Z-MESSAGE-T2
           DISPLAY AUSGABE-FILE-NAME OF MT3
           DISPLAY OUTPUT-NAME
           SET ADDRESS OF MY-STORE TO NULL
           INITIALIZE MY-NAME(2) GRP-AMOUNT (99)
           INITIALIZE OTHER-VALUES (2, 3, 2)
           SEARCH ALL SOME2-VALUES OF MY-NAME2
      *>     WHEN SA(SOME2-INDEX) = x'12'  CHECKME: Should work
             WHEN SA OF MY-NAME2(SOME2-INDEX OF MY-NAME2) = x'12'
                CONTINUE.
           GOBACK.