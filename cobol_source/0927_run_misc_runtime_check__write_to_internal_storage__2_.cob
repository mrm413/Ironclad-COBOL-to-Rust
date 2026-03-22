IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 DUMMY-STORAGE             PIC  X(128).

       PROCEDURE DIVISION.
      *    using the var so cobc cannot easily optimize that out
           IF DUMMY-STORAGE (1:1) <> SPACE  INITIALIZE DUMMY-STORAGE.

      *    We use a simple wrapper to make it _less_ likely that the
      *    following "real test" SIGSEGVs during MOVE
           CALL STATIC "progt".

      *    we don't expect to ever get here - but this creates more
      *    memory space to decrease the likelyness of a SIGSEGV more
           CALL STATIC "dummy".

           GOBACK.
       END PROGRAM prog.

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    progt.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77 PNT USAGE POINTER EXTERNAL.

       01 REC.
          03  VAR                   PIC  X.
          03  VAR2                  PIC  X.

       LINKAGE SECTION.
       01 LREC.
          03  LVAR                  PIC  X(64).
          03  LVAR2                 PIC  X(64).

       PROCEDURE DIVISION.
      *    using a (not working) call prevents the C compiler
      *    to know that we (do not) change the pointer variable
      *    and therefore disallows it to check
      *    "that points to VAR2, you only have 2 bytes" (done with gcc -O)
           SET PNT TO ADDRESS OF VAR2.
           CALL "notthere" USING PNT ON EXCEPTION CONTINUE.
           SET ADDRESS OF LREC TO PNT.
           MOVE SPACES TO LREC.

           CALL "broken".

           GOBACK.
       END PROGRAM progt.

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    dummy.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 DUMMY-STORAGE             PIC  X(128).

       PROCEDURE DIVISION.
      *    using the var so cobc cannot easily optimize that out
           IF DUMMY-STORAGE (1:1) <> SPACE  INITIALIZE DUMMY-STORAGE.

           GOBACK.
       END PROGRAM dummy.