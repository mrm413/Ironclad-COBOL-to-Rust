IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT file-1 ASSIGN DISK,
                INDEXED, RELATIVE KEY file-1-key.
            SELECT file-2 ASSIGN DISK,
                RELATIVE, RECORD KEY file-2-key.