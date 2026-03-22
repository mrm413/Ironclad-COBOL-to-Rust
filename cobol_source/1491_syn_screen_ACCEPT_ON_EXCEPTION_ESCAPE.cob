IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  foo          PIC X.
       PROCEDURE        DIVISION.
           ACCEPT foo
               ON EXCEPTION
                   CONTINUE
               NOT EXCEPTION
                   CONTINUE
           END-ACCEPT

           ACCEPT foo
               ESCAPE
                   CONTINUE
               NOT ON ESCAPE
                   CONTINUE
           END-ACCEPT
           .