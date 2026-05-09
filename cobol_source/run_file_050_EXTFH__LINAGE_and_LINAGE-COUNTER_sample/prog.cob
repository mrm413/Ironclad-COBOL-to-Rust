IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           select optional data-file assign to 'prog.cob'
               organization is line sequential
               file status is data-file-status.
           select mini-report assign to "mini-report".

       DATA DIVISION.
       FILE SECTION.
       FD  data-file.
       01  data-record.
           88 endofdata        value high-values.
           02 data-line        pic x(80).
       FD  mini-report
           linage is 16 lines
               with footing at 15
               lines at top 2
               lines at bottom 2.
       01  report-line         pic x(80).

       WORKING-STORAGE SECTION.
       01  command-arguments   pic x(1024).
       01  file-name           pic x(160).
       01  data-file-status    pic xx.
       01  lc                  pic 99.
       01  report-line-blank.
           02 filler           pic x(18) value all "*".
           02 filler           pic x(05) value spaces.
           02 filler           pic x(34)
               VALUE "THIS PAGE INTENTIONALLY LEFT BLANK".
           02 filler           pic x(05) value spaces.
           02 filler           pic x(18) value all "*".
       01  report-line-data.
           02 body-tag         pic 9(6).
           02 line-3           pic x(74).
       01  report-line-header.
           02 filler           pic x(6) VALUE "PAGE: ".
           02 page-no          pic 9999.
           02 filler           pic x(24).
           02 filler           pic x(5) VALUE " LC: ".
           02 header-tag       pic 9(6).




       01  page-count          pic 9999.

       PROCEDURE DIVISION.
       main.
           open input data-file.
           read data-file
               at end
                   display "File open error: " data-file-status
                   stop run
           end-read.

           open output mini-report.

           write report-line
               from report-line-blank
           end-write.

           move 1 to page-count.
           move page-count to page-no.
           write report-line
               from report-line-header
               after advancing page
           end-write.

           perform readwrite-loop until endofdata.

           display
               "Normal termination, ending status: "
               data-file-status
           close mini-report.

           close data-file.
           stop run.

      ****************************************************************
       readwrite-loop.
           move data-record to report-line-data
           move linage-counter to body-tag
           write report-line from report-line-data
               end-of-page
                   add 1 to page-count end-add
                   move page-count to page-no
                   move linage-counter to header-tag
                   write report-line from report-line-header
                       after advancing page
                   end-write
           end-write
           read data-file
               at end set endofdata to true
           end-read
           .