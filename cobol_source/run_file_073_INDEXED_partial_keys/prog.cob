IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL f ASSIGN "fileX"
               ORGANIZATION INDEXED
               ACCESS DYNAMIC
               RECORD KEY f-key1
               ALTERNATE RECORD f-key2
               ALTERNATE RECORD f-key3 DUPLICATES
               STATUS f-status.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-rec.
           02  f-key1.
               03  f-key1-1 PIC X(3).
               03  f-key1-2 PIC X(3).
           02  f-key2.
               03  f-key2-1 PIC X(3).
               03  f-key2-2 PIC X(3).
           02  f-key3.
               03  f-key3-1 PIC X(3).
               03  f-key3-2 PIC X(3).
           02  file1-serial PIC 99.

       WORKING-STORAGE SECTION.
       01  f-status PIC XX.
       01  w-serial PIC 99 VALUE 0.

       PROCEDURE DIVISION.
           DELETE FILE f
           OPEN I-O f
           MOVE "AAAAAAaaaaaaXX----" TO f-rec
           PERFORM write-f
           MOVE "AAAAABaaaaabXX----" TO f-rec
           PERFORM write-f
           MOVE "AAAABBaaaabbXX----" TO f-rec
           PERFORM write-f
           MOVE "AAABBBaaabbbXXX---" TO f-rec
           PERFORM write-f
           MOVE "AABBBBaabbbbXXX---" TO f-rec
           PERFORM write-f
           MOVE "ABBBBBabbbbbXXX---" TO f-rec
           PERFORM write-f
           MOVE "BBBBBBbbbbbbXXX---" TO f-rec
           PERFORM write-f

           MOVE "AAB" TO f-key1-1
           MOVE "~~~" TO f-key1-2
           START f KEY = f-key1-1
           READ f NEXT
           IF (f-status <> "00") OR
                   (file1-serial <> 4)
               DISPLAY "FAILED 1: status " f-status "-"
                       "serial: " file1-serial
           END-IF

           MOVE "AAB" TO f-key1-1
           MOVE "~~~" TO f-key1-2
           START f KEY < f-key1-1
           READ f PREVIOUS
           IF (f-status <> "00") OR
                   (file1-serial <> 3)
               DISPLAY "FAILED 2: status " f-status "-"
                       "serial: " file1-serial
           END-IF

           MOVE "AAA" TO f-key1-1
           MOVE "~~~" TO f-key1-2
           START f KEY > f-key1-1
           READ f NEXT
           IF (f-status <> "00") OR
                   (file1-serial <> 4)
               DISPLAY "FAILED 3: status " f-status "-"
                       "serial: " file1-serial
           END-IF

           MOVE "aab" TO f-key2-1
           MOVE "~~~" TO f-key2-2
           START f KEY = f-key2-1
           READ f NEXT
           IF (f-status <> "00") OR
                   (file1-serial <> 4)
               DISPLAY "FAILED 4: status " f-status "-"
                       "serial: " file1-serial
           END-IF

           MOVE "aab" TO f-key2-1
           MOVE "~~~" TO f-key2-2
           START f KEY < f-key2-1
           READ f PREVIOUS
           IF (f-status <> "00") OR
                   (file1-serial <> 3)
               DISPLAY "FAILED 5: status " f-status "-"
                       "serial: " file1-serial
           END-IF

           MOVE "aaa" TO f-key2-1
           MOVE "~~~" TO f-key2-2
           START f KEY > f-key2-1
           READ f NEXT
           IF (f-status <> "00") OR
                   (file1-serial <> 4)
               DISPLAY "FAILED 6: status " f-status "-"
                       "serial: " file1-serial
           END-IF

           MOVE "XX-" TO f-key3-1
           START f KEY > f-key3-1
           READ f NEXT
      *  CHECK: Return file-status "02" if duplicates exist
           IF (f-status <> "02"
      *    Depends on xISAM implementation and the way BDB is used (not yet
      *    implemented in 3.x)
            AND f-status <> "00"
               ) OR file1-serial <> 3
               DISPLAY "FAILED 7: status " f-status "-"
           END-IF
           CLOSE f
           STOP RUN
           .
       write-f.
           MOVE w-serial TO file1-serial
           WRITE f-rec
           ADD 1 TO w-serial
           .