program-id. prog.
       data division.
       working-storage section.
       01 default-float usage float-long.
       01 no-pointer    pic s9(9) comp.

       linkage section.
       01 float-var usage float-long.

       procedure division .
      *> previously generated error message about invalid MOVE statement,
      *> see bug #255 and an internal compiler error, see bug #295:
           set address of float-var to default-float
           set no-pointer to address of default-float
      *> previously raised internal compiler error, see bug #643:
           set 1 to no-pointer
      *> all fine...
           set address of float-var to address of default-float
           goback.
       end program prog .