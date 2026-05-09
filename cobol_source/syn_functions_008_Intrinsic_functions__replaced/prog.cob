IDENTIFICATION DIVISION.
       FUNCTION-ID. SUBSTITUTE.

       DATA DIVISION.
       LINKAGE SECTION.
       01  func-in  PIC X(15).
       01  func-sub PIC X.
       01  func-out PIC X(15).

       PROCEDURE DIVISION USING func-in, func-sub RETURNING func-out.
           MOVE func-in TO func-out
           INSPECT func-out REPLACING ALL '%' BY func-sub
           .
       END FUNCTION SUBSTITUTE.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION SUBSTITUTE
           .
       PROCEDURE DIVISION.
           DISPLAY FUNCTION SUBSTITUTE(" % C%O%B%O%L % ", "_")
           DISPLAY FUNCTION SUBSTITUTE(" % C%O%B%O%L % ", "-")
           .
       END PROGRAM prog.