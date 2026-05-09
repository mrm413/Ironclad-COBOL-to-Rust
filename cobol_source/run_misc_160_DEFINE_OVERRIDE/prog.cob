IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       >>SET CONSTANT DOGGY "Pluto"
       >>SET CONSTANT PONY "Piper"
       WORKING-STORAGE SECTION.
       01  THEDOG    PIC X(6) VALUE DOGGY.

       >>DEFINE DPONY  AS PARAMETER OVERRIDE
       >>IF DPONY IS NOT DEFINED
       >>DEFINE DPONY AS "No Dpony"
       >>END-IF
       01  CNSPONY     CONSTANT FROM DPONY.

       >>DEFINE ENVPONY AS PARAMETER OVERRIDE
       >>IF ENVPONY IS NOT DEFINED
       >>DEFINE ENVPONY AS "No EnvPony"
       >>END-IF
       01  HORSE       CONSTANT FROM ENVPONY.
       77  MYHORSE    PIC X(12) VALUE HORSE  .
       77  MYPONYENV  PIC X(12).
      *
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "ENVPONY" UPON ENVIRONMENT-NAME
           ACCEPT  MYPONYENV FROM ENVIRONMENT-VALUE.
           DISPLAY "ENVPONY env var set to " MYPONYENV ";".
           DISPLAY "1st Dog's name is " DOGGY ";".
           DISPLAY "2nd Dog's name is " PONY ";".
       >>IF ENVPONY IS DEFINED
           DISPLAY "ENVPONY is DEFINED as " HORSE ";".
       >>ELSE
           DISPLAY "ENVPONY was NOT DEFINED;".
       >>END-IF
           DISPLAY "DPONY set to " CNSPONY ";".
       >>IF ENVPONY = "WHITE"
       >>DEFINE CONSTANT PONY AS "White Horse" OVERRIDE
       >>ELSE
       >>DEFINE CONSTANT PONY AS "default Dirty" OVERRIDE
       >>END-IF
           DISPLAY "My pony is " PONY ";".
       >>IF DPONY IS DEFINED
           DISPLAY "DPONY is DEFINED as " CNSPONY ";".
       >>END-IF
           STOP RUN.