IDENTIFICATION DIVISION.
       FUNCTION-ID. reply.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 arg-len   USAGE BINARY-LONG.
       LINKAGE SECTION.
       01 argument  PIC X ANY LENGTH.
       01 result.
          05 filler PIC X OCCURS 0 to 999 DEPENDING ON arg-len.
       PROCEDURE DIVISION USING BY REFERENCE argument RETURNING result.
           MOVE FUNCTION LENGTH (argument) TO arg-len
           MOVE argument TO result.
       END FUNCTION reply.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION reply.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  arg   pic x(100).

       PROCEDURE DIVISION.
      *>
           IF not (FUNCTION         REPLY ("test")  = "test"
               and FUNCTION LENGTH (REPLY ("test")) = 4     )
              DISPLAY "'test' failed: "
                     FUNCTION LENGTH (REPLY ("test")) " #"
                     FUNCTION         REPLY ("test")  "#".
      *>
           IF not (FUNCTION         REPLY ("test   ")  = "test"
               and FUNCTION LENGTH (REPLY ("test   ")) = 7     )
              DISPLAY "'test   ' failed: "
                     FUNCTION LENGTH (REPLY ("test   ")) " #"
                     FUNCTION         REPLY ("test   ")  "#".
      *>
           IF not (FUNCTION         REPLY (arg)  = spaces
               and FUNCTION LENGTH (REPLY (arg)) = 100 )
              DISPLAY "empty arg failed: "
                     FUNCTION LENGTH (REPLY (arg)) " #"
                     FUNCTION         REPLY (arg)  "#".
      *>
           MOVE "echo this" to arg
           IF not (FUNCTION         REPLY (arg)  = arg
               and FUNCTION LENGTH (REPLY (arg)) = 100 )
              DISPLAY "echo arg failed: "
                     FUNCTION LENGTH (REPLY (arg)) " #"
                     FUNCTION         REPLY (arg)  "#".
      *>
           MOVE z"echo this" to arg
           IF not (FUNCTION         REPLY (arg)  = arg
               and FUNCTION LENGTH (REPLY (arg)) = 100 )
              DISPLAY "z'echo arg failed: "
                     FUNCTION LENGTH (REPLY (arg)) " #"
                     FUNCTION         REPLY (arg)  "#".
      *>
           GOBACK
           .
       END PROGRAM prog.