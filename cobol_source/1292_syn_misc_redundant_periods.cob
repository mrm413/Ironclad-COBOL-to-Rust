IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       REPLACE ==a== BY ==b==.. *> blah blah
       .

       COPY a..

       78  var VALUE "hello".
      * blah blah
          .