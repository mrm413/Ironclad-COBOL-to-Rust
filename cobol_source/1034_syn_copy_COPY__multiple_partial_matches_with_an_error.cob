IDENTIFICATION   DIVISION. 
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION. 
       01 GET-VALUE.
       COPY "copy.inc" REPLACING ==TEST-VAR==     BY ==TEST-AVR==
                                 == 02 TEST-OK == BY == 02 TEST-KO ==
                                 ==TEST-CC==      BY ==TEST-DD==
                                 == 02 TEST-EE == BY == 02 TEST-FF ==
                                 == PIC ==        BY == pic ==.
       PROCEDURE DIVISION.
       main.
           DISPLAY TEST-AVR.
           DISPLAY TEST-AVR-BIS.
           DISPLAY TEST-KO.
           DISPLAY TEST-DD.
           DISPLAY TEST-FF.
           STOP RUN.