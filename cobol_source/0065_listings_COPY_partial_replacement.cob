identification division.
       program-id. copytest.

       data division.
       working-storage section.
       01 hello                pic x(20) value 'Copytest'.

       01 xx                   pic x(02).

          copy 'copy1.inc' replacing 'YYY-' by a10-
                                     'yy1-' by a11-
                                     'yy2-' by a12-.

          copy 'copy1.inc' replacing 'YYY-' by a20-
                                     'yy1-' by a21-
                                     'yy2-' by a22-.

          copy 'copy1.inc' replacing 'YYY-' by a30-
                                     'yy1-' by a31-
                                     'yy2-' by a32-.

       procedure division.

       display hello

       display 'a10-struktur'
       display a10-struktur

       display 'a20-struktur'
       display a20-struktur

       display 'a30-struktur'
       display a30-struktur

       goback.
       end program copytest.