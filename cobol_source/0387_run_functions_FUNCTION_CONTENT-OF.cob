IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  P   USAGE    POINTER.
       01  X   PIC      X(4) VALUE Z"ABC".
       01  B   PIC      X(10) BASED.
       PROCEDURE        DIVISION.
           SET P TO ADDRESS OF X
           IF FUNCTION CONTENT-OF ( P ) NOT EQUAL 'ABC' THEN
              DISPLAY 'CONTENT-OF(ptr) wrong' END-DISPLAY
           END-IF
           IF FUNCTION CONTENT-OF ( P, 2 ) NOT EQUAL 'AB' THEN
              DISPLAY 'CONTENT-OF(ptr, len) wrong' END-DISPLAY
           END-IF
           IF FUNCTION EXCEPTION-STATUS NOT = SPACES THEN
              DISPLAY 'unexpected exception (1): '
                       FUNCTION EXCEPTION-STATUS
              END-DISPLAY
           END-IF
           SET  P      TO NULL
           MOVE 'PPPP' TO X
           STRING FUNCTION CONTENT-OF ( P )
                  DELIMITED BY SIZE
                  INTO X
           END-STRING
      *>   Note: result *should* depend on dialect option zero-length literals
           IF X NOT EQUAL 'PPPP' THEN
              DISPLAY 'CONTENT-OF empty POINTER wrong: "' X "'"
              END-DISPLAY
           END-IF
           IF FUNCTION EXCEPTION-STATUS NOT = "EC-DATA-PTR-NULL" THEN
              DISPLAY 'missing exception (1)'
              END-DISPLAY
           END-IF
           ALLOCATE B INITIALIZED
           SET  P      TO ADDRESS OF B
           IF FUNCTION CONTENT-OF ( P, 1 ) NOT EQUAL SPACES THEN
              DISPLAY 'CONTENT-OF allocated BASED item wrong'
              END-DISPLAY
           END-IF
           IF FUNCTION EXCEPTION-STATUS NOT = SPACES THEN
              DISPLAY 'unexpected exception (2): '
                       FUNCTION EXCEPTION-STATUS
              END-DISPLAY
           END-IF
           FREE B
           SET  P      TO ADDRESS OF B
           MOVE 'BBBB' TO X
           STRING FUNCTION CONTENT-OF ( P )
                  DELIMITED BY SIZE
                  INTO X
           END-STRING
      *>   Note: result *should* depend on dialect option zero-length literals
           IF X NOT EQUAL 'BBBB' THEN
              DISPLAY 'CONTENT-OF unallocated BASED item wrong: "' X '"'
              END-DISPLAY
           END-IF
           IF FUNCTION EXCEPTION-STATUS NOT = "EC-DATA-PTR-NULL" THEN
              DISPLAY 'missing exception (2)'
              END-DISPLAY
           END-IF
           STOP RUN.