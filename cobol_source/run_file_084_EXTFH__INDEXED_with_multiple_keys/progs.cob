[
      $SET ODOSLIDE
      **  CREATE KEY-DEF-AREA FROM ACB ARRAY
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXFHKEYS.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  ZX1           PIC X(04).
       77  ZX2           PIC X(04).
       77  ZX4           PIC X(08).
       77  Z91           PIC 9(04) COMP-5.
       77  Z92           PIC 9(04) COMP-5.
       77  Z93           PIC 9(08) COMP-5.
       77  Z94           PIC 9(08) COMP-5.
       77  E4            PIC X(08) VALUE 'E4'.
       77  E6            PIC X(08) VALUE 'E6'.
       77  OFF1          PIC X(4)    COMP-X.
       77  OFF2          PIC X(2)    COMP-X.
       01  PROGRAM-DATA.
           05  I                         PIC 9(4) COMP.
           05  J                         PIC 9(4) COMP.
           05  K                         PIC 9(4) COMP.
           05  L                         PIC 9(4) COMP.
           05  X                         PIC 9(4) COMP.
           05  Y                         PIC 9(4) COMP.
           05  Z                         PIC 9(4) COMP.
       01  KEY-DEF-AREA.
           05  GLOBAL-INFORMATION-AREA.
               10  KEY-DEF-LEN             PIC 9(04) COMP-X.
               10  FILLER                  PIC X(04).
               10  NUMBER-OF-KEYS          PIC 9(04) COMP-X.
               10  FILLER                  PIC X(06).
           05  KEY-DEFINITION-PARAMETER-BLOCK
            OCCURS 1 TO 15 TIMES DEPENDING ON NUMBER-OF-KEYS.
               10 COMPONENT-COUNT     PIC 9(4) COMP-X.
               10 OFFSET-TO-COMPONENT PIC 9(4) COMP-X.
               10 KEY-FLAGS           PIC 9(2) COMP-X.
               10 KEY-COMPRESSION     PIC 9(2) COMP-X.
               10 SPARSE-CHARACTER    PIC X.
               10 FILLER              PIC X(9).
           05  COMPONENT-DEFINITION-AREA
             OCCURS 1 TO 15 TIMES DEPENDING ON NUMBER-OF-KEYS.
               10 FILLER                  PIC X(2).
               10 OFFSET-TO-COMPONENT-DEF PIC 9(9) COMP-X.
               10 COMPONENT-LENGTH        PIC 9(9) COMP-X.
       LINKAGE SECTION.
       01  ACB-KEY-GROUP.
           05  ACB-CNT           PIC 9(02).
           05  ACB-KEY-TABLE OCCURS 32 TIMES.
               10  ACB-KEY-LEN   PIC 9(04) COMP-4.
               10  ACB-KEY-LENX REDEFINES ACB-KEY-LEN  PIC X(02).
               10  ACB-KEY-POS   PIC 9(04) COMP-4.
               10  ACB-KEY-POSX REDEFINES ACB-KEY-POS  PIC X(02).
               10  ACB-KEY-DUP PIC 9(02) COMP-X.
               10  ACB-KEY-DUPX REDEFINES ACB-KEY-DUP PIC X(01).
       01 KEY-DEFS PIC X(512).
       PROCEDURE DIVISION USING
                          ACB-KEY-GROUP
                          KEY-DEFS.
       A-010-MAINLINE.
           MOVE LOW-VALUES TO KEY-DEFS
           MOVE LOW-VALUES TO KEY-DEF-AREA
      ** POPULATE THE GLOBAL AREA
           MOVE ACB-CNT TO NUMBER-OF-KEYS
           COMPUTE KEY-DEF-LEN  = (ACB-CNT * 16) + (ACB-CNT * 10) + 14
      ** POPULATE KEY-DEFINITION-PARAMETER-BLOCK & COMPONENT DEFEINTION
           PERFORM A-020-MAKE-KEY-DEF THRU A-020-EXIT
           MOVE KEY-DEF-AREA (1:KEY-DEF-LEN) TO KEY-DEFS (1:KEY-DEF-LEN)
           GOBACK.
       A-010-EXIT.
           EXIT.
       A-020-MAKE-KEY-DEF.
      ** DO THE PRIMARY KEY
           MOVE 1 TO I
           MOVE 1 TO COMPONENT-COUNT (I)
           MOVE 16 TO KEY-FLAGS (I)
           COMPUTE OFF2 = (ACB-CNT * 16) + ((I - 1) * 10) + 14
           MOVE OFF2 TO OFFSET-TO-COMPONENT (I)
           MOVE ACB-KEY-POS (I) TO OFFSET-TO-COMPONENT-DEF (I)
           MOVE 10 TO COMPONENT-LENGTH (I)
      ** IF THERE ARE NO ALTERNATE KEYS EXIT - KEY DEF IS BUILT
           IF ACB-CNT < 2
               GO TO A-020-EXIT
           END-IF
      ** DO ALTERNATE INDEX(S)
           PERFORM VARYING I FROM 2 BY 1 UNTIL I > ACB-CNT
               MOVE 1 TO COMPONENT-COUNT (I)
               COMPUTE OFF2 = (ACB-CNT * 16) + ((I - 1) * 10) + 14
               MOVE OFF2 TO OFFSET-TO-COMPONENT (I)
               IF ACB-KEY-DUP (I) = 1
                   MOVE 64 TO KEY-FLAGS (I)
               ELSE
                   MOVE 16 TO KEY-FLAGS (I)
                   MOVE 0 TO KEY-FLAGS (I)
               END-IF
               MOVE ACB-KEY-POS (I) TO OFFSET-TO-COMPONENT-DEF (I)
               MOVE ACB-KEY-LEN (I) TO COMPONENT-LENGTH (I)
           END-PERFORM.
       A-020-EXIT.
           EXIT.
]