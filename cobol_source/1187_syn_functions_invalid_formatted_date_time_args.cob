IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  format-str         PIC X(8) VALUE "YYYYMMDD".
       01  Date-Format        CONSTANT "YYYYMMDD".
       01  Time-Format        CONSTANT "hhmmss".
       01  Datetime-Format    CONSTANT "YYYYMMDDThhmmss".
       PROCEDURE        DIVISION.
      *>   Test wrong formats
           DISPLAY FUNCTION FORMATTED-DATE ( "YYYYWWWD", 1 )
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-TIME ( "HHMMSS", 1)
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-DATETIME
                ( "YYYYWWWDTHHMMSS", 1, 1)
           END-DISPLAY

      *>   Test format in variable
           DISPLAY FUNCTION FORMATTED-DATE ( format-str, 1)
           END-DISPLAY

      *>   Test incompatible formats
           DISPLAY FUNCTION FORMATTED-CURRENT-DATE (Date-Format)
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-CURRENT-DATE (Time-Format)
           END-DISPLAY

           DISPLAY FUNCTION FORMATTED-DATE ( Time-Format, 1)
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-DATE ( Datetime-Format, 1)
           END-DISPLAY

           DISPLAY FUNCTION FORMATTED-TIME ( Date-Format, 1)
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-TIME ( Datetime-Format, 1)
           END-DISPLAY

           DISPLAY FUNCTION FORMATTED-DATETIME ( Date-Format, 1, 1)
           END-DISPLAY
           DISPLAY FUNCTION FORMATTED-DATETIME ( Time-Format, 1, 1)
           END-DISPLAY

           DISPLAY FUNCTION INTEGER-OF-FORMATTED-DATE ( Time-Format, 1)
           END-DISPLAY

           DISPLAY FUNCTION SECONDS-FROM-FORMATTED-TIME
               ( Date-Format, 1)
           END-DISPLAY

      *>   Time format with more than 9 decimal places.
           DISPLAY FUNCTION FORMATTED-TIME ( "hhmmss.ssssssssss", 1)
           END-DISPLAY

           STOP RUN.