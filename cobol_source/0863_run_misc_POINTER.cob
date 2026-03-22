IDENTIFICATION   DIVISION.
       PROGRAM-ID. prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 XX.
         02 XX-1           PIC X(4) VALUE "1234".
         02 XX-2           PIC X(4) VALUE "5678".
       01 P-XX-1        POINTER.
       01 P-XX-2        POINTER.
       LINKAGE          SECTION.
       01 Y2            PIC X(4).
       PROCEDURE        DIVISION.
         SET P-XX-1 TO ADDRESS OF XX-1
         SET P-XX-2 TO ADDRESS OF XX-2
         SET ADDRESS OF Y2 TO ADDRESS OF XX-1
         SET ADDRESS OF Y2 UP BY 4
         IF Y2 NOT = XX-2
            DISPLAY "Test 2 '" Y2 "'"
            END-DISPLAY
         END-IF
         IF ADDRESS OF Y2 NOT = P-XX-2
            DISPLAY "NOK"
         END-IF
         STOP RUN.