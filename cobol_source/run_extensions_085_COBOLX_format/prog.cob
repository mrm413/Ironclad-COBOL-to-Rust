>>SOURCE FORMAT COBOLX
 IDENTIFICATION DIVISION.
 PROGRAM-ID. prog.
* area B can extend up to character position 255
 PROCEDURE DIVISION.
/
                                                        DISPLAY "Hello!"
                                                                                                                                                                                                                                                  DISPLAY "Hi!"
DDISPLAY "Hey!"
D                                                         DISPLAY "Bye!"
* trucated alphanumeric literals are not padded with spaces
 DISPLAY "        20        30        40        50        60        70        80        90       100       110       120       130
-        "       140       150       160       170       180       190       200       210       220       230       240       250"
 .