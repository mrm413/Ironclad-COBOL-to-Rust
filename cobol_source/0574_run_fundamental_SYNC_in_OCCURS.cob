IDENTIFICATION  DIVISION.
       PROGRAM-ID.     prog.

       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01 x.
           03  ptrs                     OCCURS 5 TIMES.
               05  misalign-1           PIC X.
               05  ptr                  POINTER, SYNC.
               05  ptr-num              REDEFINES ptr,
       >>IF P64 SET
                                        USAGE BINARY-DOUBLE UNSIGNED.
       >>ELSE
                                        USAGE BINARY-LONG UNSIGNED.
       >>END-IF
               05  misalign-2           PIC X.

       01  num                          BINARY-LONG.

       PROCEDURE       DIVISION.
           SET ptr (2) TO ADDRESS OF ptr (2)
           SET ptr (3) TO ADDRESS OF ptr (3)

           SUBTRACT ptr-num (2) FROM ptr-num (3) GIVING num
           DISPLAY FUNCTION MOD (num, FUNCTION LENGTH (ptr (1)))
           .