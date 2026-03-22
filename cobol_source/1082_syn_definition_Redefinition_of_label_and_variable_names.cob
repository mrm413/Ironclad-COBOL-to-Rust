identification division.
       program-id. WORD.
       data division.
       working-storage section.
      *-----------------------------------------------------------------
       77 word pic 9.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       main section.
      *
           move 0 to word
           perform word
      *
           stop run returning word.
      *-----------------------------------------------------------------
       word section.
           add 1 to word.