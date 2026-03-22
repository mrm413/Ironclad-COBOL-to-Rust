IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc"  A.
       COPY "copy.inc"  ==A== BY B.
       COPY "copy.inc"  REPLACING.
       COPY "copy.inc"  REPLACING ABC.
       COPY "copy.inc"  REPLACING 'POST' IN.
       COPY "copy.inc"  REPLACING 'POST' BY BY.
       COPY "copy.inc"
             REPLACING ==some-name== BY ==other-name==
             REPLACING "some lit" BY "other literal".
       COPY "copy.inc".
       PROCEDURE        DIVISION.
           STOP RUN.