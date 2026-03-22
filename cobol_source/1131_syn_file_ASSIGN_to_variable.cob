IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT      DIVISION.
       INPUT-OUTPUT     SECTION.
       FILE-CONTROL.
           SELECT test-file-1 ASSIGN TO var-1
               ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-2 ASSIGN USING var-2
              ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-3 ASSIGN TO VARYING var-3
               ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-4 ASSIGN DISK USING var-4
               ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-5 ASSIGN DYNAMIC DISK var-5
               ORGANIZATION IS SEQUENTIAL.
           SELECT test-file-6 ASSIGN DISK FROM var-6
               ORGANIZATION IS SEQUENTIAL.
       DATA             DIVISION.
       FILE             SECTION.
       FD test-file-1.
       01 test-rec-1    PIC X(4).
       FD test-file-2.
       01 test-rec-2    PIC X(4).
       FD test-file-3.
       01 test-rec-3    PIC X(4).
       FD test-file-4.
       01 test-rec-4    PIC X(4).
       FD test-file-5.
       01 test-rec-5    PIC X(4).
       FD test-file-6.
       01 test-rec-6    PIC X(4).
       WORKING-STORAGE  SECTION.
       01  var-1        PIC X(255).
       01  var-2        PIC X(255).
       01  var-3        PIC X(255).
       01  var-4        PIC X(255).
       01  var-5        PIC X(255).
       01  var-6        PIC X(255).
       PROCEDURE        DIVISION.
           OPEN INPUT test-file-1
           CLOSE test-file-1
           OPEN INPUT test-file-2
           CLOSE test-file-2
           OPEN INPUT test-file-3
           CLOSE test-file-3
           OPEN INPUT test-file-4
           CLOSE test-file-4
           OPEN INPUT test-file-5
           CLOSE test-file-5
           OPEN INPUT test-file-6
           CLOSE test-file-6
           .