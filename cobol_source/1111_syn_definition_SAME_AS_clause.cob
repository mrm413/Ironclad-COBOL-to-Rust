IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MESSAGE-TEXT-2.
         02 AUSGABE-FILE-NAME                 PIC X(50).
         02 F1         SAME AS MESSAGE-TEXT-2.
       01 MT2          SAME AS MESSAGE-TEXT-2.
             05 FILLER                        PIC 9999.
       01 MT3          SAME AS MESSAGE-TEXT-2 PIC X.
       77 OUTPUT-NAME  SAME AS MESSAGE-TEXT-2.