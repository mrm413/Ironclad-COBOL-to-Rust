IDENTIFICATION DIVISION.                                         EDIT0001
       PROGRAM-ID.                                                      EDIT0002
           EDITOR.                                                      EDIT0003
                                                                        EDIT0008
      *NOTE.                                                            EDIT0009
      *    THIS VERSION OF EDITOR 1 COMPRISES AN ENTIRE RE_WRITE        EDIT0010
      *    OF THE BASIC EDITOR WITH ONLY ONE CHANGE IN THE COMMAND      EDIT0011
      *    STRUCTURE, THAT BEING THE ADDITION OF A "CHANGE" COMMAND     EDIT0012
      *    TO SERVE IN PLACE OF THE INSERT-DELETE COMBINATION WHICH     EDIT0013
      *    WAS REQUIRED IN PREVIOUS VERSIONS. RECORD NUMBER FIELDS      EDIT0014
      *    HAVE ALSO BEEN REDUCED FROM 5 DIGITS TO 4.                   EDIT0015
      *    CHANGE 1.                                                    EDIT0016
      *       MODIFY TO RUN ON TI-990.                                  EDIT0017
      *    CHANGE 2.                                                    EDIT0018
      *       MODIFY TO RUN ON GNUCOBOL.                                EDIT0019
                                                                        EDIT0020
       ENVIRONMENT DIVISION.                                            EDIT0021
       CONFIGURATION SECTION.                                           EDIT0022
       SOURCE-COMPUTER.                                                 EDIT0023
           IBM-360.                                                     EDIT0024
       OBJECT-COMPUTER.                                                 EDIT0025
           IBM-360.                                                     EDIT0026
       INPUT-OUTPUT SECTION.                                            EDIT0027
       FILE-CONTROL.                                                    EDIT0028
           SELECT OLD-VERSION  ASSIGN TO "SYSUT1"                       EDIT0029
                               ORGANIZATION LINE SEQUENTIAL.            EDIT0030
           SELECT NEW-VERSION  ASSIGN TO "SYSUT2"                       EDIT0031
                               ORGANIZATION LINE SEQUENTIAL.            EDIT0032
           SELECT PRT-VERSION  ASSIGN TO "SYSUT2"                       EDIT0033
                               ORGANIZATION LINE SEQUENTIAL.            EDIT0034
           SELECT MODIFICATION ASSIGN TO "SYSIN1"                       EDIT0035
                               ORGANIZATION LINE SEQUENTIAL.            EDIT0036
           SELECT COMMENTARY   ASSIGN TO "SYSOU1"                       EDIT0037
                               ORGANIZATION LINE SEQUENTIAL.            EDIT0038
                                                                        EDIT0039
       DATA DIVISION.                                                   EDIT0040
                                                                        EDIT0041
       FILE SECTION.                                                    EDIT0042
                                                                        EDIT0043
       FD  OLD-VERSION                                                  EDIT0044
           LABEL RECORDS ARE STANDARD                                   EDIT0045
           BLOCK CONTAINS 80 CHARACTERS                                 EDIT0046
           DATA RECORD IS OLD-RECORD.                                   EDIT0047
                                                                        EDIT0048
       01  OLD-RECORD.                                                  EDIT0049
           02 OLD-STATEMENT       PICTURE X(75).                        EDIT0050
           02 OLD-NUMBER          PICTURE X(5).                         EDIT0051
                                                                        EDIT0052
       FD  NEW-VERSION                                                  EDIT0053
           LABEL RECORDS ARE STANDARD                                   EDIT0054
           BLOCK CONTAINS 80 CHARACTERS                                 EDIT0055
           DATA RECORD IS NEW-RECORD.                                   EDIT0056
                                                                        EDIT0057
       01  NEW-RECORD.                                                  EDIT0058
           02 NEW-STATEMENT       PICTURE X(75).                        EDIT0059
           02 NEW-NUMBER          PICTURE X(5).                         EDIT0060
                                                                        EDIT0061
       FD  MODIFICATION                                                 EDIT0062
           LABEL RECORDS ARE OMITTED                                    EDIT0063
           BLOCK CONTAINS 80 CHARACTERS                                 EDIT0064
           DATA RECORD IS UPDATE-ORDER.                                 EDIT0065
                                                                        EDIT0066
       01  UPDATE-ORDER.                                                EDIT0067
           02 INSERTION.                                                EDIT0068
              03 COMMAND          PICTURE X(6).                         EDIT0069
                 88 ENDJOB        VALUE "ENDJOB".                       EDIT0070
                 88 ENDSET        VALUE "ENDSET".                       EDIT0071
                 88 REMOVE        VALUE "REMOVE".                       EDIT0072
                 88 ADDNEW        VALUE "INSERT".                       EDIT0073
                 88 CHANGE        VALUE "CHANGE".                       EDIT0074
                 88 DISPLY        VALUE "DISPLY".                       EDIT0075
              03 FILLER           PICTURE X.                            EDIT0076
              03 A-FIELD          PICTURE 9(5).                         EDIT0077
              03 A-ALPHA REDEFINES A-FIELD    PICTURE X(5).             EDIT0078
                 88 A-BLANK       VALUE SPACES.                         EDIT0079
              03 FILLER           PICTURE X(4).                         EDIT0080
              03 B-FIELD          PICTURE 9(5).                         EDIT0081
              03 B-ALPHA REDEFINES B-FIELD    PICTURE X(5).             EDIT0082
                 88 B-BLANK       VALUE SPACES.                         EDIT0083
              03 FILLER           PICTURE X(54).                        EDIT0084
           02 FILLER              PICTURE X(5).                         EDIT0085
                                                                        EDIT0086
       FD  COMMENTARY                                                   EDIT0087
           LABEL RECORDS ARE OMITTED                                    EDIT0088
           BLOCK CONTAINS 82 CHARACTERS                                 EDIT0089
           DATA RECORD IS COMMENT-LINE.                                 EDIT0090
                                                                        EDIT0091
       01  COMMENT-LINE.                                                EDIT0092
           02 FILLER              PICTURE X(82).                        EDIT0093
                                                                        EDIT0094
       WORKING-STORAGE SECTION.                                         EDIT0095
                                                                        EDIT0096
       77  COMMAND-ADDITIONS      PICTURE 9(3) COMPUTATIONAL VALUE 0.   EDIT0097
       77  COMMAND-SUBTRACTIONS   PICTURE 9(3) COMPUTATIONAL VALUE 0.   EDIT0098
       77  TOTAL-INSERTED         PICTURE 9(3) COMPUTATIONAL VALUE 0.   EDIT0099
       77  TOTAL-DELETED          PICTURE 9(3) COMPUTATIONAL VALUE 0.   EDIT0100
       77  OUTPUT-COUNT           PICTURE 9(5) COMPUTATIONAL VALUE 0.   EDIT0101
       77  LINE-COUNT             PICTURE 9(2) COMPUTATIONAL VALUE 0.   EDIT0102
       77  FIELDA                 PICTURE 9(5) VALUE 0.                 EDIT0103
       77  FIELDB                 PICTURE 9(5) VALUE 0.                 EDIT0104
       77  BLANK-LINE             PICTURE X(82) VALUE SPACES.           EDIT0105
                                                                        EDIT0106
       01  DATE-FROM-SYS.                                               EDIT0107
           02 DFSYS OCCURS 3 TIMES PICTURE 99.                          EDIT0108
                                                                        EDIT0109
       01  HEADINGS-LINE.                                               EDIT0110
           02 FILLER              PICTURE X(15) VALUE "EDITOR VERSION". EDIT0111
           02 FILLER              PICTURE X(20) VALUE "1.1 - 206/72".   EDIT0112
           02 PHASE               PICTURE X(17) VALUE "UPDATING AS OF". EDIT0113
           02 MONTH-RUN           PICTURE XX.                           EDIT0114
           02 FILLER              PICTURE X VALUE "/".                  EDIT0115
           02 DAY-RUN             PICTURE XX.                           EDIT0116
           02 FILLER              PICTURE X VALUE "/".                  EDIT0117
           02 YEAR-RUN            PICTURE XX.                           EDIT0118
           02 FILLER              PICTURE X(8) VALUE SPACES.            EDIT0119
           02 FILLER              PICTURE X(8) VALUE "  PAGE: ".        EDIT0120
           02 PAGE-NUMBER         PICTURE 9(4) VALUE 0.                 EDIT0121
                                                                        EDIT0122
       01  COMMAND-LISTING.                                             EDIT0123
           02 FILLER              PICTURE X(2) VALUE SPACES.            EDIT0124
           02 COMMAND-IMAGE       PICTURE X(80).                        EDIT0125
                                                                        EDIT0126
       01  ACTIVITIES-LISTING.                                          EDIT0127
           02 DISPOSITION         PICTURE X(2).                         EDIT0128
           02 ACTIVE-IMAGE        PICTURE X(80).                        EDIT0129
                                                                        EDIT0130
       01  UPSI-BYTE.                                                   EDIT0131
           02 UPSI-BIT OCCURS 8 TIMES  PICTURE X.                       EDIT0132
                                                                        EDIT0133
       01  MESSAGE-LOG.                                                 EDIT0134
           02 FILLER              PICTURE X(2) VALUE SPACES.            EDIT0135
           02 MESSAGE-TEXT        PICTURE X(80).                        EDIT0136
                                                                        EDIT0137
       01  DISPLAY-MESSAGE.                                             EDIT0138
           02 FILLER              PICTURE X(2) VALUE SPACES.            EDIT0139
           02 DISPLAY-TEMP        PICTURE X(6).                         EDIT0140
           02 FILLER              PICTURE X(2) VALUE SPACES.            EDIT0141
           02 DISPLAY-TEXT        PICTURE X(60).                        EDIT0142
                                                                        EDIT0143
       77  END-JOB-PROCESS        PICTURE 9 VALUE 0.                    EDIT0144
       77  DELETE-PROCESS         PICTURE 9 VALUE 1.                    EDIT0145
       77  INSERT-PROCESS         PICTURE 9 VALUE 2.                    EDIT0146
       77  WRITE-PROCESS          PICTURE 9 VALUE 3.                    EDIT0147
                                                                        EDIT0148
       01  SELECTORS.                                                   EDIT0149
           02 RETURN-SELECT       PICTURE 9 VALUE 0.                    EDIT0150
           02 NEXT-JOB-SELECT     PICTURE 9 VALUE 0.                    EDIT0151
                                                                        EDIT0152
       PROCEDURE DIVISION.                                              EDIT0153
                                                                        EDIT0154
       START-SECTION.                                                   EDIT0155
           OPEN INPUT OLD-VERSION, MODIFICATION,                        EDIT0156
                OUTPUT NEW-VERSION, COMMENTARY.                         EDIT0157
           MOVE "F" TO UPSI-BIT (1), UPSI-BIT (2).                      EDIT0158
           ACCEPT DATE-FROM-SYS FROM DATE.                              EDIT0159
           MOVE DFSYS (1) TO YEAR-RUN.                                  EDIT0160
           MOVE DFSYS (2) TO MONTH-RUN.                                 EDIT0161
           MOVE DFSYS (3) TO DAY-RUN.                                   EDIT0162
           READ OLD-VERSION AT END                                      EDIT0163
              MOVE "NO OLD VERSION FOUND" TO MESSAGE-TEXT               EDIT0164
              WRITE COMMENT-LINE FROM MESSAGE-LOG                       EDIT0165
              GO TO END-JOB.                                            EDIT0166
           MOVE OLD-STATEMENT TO NEW-STATEMENT.                         EDIT0167
           PERFORM OUTPUT-A-RECORD.                                     EDIT0168
                                                                        EDIT0169
       TOP-OF-PAGE-ROUTINE.                                             EDIT0170
           ADD 1 TO PAGE-NUMBER.                                        EDIT0171
           MOVE ZERO TO LINE-COUNT.                                     EDIT0172
           WRITE COMMENT-LINE FROM HEADINGS-LINE AFTER PAGE.            EDIT0173
           WRITE COMMENT-LINE FROM BLANK-LINE.                          EDIT0174
                                                                        EDIT0175
       READ-A-COMMAND.                                                  EDIT0176
           READ MODIFICATION AT END                                     EDIT0177
              MOVE "MODIFICATION FILE ENDED " TO MESSAGE-TEXT           EDIT0178
              WRITE COMMENT-LINE FROM MESSAGE-LOG                       EDIT0179
              GO TO FINISH-JOB.                                         EDIT0180
           MOVE UPDATE-ORDER TO COMMAND-IMAGE.                          EDIT0181
           WRITE COMMENT-LINE FROM COMMAND-LISTING.                     EDIT0182
           ADD 2 TO LINE-COUNT.                                         EDIT0183
           IF A-BLANK MOVE ZEROES TO A-FIELD.                           EDIT0184
           IF B-BLANK MOVE ZEROES TO B-FIELD.                           EDIT0185
           MOVE A-FIELD TO FIELDA.                                      EDIT0186
           MOVE B-FIELD TO FIELDB.                                      EDIT0187
                                                                        EDIT0188
       TEST-COMMAND-TYPE.                                               EDIT0189
           IF CHANGE GO TO CHANGE-A-RECORD.                             EDIT0190
           IF REMOVE GO TO DELETE-A-RECORD.                             EDIT0191
           IF DISPLY MOVE "T" TO UPSI-BIT (2)                           EDIT0192
              GO TO FINISH-JOB.                                         EDIT0193
           IF ENDJOB GO TO FINISH-JOB.                                  EDIT0194
           IF ADDNEW GO TO INSERT-A-RECORD.                             EDIT0195
           MOVE "INVALID COMMAND IGNORED." TO MESSAGE-TEXT.             EDIT0196
           WRITE COMMENT-LINE FROM MESSAGE-LOG.                         EDIT0197
           GO TO READ-A-COMMAND.                                        EDIT0198
                                                                        EDIT0199
       CHANGE-A-RECORD.                                                 EDIT0200
           ALTER RETURN-TO-USER TO PROCEED TO INSERTION-PROCESS.        EDIT0201
           ALTER NEXT-JOB-STEP TO PROCEED TO DELETION-PROCESS.          EDIT0202
                                                                        EDIT0205
       FIND-FIELDA.                                                     EDIT0206
           IF OLD-NUMBER IS GREATER THAN FIELDA                         EDIT0207
              MOVE "RECORD ALREADY PASSED" TO MESSAGE-TEXT              EDIT0208
              WRITE COMMENT-LINE FROM MESSAGE-LOG                       EDIT0209
              GO TO READ-A-COMMAND.                                     EDIT0210
           READ OLD-VERSION AT END                                      EDIT0211
              MOVE "NOT FOUND IN OLD VERSION" TO DISPLAY-TEXT           EDIT0212
              MOVE FIELDA TO DISPLAY-TEMP                               EDIT0213
              WRITE COMMENT-LINE FROM DISPLAY-MESSAGE                   EDIT0214
              GO TO END-JOB.                                            EDIT0215
           IF OLD-NUMBER IS LESS THAN FIELDA                            EDIT0216
              MOVE OLD-STATEMENT TO NEW-STATEMENT                       EDIT0217
              PERFORM OUTPUT-A-RECORD                                   EDIT0218
              GO TO FIND-FIELDA.                                        EDIT0219
                                                                        EDIT0220
       RETURN-TO-USER.                                                  EDIT0221
           GO TO END-JOB.                                               EDIT0223
                                                                        EDIT0228
       INSERT-A-RECORD.                                                 EDIT0229
           ALTER RETURN-TO-USER TO PROCEED TO INSERTION-PROCESS.        EDIT0230
           ALTER NEXT-JOB-STEP TO PROCEED TO FORCED-WRITE.              EDIT0231
           GO TO FIND-FIELDA.                                           EDIT0234
                                                                        EDIT0235
       INSERTION-PROCESS.                                               EDIT0236
           READ MODIFICATION AT END                                     EDIT0237
              MOVE "NO ENDSET FOUND" TO MESSAGE-TEXT                    EDIT0238
              WRITE COMMENT-LINE FROM MESSAGE-LOG                       EDIT0239
              GO TO END-JOB.                                            EDIT0240
           IF ENDSET                                                    EDIT0241
              MOVE COMMAND-ADDITIONS TO DISPLAY-TEMP                    EDIT0242
              MOVE "RECORDS INSERTED." TO DISPLAY-TEXT                  EDIT0243
              WRITE COMMENT-LINE FROM DISPLAY-MESSAGE                   EDIT0244
              ADD COMMAND-ADDITIONS TO TOTAL-INSERTED                   EDIT0245
              MOVE ZEROES TO COMMAND-ADDITIONS                          EDIT0246
              GO TO NEXT-JOB-STEP.                                      EDIT0247
           MOVE INSERTION TO NEW-STATEMENT, ACTIVE-IMAGE.               EDIT0248
           MOVE "I " TO DISPOSITION.                                    EDIT0249
           PERFORM OUTPUT-A-RECORD.                                     EDIT0250
           WRITE COMMENT-LINE FROM ACTIVITIES-LISTING.                  EDIT0251
           ADD 1 TO COMMAND-ADDITIONS.                                  EDIT0252
           ADD 1 TO LINE-COUNT.                                         EDIT0253
           IF LINE-COUNT EQUAL 56 PERFORM TOP-OF-PAGE-ROUTINE.          EDIT0254
           GO TO INSERTION-PROCESS.                                     EDIT0255
                                                                        EDIT0256
       NEXT-JOB-STEP.                                                   EDIT0257
           GO TO END-JOB.                                               EDIT0259
                                                                        EDIT0264
       FORCED-WRITE.                                                    EDIT0265
           MOVE OLD-STATEMENT TO NEW-STATEMENT.                         EDIT0266
           PERFORM OUTPUT-A-RECORD.                                     EDIT0267
           GO TO READ-A-COMMAND.                                        EDIT0268
                                                                        EDIT0269
       DELETE-A-RECORD.                                                 EDIT0270
           ALTER RETURN-TO-USER TO PROCEED TO DELETION-PROCESS.         EDIT0271
           GO TO FIND-FIELDA.                                           EDIT0273
                                                                        EDIT0274
       DELETION-PROCESS.                                                EDIT0275
           MOVE OLD-RECORD TO ACTIVE-IMAGE.                             EDIT0276
           MOVE "D " TO DISPOSITION.                                    EDIT0277
           WRITE COMMENT-LINE FROM ACTIVITIES-LISTING.                  EDIT0278
           ADD 1 TO LINE-COUNT.                                         EDIT0279
           IF LINE-COUNT EQUAL 56 PERFORM TOP-OF-PAGE-ROUTINE.          EDIT0280
           ADD 1 TO COMMAND-SUBTRACTIONS.                               EDIT0281
           IF OLD-NUMBER IS NOT LESS THAN FIELDB                        EDIT0282
              MOVE COMMAND-SUBTRACTIONS TO DISPLAY-TEMP                 EDIT0283
              MOVE "RECORDS DELETED." TO DISPLAY-TEXT                   EDIT0284
              WRITE COMMENT-LINE FROM DISPLAY-MESSAGE                   EDIT0285
              ADD COMMAND-SUBTRACTIONS TO TOTAL-DELETED                 EDIT0286
              MOVE OLD-STATEMENT TO NEW-STATEMENT                       EDIT0287
              MOVE ZEROES TO COMMAND-SUBTRACTIONS                       EDIT0288
              GO TO READ-A-COMMAND.                                     EDIT0289
           READ OLD-VERSION AT END                                      EDIT0290
              MOVE "NOT FOUND IN OLD VERSION DOING DELETE"              EDIT0291
                    TO DISPLAY-TEXT                                     EDIT0292
              WRITE COMMENT-LINE FROM DISPLAY-MESSAGE                   EDIT0293
              GO TO END-JOB.                                            EDIT0294
           GO TO DELETION-PROCESS.                                      EDIT0295
                                                                        EDIT0296
       OUTPUT-A-RECORD.                                                 EDIT0297
           ADD 1 TO OUTPUT-COUNT.                                       EDIT0298
           MOVE OUTPUT-COUNT TO NEW-NUMBER.                             EDIT0299
           WRITE NEW-RECORD.                                            EDIT0300
                                                                        EDIT0301
       FINISH-JOB.                                                      EDIT0302
           READ OLD-VERSION AT END GO TO TEST-FOR-LISTING.              EDIT0303
           MOVE OLD-STATEMENT TO NEW-STATEMENT.                         EDIT0304
           GO TO OUTPUT-A-RECORD.                                       EDIT0305
                                                                        EDIT0306
       TEST-FOR-LISTING.                                                EDIT0307
           PERFORM TOP-OF-PAGE-ROUTINE.                                 EDIT0308
           MOVE OLD-NUMBER TO DISPLAY-TEMP.                             EDIT0309
           MOVE "RECORDS READ." TO DISPLAY-TEXT.                        EDIT0310
           WRITE COMMENT-LINE FROM DISPLAY-MESSAGE.                     EDIT0311
           MOVE TOTAL-INSERTED TO DISPLAY-TEMP.                         EDIT0312
           MOVE "RECORDS ADDED." TO DISPLAY-TEXT.                       EDIT0313
           WRITE COMMENT-LINE FROM DISPLAY-MESSAGE.                     EDIT0314
           MOVE TOTAL-DELETED TO DISPLAY-TEMP.                          EDIT0315
           MOVE "RECORDS DROPPED." TO DISPLAY-TEXT.                     EDIT0316
           WRITE COMMENT-LINE FROM DISPLAY-MESSAGE.                     EDIT0317
           MOVE OUTPUT-COUNT TO DISPLAY-TEMP.                           EDIT0318
           MOVE "RECORDS IN NEW FILE." TO DISPLAY-TEXT.                 EDIT0319
           WRITE COMMENT-LINE FROM DISPLAY-MESSAGE.                     EDIT0320
           IF UPSI-BIT (2) EQUAL "F" GO TO END-JOB.                     EDIT0321
           CLOSE NEW-VERSION.                                           EDIT0322
           OPEN INPUT NEW-VERSION.                                      EDIT0323
           MOVE "UPDATED LISTING" TO PHASE.                             EDIT0324
           MOVE ZEROES TO PAGE-NUMBER.                                  EDIT0325
           PERFORM TOP-OF-PAGE-ROUTINE.                                 EDIT0326
           MOVE SPACES TO DISPOSITION.                                  EDIT0327
                                                                        EDIT0328
       LISTING-LOOP.                                                    EDIT0329
           READ NEW-VERSION AT END GO TO END-JOB.                       EDIT0330
           MOVE NEW-RECORD TO ACTIVE-IMAGE.                             EDIT0331
           WRITE COMMENT-LINE FROM ACTIVITIES-LISTING.                  EDIT0332
           ADD 1 TO LINE-COUNT.                                         EDIT0333
           IF LINE-COUNT EQUAL 56 PERFORM TOP-OF-PAGE-ROUTINE.          EDIT0334
           GO TO LISTING-LOOP.                                          EDIT0335
                                                                        EDIT0336
       END-JOB.                                                         EDIT0337
           MOVE "PROGRAM TERMINATION" TO MESSAGE-TEXT.                  EDIT0338
           WRITE COMMENT-LINE FROM MESSAGE-LOG.                         EDIT0339
           CLOSE OLD-VERSION, NEW-VERSION, MODIFICATION, COMMENTARY.    EDIT0340
           STOP RUN.                                                    EDIT0341
                                                                        EDIT0342
       END PROGRAM EDITOR.                                              EDIT0343