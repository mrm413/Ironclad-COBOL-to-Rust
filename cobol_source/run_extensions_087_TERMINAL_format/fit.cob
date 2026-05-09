* Sample program in ACU terminal format, and with longer lines and truncated literals.

IDENTIFICATION   DIVISION.
PROGRAM-ID.      fit.
DATA             DIVISION.
WORKING-STORAGE  SECTION.
PROCEDURE        DIVISION.
      DISPLAY '   20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250       260       270       280       290       300       310      319'
\D    DISPLAY '   20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250       260       270       280       290       300       310      319'
\D    END-DISPLAY.
      DISPLAY '   20        30        40        50        60        70        80        90       100       110       120       130
-             '       140       150       160       170       180       190       200       210       220       230       240       250       260       270       280       290       300       310      319'
      STOP RUN.