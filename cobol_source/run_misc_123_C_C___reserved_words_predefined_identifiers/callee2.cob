IDENTIFICATION   DIVISION.
       PROGRAM-ID.      callee2.
       DATA             DIVISION.
       LINKAGE SECTION.
      *
      * More Reserved Words in C++
      * var names MUST BE IN LOWER CASE (!)
      *
       77  asm                         PIC X.
       77  dynamic_cast                PIC X.
       77  namespace                   PIC X.
       77  reinterpret_cast            PIC X.
       77  try                         PIC X.
       77  bool                        PIC X.
       77  explicit                    PIC X.
       77  new                         PIC X.
       77  static_cast                 PIC X.
       77  typeid                      PIC X.
       77  catch                       PIC X.
       77  operator                    PIC X.
       77  template                    PIC X.
       77  typename                    PIC X.
       77  friend                      PIC X.
       77  private                     PIC X.
       77  this                        PIC X.
       77  const_cast                  PIC X.
       77  inline                      PIC X.
       77  public                      PIC X.
       77  throw                       PIC X.
       77  virtual                     PIC X.
       77  mutable                     PIC X.
       77  protected                   PIC X.
       77  wchar_t                     PIC X.
      *
      * More Reserved Words in C++ (not essential)
      *
       77  bitand                      PIC X.
       77  compl                       PIC X.
       77  not_eq                      PIC X.
       77  or_eq                       PIC X.
       77  xor_eq                      PIC X.
       77  and_eq                      PIC X.
       77  bitor                       PIC X.
       77  xor                         PIC X.
       PROCEDURE        DIVISION USING
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
           IF (asm                         NOT = "W") OR
              (dynamic_cast                NOT = "X") OR
              (namespace                   NOT = "Y") OR
              (reinterpret_cast            NOT = "Z") OR
              (try                         NOT = "a") OR
              (bool                        NOT = "b") OR
              (explicit                    NOT = "c") OR
              (new                         NOT = "d") OR
              (static_cast                 NOT = "e") OR
              (typeid                      NOT = "f") OR
              (catch                       NOT = "g") OR
              (operator                    NOT = "h") OR
              (template                    NOT = "i") OR
              (typename                    NOT = "j") OR
              (friend                      NOT = "k") OR
              (private                     NOT = "l") OR
              (this                        NOT = "m") OR
              (const_cast                  NOT = "n") OR
              (inline                      NOT = "o") OR
              (public                      NOT = "p") OR
              (throw                       NOT = "q") OR
              (virtual                     NOT = "r") OR
              (mutable                     NOT = "s") OR
              (protected                   NOT = "t") OR
              (wchar_t                     NOT = "u") OR
              (bitand                      NOT = "v") OR
              (compl                       NOT = "w") OR
              (not_eq                      NOT = "x") OR
              (or_eq                       NOT = "y") OR
              (xor_eq                      NOT = "z") OR
              (and_eq                      NOT = "0") OR
              (bitor                       NOT = "1") OR
              (xor                         NOT = "2")
              DISPLAY "At least one var has wrong content!".
           MOVE x'FF' TO         asm
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
           EXIT PROGRAM.