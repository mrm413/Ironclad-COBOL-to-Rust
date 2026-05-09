IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT file1 ASSIGN DISK.
       DATA DIVISION.
       FILE SECTION.
       SD file1.
       1  file1-rec.
          2  file1-key pic 9(4).
          2  file1-data pic x(10).
       WORKING-STORAGE SECTION.
       77 w-eof pic 9 value 0.
       1  1-values.
          2  filler pic x(14) value "0001A--------A".
          2  filler pic x(14) value "0002B--------B".
          2  filler pic x(14) value "0003C--------C".
          2  filler pic x(14) value "0004D--------D".
          2  filler pic x(14) value "0005E--------E".
          2  filler pic x(14) value "0006F--------F".
          2  filler pic x(14) value "0007G--------G".
          2  filler pic x(14) value "0008H--------H".
          2  filler pic x(14) value "0009I--------I".
          2  filler pic x(14) value "0010J--------J".
          2  filler pic x(14) value "0011K--------K".
          2  filler pic x(14) value "0012L--------L".
          2  filler pic x(14) value "0013M--------M".
          2  filler pic x(14) value "0014N--------N".
          2  filler pic x(14) value "0015O--------O".
          2  filler pic x(14) value "0016P--------P".
          2  filler pic x(14) value "0017Q--------Q".
          2  filler pic x(14) value "0018R--------R".
          2  filler pic x(14) value "0019S--------S".
          2  filler pic x(14) value "0020T--------T".
          2  filler pic x(14) value "0021U--------U".
          2  filler pic x(14) value "0022V--------V".
          2  filler pic x(14) value "0023W--------W".
          2  filler pic x(14) value "0024X--------X".
          2  filler pic x(14) value "0025Y--------Y".
          2  filler pic x(14) value "0026Z--------Z".
       1  filler redefines 1-values.
          2  1-record occurs 26 times indexed by ix-1.
           3 1-key pic 9(4).
           3 1-data pic x(10).
       PROCEDURE DIVISION.
       a01-main.
          SORT file1 ON ASCENDING file1-key
             INPUT PROCEDURE a02-release-to-sort
             OUTPUT PROCEDURE a03-return-from-sort.
          STOP RUN.
      *
       a02-release-to-sort.
          PERFORM VARYING ix-1 FROM 1 BY 2 UNTIL ix-1 > 26
             RELEASE file1-rec from 1-record(ix-1)
          END-PERFORM.
          PERFORM VARYING ix-1 FROM 2 BY 2 UNTIL ix-1 > 26
             RELEASE file1-rec from 1-record(ix-1)
          END-PERFORM.
      *
       a03-return-from-sort.
          PERFORM VARYING ix-1 FROM 1 BY 1
             UNTIL (ix-1 > 26) OR (w-eof = 1)
             RETURN file1 RECORD
               AT END MOVE 1 TO w-eof
             END-RETURN
             IF (file1-rec <> 1-record(ix-1))
                MOVE 1 TO w-eof
             END-IF
          END-PERFORM.
          IF (w-eof = 1)
             DISPLAY "FAILED: unexpected eof"
          ELSE
             RETURN file1 RECORD
               AT END CONTINUE
               NOT AT END DISPLAY "FAILED: expected eof"
             END-RETURN
          END-IF.