IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 DOLLARS.
           05  REPORT-LINE.
               10  REPORT-ITEMS                PIC ZZ,ZZZ,ZZZ,ZZ9-.
               10  REPORT-FICA-WAGES           PIC
                     $$$,$$$,$$$,$$$,$$$.99-.
               10  REPORT-FICA-TIPS            PIC
                     $$$,$$$,$$$,$$$,$$$.99-.
               10  REPORT-TOTAL-COMP           PIC
                     $$$,$$$,$$$,$$$,$$$.99-.
               10  REPORT-MEDICARE             PIC
                     $$$,$$$,$$$,$$$,$$$.99-.
           05  ACCT-REPORT-TOTAL-LINE          PIC XXX.