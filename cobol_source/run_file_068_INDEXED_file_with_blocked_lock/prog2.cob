identification division.
       program-id. prog2.
       environment division.
       input-output section.
       file-control.
       select file1 assign disk
           organization indexed
           record key file1-key
           status is fs.
       data division.
       file section.
       fd file1.
       1    file1-rec.
        2   file1-key pic x.
       working-storage section.
       1    fs pic xx.
       procedure division.
           open input file1.
           if fs not = "00"
              display "FAILED: " fs
              stop run
           end-if.
           close file1
           open input file1 with lock.
           if fs not = "61"
              display "FAILED: " fs
              close file1
           end-if.
           stop run.