IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2.
       DATA             DIVISION.
       LINKAGE          SECTION.
       01 LNK-X         PIC XXX.
       PROCEDURE        DIVISION USING LNK-X.
           DISPLAY LNK-X NO ADVANCING.
           EXIT PROGRAM.