IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  test-var   pic xx.
           88  endOfFile value '10'.
       01  todo       pic xx.

       PROCEDURE DIVISION.
           if not endOfFile
              display 'all fine'
           end-if
           if test-var greater or equal todo
              display 'still fine'
           end-if
           .