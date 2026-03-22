IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 P1 PIC  999  value 1.
       01 P2 PIC  9P   value 0.
       01 P3 PIC  V999 value .123.
       01 P4 PIC  VP9  value 0.
       01 P5 PIC  VPP9 value 0.
       01 P6 PIC  9P   value 10.
       PROCEDURE DIVISION.
           display '00=' P2 '; 001=' P1 '; 00=' P2 ';'
           display '.00=' P4 '; .000=' P5 '; .123=' P3 '; '
                   '.00=' P4 '; .000=' P5 ';'
           move P1 to P2
           move P3 to P4, P5
           display '00=' P2 '; .02=' P4 '; .003=' P5 ';'
           display '10=' P6 ';'
           GOBACK.