IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           *> Valid.
           SELECT good-1 ASSIGN "a"
               RECORD DELIMITER LINE-SEQUENTIAL.

           SELECT good-2 ASSIGN "a"
               SEQUENTIAL
               RECORD DELIMITER LINE-SEQUENTIAL.

           SELECT good-3 ASSIGN "a"
               RECORD DELIMITER LINE-SEQUENTIAL
               LINE SEQUENTIAL.

           SELECT good-4 ASSIGN "a"
               RECORD DELIMITER BINARY-SEQUENTIAL.

           *> Warning.
           SELECT ok-i-guess-1 ASSIGN "a"
               RECORD DELIMITER STANDARD-1.

           SELECT ok-i-guess-2 ASSIGN "a"
               RECORD DELIMITER THE-END-OF-THE-WORLD.

           *> Not valid.
           SELECT bad-1 ASSIGN "a"
               RECORD DELIMITER LINE-SEQUENTIAL
               INDEXED
               RECORD KEY bad-1-rec.

           SELECT bad-2 ASSIGN "a"
               INDEXED
               RECORD KEY bad-2-rec
               RECORD DELIMITER LINE-SEQUENTIAL.

           SELECT bad-3 ASSIGN "a"
               LINE SEQUENTIAL
               RECORD DELIMITER BINARY-SEQUENTIAL.

           SELECT bad-4 ASSIGN "a"
               LINE SEQUENTIAL
               RECORD DELIMITER STANDARD-1.

           SELECT bad-5 ASSIGN "a"
               RECORD DELIMITER BINARY-SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  good-1.
       01  good-1-rec PIC 9.
       01  good-1-rec-2 PIC 99.

       FD  good-2 RECORD VARYING FROM 1 TO 5 CHARACTERS.
       01  good-2-rec PIC 9.

       FD  good-3.
       01  good-3-rec PIC 9.
       01  good-3-rec-2 PIC 99.

       FD  good-4 RECORD CONTAINS 1 TO 5 CHARACTERS.
       01  good-4-rec PIC 9.

       FD  ok-i-guess-1.
       01  ok-i-guess-1-rec PIC 9.
       01  ok-i-guess-1-rec-2 PIC 99.

       FD  ok-i-guess-2.
       01  ok-i-guess-2-rec PIC 9.
       01  ok-i-guess-2-rec-2 PIC 99.

       FD  bad-1.
       01  bad-1-rec PIC 9.

       FD  bad-2.
       01  bad-2-rec PIC 9.

       FD  bad-3.
       01  bad-3-rec PIC 9.

       FD  bad-4.
       01  bad-4-rec PIC 9.

       FD  bad-5 RECORD CONTAINS 1 CHARACTERS.
       01  bad-5-rec PIC 9.