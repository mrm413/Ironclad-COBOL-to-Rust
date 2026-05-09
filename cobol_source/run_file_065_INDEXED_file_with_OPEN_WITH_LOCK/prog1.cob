identification division.
       program-id. prog1.
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
       1    os-check   pic x(7).
         88 os-is-windows-or-dos values 'WINDOWS' 'FREEDOS'.
       78  callee       value "./prog2".
       78  callee-wdos  value ".\prog2".
       procedure division.
           open output file1.
           close file1.
           open input file1 with lock.
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