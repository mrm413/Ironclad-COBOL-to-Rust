Identification division.
       Program-id. prog.
      *
       Environment division.

       Input-output section.
       File-control.
      *
           Select optional tbw
               assign to path-tbw
               organization is indexed
               access mode is dynamic
               record key is tbw-key
               alternate record key is tbw-alt
                   suppress when space
               sharing with no other
               file status is fs-file-status.
      *
       I-o-control.
      *
       Data division.
       File section.
      *
       FD  tbw
           record is varying in size
               from 107 to 362 characters
               depending on end-tbw-record
	       .
       01  tbw-record.
           02 tbw-key                        pic x(100).
           02 tbw-alt.
               03 tbw-alt-1                  pic 9(02).
               03 tbw-alt-2                  pic 9(04).
           02 tbw-f1                         pic x(01).
           02 tbw-f2                         pic x(255).
      *
       Working-storage section.

       01  fs-file-status                 pic x(02).

       01  end-tbw-record                 pic 9(09) binary.

       01  flag-tbw                       pic x(01) value low-value.
           88 flag-tbw-open   value high-value.
           88 flag-tbw-closed value low-value.

       01  path-tbw                       pic x(255) value space.

       Procedure division.

      * Prepare.
           Move "tbw" to path-tbw.

      * First test.
           Perform tbw-delete-file thru tbw-exit.

           Perform tbw-open-i-o    thru tbw-exit.

           Move low-values to tbw-key.
           Perform tbw-start-primary-greater thru tbw-exit.

           Perform tbw-read-next thru tbw-exit.

           Move 122 to end-tbw-record.
           Move "aaaaa" to tbw-key.
           Move spaces to tbw-alt
                          tbw-f1
                          tbw-f2.
           Perform tbw-write thru tbw-exit.

           Move low-values to tbw-alt.
           Perform tbw-start-alternate thru tbw-exit.

           Move low-values to tbw-key.
           Perform tbw-start-primary-greater thru tbw-exit.

           Perform tbw-read-next thru tbw-exit.

           Perform tbw-read-next thru tbw-exit.

           Perform tbw-close thru tbw-exit.

      * Second test.

           Perform tbw-delete-file thru tbw-exit.

           Perform tbw-open-i-o thru tbw-exit.

           Move low-values to tbw-key.
           Perform tbw-start-primary-greater thru tbw-exit.

           Perform tbw-read-next thru tbw-exit.

           Move 163 to end-tbw-record.
           Move "aaaaa" to tbw-key.
           Move 1 to tbw-alt-1
                     tbw-alt-2.
           Move spaces to tbw-f1
                          tbw-f2.
           Perform tbw-write thru tbw-exit.

           Move 122 to end-tbw-record.
           Move "aaaab" to tbw-key.
           Move spaces to tbw-alt
                          tbw-f1
                          tbw-f2.
           Perform tbw-write thru tbw-exit.

           Move low-values to tbw-alt.
           Perform tbw-start-alternate thru tbw-exit.

           Perform tbw-read-next thru tbw-exit.

           Move spaces to tbw-alt.
           Perform tbw-rewrite thru tbw-exit.

      *>   note: should not have status 02 as it a suppressed alternate key
      *>         therefore duplicate checks must be skipped

      * Finish.
           Perform tbw-close thru tbw-exit.
           Display "Test completed".
           Stop run.

      * I/O.
       tbw-Open-I-O.
           If flag-tbw-open
               Perform tbw-Close thru tbw-Close-exit.
           Display "open".
           Open i-o tbw.
           Display "open done".
           If fs-file-status is less than "10"
               Set flag-tbw-open to true.
           Go to tbw-exit.
      *
       tbw-Start-Primary-Greater.
           Display "start > tbw-key".
           Start tbw
               key is greater than tbw-key
               invalid key
                 Display "start > tbw-key inv"
                 Go to tbw-exit
               not invalid
                 Display "start > tbw-key done"
                 Go to tbw-exit.
           Display "start > tbw-key "  fs-file-status
           Go to tbw-exit.
      *
       tbw-Start-Alternate.
           Display "start >= tbw-alt".
           Start tbw
               key is not less than tbw-alt
               invalid key
      *>Inspect! Display "start >= tbw-alt inv"
                 Display "start >= tbw-alt done"
                 Go to tbw-exit
               not invalid
                 Display "start >= tbw-alt done"
                 Go to tbw-exit.
           Display "start >= tbw-alt "  fs-file-status
           Go to tbw-exit.
      *
       tbw-Read-Next.
           Display "read next".
           Read tbw
               next record
               at end
                 Display "read next end"
                 Go to tbw-exit
               not at end
                 Display "read next done"
                 Go to tbw-exit.
           Display "read next "  fs-file-status
           Go to tbw-exit.
      *
       tbw-Write.
           Display "write".
           Write tbw-record
               invalid key
                 Display "write inv"
                 Go to tbw-exit
               not invalid
                 Display "write done"
                 Go to tbw-exit.
           Display "write "  fs-file-status
           Go to tbw-exit.
      *
       tbw-Rewrite.
           Display "rewrite".
           Rewrite tbw-record
               invalid key
                 Display "rewrite inv "  fs-file-status
                 Go to tbw-exit
               not invalid
                 Display "rewrite done " fs-file-status
                 Go to tbw-exit.
           Display "rewrite "  fs-file-status
           Go to tbw-exit.
      *
       tbw-Delete-File.
           If flag-tbw-open
               Perform tbw-Close thru tbw-Close-exit.
           Move "xx" to fs-file-status.
           Display "delete file".
           Delete file tbw.
           Display "delete file done".
           Go to tbw-exit.
      *
       tbw-Close.
           If flag-tbw-open
               Display "close"
               Close tbw
               Display "close done"
               Set flag-tbw-closed to true
           end-if.
       tbw-Close-exit.
           Exit.
       tbw-exit.
           Exit.