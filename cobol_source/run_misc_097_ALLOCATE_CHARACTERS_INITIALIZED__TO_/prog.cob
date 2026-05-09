IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  MYPTR        USAGE POINTER.
       LINKAGE          SECTION.
       01  MYFLD        PIC X(4).
       PROCEDURE        DIVISION.
       ASTART SECTION.
       A01.
           ALLOCATE 4 CHARACTERS
                    INITIALIZED TO "ABCD"
                    RETURNING MYPTR
           SET ADDRESS OF MYFLD TO MYPTR
           IF MYFLD NOT = "ABCD"
              DISPLAY MYFLD
           END-IF
           FREE MYPTR
           ALLOCATE 4 CHARACTERS
                    INITIALIZED TO ALL "Z"
                    RETURNING MYPTR
           SET ADDRESS OF MYFLD TO MYPTR
           IF MYFLD NOT = "ZZZZ"
              DISPLAY MYFLD
           END-IF
           FREE MYPTR
           ALLOCATE 4 CHARACTERS
                    INITIALIZED
                    RETURNING MYPTR
           SET ADDRESS OF MYFLD TO MYPTR
           IF MYFLD NOT = LOW-VALUES
              DISPLAY MYFLD
           END-IF
           FREE MYPTR
           STOP RUN.