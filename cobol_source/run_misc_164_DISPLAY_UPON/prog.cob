IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           PRINTER IS PRINTER.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 note PIC X(05).
       PROCEDURE DIVISION CHAINING note.
       DISPLAY "This is sent to CONSOLE " note UPON CONSOLE.
       DISPLAY "This is sent to SYSERR  " note UPON SYSERR.
       DISPLAY "This is sent to PRINTER " note UPON PRINTER.
       DISPLAY "This is also sent to CONSOLE " note UPON CONSOLE.
       DISPLAY "This is also sent to SYSERR  " note UPON SYSERR.
       DISPLAY "This is also sent to PRINTER " note UPON PRINTER.
       DISPLAY "This is sent to SYSPUNCH " note UPON SYSPUNCH
            ON EXCEPTION DISPLAY 'NO ...'        UPON SYSERR.
       DISPLAY "This is also sent to SYSPUNCH " note UPON SYSPCH
            ON EXCEPTION DISPLAY ' ... SYSPUNCH' UPON SYSERR.
       STOP RUN RETURNING 0.