IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           *> Valid forms
           DISPLAY %17 %37777777777 %456

           *> invalid forms
           DISPLAY %11111111111111111111111
           DISPLAY %89

           STOP RUN.