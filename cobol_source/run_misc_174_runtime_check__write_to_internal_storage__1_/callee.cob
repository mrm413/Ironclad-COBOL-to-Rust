IDENTIFICATION DIVISION.
       PROGRAM-ID.    callee.

       DATA DIVISION.
       LINKAGE SECTION.

       77 var                   PIC  X.
       01 lrec.
          03  lvar                  PIC  X(32).
          03  lvar2                 PIC  X(32).

       PROCEDURE DIVISION USING var.
      *
           SET ADDRESS OF lrec TO ADDRESS OF var
           SET ADDRESS OF lrec DOWN BY 32
           MOVE SPACES TO lrec
           GOBACK.