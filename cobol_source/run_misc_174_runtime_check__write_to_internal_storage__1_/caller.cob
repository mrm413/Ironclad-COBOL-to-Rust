IDENTIFICATION DIVISION.
       PROGRAM-ID.    caller.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 var                   PIC  X.
       01 vars.
          03 filler             PIC  X.
          03 vars-field         PIC  X.

       01 varg                  GLOBAL.
          03 filler             PIC  X.
          03 varg-field         PIC  X.
       01 vare                  EXTERNAL.
          03 filler             PIC  X.
          03 vare-field         PIC  X.
       01 varb                  BASED.
          03 filler             PIC  X.
          03 varb-field         PIC  X.
       LINKAGE SECTION.
       01 varl                  PIC  X.
       01 varls.
          03 filler             PIC  X.
          03 varls-field        PIC  X.

       PROCEDURE DIVISION.
      *
           CALL "callee" USING var
      *    without the check this second call would SIGSEGV
           CALL "callee" USING var

      *    the following are mostly in to co-test the codegen
           CALL "callee" USING vars
           CALL "callee" USING varg
           CALL "callee" USING vare
           CALL "callee" USING varb
           CALL "callee" USING varl
           CALL "callee" USING varls
           CALL "callee" USING vars-field
           CALL "callee" USING varg-field
           CALL "callee" USING vare-field
           CALL "callee" USING varb-field
           CALL "callee" USING varls-field

           GOBACK.