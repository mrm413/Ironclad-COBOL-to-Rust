IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  Y   PIC   X(20).
       01  Z   PIC   X(20) VALUE ALL '_'.
       PROCEDURE        DIVISION.
           MOVE "abc111444555defxxabc" TO Y.
           STRING FUNCTION SUBSTITUTE ( Y "abc" "zz" "55" "666" )
                  DELIMITED BY SIZE
                  INTO Z
           END-STRING
           IF Z NOT = "zz1114446665defxxzz_"
              DISPLAY Z.
           STOP RUN.