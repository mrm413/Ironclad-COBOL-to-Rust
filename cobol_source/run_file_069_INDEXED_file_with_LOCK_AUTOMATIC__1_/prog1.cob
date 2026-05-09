identification division.
       program-id. prog1.
       environment division.
       input-output section.
       file-control.
       select file1 assign disk
           access mode is random
           organization indexed
           record key file1-key
           lock mode is automatic
           status is fs.
       data division.
       file section.
       fd file1.
       1    file1-rec.
        2   file1-key pic x.
       working-storage section.
       1    fs pic xx.
       1    os-check   pic x(7).
         88 os-is-windows-or-dos values 'WINDOWS' 'FREEDOS'.
       78  callee       value "./prog2".
       78  callee-wdos  value ".\prog2".
       procedure division.
           open output file1.
           move "X" to file1-key.
           write file1-rec.
           if fs not = "00"
              display "FAILED 1::w fs=" fs.
           close file1.
           open i-o file1.
           move "X" to file1-key.
           read file1.
           if fs not = "00"
              display "FAILED 1::r fs=" fs.
           accept os-check from environment "COB_ON_CYGWIN".
           if os-check = spaces
             accept os-check from environment "OS".
           if os-check = spaces
             accept os-check from environment "OS_NAME".
           inspect os-check converting "werfdosin" to "WERFDOSIN".
           if os-is-windows-or-dos
             call "SYSTEM" using callee-wdos
           else
             call "SYSTEM" using callee.
           close file1.
           stop run.