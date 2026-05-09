IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT f ASSIGN whatever
               ORGANIZATION LINE SEQUENTIAL.
      $SET ASSIGN "EXTERNAL"
           SELECT g ASSIGN whatever
               ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  f.
       01  f-rec PIC XXX.
       FD  g.
       01  g-rec PIC XXX.

       PROCEDURE DIVISION.
           MOVE "out.txt" TO whatever

           OPEN OUTPUT f
           WRITE f-rec FROM "hi"
           CLOSE f

           OPEN OUTPUT g
           WRITE g-rec FROM "hi"
           CLOSE g
           .
       END PROGRAM prog.