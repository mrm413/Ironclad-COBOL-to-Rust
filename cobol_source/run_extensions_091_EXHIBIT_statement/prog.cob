IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       77 VAR-1         PIC X(8) VALUE SPACES.
       77 VAR-2         PIC 999.
       PROCEDURE        DIVISION.
           EXHIBIT CHANGED VAR-1 'X'
           MOVE ALL 'X' TO VAR-1
           STRING "123" DELIMITED BY SIZE INTO VAR-1
           EXHIBIT NAMED VAR-1 VAR-2 'Y'
           EXHIBIT VAR-2
           EXHIBIT SORT-RETURN TALLY
           STOP RUN.