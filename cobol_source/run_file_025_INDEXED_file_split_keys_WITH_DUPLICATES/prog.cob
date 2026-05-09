IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
           SELECT test-file
               ASSIGN        "TESTFILE"
               ACCESS        DYNAMIC
               ORGANIZATION  INDEXED
               RECORD KEY           test-key-1 SOURCE IS test-key-p1
               ALTERNATE RECORD KEY test-key-2 SOURCE IS test-key-p2,
                                                         test-key-p3
               WITH DUPLICATES
           .

       DATA             DIVISION.
       FILE             SECTION.
       FD  test-file.
       01  test-rec.
           03  test-key-p1 PIC X(4).
           03  test-key-p2 PIC 9(4).
           03  test-data   PIC X(4).
           03  test-key-p3 PIC X(4).

       WORKING-STORAGE SECTION.
       01  found        PIC X(03).

       PROCEDURE        DIVISION.
           OPEN OUTPUT test-file
           WRITE test-rec FROM "BBBB0001dat1aaaa"
           WRITE test-rec FROM "AAAA0001dat2aaaa"
           WRITE test-rec FROM "CCCC0002dat3aaaa"
           WRITE test-rec FROM "DDDD0002dat4bbbb"
           WRITE test-rec FROM "EEEE0002dat5bbbb"
           CLOSE test-file

           OPEN INPUT test-file

           MOVE "CCCC" TO test-key-p1
           READ test-file KEY IS test-key-1
               INVALID KEY
                   DISPLAY "READ with CCCC found no record"
               NOT INVALID KEY
                   IF test-data NOT = "dat3"
                       DISPLAY "READ with wrong result: "
                           test-rec
           END-READ

           MOVE SPACES   TO found

           MOVE 0001     TO test-key-p2
           MOVE "aaaa"   TO test-key-p3
           START test-file KEY >= test-key-2
               INVALID KEY
                   DISPLAY "START >= 0001/aaaa found no record"
               NOT INVALID KEY
                   READ  test-file NEXT
                       AT END
                           DISPLAY "READ NEXT (1) found no record"
                       NOT AT END
                           EVALUATE test-data
                              WHEN "dat1"
                                 MOVE 'X' TO found (1:1)
                              WHEN "dat2"
                                 MOVE 'X' TO found (2:1)
                              WHEN OTHER
                                 DISPLAY "READ NEXT (1) "
                                     "with wrong result: "
                                     test-data
                   END-READ
                   READ  test-file NEXT
                       AT END
                           DISPLAY "READ NEXT (2) found no record"
                       NOT AT END
                           EVALUATE test-data
                              WHEN "dat1"
                                 MOVE 'X' TO found (1:1)
                              WHEN "dat2"
                                 MOVE 'X' TO found (2:1)
                              WHEN OTHER
                                 DISPLAY "READ NEXT (2) "
                                     "with wrong result: "
                                     test-data
                   END-READ
                   IF found NOT = 'XX '
                      DISPLAY "START >= + READ NEXT * 2 "
                          "with wrong result: " found
           END-START
           MOVE 0001      TO test-key-p2
           MOVE "aaaa"    TO test-key-p3
           START test-file KEY > test-key-2
               INVALID KEY
                   DISPLAY "START > 0001/aaaa found no record"
               NOT INVALID KEY
                   READ  test-file NEXT
                       AT END
                           DISPLAY "READ NEXT (3) found no record"
                       NOT AT END
                           IF test-data NOT = "dat3"
                               DISPLAY "READ NEXT (3) "
                                   "with wrong result: "
                                   test-data
                   END-READ
           END-START

           MOVE 0002      TO test-key-p2
           MOVE ALL "z"   TO test-key-p3
           START test-file KEY IS < test-key-2
               INVALID KEY
                   DISPLAY "START < 0002/zzzz found no record"
               NOT INVALID KEY
                   READ  test-file PREVIOUS
                       AT END
                           DISPLAY "READ PREVIOUS (1) found no record"
                       NOT AT END
                           IF test-data NOT = "dat5"
                              DISPLAY "READ PREVIOUS (1) "
                                  "with wrong result: "
                                  test-data
                   END-READ
                   READ  test-file PREVIOUS
                       AT END
                           DISPLAY "READ PREVIOUS (2) found no record"
                       NOT AT END
                           IF test-data NOT = "dat4"
                              DISPLAY "READ PREVIOUS (2) "
                                  "with wrong result: "
                                  test-data
                   END-READ
                   READ  test-file PREVIOUS
                       AT END
                           DISPLAY "READ PREVIOUS (3) found no record"
                       NOT AT END
                           IF test-data NOT = "dat3"
                              DISPLAY "READ PREVIOUS (3) "
                                  "with wrong result: "
                                  test-data
                   END-READ
           END-START

           CLOSE test-file
           STOP RUN.