IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 PROGRAM-LINK         USAGE PROGRAM-POINTER.

       PROCEDURE DIVISION.
       SET PROGRAM-LINK TO ENTRY "subprogram"
       IF PROGRAM-LINK EQUAL NULL THEN
           DISPLAY "error: no subprogram linkage" UPON SYSERR
           END-DISPLAY
       ELSE
           CALL PROGRAM-LINK
               ON EXCEPTION
                   DISPLAY "hard error: unable to invoke subprogram"
                      UPON SYSERR
                   END-DISPLAY
           END-CALL
           DISPLAY RETURN-CODE WITH NO ADVANCING
           END-DISPLAY
       END-IF
       GOBACK.

       ENTRY "subprogram".
           DISPLAY "subprogram" WITH NO ADVANCING
           END-DISPLAY
           SET RETURN-CODE TO 42
       .