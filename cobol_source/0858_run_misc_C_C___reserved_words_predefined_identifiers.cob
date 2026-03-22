IDENTIFICATION   DIVISION.
       PROGRAM-ID.      caller.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
      *
      * Reserved Words in C (that aren't reserved in COBOL)
      * var names MUST BE IN LOWER CASE (!)
      *
       77  const                       PIC X VALUE "A".
       77  double                      PIC X VALUE "B".
       77  float                       PIC X VALUE "C".
       77  int                         PIC X VALUE "D".
       77  short                       PIC X VALUE "E".
       77  struct                      PIC X VALUE "F".
       77  break                       PIC X VALUE "G".
       77  long                        PIC X VALUE "H".
       77  switch                      PIC X VALUE "I".
       77  void                        PIC X VALUE "J".
       77  case                        PIC X VALUE "K".
       77  enum                        PIC X VALUE "L".
       77  goto                        PIC X VALUE "M".
       77  register                    PIC X VALUE "N".
       77  sizeof                      PIC X VALUE "O".
       77  volatile                    PIC X VALUE "P".
       77  char                        PIC X VALUE "Q".
       77  do                          PIC X VALUE "R".
       77  extern                      PIC X VALUE "S".
       77  static                      PIC X VALUE "T".
       77  union                       PIC X VALUE "U".
       77  while                       PIC X VALUE "V".
      *
      * More Reserved Words in C++
      * var names MUST BE IN LOWER CASE (!)
      *
       77  asm                         PIC X VALUE "W".
       77  dynamic_cast                PIC X VALUE "X".
       77  namespace                   PIC X VALUE "Y".
       77  reinterpret_cast            PIC X VALUE "Z".
       77  try                         PIC X VALUE "a".
       77  bool                        PIC X VALUE "b".
       77  explicit                    PIC X VALUE "c".
       77  new                         PIC X VALUE "d".
       77  static_cast                 PIC X VALUE "e".
       77  typeid                      PIC X VALUE "f".
       77  catch                       PIC X VALUE "g".
       77  operator                    PIC X VALUE "h".
       77  template                    PIC X VALUE "i".
       77  typename                    PIC X VALUE "j".
       77  friend                      PIC X VALUE "k".
       77  private                     PIC X VALUE "l".
       77  this                        PIC X VALUE "m".
       77  const_cast                  PIC X VALUE "n".
       77  inline                      PIC X VALUE "o".
       77  public                      PIC X VALUE "p".
       77  throw                       PIC X VALUE "q".
       77  virtual                     PIC X VALUE "r".
       77  mutable                     PIC X VALUE "s".
       77  protected                   PIC X VALUE "t".
       77  wchar_t                     PIC X VALUE "u".
      *
      * More Reserved Words in C++ (not essential)
      * var names MUST BE IN LOWER CASE (!)
      *
       77  bitand                      PIC X VALUE "v".
       77  compl                       PIC X VALUE "w".
       77  not_eq                      PIC X VALUE "x".
       77  or_eq                       PIC X VALUE "y".
       77  xor_eq                      PIC X VALUE "z".
       77  and_eq                      PIC X VALUE "0".
       77  bitor                       PIC X VALUE "1".
       77  xor                         PIC X VALUE "2".
      *
       PROCEDURE        DIVISION.
           CALL "callee" USING   const
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
           END-CALL.
           CALL "callee2" USING  asm
                                 dynamic_cast
                                 namespace
                                 reinterpret_cast
                                 try
                                 bool
                                 explicit
                                 new
                                 static_cast
                                 typeid
                                 catch
                                 operator
                                 template
                                 typename
                                 friend
                                 private
                                 this
                                 const_cast
                                 inline
                                 public
                                 throw
                                 virtual
                                 mutable
                                 protected
                                 wchar_t
                                 bitand
                                 compl
                                 not_eq
                                 or_eq
                                 xor_eq
                                 and_eq
                                 bitor
                                 xor
           END-CALL.
           MOVE x'00' TO         const
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
                                 extern
                                 static
                                 union
                                 while
                                 asm
                                 dynamic_cast
                                 namespace
                                 reinterpret_cast
                                 try
                                 bool
                                 explicit
                                 new
                                 static_cast
                                 typeid
                                 catch
                                 operator
                                 template
                                 typename
                                 friend
                                 private
                                 this
                                 const_cast
                                 inline
                                 public
                                 throw
                                 virtual
                                 mutable
                                 protected
                                 wchar_t
                                 bitand
                                 compl
                                 not_eq
                                 or_eq
                                 xor_eq
                                 and_eq
                                 bitor
                                 xor
                                 .
           STOP RUN.