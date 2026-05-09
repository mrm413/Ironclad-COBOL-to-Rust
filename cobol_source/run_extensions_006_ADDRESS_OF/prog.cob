IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 X-1           PIC X(3) VALUE "X-1".
       01 X-2           PIC X(3) VALUE "X-2".
       01 G.
         02 PTR-1       USAGE POINTER VALUE NULL.
         02 PTR-2       USAGE POINTER VALUE NULL.
       LINKAGE          SECTION.
       01 Y             PIC X(3).
       PROCEDURE        DIVISION.
         SET ADDRESS OF Y TO ADDRESS OF X-1.
         IF Y NOT = "X-1"
            DISPLAY "Test 1 " Y
            END-DISPLAY
         END-IF.
         SET PTR-1 TO ADDRESS OF X-2.
         SET PTR-2 TO PTR-1
         SET ADDRESS OF Y TO PTR-2.
         IF Y NOT = "X-2"
            DISPLAY "Test 2 " Y
            END-DISPLAY
         END-IF
         INITIALIZE PTR-1.
         IF PTR-1 NOT = NULL
           DISPLAY "NG 1"
           END-DISPLAY
         END-IF.
         SET ADDRESS OF Y TO NULL.
         IF PTR-1 NOT = ADDRESS OF Y
           DISPLAY "NG 2"
           END-DISPLAY
         END-IF.
         IF ADDRESS OF Y NOT = PTR-1
           DISPLAY "NG 3"
           END-DISPLAY
         END-IF.