IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  I            PIC 99.
       01  J            PIC 99.
       01  K            PIC 99.
       01  VLEN         PIC 99.
       01  VTOP.
           03 VGROUP.
             05  VX     OCCURS 1 TO 5 DEPENDING ON I.
               10 VXX   PIC X(1).
             05  VY     OCCURS 1 TO 5 DEPENDING ON J.
               10 VYY   PIC X(2).
             05 ZZ      OCCURS 1 TO 5 DEPENDING ON K.
               10 VZZ   PIC X(3).
             05  VFIX   PIC X(3).
       PROCEDURE        DIVISION.
           MOVE    1      TO I.
           MOVE    1      TO J.
           MOVE    1      TO K.
           MOVE    '1'    TO VXX (1).
           MOVE    '22'   TO VYY (1).
           MOVE    '333'  TO VZZ (1).
           MOVE    '444'  TO VFIX.
           MOVE    LENGTH OF VGROUP         TO VLEN.
           DISPLAY VLEN   NO ADVANCING
           END-DISPLAY.
           MOVE    FUNCTION LENGTH (VGROUP) TO VLEN.
           DISPLAY VLEN   NO ADVANCING
           END-DISPLAY.
           DISPLAY VGROUP
           END-DISPLAY.
           INITIALIZE     VTOP.
           MOVE    3      TO I.
           MOVE    2      TO J.
           MOVE    1      TO K.
           MOVE    '3'    TO VXX (3).
           MOVE    '22'   TO VYY (2).
           MOVE    '111'  TO VZZ (1).
           MOVE    '000'  TO VFIX.
           MOVE    LENGTH OF VGROUP         TO VLEN.
           DISPLAY VLEN   NO ADVANCING
           END-DISPLAY.
           MOVE    FUNCTION LENGTH (VGROUP) TO VLEN.
           DISPLAY VLEN   NO ADVANCING
           END-DISPLAY.
           DISPLAY VGROUP
           END-DISPLAY.
           STOP RUN.