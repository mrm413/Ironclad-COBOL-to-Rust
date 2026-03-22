#       IDENTIFICATION   DIVISION.
#       PROGRAM-ID.      prog.
#       DATA             DIVISION.
#       WORKING-STORAGE  SECTION.
#       01  x PIC X.
#       66  y RENAMES x OCCURS 10.
#         88  y VALUE "a" OCCURS 10.
#         78  y VALUE "a" OCCURS 10.
#