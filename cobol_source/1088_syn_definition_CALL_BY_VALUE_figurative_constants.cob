IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           CALL "PROG2" USING BY VALUE
                low-value
                high-value
                space
                quote
                zero
           END-CALL.
           CALL "PROG2" USING
                low-value
                high-value
                space
                quote
                zero
           END-CALL.
           CALL "PROG3" USING
                null
           END-CALL.
           STOP RUN.