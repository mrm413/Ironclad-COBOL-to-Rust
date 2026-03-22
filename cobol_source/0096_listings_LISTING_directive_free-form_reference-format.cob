IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       COPY "copy.inc".
       COPY "copy2.inc".
       PROCEDURE        DIVISION.
>>LISTING OFF
           DISPLAY TEST1-VAR NO ADVANCING
           END-DISPLAY.
>> LISTING ON
           STOP RUN.