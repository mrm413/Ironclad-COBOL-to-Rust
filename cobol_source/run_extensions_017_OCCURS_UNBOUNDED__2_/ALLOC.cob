ID DIVISION.
        PROGRAM-ID. ALLOC.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
        WORKING-STORAGE SECTION.
        77  X   PIC  9(2) PACKED-DECIMAL.
        77  NUM-ELEMENTS PIC 9(4) BINARY.
        77  SIZE-NEEDED  PIC 9(4) BINARY.
        77  old-size     pic 9(4) binary.
        77  VPTR  POINTER.

        LINKAGE       SECTION.

        01  VARGRP.
          02  OBJ     PIC 9(4) COMP.
          02  TABGRP.
            03  VARTAB OCCURS 1 TO UNBOUNDED DEPENDING ON OBJ.
              04  T1      PIC 9(4).
              04  T2      PIC X(8).
              04  T3      PIC 9(4). *> changed from COMP because of output
        01 BUFFER         PIC X(1000).

       PROCEDURE DIVISION.

      *>    DISPLAY 'Starting testcase ALLOC'

           SET VPTR To NULL

      *************************************************************
      *  Allocate a table with 20 elements
      *************************************************************
           COMPUTE NUM-ELEMENTS = 20
           PERFORM ALLOC-VARGRP

      *************************************************************
      *  Set some 'test' values to validate re-allocated table
      *************************************************************
           initialize vartab(12), vartab(17)
           COMPUTE T1(12) = 9999
           MOVE 'HI MOM' TO T2 (17)
      *>   DISPLAY '  '
           DISPLAY 'VARTAB(12) = "' VARTAB(12) '"'
           DISPLAY 'VARTAB(17) = "' VARTAB(17) '"'
      *>   DISPLAY '  '

      *************************************************************
      *  Need a bigger table! Allocate a larger one and copy data
      *************************************************************
           COMPUTE NUM-ELEMENTS = 30
           PERFORM ALLOC-VARGRP

      *************************************************************
      *  Ensure that new table has correct data from original
      *************************************************************
           DISPLAY 'VARTAB(12) = "' VARTAB(12) '"'
           DISPLAY 'VARTAB(17) = "' VARTAB(17) '"'

           GOBACK.

      *************************************************************
      *  The first time allocate the original table.  If the table
      *  has already been allocated, assume that we are allocating
      *  a larger one and want to copy the data over to it
      *************************************************************
        ALLOC-VARGRP.

           If VPTR = NULL Then      *> If first time, allocate the table
             COMPUTE SIZE-NEEDED = LENGTH OF OBJ +
                                 LENGTH OF VARTAB * NUM-ELEMENTS
             display 'First allocation, using ' size-needed ' bytes.'
             ALLOCATE SIZE-NEEDED CHARACTERS INITIALIZED RETURNING VPTR

             SET ADDRESS OF VARGRP TO VPTR
             MOVE NUM-ELEMENTS TO OBJ
             move SIZE-NEEDED  to old-size

           Else                     *> If already have a table, doing re-size
      *********************************************************************
      * Re-size it!
      * First, map BUFFER on current table
      *********************************************************************

             SET ADDRESS OF BUFFER TO VPTR

      *********************************************************************
      * Calculate new size from NUM-ElEMENTS
      *********************************************************************
             COMPUTE SIZE-NEEDED = LENGTH OF OBJ +
                                   LENGTH OF VARTAB * NUM-ELEMENTS

             display 'Re-allocation, using ' size-needed ' bytes.'
      *>     ALLOCATE SIZE-NEEDED CHARACTERS INITIALIZED RETURNING VPTR
             if size-needed < 2097152
                ALLOCATE SIZE-NEEDED CHARACTERS INITIALIZED
                                                loc 24
                                                RETURNING VPTR
             else
                ALLOCATE SIZE-NEEDED CHARACTERS INITIALIZED
                                                loc 31
                                                RETURNING VPTR
             end-if

      *************************************************************
      * Move data from data save area to new larger table
      *************************************************************
             SET ADDRESS OF VARGRP TO VPTR
             MOVE NUM-ELEMENTS TO OBJ
             MOVE BUFFER(1:old-size) TO VARGRP
             move SIZE-NEEDED  to old-size
      *************************************************************
      * Free the original table
      ************************************************************
             SET VPTR TO ADDRESS OF BUFFER
             FREE VPTR
             .