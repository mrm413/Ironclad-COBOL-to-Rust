IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       PROCEDURE        DIVISION.
           DISPLAY FUNCTION LENGTH      ("abcd" & "xyz")
           DISPLAY FUNCTION BYTE-LENGTH ("abcd" & "xyz")
           DISPLAY FUNCTION LENGTH      ("abcd" "xyz")
           DISPLAY FUNCTION BYTE-LENGTH (01234)
           DISPLAY FUNCTION LENGTH      (567)
           DISPLAY FUNCTION LENGTH      ("abcd" & "xyz" PHYSICAL)
           DISPLAY FUNCTION BYTE-LENGTH ("abcd" & "xyz" PHYSICAL)
           .