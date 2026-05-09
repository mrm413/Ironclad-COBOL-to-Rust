>>DEFINE CONSTANT DOGGY "Barky"
       >>DEFINE CONSTANT PONY "Blacky"
       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog3.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  THEDOG    PIC X(6) VALUE DOGGY.
       77  MYHORSE   PIC X(7) VALUE PONY.
       >>DEFINE CONSTANT PONY "White" OVERRIDE
      *
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "Your Dog's name is " DOGGY ";".
           DISPLAY "The Dog's name is " THEDOG ";".
           DISPLAY "My Horse is " MYHORSE ";".
           DISPLAY "My little pony is " PONY ".".
           STOP RUN.