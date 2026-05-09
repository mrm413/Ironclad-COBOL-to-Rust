IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       PROCEDURE        DIVISION.
           *> Test of auto size, identical to SIZE AUTO
           CALL "prog2" USING BY VALUE 4 0 0 1 0
           END-CALL

           *> Test of explicit SIZE syntax
           CALL "prog2" USING BY VALUE 1 SIZE 1 2 0 0 0
           END-CALL
           CALL "prog2" USING BY VALUE 2 0 SIZE 2 3 0 0
           END-CALL
           CALL "prog2" USING BY VALUE 4 0 0 SIZE 4 4 0
           END-CALL
           CALL "prog2" USING BY VALUE 8 0 0 0 SIZE 8 5
           END-CALL
           CALL "prog2" USING BY VALUE 4 0 0 SIZE DEFAULT 6 0
           END-CALL
           CALL "prog2" USING BY VALUE 4 0 0 SIZE AUTO    7 0
           END-CALL
           *> test for SIZE AUTO with VALUE > INT_MAX is non-portable

           *> Test of explicit UNSIGNED SIZE syntax
           CALL "prog2" USING BY VALUE 1 UNSIGNED SIZE 1 2 0 0 0
           END-CALL
           CALL "prog2" USING BY VALUE 2 0 UNSIGNED SIZE 2 3 0 0
           END-CALL
           CALL "prog2" USING BY VALUE 4 0 0 UNSIGNED SIZE 4 4 0
           END-CALL
           CALL "prog2" USING BY VALUE 8 0 0 0 UNSIGNED SIZE 8 5 0
           END-CALL
           CALL "prog2" USING BY VALUE 4 0 0 UNSIGNED SIZE AUTO 6 0
           END-CALL
           *> test for SIZE AUTO with VALUE > INT_MAX is non-portable

           *> Test of MF size syntax
           *>CALL "prog2" USING BY VALUE 2 SIZE 1
           *>END-CALL
           *>CALL "prog2" USING BY VALUE 3 SIZE 2
           *>END-CALL
           *>CALL "prog2" USING BY VALUE 4 SIZE 4
           *>END-CALL
           *>CALL "prog2" USING BY VALUE 5 SIZE 8
           *>END-CALL

           STOP RUN.
       END PROGRAM prog. *> FIXME: C compile warnings when moved to end (nested programs)

       PROGRAM-ID.      prog2.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01  LEN          USAGE BINARY-LONG.
       01  VAR-1        USAGE BINARY-CHAR.
       01  VAR-2        USAGE BINARY-SHORT.
       01  VAR-4        USAGE BINARY-LONG.
       01  VAR-8        USAGE BINARY-DOUBLE.
       PROCEDURE        DIVISION USING BY VALUE LEN
                                                SIZE 1 VAR-1
                                                SIZE 2 VAR-2
                                                SIZE 4 VAR-4
                                                SIZE 8 VAR-8.
           EVALUATE len
              WHEN 1
                 DISPLAY '1: ' VAR-1 END-DISPLAY
              WHEN 2
                 DISPLAY '2: ' VAR-2 END-DISPLAY
              WHEN 4
                 DISPLAY '4: ' VAR-4 END-DISPLAY
              WHEN 8
                 DISPLAY '8: ' VAR-8 END-DISPLAY
           END-EVALUATE
           EXIT PROGRAM.
       END PROGRAM prog2.