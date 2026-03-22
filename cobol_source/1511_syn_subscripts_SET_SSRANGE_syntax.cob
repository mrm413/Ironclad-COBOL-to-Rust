*> Valid
      $SET SSRANGE
      $SET SSRANGE(1)
      $SET SSRANGE "2"
      $SET SSRANGE (3)

       *> Invalid
      $SET SSRANGE(0)
      $SET SSRANGE(4)
      $SET SSRANGE "variable"

       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       PROCEDURE DIVISION.
           GOBACK
           .