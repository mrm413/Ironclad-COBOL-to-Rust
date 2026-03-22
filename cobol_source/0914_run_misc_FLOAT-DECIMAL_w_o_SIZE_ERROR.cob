IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  FD16                        USAGE FLOAT-DECIMAL-16.
       01  SV16                        USAGE FLOAT-DECIMAL-16.
       01  FD34                        USAGE FLOAT-DECIMAL-34.
       01  SV34                        USAGE FLOAT-DECIMAL-34.

       PROCEDURE DIVISION.
       CND-000.
           DISPLAY "--- FLOAT-DECIMAL-34 ---"
           COMPUTE FD34 = (((1.0E7 / 2.1E0) / 3.1E0) - 5.0E-1) * 6.0E0
           DISPLAY "A: " FD34

           COMPUTE FD34 = (((1.0E7 / 2.9E0) / 3.9E0) - 5.0E-1) * 6.0E0
           DISPLAY "B: " FD34
           MOVE ZERO TO FD34.
           COMPUTE FD34 = 1.0E3 / 2.1E0
                   ON SIZE ERROR DISPLAY "Z: " FD34 " SIZE ERROR"
               NOT ON SIZE ERROR DISPLAY "Z: " FD34 " IS OK"
           END-COMPUTE.

           DISPLAY "    ..."
           DISPLAY "--- FLOAT-DECIMAL-16 ---"
           COMPUTE FD16 = (((1.0E7 / 2.1E0) / 3.1E0) - 5.0E-1) * 6.0E0
           DISPLAY "A: " FD16

           COMPUTE FD16 = (((1.0E7 / 2.9E0) / 3.9E0) - 5.0E-1) * 6.0E0
           DISPLAY "B: " FD16
           MOVE ZERO TO FD16.
           COMPUTE FD16 = 1.0E3 / 2.1E0
                   ON SIZE ERROR DISPLAY "Z: " FD16 " SIZE ERROR"
               NOT ON SIZE ERROR DISPLAY "Z: " FD16 " IS OK"
           END-COMPUTE.

           DISPLAY "    ..."
           DISPLAY "--- 99 + 1 / 3 ---"
           MOVE -1 TO FD16, FD34.
           COMPUTE FD34 = 99 + 1 / 3
                   ON SIZE ERROR DISPLAY "FD34: " FD34 " SIZE ERROR"
               NOT ON SIZE ERROR DISPLAY "FD34: " FD34 " IS OK"
           END-COMPUTE.
           COMPUTE FD16 = 99 + 1 / 3
                   ON SIZE ERROR DISPLAY "FD16: " FD16 " SIZE ERROR"
               NOT ON SIZE ERROR DISPLAY "FD16: " FD16 " IS OK"
           END-COMPUTE.

           DISPLAY "    ..."
           DISPLAY "--- 99 ---"
           MOVE -1 TO FD16, FD34.
           COMPUTE FD34 = 99
                   ON SIZE ERROR DISPLAY "FD34: " FD34 " SIZE ERROR"
               NOT ON SIZE ERROR DISPLAY "FD34: " FD34 " IS OK"
           END-COMPUTE.
           COMPUTE FD16 = 99
                   ON SIZE ERROR DISPLAY "FD16: " FD16 " SIZE ERROR"
               NOT ON SIZE ERROR DISPLAY "FD16: " FD16 " IS OK"
           END-COMPUTE.

       CND-100-OK.
           DISPLAY "    ..."
           DISPLAY "--- Test overflow ---"
           MOVE 9900000000000 TO FD16, FD34.
           PERFORM 390 TIMES
             MOVE FD16 TO SV16
             COMPUTE FD16 = FD16 * 10
                    ON SIZE ERROR GO TO CND-100-ERR
             END-COMPUTE
             IF FD16 < 9.0
               DISPLAY "FD16: " FD16 " IS Wrong"
               GO TO CND-100-ERR
             END-IF
           END-PERFORM.
           DISPLAY "FD16: " FD16 " IS OK".
           GO TO CND-200-OK.
       CND-100-ERR.
           DISPLAY "FD16: after " SV16 " SIZE ERROR".

       CND-200-OK.
           MOVE 9900000000000 TO FD16, FD34.
           PERFORM 6500 TIMES
             MOVE FD34 TO SV34
             COMPUTE FD34 = FD34 * 10
                    ON SIZE ERROR GO TO CND-200-ERR
             END-COMPUTE
             IF FD34 < 9.0
               GO TO CND-200-ERR
             END-IF
           END-PERFORM.
           DISPLAY "FD34: " FD34 " IS OK".
           GO TO CND-380-OK.
       CND-200-ERR.
           DISPLAY "FD34: after " SV34 " SIZE ERROR".

       CND-380-OK.
           DISPLAY "    ..."
           DISPLAY "--- Test underflow ---"
           MOVE 0.000000099 TO FD16, FD34.
           PERFORM 400 TIMES
             MOVE FD16 TO SV16
             COMPUTE FD16 = FD16 / 10
                    ON SIZE ERROR GO TO CND-300-ERR
             END-COMPUTE
             IF FD16 = 0.0
               GO TO CND-300-ERR
             END-IF
           END-PERFORM.
           DISPLAY "FD16: " FD16 " IS OK".
           GO TO CND-400-OK.
       CND-300-ERR.
           DISPLAY "FD16: after " SV16 " SIZE ERROR".

       CND-400-OK.
           MOVE 0.000000099 TO FD16, FD34.
           PERFORM 6600 TIMES
             MOVE FD34 TO SV34
             COMPUTE FD34 = FD34 / 10.0
                    ON SIZE ERROR GO TO CND-400-ERR
             END-COMPUTE
             IF FD34 = 0.0
               GO TO CND-400-ERR
             END-IF
           END-PERFORM.
           DISPLAY "FD34: " FD34 " IS OK".
           GO TO CND-999.
       CND-400-ERR.
           DISPLAY "FD34: after " SV34 " SIZE ERROR".

       CND-999.
           STOP RUN.
           END PROGRAM prog.