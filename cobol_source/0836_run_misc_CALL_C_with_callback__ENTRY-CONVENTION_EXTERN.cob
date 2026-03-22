IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 CB            USAGE PROGRAM-POINTER.
       PROCEDURE        DIVISION.
           SET CB TO ENTRY "callback"
           CALL STATIC "cprog" USING BY VALUE CB
           END-CALL
           EXIT PROGRAM.
       END PROGRAM prog.

       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callback.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CALL-CONVENTION 0 IS EXTERN.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 P1            USAGE POINTER.
       01 P2            USAGE BINARY-LONG.
       01 P3            PIC X(8).
       PROCEDURE        DIVISION EXTERN
                        USING BY VALUE P1 P2 BY REFERENCE P3.
           IF P1 NOT EQUAL ADDRESS OF P3
              DISPLAY P1
              END-DISPLAY
           END-IF
           IF P2 NOT EQUAL 42
              DISPLAY P2
              END-DISPLAY
           END-IF
           IF P3 NOT EQUAL "CALLBACK"
              DISPLAY P3
              END-DISPLAY
           END-IF
           EXIT PROGRAM.