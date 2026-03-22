IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01 ttab.
          03 tentries   PIC 9 VALUE 0.
          03 tentry     OCCURS 0 TO 5    DEPENDING ON tentries
                        ASCENDING KEY tkey INDEXED BY tidx.
             05 tkey    pic x(3).
       78 ZER  VALUE ZERO.
      *>
       PROCEDURE        DIVISION.
           READY TRACE
           MOVE 1 TO RETURN-CODE
           RESET TRACE
           CALL "callee1"
           END-CALL
           READY TRACE
           MOVE 2 TO RETURN-CODE
           CALL "callee1"
           END-CALL
           CALL "callee1"
           CANCEL "callee1"
           CALL "callrec"
           MOVE 0 TO RETURN-CODE
      *>
           SEARCH ALL tentry
              AT END
                 ADD  1    TO tentries
                 SET  tidx TO tentries
                 MOVE 'A'  TO tkey(tidx)
              WHEN tkey(tidx) = 'A'
                 DISPLAY '*Magic*'
           END-SEARCH
      *> tidx is still one, expect a direct find
           SEARCH tentry
              AT END
                 DISPLAY '*Dark Magic*'
              WHEN tkey(tidx) = 'A'
                 ADD  1    TO tentries
                 SET  tidx TO tentries
                 MOVE 'B'  TO tkey(tidx)
           END-SEARCH
      *> tidx is still two, expect end
           SEARCH tentry
              VARYING tidx
              AT END
                 ADD  1    TO tentries
                 SET  tidx TO tentries
                 MOVE 'C'  TO tkey(tidx)
              WHEN tkey(tidx) = ZER
                 DISPLAY '* Darker Magic *'
           END-SEARCH
           SEARCH ALL tentry
              AT END
                 DISPLAY 'NO COMMENT'
              WHEN tkey(tidx) = 'C'
                 CONTINUE
           END-SEARCH
           SEARCH ALL tentry
              WHEN tkey(tidx) = 'X'
                 CONTINUE
           END-SEARCH
      *>
           STOP RUN.