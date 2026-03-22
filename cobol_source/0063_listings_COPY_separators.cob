IDENTIFICATION   DIVISION.                                        PROG001
       PROGRAM-ID.      prog.                                            PROG002
       DATA             DIVISION.                                        PROG003
       WORKING-STORAGE  SECTION.                                         PROG004
       COPY "copy.inc"                                                   PROG005
          REPLACING ==TEST-VAR==, BY ==FIRST-MATCH==,                    PROG006
                 ,  ==TEST-VAR==; BY ==SECOND-MATCH==;                   PROG007
                 ;  ==TEST-VAR== , BY ==THIRD-MATCH==                    PROG008
                    ==TEST-VAR== ; BY ==FOURTH-MATCH==.                  PROG009
       PROCEDURE        DIVISION.                                        PROG010
           DISPLAY FIRST-MATCH NO ADVANCING                              PROG011
           END-DISPLAY.                                                  PROG012
           STOP RUN.                                                     PROG013