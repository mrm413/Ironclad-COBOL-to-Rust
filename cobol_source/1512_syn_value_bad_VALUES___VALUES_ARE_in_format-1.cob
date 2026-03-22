IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * explicit testing in sub-fields to ensure parsing goes on
       01  WS.
           10  SEPX   PICTURE XX VALUES     ", ".
           10  SEPL   PICTURE X  VALUE      LOW-VALUE.
           10  BADIS  PICTURE 9  VALUE  ARE 1.
           10  BADARE PICTURE 9  VALUES IS  2.
           10  DAYS   PICTURE 99 VALUES ARE 31.
           10  MONTHS PICTURE 99 VALUE  IS  12.
           10  NO-OCCURS   PICTURE 99 VALUES ARE 08 15.

       PROCEDURE DIVISION.
           DISPLAY DAYS SEPX MONTHS SEPL.
           GOBACK.