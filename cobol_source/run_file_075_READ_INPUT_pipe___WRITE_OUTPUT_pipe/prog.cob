identification division.
       program-id. prog.
       environment division.
       configuration section.
       input-output section.
       file-control.
           select pipe-in
               organization line sequential
               access sequential
               assign to w-command
               status is f-status.
           select pipe-out
               organization line sequential
               access sequential
               assign to w-command
               status is f-status.
       data division.
       file section.
       fd  pipe-in.
       1   pipe-msg-in pic x(132).
       fd  pipe-out.
       1   pipe-msg-out pic x(132).
       working-storage section.
       77  f-status pic xx.
           88  f-status-ok value "00".
       77  w-command pic x(100).
       procedure division.
           move "< sh ./provider ./test-data-in"
             to w-command.
           open input pipe-in.
           if not f-status-ok
              display "FAILED: OPEN INPUT"
              stop run
           end-if.
           move "> sh ./consumer > ./test-data-out"
             to w-command.
           open output pipe-out.
           if not f-status-ok
              display "FAILED: OPEN OUTPUT"
              stop run
           end-if.
           perform until not f-status-ok
              read pipe-in
              if f-status-ok
                 perform x01-100-map
                 write pipe-msg-out
              end-if
           end-perform.
           close pipe-in.
           close pipe-out.
           stop run.
      *
       x01-100-map.
           move "*** Jacques Tati ***" to pipe-msg-out.
           if (pipe-msg-in = "COUNTRY")
              move "Country: FRANCE" to pipe-msg-out.
           if (pipe-msg-in = "TOWN")
              move "Town: DEAUVILLE" to pipe-msg-out.
           if (pipe-msg-in = "NAME")
              move "Name: M. Hulot" to pipe-msg-out.
           if (pipe-msg-in = "STREET")
              move "Street: Rue des Anglais" to pipe-msg-out.