identification division.
         program-id. cbug.
       procedure division.
         mainline.
           call 'bug'
           goback
           .
       end program cbug.
      *
       identification division.
         program-id. bug.
       data division.
         working-storage section.
           01  pw   pic 9(02).
           01  px   pic x value '3'.
       procedure division.
         mainline.
           compute pw = function numval(px).
           if pw <> 3
              display 'bad calc: ' pw.
           goback
           .
       end program bug.