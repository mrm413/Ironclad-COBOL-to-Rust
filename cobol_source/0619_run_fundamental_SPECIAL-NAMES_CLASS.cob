IDENTIFICATION DIVISION.
       PROGRAM-ID. TSTCLASS.

       ENVIRONMENT  DIVISION.
       CONFIGURATION SECTION .
       SPECIAL-NAMES         .
       CLASS HEXA IS '0' THRU '9'
                     'A' THRU 'F' .
       CLASS ODD   IS '1' '3' '5' '7' '9'   .

      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *    NOTICE THAT THE VALUES SUPPLIED ARE NUMERIC LITERALS       *
      *    WHICH REPRESENT A VALUE WHICH IS 1 NUMBER HIGHER THAN      *
      *    THE HEX VALUES WHICH THEY REPRESENT. THIS IS BECAUSE       *
      *    THE ALLOWABLE VALUES ARE FROM 1 THROUGH 256.               *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

       CLASS EVEN  IS  49 51 53 55 57.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ALPHA       PIC X(01)  .
       01  NUM-1       PIC 9(01)  .
      *>
       PROCEDURE DIVISION.
      *>
           MOVE '3' TO ALPHA .
           IF ALPHA IS HEXA
           THEN
               CONTINUE
           ELSE
               DISPLAY 'ERROR 1'
           END-IF.
      *>
           IF ALPHA IS ODD
           THEN
               CONTINUE
           ELSE
               DISPLAY 'ERROR 2'
           END-IF.
      *>
           MOVE  2  TO NUM-1
           IF NUM-1 IS EVEN
           THEN
               CONTINUE
           ELSE
               DISPLAY 'ERROR 3'
           END-IF.
      *>
           GOBACK  .