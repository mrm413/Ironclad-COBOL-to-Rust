IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee.
       DATA             DIVISION.
       LINKAGE SECTION.
      *
      * Reserved Words in C (that aren't reserved in COBOL)
      * var names MUST BE IN LOWER CASE (!)
      *
       77  const                       PIC X.
       77  double                      PIC X.
       77  float                       PIC X.
       77  int                         PIC X.
       77  short                       PIC X.
       77  struct                      PIC X.
       77  break                       PIC X.
       77  long                        PIC X.
       77  switch                      PIC X.
       77  void                        PIC X.
       77  case                        PIC X.
       77  enum                        PIC X.
       77  goto                        PIC X.
       77  register                    PIC X.
       77  sizeof                      PIC X.
       77  volatile                    PIC X.
       77  char                        PIC X.
       77  do                          PIC X.
      *77  extern                      PIC X.
      *77  static                      PIC X.
       77  union                       PIC X.
       77  while                       PIC X.
       PROCEDURE        DIVISION USING
                                 const
                                 double
                                 float
                                 int
                                 short
                                 struct
                                 break
                                 long
                                 switch
                                 void
                                 case
                                 enum
                                 goto
                                 register
                                 sizeof
                                 volatile
                                 char
                                 do
                                *>extern
                                *>static
                                 union
                                 while
                                 .
           IF (const                       NOT = "A") OR
              (double                      NOT = "B") OR
              (float                       NOT = "C") OR
              (int                         NOT = "D") OR
              (short                       NOT = "E") OR
              (struct                      NOT = "F") OR
              (break                       NOT = "G") OR
              (long                        NOT = "H") OR
              (switch                      NOT = "I") OR
              (void                        NOT = "J") OR
              (case                        NOT = "K") OR
              (enum                        NOT = "L") OR
              (goto                        NOT = "M") OR
              (register                    NOT = "N") OR
              (sizeof                      NOT = "O") OR
              (volatile                    NOT = "P") OR
              (char                        NOT = "Q") OR
              (do                          NOT = "R") OR
            *>(extern                      NOT = "S") OR
            *>(static                      NOT = "T") OR
              (union                       NOT = "U") OR
              (while                       NOT = "V")
              DISPLAY "At least one var has wrong content!".
           MOVE x'FF' TO         const
                                 double
                                 float
                                 int
                                 short
                                 struct
                                 break
                                 long
                                 switch
                                 void
                                 case
                                 enum
                                 goto
                                 register
                                 sizeof
                                 volatile
                                 char
                                 do
                               *>extern
                               *>static
                                 union
                                 while
                                 .
           EXIT PROGRAM.