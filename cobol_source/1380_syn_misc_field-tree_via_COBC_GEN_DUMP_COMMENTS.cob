identification division.
       program-id. debugme.
       data division.
       working-storage section.
       01  numeric-data.
           05 disp     usage display        pic s99v999  value -12.34.
           05 disp-u   usage display        pic  99v999  value  12.34.
           05 dispp    usage display        pic sppp9999 value -.000123.
           05 dispp-u  usage display        pic  ppp9999 value  .000123.
           05 disppp   usage display        pic s9999ppp value -1234000.
           05 disppp-u usage display        pic  9999ppp value  1234000.
           05 bin      usage binary         pic s99v999  value -12.34.
           05 bin-u    usage binary         pic  99v999  value  12.34.
           05 cmp3     usage packed-decimal pic s99v999  value -12.34.
           05 cmp3-u   usage packed-decimal pic  99v999  value  12.34.
           05 cmp5     usage comp-5         pic s99v999  value -12.34.
           05 cmp5-u   usage comp-5         pic  99v999  value  12.34.
           05 cmp6     usage comp-6         pic  99v999  value  12.34.
           05 cmpx     usage comp-x         pic s99v999  value -12.34.
           05 cmpx-u   usage comp-x         pic  99v999  value  12.34.
           05 cmpn     usage comp-n         pic s99v999  value -12.34.
           05 cmpn-u   usage comp-n         pic  99v999  value  12.34.
           05 chr      usage binary-char    signed    value -128.
           05 chr-u    usage binary-char    unsigned  value  254.
           05 shrt     usage binary-short   signed    value -32768.
           05 shrt-u   usage binary-short   unsigned  value  65535.
           05 long     usage binary-long    signed    value -2147483648.
           05 long-u   usage binary-long    unsigned  value  4294967295.
           05 dble     usage binary-double  signed    value -4294967295.
           05 dble-u   usage binary-double  unsigned  value  8294967295.
      *   05 cmp0       usage comp-0.  TODO
       01  floating-data.
           05 dbl       usage float-long      value -3.40282e+038.
           05 flt       usage float-short     value 3.40282e+038.
      *   05 b32        usage FLOAT-BINARY-32  signed.      TODO
      *   05 b64        usage FLOAT-BINARY-64  signed.      TODO
      *   05 b128       usage FLOAT-BINARY-128 signed.      TODO
      *   05 b32-u      usage FLOAT-BINARY-32  unsigned.    TODO
      *   05 b64-u      usage FLOAT-BINARY-64  unsigned.    TODO
      *   05 b128-u     usage FLOAT-BINARY-128 unsigned.    TODO
      *
      *  --> missing:   floating point edited pictures,
      *                 those are left to the reader as excercise :-)
       77 x36            pic x(36) is typedef.
      * In the following block, "sync" prevents SIGBUS errors on SOLARIS systems.
       01  special-data.
           05 r2d2       usage bit pic 111 value b'110'.
      *>   disabled for now because of varying size
      *>   05 point      usage pointer         sync.
      *>   05 ppoint     usage program-pointer sync.
      *>   05 idx        usage index           sync.
      *>   05 hnd        usage handle          sync.
       01  alphanumeric-data.
           05 alpnum     usage x36 value "some numb3rs 4 n00bs l1k3 m3".
           05 alpha      pic a(36) value "thats some text".
           05 edit-num1  pic --9.999.
           05 edit-num2  pic ++9.999.
           05 edit-num3  pic zz9.999.
           05 edit-num4  pic -zz9.999   blank when zero.
       01  national-data.
           05 nat        pic n(36) value "data shown here will change.".
           05 nat-num    pic 9(12)v9(3) usage national.
           05 net-num1   pic --9.999    usage national.
           05 net-num2   pic ++9.999    usage national.
           05 net-num3   pic zz9.999    usage national.
           05 net-num4   pic -zz9.999   usage national blank when zero.
      *
       01 occurs 2 to 5 times depending on chr indexed by x-idx.
         03 x-basis.
           05  x-a                 pic x(01) value space.
           05  x-b                 pic x(01) value space.
           05  x-c                 pic x(01) value space.
         03 filler redefines x-basis pic x(03).
           88  sw-x-basis-full     value "xxx".
       01  x-rms.                  
           05  x-rms-a             pic x(01) value space.
       01 filler redefines x-rms   pic x(01).
           88  sw-x-rms-full       value "X" or "A" thru "C" or QUOTE.

       local-storage section.
       01  var1       pic x.
       01  var2.
          03  var2a   pic x.
          03  var2b   pic 9.
           88 yay     values zero, 2 through 5, 9.