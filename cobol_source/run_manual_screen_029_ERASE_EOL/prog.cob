IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  success-flag PIC X VALUE 'Y'.
           88  success  VALUE 'Y', 'y'.

       SCREEN           SECTION.
       01  scr-1.
           03  LINE 1 VALUE 'Enter "y" if all the text after foo on '
               & 'that line alone has been erased.'.
           03  LINE 3 VALUE 'Lorem ipsum dolor sit amet, consectetur ad'
               & 'ipiscing elit. Curabitur dapibus dui'.
           03  LINE 4 VALUE 'vitae augue lobortis, non tempor diam tris'
               & 'tique. Donec dignissim ex velit, ut'.
           03  LINE 5 VALUE 'efficitur tellus pharetra at. Curabitur at'
               & ' condimentum nunc, nec accumsan'.
           03  LINE 6 VALUE 'nulla. Nulla at feugiat elit, eget condime'
               & 'ntum justo. Nam lorem lectus,'.
           03  LINE 7 VALUE 'imperdiet sit amet odio eu, eleifend conse'
               & 'ctetur ligula. Duis diam felis, porta'.
           03  LINE 8 VALUE 'id diam id, ultrices finibus augue. Mauris'
               & ' imperdiet, dolor sed sodales porta,'.
           03  LINE 9 VALUE 'justo nunc consequat nulla, iaculis venena'
               & 'tis lorem libero sit amet'.
           03  LINE 10 VALUE 'magna. Nullam pulvinar nullam.'.
           03  success-field LINE + 2, PIC X, REQUIRED,
                                              USING success-flag.

       01  scr-2.
           03  LINE 6 COL 8 VALUE 'foo' ERASE EOL, HIGHLIGHT.

       PROCEDURE        DIVISION.
           DISPLAY scr-1
           DISPLAY scr-2
           ACCEPT success-field

           IF success AND COB-CRT-STATUS = 0
               GOBACK RETURNING 0
           ELSE
               GOBACK RETURNING 1
           END-IF
           .