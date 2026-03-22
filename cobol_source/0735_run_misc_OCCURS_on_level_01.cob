IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 XX PIC 99 VALUE 5.
       01 X             PIC X OCCURS 0 TO 10
                        DEPENDING ON XX VALUE "A".
       LINKAGE SECTION.
       01 X-ALL         PIC X(10).
       PROCEDURE        DIVISION.
           MOVE ZERO TO X(2) X(4) X(6) X(8)
           INITIALIZE   X(1) X(3) X(5) X(7)
           SET ADDRESS OF X-ALL TO ADDRESS OF X(1)
           IF X-ALL NOT = " 0 0 0 0AA"
              DISPLAY X-ALL UPON SYSERR.
           STOP RUN.