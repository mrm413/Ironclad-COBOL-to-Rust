IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 STDIN    USAGE POINTER.
       01 STDOUT   USAGE POINTER.
       01 STDERR   USAGE POINTER.
       01 CELL     USAGE BINARY-LONG.
       01 ARGC     USAGE BINARY-LONG.
       01 ARGV     USAGE POINTER.
       01 ERRPTR   USAGE POINTER.
       01 ERRNO    USAGE BINARY-LONG BASED.
       01 CERRNO   USAGE BINARY-LONG EXTERNAL AS "errno".
       01 TZNAME   USAGE POINTER.
       01 TZNAMES  USAGE POINTER BASED.
          05 TZS      USAGE POINTER OCCURS 2 TIMES.
       01 TIMEZONE USAGE BINARY-C-LONG.
       01 DAYLIGHT USAGE BINARY-LONG.
       01 EXTPTR   USAGE POINTER. *> only for the check, otherwise unused

       PROCEDURE DIVISION.
           CALL "CBL_GC_HOSTED" USING STDIN "stdin"
           CALL "CBL_GC_HOSTED" USING STDOUT "stdout"
           CALL "CBL_GC_HOSTED" USING STDERR "stderr"
      *> verify working alias with old name "CBL_OC_HOSTED"
           CALL "CBL_OC_HOSTED" USING ARGC "argc"
           CALL "CBL_OC_HOSTED" USING ARGV "argv"
           CALL "CBL_GC_HOSTED" USING CELL "cell"
           CALL "CBL_GC_HOSTED" USING ERRPTR "errno"
           CALL "CBL_GC_HOSTED" USING ARGC "arg"
           CALL "CBL_GC_HOSTED" USING NULL "argc"
           SET ADDRESS OF ERRNO TO ERRPTR
           CALL "CBL_GC_HOSTED" USING TZNAME "tzname"
           CALL "CBL_GC_HOSTED" USING TIMEZONE "timezone"
           CALL "CBL_GC_HOSTED" USING DAYLIGHT "daylight"

      *> prog.cob must be compiled with same C runtime as libcob to match...
           IF ERRPTR NOT EQUAL ADDRESS OF CERRNO
              DISPLAY "ADDRESS OF ERRNO VARIABLES DON'T MATCH"
              SET EXTPTR TO ADDRESS OF CERRNO
              DISPLAY "HOSTED: "   ERRPTR ", "
                      "EXTERNAL: " EXTPTR
              END-DISPLAY
           END-IF

      *> test_errno.c must be compiled with same C runtime as libcob to match...
           CALL "test_errno"
           IF ERRNO NOT EQUAL 2 THEN
              DISPLAY "BAD HOSTED ERRNO " ERRNO
              IF CERRNO NOT EQUAL 2 THEN
                 DISPLAY "BAD EXTERNAL ERRNO " CERRNO
              END-IF
           END-IF

           IF ARGC NOT EQUAL 2 THEN
              DISPLAY "BAD ARGC " ARGC
           END-IF
           IF ARGV EQUAL NULL THEN
              DISPLAY "BAD ARGV"
           END-IF

           IF CELL LESS THAN 0 OR GREATER THAN 8 THEN
              DISPLAY "UNK CELL " CELL
           END-IF

           SET ENVIRONMENT "TZ" TO "PST8PDT"
           CALL "tzset" RETURNING OMITTED
              ON EXCEPTION CONTINUE
           END-CALL
           IF TZNAME NOT EQUAL NULL THEN
              SET ADDRESS OF TZNAMES TO TZNAME
              IF TZS(1) EQUAL NULL THEN
                 DISPLAY "BAD TZNAME" END-DISPLAY
              END-IF
           END-IF

      *> Test assumes return-code will be 3, chars output by last fprintf
      *> test_stdio.c must be compiled with same C runtime as libcob to match...
           CALL "test_stdio" USING BY VALUE STDIN STDOUT STDERR
           END-CALL

           STOP RUN.