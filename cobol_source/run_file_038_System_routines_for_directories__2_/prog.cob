IDENTIFICATION      DIVISION.
       PROGRAM-ID.         prog.

       DATA                DIVISION.
       WORKING-STORAGE     SECTION.
       01  fh              PIC X(4) COMP-5.
       01  rb              PIC X(8) COMP-X.
       01  cb-bfr          PIC X(4) COMP-X VALUE 16.
       01  w-dirname-1     PIC X(4) VALUE "tmp1".
       01  w-dirname-2     PIC X(9) VALUE "tmp1/tmp2".
       01  w-dirname-3     PIC X(14) VALUE "tmp1/tmp2/tmp3".
       01  w-filename      PIC X(20) VALUE "tmp1/tmp2/tmp3/file1".
       01  w-finfo         PIC X(16).

       PROCEDURE DIVISION.
           CALL "CBL_CREATE_DIR" USING w-dirname-1.
           IF RETURN-CODE <> 0
              DISPLAY "FAILED 1: CBL_CREATE_DIR (res=" RETURN-CODE ")"
           END-IF

           CALL "CBL_CREATE_DIR" USING w-dirname-2.
           IF RETURN-CODE <> 0
              DISPLAY "FAILED 2: CBL_CREATE_DIR (res=" RETURN-CODE ")"
           END-IF

      *    Should fail because directory does NOT exists yet.
           CALL "CBL_CREATE_FILE"
              USING w-filename, 1, 0, 0, fh.
           IF RETURN-CODE <> 35
              DISPLAY "FAILED 3: CBL_CREATE_FILE expected fail (res="
                      RETURN-CODE ")"
              IF RETURN-CODE = ZERO
                 CALL "CBL_CLOSE_FILE" USING fh
              END-IF
           END-IF

           CALL "CBL_CREATE_DIR" USING w-dirname-3.
           IF RETURN-CODE <> 0
              DISPLAY "FAILED 4: CBL_CREATE_DIR (res=" RETURN-CODE ")"
           END-IF

           CALL "CBL_CREATE_FILE"
              USING w-filename, 1, 0, 0, fh.
           IF RETURN-CODE <> 0
              DISPLAY "FAILED 5: CBL_CREATE_FILE (res="
                      RETURN-CODE ")"
           END-IF

           CALL "CBL_CLOSE_FILE" USING fh.
           IF RETURN-CODE <> 0
              DISPLAY "FAILED 6: CBL_CLOSE_FILE (res="
                      RETURN-CODE ")"
           END-IF

           CALL "CBL_CHECK_FILE_EXIST" USING w-filename, w-finfo.
           IF RETURN-CODE <> 0
              DISPLAY "FAILED 7: CBL_CHECK_FILE_EXIST (res="
                      RETURN-CODE ")"
           END-IF


      *    Should fail because directory is NOT empty.
           CALL "CBL_DELETE_DIR" USING w-dirname-1.
           IF RETURN-CODE = 0
              DISPLAY "FAILED 8: CBL_DELETE_DIR EXPECTED TO FAIL"
           END-IF
      ***********************
      * TO-DO: IMPLEMENT CBL_PURGE_DIR? NOT IN MF OR ACU.
      ***********************
      *    Remove all files (including sub-directories) in tmp1
      *    CALL "CBL_PURGE_DIR" USING w-dirname-1.
      *    IF RETURN-CODE <> 0
      *        DISPLAY "FAILED 9: CBL_PURGE_DIR (res=" RETURN-CODE ")"
      *  END-IF
      *
      *     Should succeed because directory is NOW empty.
      *     CALL "CBL_DELETE_DIR" USING w-dirname-1.
      *     IF RETURN-CODE <> 0
      *         DISPLAY "FAILED 10: CBL_DELETE_DIR (res=" RETURN-CODE ")"
      *     END-IF

           STOP RUN NORMAL
           .