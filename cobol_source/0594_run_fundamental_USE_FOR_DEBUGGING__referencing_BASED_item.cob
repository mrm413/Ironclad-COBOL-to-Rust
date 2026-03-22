IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
           SOURCE-COMPUTER. mine WITH DEBUGGING MODE.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  DATA-FIELD   PIC X(40) VALUE "ABCD" BASED.
       77  PTR          USAGE POINTER VALUE NULL.
       01  DATA-FIELD3  PIC X(13) VALUE "42"   BASED.
       LINKAGE SECTION.
       01  DATA-FIELD2  PIC X(10) VALUE "DEF".
       PROCEDURE        DIVISION.
       DECLARATIVES.
       TEST-DEBUG SECTION.
           USE FOR DEBUGGING  ON ALL REFERENCES OF DATA-FIELD
                                 ALL REFERENCES OF DATA-FIELD2
                                 DATA-FIELD3.
           DISPLAY DEBUG-ITEM "|" END-DISPLAY.
       END DECLARATIVES.
       SOME-PAR.
           ALLOCATE -20 CHARACTERS RETURNING PTR
           SET ADDRESS OF DATA-FIELD TO PTR   *> first expected output -> is NULL
           ALLOCATE DATA-FIELD INITIALIZED    *> output with data as specified
           FREE DATA-FIELD                    *> No data any more
           ALLOCATE DATA-FIELD2 INITIALIZED   *> DO-CHECK MF extension - otherwise identical
           SET PTR TO ADDRESS OF DATA-FIELD2
           FREE PTR
           SET ADDRESS OF DATA-FIELD2 TO NULL
           ALLOCATE DATA-FIELD3 INITIALIZED
           SET PTR TO ADDRESS OF DATA-FIELD3  *> only read, no output expected
           FREE DATA-FIELD3
           STOP RUN.