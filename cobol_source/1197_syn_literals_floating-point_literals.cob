IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           *> Valid literals
           DISPLAY 1.0E6144, +1.0E+3, +1.0E-6143, 123.E1,
               +.123456789012345678901234567890123456E+0000
           END-DISPLAY

           *> invalid literals
           DISPLAY 1.0D3 END-DISPLAY
           DISPLAY 1E3 END-DISPLAY
           DISPLAY '1.0E3'BLAH END-DISPLAY
           DISPLAY 1.0E3.0 END-DISPLAY
           DISPLAY -0.0E-0 END-DISPLAY
           DISPLAY 1.0E00003 END-DISPLAY
           DISPLAY .123456789012345678901234567890123456789E0
           END-DISPLAY
           DISPLAY 0.0E3 END-DISPLAY

           *> Implementor-defined invalid literals
           DISPLAY 1.0E6145 END-DISPLAY
           DISPLAY 1.0E-6144 END-DISPLAY

           STOP RUN.