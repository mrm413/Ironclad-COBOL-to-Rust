IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION. 
       FILE-CONTROL.
           SELECT test-file-1 ASSIGN USING not-a-var
              ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-2 ASSIGN DYNAMIC not-a-var
               ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-3 ASSIGN DISK FROM not-a-var
               ORGANIZATION IS SEQUENTIAL.    
       DATA             DIVISION.
       FILE             SECTION.
       FD test-file-1.
       01 test-rec-1    PIC X(4).
       FD test-file-2.
       01 test-rec-2    PIC X(4).
       FD test-file-3.
       01 test-rec-3    PIC X(4).
       PROCEDURE        DIVISION.
           OPEN INPUT test-file-1
           CLOSE test-file-1
           OPEN INPUT test-file-2
           CLOSE test-file-2
           OPEN INPUT test-file-3
           CLOSE test-file-3
           .