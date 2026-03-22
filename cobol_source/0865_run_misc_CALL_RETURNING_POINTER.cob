identification division.
       program-id. progdyn.

       data division.
       working-storage section.

       01  c-text-pointer usage pointer.

       procedure division.

           call        "calldyn"
                       using "COB_UNIX_LF"
                       returning c-text-pointer
           end-call

           IF function content-of(c-text-pointer) <> "1"
              DISPLAY "unexpected value: "
                      function content-of(c-text-pointer).

          GOBACK.