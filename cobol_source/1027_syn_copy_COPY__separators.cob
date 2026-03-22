IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"
          REPLACING ==TEST-VAR==, BY ==FIRST-MATCH==,
                 ,  ==TEST-VAR==; BY ==SECOND-MATCH==;
                 ;  ==TEST-VAR== , BY ==THIRD-MATCH==
                    ==TEST-VAR== ; BY ==FOURTH-MATCH==.
       PROCEDURE        DIVISION.
           DISPLAY FIRST-MATCH NO ADVANCING
           END-DISPLAY.
           STOP RUN.