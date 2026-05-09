identification division.
       program-id. prog2.
       environment division.
       input-output section.
       file-control.
       select file1 assign disk status is fs.
       data division.
       file section.
       fd file1.
       1    file1-rec pic x.
       working-storage section.
       1    fs pic xx.
       procedure division.
           open i-o file1.
           if fs not = "61"
              display "FAILED 1: " fs
              close file1
           end-if.
           open input file1.
           if fs not = "00"
              display "FAILED 2: " fs
           else
              close file1
           end-if.
           stop run.