IDENTIFICATION DIVISION.
       PROGRAM-ID. PDTESTR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
       FUNCTION HEX-OF INTRINSIC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * DATA-AREA

       77  FLD0001A                       PIC  9(08)V9(19) COMP-3
           VALUE  72210483.5706116943150334464.
       77  FLD0001B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0002A                       PIC  9(05)V9(26) COMP-6
           VALUE  83954.98773698940597753903603006.
       77  FLD0002B                       PIC  9(05)V9(27) COMP-6
           VALUE  85526.912891598327881581553810974.

       77  FLD0003A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0003B                       PIC  9(10)V9(08) COMP-6
           VALUE  4976916625.40136914.

       77  FLD0004A                       PIC S9(08)V9(03) COMP-3
           VALUE +31348416.669.
       77  FLD0004B                       PIC  9(05)V9(01) COMP-6
           VALUE  16799.5.

       77  FLD0005A                       PIC S9(07)V9(01) COMP-3
           VALUE +2337334.8.
       77  FLD0005B                       PIC S9(09)V9(03) COMP-3
           VALUE +324331791.973.

       77  FLD0006A                       PIC  9(04)       COMP-6
           VALUE  1169.
       77  FLD0006B                       PIC  9(03)V9(31) COMP-3
           VALUE  912.5850054312464321171205483551602.

       77  FLD0007A                       PIC S9(04)       COMP-3
           VALUE +1123.
       77  FLD0007B                       PIC S9(08)V9(02) COMP-3
           VALUE -27032151.91.

       77  FLD0008A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0008B                       PIC S9(03)       COMP-3
           VALUE -091.

       77  FLD0009A                       PIC  9(10)V9(07) COMP-6
           VALUE  4695987895.4491957.
       77  FLD0009B                       PIC  9(05)V9(28) COMP-3
           VALUE  87164.4396861416259625343627703841.

       77  FLD0010A                       PIC  9(03)V9(32) COMP-3
           VALUE  932.59120224122482589734772773226723.
       77  FLD0010B                       PIC S9(09)V9(06) COMP-3
           VALUE +401314086.816856.

       77  FLD0011A                       PIC  9(09)V9(04) COMP-6
           VALUE  356168291.4830.
       77  FLD0011B                       PIC  9(04)V9(29) COMP-6
           VALUE  8869.25340695890795927880390081554.

       77  FLD0012A                       PIC  9(03)       COMP-6
           VALUE  087.
       77  FLD0012B                       PIC  9(08)V9(19) COMP-3
           VALUE  71485769.2486604356929547066.

       77  FLD0013A                       PIC  9(06)V9(25) COMP-6
           VALUE  829630.0004717120923913853403064.
       77  FLD0013B                       PIC  9(07)V9(02) COMP-6
           VALUE  2497013.60.

       77  FLD0014A                       PIC  9(09)V9(13) COMP-3
           VALUE  592943121.2490873237541.
       77  FLD0014B                       PIC  9(06)V9(01) COMP-6
           VALUE  186764.7.

       77  FLD0015A                       PIC  9(07)V9(23) COMP-6
           VALUE  7984732.71412134533164817185024.
       77  FLD0015B                       PIC  9(10)V9(08) COMP-6
           VALUE  4953047329.19498391.

       77  FLD0016A                       PIC  9(05)V9(28) COMP-3
           VALUE  87275.9557853607148558694461826235.
       77  FLD0016B                       PIC S9(10)V9(06) COMP-3
           VALUE +4316165362.791636.

       77  FLD0017A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0017B                       PIC  9(04)V9(30) COMP-6
           VALUE  8983.341087204116393039043941826093.

       77  FLD0018A                       PIC  9(07)V9(21) COMP-3
           VALUE  7619026.805277494540646898713.
       77  FLD0018B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0019A                       PIC S9(10)V9(08) COMP-3
           VALUE -4930528885.68236813.
       77  FLD0019B                       PIC S9(09)V9(06) COMP-3
           VALUE +402620216.542097.

       77  FLD0020A                       PIC  9(09)V9(15) COMP-3
           VALUE  643887452.720044328735582.
       77  FLD0020B                       PIC  9(09)V9(11) COMP-3
           VALUE  552340679.26366126055.

       77  FLD0021A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.880441680787707126043528660375159233.
       77  FLD0021B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0022A                       PIC  9(06)V9(24) COMP-3
           VALUE  810040.192546636172998830716096.
       77  FLD0022B                       PIC  9(07)V9(21) COMP-3
           VALUE  7610660.641468062204140210269.

       77  FLD0023A                       PIC  9(02)       COMP-6
           VALUE  06.
       77  FLD0023B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.1865432391802879230624512274516746.

       77  FLD0024A                       PIC  9(09)V9(03) COMP-6
           VALUE  329406009.124.
       77  FLD0024B                       PIC S9(09)V9(06) COMP-3
           VALUE +410668612.232476.

       77  FLD0025A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0025B                       PIC  9(07)V9(02) COMP-6
           VALUE  2497488.27.

       77  FLD0026A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0026B                       PIC S9(09)V9(05) COMP-3
           VALUE -383757196.20564.

       77  FLD0027A                       PIC  9(09)V9(13) COMP-3
           VALUE  601026867.0937520818498.
       77  FLD0027B                       PIC  9(06)V9(25) COMP-6
           VALUE  815849.1045356750515082921992870.

       77  FLD0028A                       PIC  9(04)V9(29) COMP-6
           VALUE  8794.72782911061568000832266989164.
       77  FLD0028B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0029A                       PIC  9(05)       BINARY
           VALUE  13697.
       77  FLD0029B                       PIC  9(09)V9(17) COMP-3
           VALUE  684374480.18294422258378517.

       77  FLD0030A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0030B                       PIC  9(08)V9(18) COMP-3
           VALUE  70264210.169553353857452293.

       77  FLD0031A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0031B                       PIC  9(08)V9(18) COMP-3
           VALUE  70450280.588407820925311852.

       77  FLD0032A                       PIC  9(10)V9(10) COMP-6
           VALUE  5269599769.4606222516.
       77  FLD0032B                       PIC S9(09)V9(03) COMP-3
           VALUE +322379197.669.

       77  FLD0033A                       PIC  9(09)V9(15) COMP-3
           VALUE  641903038.069859710468278.
       77  FLD0033B                       PIC  9(09)V9(03) COMP-6
           VALUE  318353502.142.

       77  FLD0034A                       PIC S9(02)       COMP-3
           VALUE -05.
       77  FLD0034B                       PIC S9(07)V9(01) COMP-3
           VALUE +2126766.9.

       77  FLD0035A                       PIC  9(06)V9(25) COMP-6
           VALUE  816285.5924199176049782522568420.
       77  FLD0035B                       PIC  9(07)V9(01) COMP-6
           VALUE  2276316.1.

       77  FLD0036A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.789384107274801127829277902492322027.
       77  FLD0036B                       PIC  9(05)V9(27) COMP-6
           VALUE  84790.535447228665422159110676147.

       77  FLD0037A                       PIC  9(10)V9(11) COMP-6
           VALUE  5559560836.79804091701.
       77  FLD0037B                       PIC S9(05)       COMP-3
           VALUE -15352.

       77  FLD0038A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.5897506417712539139586169767426326.
       77  FLD0038B                       PIC  9(06)V9(25) COMP-6
           VALUE  819342.2486726212872198971126636.

       77  FLD0039A                       PIC  9(04)V9(29) COMP-3
           VALUE  8933.20399454893721014059337903745.
       77  FLD0039B                       PIC  9(06)V9(01) COMP-6
           VALUE  205344.3.

       77  FLD0040A                       PIC S9(06)       COMP-5
           VALUE -162227.
       77  FLD0040B                       PIC S9(03)       COMP-3
           VALUE +101.

       77  FLD0041A                       PIC  9(09)V9(17) COMP-6
           VALUE  687709210.19485042879892944.
       77  FLD0041B                       PIC  9(10)V9(09) COMP-3
           VALUE  5032246021.307608119.

       77  FLD0042A                       PIC  9(07)V9(22) COMP-6
           VALUE  7680734.5400734650109342283030.
       77  FLD0042B                       PIC  9(10)V9(10) COMP-6
           VALUE  5398987461.4943655917.

       77  FLD0043A                       PIC S9(08)V9(02) COMP-3
           VALUE -28038049.48.
       77  FLD0043B                       PIC  9(04)V9(30) COMP-3
           VALUE  9102.051349475740460448491830902639.

       77  FLD0044A                       PIC  9(06)V9(01) COMP-6
           VALUE  206224.3.
       77  FLD0044B                       PIC  9(09)V9(04) COMP-6
           VALUE  359534215.7883.

       77  FLD0045A                       PIC  9(08)V9(02) COMP-6
           VALUE  28592495.81.
       77  FLD0045B                       PIC  9(09)V9(05) COMP-6
           VALUE  377058873.76830.

       77  FLD0046A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0046B                       PIC  9(05)V9(27) COMP-3
           VALUE  86000.025910646182847330010190489.

       77  FLD0047A                       PIC  9(08)V9(02) COMP-6
           VALUE  26966592.97.
       77  FLD0047B                       PIC  9(10)V9(08) COMP-6
           VALUE  4982239515.90845814.

       77  FLD0048A                       PIC  9(05)V9(26) COMP-6
           VALUE  83962.84254838164429202151950448.
       77  FLD0048B                       PIC S9(05)V9(01) COMP-3
           VALUE -17309.9.

       77  FLD0049A                       PIC  9(09)V9(16) COMP-6
           VALUE  677621907.0336453320635428.
       77  FLD0049B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.784571866912429305429554915463086217.

       77  FLD0050A                       PIC  9(09)V9(03) COMP-6
           VALUE  329667670.988.
       77  FLD0050B                       PIC  9(09)V9(06) COMP-6
           VALUE  408790070.710566.

       77  FLD0051A                       PIC  9(09)V9(15)
           VALUE  643375703.689413991348544.
       77  FLD0051B                       PIC  9(04)V9(30) COMP-6
           VALUE  9064.871948640588206203005938732530.

       77  FLD0052A                       PIC  9(09)V9(04) COMP-6
           VALUE  367200483.8576.
       77  FLD0052B                       PIC  9(09)V9(11) COMP-3
           VALUE  550990476.15163754265.

       77  FLD0053A                       PIC  9(07)V9(01) COMP-6
           VALUE  2260324.6.
       77  FLD0053B                       PIC S9(09)V9(04) COMP-3
           VALUE -361176713.4701.

       77  FLD0054A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0054B                       PIC  9(09)V9(03) COMP-6
           VALUE  319288758.232.

       77  FLD0055A                       PIC  9(09)V9(14) COMP-3
           VALUE  622232417.66982828604426.
       77  FLD0055B                       PIC  9(08)V9(17) COMP-3
           VALUE  68254498.02012105715576240.

       77  FLD0056A                       PIC  9(07)V9(01) COMP-6
           VALUE  2161993.9.
       77  FLD0056B                       PIC  9(08)V9(02) COMP-6
           VALUE  27806089.73.

       77  FLD0057A                       PIC  9(03)V9(32) COMP-6
           VALUE  929.20878243011406638629523513372987.
       77  FLD0057B                       PIC S9(02)       COMP-3
           VALUE -06.

       77  FLD0058A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.6574119281082611010447180888149887.
       77  FLD0058B                       PIC S9(09)V9(04) COMP-3
           VALUE +343623662.0368.

       77  FLD0059A                       PIC  9(07)V9(02) COMP-6
           VALUE  2566438.61.
       77  FLD0059B                       PIC  9(09)V9(14) COMP-6
           VALUE  625762300.58564874525472.

       77  FLD0060A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.888752946983269120906356874911580234.
       77  FLD0060B                       PIC  9(06)       COMP-6
           VALUE  159150.

       77  FLD0061A                       PIC  9(03)       COMP-6
           VALUE  095.
       77  FLD0061B                       PIC  9(06)V9(25) COMP-6
           VALUE  816564.2123096498172785118185856.

       77  FLD0062A                       PIC  9(10)V9(11) COMP-6
           VALUE  5579259193.81647705819.
       77  FLD0062B                       PIC  9(09)V9(13) COMP-3
           VALUE  602304146.8914084317631.

       77  FLD0063A                       PIC S9(07)V9(01) COMP-3
           VALUE +2106925.6.
       77  FLD0063B                       PIC  9(08)V9(19) COMP-3
           VALUE  73193550.7264897311507922950.

       77  FLD0064A                       PIC  9(06)V9(25) COMP-6
           VALUE  828553.1635867423583263757791428.
       77  FLD0064B                       PIC S9(04)       COMP-3
           VALUE +1113.

       77  FLD0065A                       PIC  9(08)V9(02) BINARY
           VALUE  26934154.73.
       77  FLD0065B                       PIC S9(04)       COMP-3
           VALUE +1223.

       77  FLD0066A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0066B                       PIC  9(05)V9(27) COMP-3
           VALUE  85085.260849998822774153950376785.

       77  FLD0067A                       PIC S9(03)       COMP-3
           VALUE -091.
       77  FLD0067B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0068A                       PIC  9(06)V9(25) COMP-6
           VALUE  838055.6814082209537986045688739.
       77  FLD0068B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0069A                       PIC  9(10)V9(08) COMP-6
           VALUE  4880885916.76487937.
       77  FLD0069B                       PIC  9(03)       COMP-6
           VALUE  097.

       77  FLD0070A                       PIC  9(08)V9(18) COMP-6
           VALUE  69654747.914044090606466852.
       77  FLD0070B                       PIC S9(06)V9(01) COMP-3
           VALUE -192591.5.

       77  FLD0071A                       PIC  9(02)       COMP-6
           VALUE  05.
       77  FLD0071B                       PIC  9(04)       COMP-6
           VALUE  1269.

       77  FLD0072A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.925387953744267965916492357791867107.
       77  FLD0072B                       PIC  9(09)V9(15) COMP-6
           VALUE  655377323.717403204028641.

       77  FLD0073A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.812328554525302504174533169134519994.
       77  FLD0073B                       PIC  9(08)V9(18) COMP-6
           VALUE  70717230.890474991333860543.

       77  FLD0074A                       PIC  9(03)V9(32) COMP-6
           VALUE  925.84903592679257400277492706663906.
       77  FLD0074B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.839916331263631743553332853480242192.

       77  FLD0075A                       PIC  9(10)V9(10) COMP-3
           VALUE  5446083738.8683014381.
       77  FLD0075B                       PIC S9(07)V9(01) COMP-3
           VALUE +2205661.8.

       77  FLD0076A                       PIC S9(07)V9(02) COMP-3
           VALUE +2412584.18.
       77  FLD0076B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.1877730461857529675739897356834262.

       77  FLD0077A                       PIC  9(10)V9(08) COMP-6
           VALUE  4971042025.86989840.
       77  FLD0077B                       PIC  9(05)V9(28) COMP-6
           VALUE  87747.7884783979700245026833727024.

       77  FLD0078A                       PIC  9(06)V9(01) COMP-6
           VALUE  186044.2.
       77  FLD0078B                       PIC  9(10)V9(10) COMP-6
           VALUE  5264094377.6727222580.

       77  FLD0079A                       PIC  9(09)V9(15) COMP-6
           VALUE  638119223.314542294289708.
       77  FLD0079B                       PIC S9(03)       COMP-3
           VALUE +101.

       77  FLD0080A                       PIC  9(07)V9(23) COMP-3
           VALUE  7905587.67133311302011122734256.
       77  FLD0080B                       PIC S9(09)V9(04) COMP-3
           VALUE -363247849.5626.

       77  FLD0081A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.951308658902108250643436804239172488.
       77  FLD0081B                       PIC  9(09)V9(04) COMP-6
           VALUE  367206952.3371.

       77  FLD0082A                       PIC S9(08)V9(02) COMP-3
           VALUE -26324419.10.
       77  FLD0082B                       PIC  9(07)V9(22) COMP-6
           VALUE  7666475.1738066827524420432382.

       77  FLD0083A                       PIC  9(09)V9(14) COMP-3
           VALUE  631384121.39469823891602.
       77  FLD0083B                       PIC S9(07)V9(02) COMP-3
           VALUE -2518657.33.

       77  FLD0084A                       PIC  9(04)V9(29) COMP-3
           VALUE  8913.08379718931953483718189090723.
       77  FLD0084B                       PIC  9(09)V9(06) COMP-6
           VALUE  405118244.918866.

       77  FLD0085A                       PIC  9(05)       COMP-6
           VALUE  15779.
       77  FLD0085B                       PIC  9(10)V9(06) COMP-6
           VALUE  4354227755.611629.

       77  FLD0086A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.766547774737049936177868403319735080.
       77  FLD0086B                       PIC  9(10)V9(11) COMP-3
           VALUE  5711670223.78104349833.

       77  FLD0087A                       PIC  9(09)V9(14) COMP-6
           VALUE  617158605.01368802193411.
       77  FLD0087B                       PIC  9(04)       COMP-6
           VALUE  1168.

       77  FLD0088A                       PIC  9(10)V9(12) COMP-3
           VALUE  5809468198.000283800652.
       77  FLD0088B                       PIC  9(09)V9(03) COMP-6
           VALUE  327927843.481.

       77  FLD0089A                       PIC  9(06)V9(24) COMP-3
           VALUE  802942.222446262787727278009697.
       77  FLD0089B                       PIC  9(03)V9(31) COMP-3
           VALUE  913.0556640200002682661306607769802.

       77  FLD0090A                       PIC S9(08)V9(02) COMP-3
           VALUE -28271627.31.
       77  FLD0090B                       PIC S9(08)V9(03) COMP-3
           VALUE -29023436.992.

       77  FLD0091A                       PIC  9(09)V9(07) COMP-6
           VALUE  438808038.0901770.
       77  FLD0091B                       PIC  9(08)V9(18) COMP-6
           VALUE  69809163.794725925811235356.

       77  FLD0092A                       PIC S9(07)V9(01) COMP-3
           VALUE +2146587.0.
       77  FLD0092B                       PIC  9(06)V9(25) COMP-6
           VALUE  828676.9901534452031910404912196.

       77  FLD0093A                       PIC  9(06)V9(25) COMP-3
           VALUE  831848.6927757260396276706160278.
       77  FLD0093B                       PIC  9(07)V9(23) COMP-3
           VALUE  7909193.25337388512409120266966.

       77  FLD0094A                       PIC  9(07)V9(01) COMP-6
           VALUE  2260698.5.
       77  FLD0094B                       PIC  9(10)V9(10) COMP-3
           VALUE  5308926344.5354850645.

       77  FLD0095A                       PIC  9(07)V9(22) COMP-6
           VALUE  7681159.7607563408818265315858.
       77  FLD0095B                       PIC  9(06)V9(25) COMP-6
           VALUE  835614.2190518044410296738533361.

       77  FLD0096A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0096B                       PIC  9(05)V9(28) COMP-6
           VALUE  87505.3049076218392166026660561328.

       77  FLD0097A                       PIC  9(03)       COMP-6
           VALUE  085.
       77  FLD0097B                       PIC  9(07)V9(22) COMP-6
           VALUE  7663819.4132902548449948199049.

       77  FLD0098A                       PIC  9(05)V9(28) COMP-6
           VALUE  87637.1310136299430659789777564583.
       77  FLD0098B                       PIC  9(08)V9(04) COMP-6
           VALUE  33500668.0379.

       77  FLD0099A                       PIC S9(10)V9(08) COMP-3
           VALUE -4946809917.70565292.
       77  FLD0099B                       PIC S9(08)V9(03) COMP-3
           VALUE +30007106.715.

       77  FLD0100A                       PIC  9(10)V9(09) COMP-3
           VALUE  5148281813.288457797.
       77  FLD0100B                       PIC  9(09)V9(14) COMP-6
           VALUE  609442213.66168171982735.

       77  FLD0101A                       PIC S9(07)V9(02) COMP-3
           VALUE -2605358.58.
       77  FLD0101B                       PIC S9(07)V9(02) COMP-3
           VALUE -2515761.93.

       77  FLD0102A                       PIC  9(05)       COMP-6
           VALUE  13880.
       77  FLD0102B                       PIC  9(09)V9(14) COMP-6
           VALUE  626009568.32775289662151.

       77  FLD0103A                       PIC  9(03)V9(32) COMP-6
           VALUE  929.51599988912647631877916865050792.
       77  FLD0103B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0104A                       PIC  9(07)V9(01) COMP-6
           VALUE  2254306.3.
       77  FLD0104B                       PIC S9(10)V9(08) COMP-3
           VALUE -4810300752.02174334.

       77  FLD0105A                       PIC S9(08)V9(03) COMP-3
           VALUE -29081388.428.
       77  FLD0105B                       PIC  9(08)V9(02) COMP-6
           VALUE  27558698.77.

       77  FLD0106A                       PIC S9(02)       COMP-3
           VALUE -07.
       77  FLD0106B                       PIC S9(08)V9(02) COMP-3
           VALUE -26362185.29.

       77  FLD0107A                       PIC  9(09)V9(16) COMP-6
           VALUE  677462443.7557797973497031.
       77  FLD0107B                       PIC  9(08)V9(19) COMP-6
           VALUE  71705910.5997380985542122289.

       77  FLD0108A                       PIC  9(09)V9(14) COMP-3
           VALUE  610210882.31341436003418.
       77  FLD0108B                       PIC S9(08)V9(02) COMP-3
           VALUE -28421053.19.

       77  FLD0109A                       PIC S9(04)       COMP-3
           VALUE +1136.
       77  FLD0109B                       PIC  9(04)V9(30) COMP-3
           VALUE  9020.720262660837374113498299266211.

       77  FLD0110A                       PIC  9(07)V9(23) COMP-3
           VALUE  7940109.55673497886841971649118.
       77  FLD0110B                       PIC  9(08)V9(18) COMP-6
           VALUE  69721135.284383173313926818.

       77  FLD0111A                       PIC  9(09)V9(03) COMP-6
           VALUE  326472185.831.
       77  FLD0111B                       PIC  9(10)V9(09) COMP-6
           VALUE  5255901748.964217912.

       77  FLD0112A                       PIC  9(08)V9(19) COMP-3
           VALUE  71238052.4624002697819946661.
       77  FLD0112B                       PIC S9(08)V9(02) COMP-3
           VALUE -27133920.74.

       77  FLD0113A                       PIC  9(04)V9(30) COMP-6
           VALUE  9092.566324157485002643852567416615.
       77  FLD0113B                       PIC  9(04)       COMP-6
           VALUE  1277.

       77  FLD0114A                       PIC  9(09)V9(07) COMP-6
           VALUE  437805064.1539988.
       77  FLD0114B                       PIC  9(05)V9(01) COMP-6
           VALUE  17667.3.

       77  FLD0115A                       PIC  9(02)V9(34) COMP-3
           VALUE  96.2362934933669089687668929400388151.
       77  FLD0115B                       PIC S9(08)V9(03) COMP-3
           VALUE +30236682.408.

       77  FLD0116A                       PIC  9(07)V9(22) COMP-3
           VALUE  7646463.4359510952332783517704.
       77  FLD0116B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0117A                       PIC  9(09)V9(14) COMP-6
           VALUE  617509561.34001855346582.
       77  FLD0117B                       PIC  9(05)       COMP-6
           VALUE  13612.

       77  FLD0118A                       PIC  9(10)V9(10) COMP-3
           VALUE  5408402726.5490597358.
       77  FLD0118B                       PIC S9(03)       COMP-3
           VALUE -080.

       77  FLD0119A                       PIC S9(08)V9(03) COMP-3
           VALUE +30078875.458.
       77  FLD0119B                       PIC  9(07)V9(02) COMP-6
           VALUE  2460449.05.

       77  FLD0120A                       PIC  9(06)V9(25) COMP-3
           VALUE  830160.1137616416714593015058198.
       77  FLD0120B                       PIC S9(02)       COMP-3
           VALUE -07.

       77  FLD0121A                       PIC S9(07)V9(01) COMP-3
           VALUE +2338292.2.
       77  FLD0121B                       PIC S9(09)V9(03) COMP-3
           VALUE +320991974.822.

       77  FLD0122A                       PIC S9(06)V9(01) COMP-3
           VALUE -184951.8.
       77  FLD0122B                       PIC  9(08)V9(02) COMP-6
           VALUE  26752619.72.

       77  FLD0123A                       PIC S9(02)       COMP-3
           VALUE -05.
       77  FLD0123B                       PIC  9(07)V9(21) COMP-3
           VALUE  7502027.502690824523057244732.

       77  FLD0124A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0124B                       PIC S9(10)V9(06) COMP-3
           VALUE +4223876720.963152.

       77  FLD0125A                       PIC  9(04)V9(29) COMP-3
           VALUE  8800.31826789913984576685379579430.
       77  FLD0125B                       PIC  9(09)V9(15) COMP-6
           VALUE  637787216.045794358443288.

       77  FLD0126A                       PIC  9(06)V9(24) COMP-6
           VALUE  807990.071015203703552742808824.
       77  FLD0126B                       PIC  9(07)V9(01) COMP-6
           VALUE  2285688.0.

       77  FLD0127A                       PIC  9(04)V9(30) COMP-6
           VALUE  8981.860178820127993404298649693373.
       77  FLD0127B                       PIC  9(05)V9(28) COMP-6
           VALUE  87878.0390073648609572387613297905.

       77  FLD0128A                       PIC  9(10)V9(06) COMP-6
           VALUE  4298489587.591516.
       77  FLD0128B                       PIC  9(08)V9(02) COMP-6
           VALUE  26904320.50.

       77  FLD0129A                       PIC S9(08)V9(04) COMP-3
           VALUE +33460508.1048.
       77  FLD0129B                       PIC  9(09)V9(14) COMP-6
           VALUE  629564859.51748508700376.

       77  FLD0130A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0130B                       PIC  9(08)V9(03) COMP-6
           VALUE  30500681.275.

       77  FLD0131A                       PIC  9(08)V9(02) COMP-6
           VALUE  26916210.05.
       77  FLD0131B                       PIC  9(08)V9(18) COMP-6
           VALUE  70626515.642831921848454612.

       77  FLD0132A                       PIC  9(04)       COMP-6
           VALUE  1270.
       77  FLD0132B                       PIC  9(07)V9(01) COMP-6
           VALUE  2163498.7.

       77  FLD0133A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.890353542063604619372085835493635386.
       77  FLD0133B                       PIC S9(07)V9(02) COMP-3
           VALUE -2528421.98.

       77  FLD0134A                       PIC  9(08)V9(18) COMP-3
           VALUE  70385499.741438917187252855.
       77  FLD0134B                       PIC  9(09)V9(16) COMP-3
           VALUE  673960062.4739148226893803.

       77  FLD0135A                       PIC  9(10)V9(07) COMP-6
           VALUE  4678335500.0128495.
       77  FLD0135B                       PIC  9(07)V9(02) COMP-6
           VALUE  2561321.97.

       77  FLD0136A                       PIC S9(05)       COMP-3
           VALUE -15169.
       77  FLD0136B                       PIC  9(08)V9(19) COMP-3
           VALUE  72091249.9695820607747975827.

       77  FLD0137A                       PIC S9(08)V9(02) COMP-3
           VALUE -27190319.39.
       77  FLD0137B                       PIC  9(03)V9(32) COMP-3
           VALUE  921.23024961283406231160597599227912.

       77  FLD0138A                       PIC S9(10)V9(08) COMP-3
           VALUE -4824223828.94490853.
       77  FLD0138B                       PIC  9(04)V9(30) COMP-6
           VALUE  8976.142294415691003095503219810780.

       77  FLD0139A                       PIC  9(09)V9(03) COMP-6
           VALUE  319644653.394.
       77  FLD0139B                       PIC  9(06)V9(25) COMP-6
           VALUE  818318.3537620841718762676464393.

       77  FLD0140A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0140B                       PIC  9(03)V9(31) COMP-3
           VALUE  913.4502802484925076953459210926666.

       77  FLD0141A                       PIC  9(09)V9(14) COMP-3
           VALUE  612266512.11346116987499.
       77  FLD0141B                       PIC  9(06)V9(01) COMP-6
           VALUE  198046.5.

       77  FLD0142A                       PIC  9(09)V9(04) COMP-6
           VALUE  356201246.7531.
       77  FLD0142B                       PIC S9(04)       COMP-3
           VALUE +1134.

       77  FLD0143A                       PIC S9(07)V9(02) COMP-3
           VALUE -2608987.15.
       77  FLD0143B                       PIC  9(06)V9(01) COMP-6
           VALUE  205887.8.

       77  FLD0144A                       PIC  9(10)V9(11) COMP-6
           VALUE  5664625691.64754570216.
       77  FLD0144B                       PIC  9(07)V9(01) COMP-6
           VALUE  2170292.3.

       77  FLD0145A                       PIC  9(09)V9(13) COMP-3
           VALUE  592809780.4295365813587.
       77  FLD0145B                       PIC  9(09)V9(06) COMP-6
           VALUE  416669902.306984.

       77  FLD0146A                       PIC S9(03)       COMP-3
           VALUE -091.
       77  FLD0146B                       PIC  9(09)V9(13) COMP-3
           VALUE  592675280.7490164309811.

       77  FLD0147A                       PIC  9(03)       COMP-6
           VALUE  085.
       77  FLD0147B                       PIC  9(10)V9(05) COMP-6
           VALUE  3974420340.21838.

       77  FLD0148A                       PIC  9(04)       COMP-6
           VALUE  1189.
       77  FLD0148B                       PIC  9(08)V9(04) COMP-6
           VALUE  33583306.9980.

       77  FLD0149A                       PIC  9(05)V9(27) COMP-3
           VALUE  86469.811002464236349140946913394.
       77  FLD0149B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0150A                       PIC S9(02)       COMP-3
           VALUE -06.
       77  FLD0150B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.779789481524289174174668914929497987.

       77  FLD0151A                       PIC  9(09)V9(13) COMP-3
           VALUE  602633749.4884196344102.
       77  FLD0151B                       PIC  9(07)V9(22) COMP-3
           VALUE  7715228.5011189425389943608024.

       77  FLD0152A                       PIC S9(08)V9(02) COMP-3
           VALUE -28005400.65.
       77  FLD0152B                       PIC  9(02)V9(34) COMP-6
           VALUE  96.9689035330467796747200281970435753.

       77  FLD0153A                       PIC  9(08)V9(18) COMP-3
           VALUE  69246387.672994647033419823.
       77  FLD0153B                       PIC  9(07)V9(22) COMP-3
           VALUE  7700147.9845998110906890588012.

       77  FLD0154A                       PIC  9(09)V9(14) COMP-6
           VALUE  618531644.61004783714059.
       77  FLD0154B                       PIC  9(10)V9(07) COMP-6
           VALUE  4667533939.9326892.

       77  FLD0155A                       PIC  9(10)V9(12) COMP-3
           VALUE  5816028861.286740569980.
       77  FLD0155B                       PIC  9(03)V9(31) COMP-3
           VALUE  920.9824083062539967770021576143335.

       77  FLD0156A                       PIC  9(02)V9(34) COMP-3
           VALUE  95.3830714078202746009083057288080453.
       77  FLD0156B                       PIC  9(04)V9(30) COMP-6
           VALUE  9080.971133779824899789900882751680.

       77  FLD0157A                       PIC  9(09)V9(16) COMP-6
           VALUE  659745695.0483697735165833.
       77  FLD0157B                       PIC  9(10)V9(06) COMP-6
           VALUE  4359875032.276696.

       77  FLD0158A                       PIC S9(09)V9(06) COMP-3
           VALUE +412656981.234114.
       77  FLD0158B                       PIC  9(09)V9(14) COMP-3
           VALUE  611832243.66474420197192.

       77  FLD0159A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0159B                       PIC  9(09)V9(15) COMP-3
           VALUE  643529357.674236912600918.

       77  FLD0160A                       PIC  9(08)V9(20) COMP-6
           VALUE  74656107.83998073429756914265.
       77  FLD0160B                       PIC  9(06)V9(01) COMP-6
           VALUE  207077.8.

       77  FLD0161A                       PIC  9(07)V9(22) COMP-6
           VALUE  7887170.9741627593626134284932.
       77  FLD0161B                       PIC  9(08)V9(19) COMP-6
           VALUE  71702582.3615881408024108623.

       77  FLD0162A                       PIC S9(02)       COMP-3
           VALUE -07.
       77  FLD0162B                       PIC  9(10)V9(11) COMP-6
           VALUE  5668143857.58160899086.

       77  FLD0163A                       PIC  9(09)V9(14) COMP-6
           VALUE  618392824.19829444403802.
       77  FLD0163B                       PIC  9(09)V9(15) COMP-3
           VALUE  650815786.826470232817598.

       77  FLD0164A                       PIC S9(06)V9(01) COMP-3
           VALUE +204076.7.
       77  FLD0164B                       PIC  9(04)       COMP-6
           VALUE  1076.

       77  FLD0165A                       PIC  9(09)V9(14) COMP-3
           VALUE  610409164.63927785695631.
       77  FLD0165B                       PIC  9(04)       COMP-6
           VALUE  1267.

       77  FLD0166A                       PIC  9(07)V9(02) COMP-6
           VALUE  2460589.98.
       77  FLD0166B                       PIC  9(05)V9(01) COMP-6
           VALUE  17630.0.

       77  FLD0167A                       PIC S9(09)V9(03) COMP-3
           VALUE +323253458.962.
       77  FLD0167B                       PIC  9(06)V9(25) COMP-6
           VALUE  838285.1322478405142746282763255.

       77  FLD0168A                       PIC S9(04)       COMP-3
           VALUE +1200.
       77  FLD0168B                       PIC S9(10)V9(06) COMP-3
           VALUE +4326937205.661665.

       77  FLD0169A                       PIC  9(06)V9(25) COMP-3
           VALUE  834885.7368063762329768451309064.
       77  FLD0169B                       PIC  9(08)V9(18) COMP-6
           VALUE  70699865.109667991980302304.

       77  FLD0170A                       PIC  9(08)V9(19) COMP-3
           VALUE  72325482.4666709539293663056.
       77  FLD0170B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.863493423765207213094186045054811984.

       77  FLD0171A                       PIC  9(09)V9(16) COMP-6
           VALUE  675345293.4675296948086042.
       77  FLD0171B                       PIC  9(10)V9(06) COMP-6
           VALUE  4258478422.558273.

       77  FLD0172A                       PIC  9(02)V9(34) COMP-3
           VALUE  96.0216523360032936373897882731398567.
       77  FLD0172B                       PIC  9(04)V9(30) COMP-6
           VALUE  8999.798406174591702821885519369971.

       77  FLD0173A                       PIC S9(09)V9(06) COMP-3
           VALUE +412472914.336663.
       77  FLD0173B                       PIC  9(10)V9(08) COMP-6
           VALUE  4786981213.45750904.

       77  FLD0174A                       PIC S9(04)       COMP-3
           VALUE +1244.
       77  FLD0174B                       PIC  9(10)V9(09) COMP-6
           VALUE  5152586737.087611057.

       77  FLD0175A                       PIC S9(05)       COMP-3
           VALUE +13456.
       77  FLD0175B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0176A                       PIC  9(07)V9(23) COMP-3
           VALUE  7902178.74582138546379894705751.
       77  FLD0176B                       PIC  9(08)V9(03) COMP-6
           VALUE  29797398.003.

       77  FLD0177A                       PIC  9(07)V9(21) COMP-3
           VALUE  7618839.577049143496623173632.
       77  FLD0177B                       PIC  9(07)V9(02) COMP-6
           VALUE  2373414.07.

       77  FLD0178A                       PIC  9(09)V9(04) COMP-6
           VALUE  355502105.3348.
       77  FLD0178B                       PIC S9(08)V9(03) COMP-3
           VALUE +31397739.222.

       77  FLD0179A                       PIC  9(09)V9(05) COMP-6
           VALUE  388560564.63472.
       77  FLD0179B                       PIC  9(03)       COMP-6
           VALUE  099.

       77  FLD0180A                       PIC  9(05)V9(27) COMP-6
           VALUE  85946.157652659294079455776227405.
       77  FLD0180B                       PIC  9(10)V9(10) COMP-3
           VALUE  5435189439.3573940700.

       77  FLD0181A                       PIC  9(06)V9(01) COMP-6
           VALUE  188908.8.
       77  FLD0181B                       PIC S9(10)V9(08) COMP-3
           VALUE -4740924741.33910868.

       77  FLD0182A                       PIC  9(10)V9(13) COMP-6
           VALUE  6061401860.3468300394609.
       77  FLD0182B                       PIC  9(09)V9(15) COMP-3
           VALUE  643493508.008180281620980.

       77  FLD0183A                       PIC  9(07)V9(23) COMP-3
           VALUE  7910108.10526126539876656806882.
       77  FLD0183B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0184A                       PIC  9(09)V9(15) COMP-6
           VALUE  635945742.812533687526865.
       77  FLD0184B                       PIC S9(07)V9(01) COMP-3
           VALUE +2343773.6.

       77  FLD0185A                       PIC  9(05)       COMP-6
           VALUE  15666.
       77  FLD0185B                       PIC  9(08)V9(20) COMP-6
           VALUE  73935660.38753716096465495866.

       77  FLD0186A                       PIC  9(02)       COMP-6
           VALUE  07.
       77  FLD0186B                       PIC  9(05)V9(26) COMP-3
           VALUE  84084.08947119312415452441200613.

       77  FLD0187A                       PIC  9(09)V9(13) COMP-3
           VALUE  604672028.7423602568921.
       77  FLD0187B                       PIC  9(10)V9(12) COMP-6
           VALUE  5893278013.192120301511.

       77  FLD0188A                       PIC  9(08)V9(17) COMP-3
           VALUE  68008236.87569536035724127.
       77  FLD0188B                       PIC  9(07)V9(21) COMP-3
           VALUE  7537078.198448752264226868646.

       77  FLD0189A                       PIC  9(10)V9(09) COMP-3
           VALUE  5115071016.238050827.
       77  FLD0189B                       PIC  9(10)V9(11) COMP-6
           VALUE  5668524677.20726727051.

       77  FLD0190A                       PIC  9(07)V9(02) COMP-6
           VALUE  2382137.54.
       77  FLD0190B                       PIC  9(09)V9(14) COMP-6
           VALUE  627148648.94273569806415.

       77  FLD0191A                       PIC  9(05)       COMP-6
           VALUE  13720.
       77  FLD0191B                       PIC  9(06)V9(24) COMP-3
           VALUE  803717.168989411478996487403492.

       77  FLD0192A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.894259454195439840162862310535274446.
       77  FLD0192B                       PIC  9(09)V9(04) COMP-6
           VALUE  358034239.3955.

       77  FLD0193A                       PIC  9(10)V9(06) COMP-6
           VALUE  4252943677.090519.
       77  FLD0193B                       PIC  9(09)V9(14) COMP-3
           VALUE  612048644.17243076690766.

       77  FLD0194A                       PIC  9(09)V9(06) COMP-6
           VALUE  417168379.939779.
       77  FLD0194B                       PIC  9(09)V9(15) COMP-3
           VALUE  634454032.998696626499679.

       77  FLD0195A                       PIC  9(08)V9(02) COMP-6
           VALUE  26645846.45.
       77  FLD0195B                       PIC  9(05)       COMP-6
           VALUE  14921.

       77  FLD0196A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0196B                       PIC S9(05)V9(01) COMP-3
           VALUE -18000.7.

       77  FLD0197A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.847788375924405590566834689525421708.
       77  FLD0197B                       PIC  9(02)       COMP-6
           VALUE  05.

       77  FLD0198A                       PIC  9(09)V9(13) COMP-3
           VALUE  593293108.5591157671643.
       77  FLD0198B                       PIC S9(05)       COMP-3
           VALUE +14072.

       77  FLD0199A                       PIC  9(07)V9(02) COMP-6
           VALUE  2483287.24.
       77  FLD0199B                       PIC  9(07)V9(23) COMP-6
           VALUE  7969040.17410605347571106449322.

       77  FLD0200A                       PIC S9(10)V9(08) COMP-3
           VALUE -4935972790.60619176.
       77  FLD0200B                       PIC  9(10)V9(07) COMP-6
           VALUE  4582475224.7206340.

       77  FLD0201A                       PIC  9(04)       COMP-6
           VALUE  1282.
       77  FLD0201B                       PIC  9(07)V9(23) COMP-3
           VALUE  7926313.90444417882612526682351.

       77  FLD0202A                       PIC S9(09)V9(04) COMP-3
           VALUE -360603443.7503.
       77  FLD0202B                       PIC  9(03)V9(32) COMP-6
           VALUE  935.68197555010013122256395945441909.

       77  FLD0203A                       PIC  9(09)V9(14) COMP-6
           VALUE  628607663.38264040253847.
       77  FLD0203B                       PIC  9(03)V9(31) COMP-3
           VALUE  920.1886012491730104656539879215415.

       77  FLD0204A                       PIC  9(01)V9(35) COMP-3
           VALUE  9.73054030732718233664968465745914727.
       77  FLD0204B                       PIC  9(07)V9(01) COMP-6
           VALUE  2363275.3.

       77  FLD0205A                       PIC  9(09)V9(15) COMP-6
           VALUE  648926914.508991536933990.
       77  FLD0205B                       PIC  9(09)V9(15) COMP-6
           VALUE  639814213.238647178094709.

       77  FLD0206A                       PIC  9(06)V9(01) COMP-6
           VALUE  186967.7.
       77  FLD0206B                       PIC  9(08)V9(18) COMP-6
           VALUE  70826356.466434425840361654.

       77  FLD0207A                       PIC  9(05)V9(26) COMP-6
           VALUE  83944.39242287422553445708217623.
       77  FLD0207B                       PIC  9(07)V9(21) COMP-3
           VALUE  7607846.993308088334728722657.

       77  FLD0208A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7940040016311842308027735271025449.
       77  FLD0208B                       PIC  9(07)V9(01) COMP-6
           VALUE  2151595.4.

       77  FLD0209A                       PIC  9(03)V9(32) COMP-6
           VALUE  926.61149050802726900855077474261634.
       77  FLD0209B                       PIC  9(07)V9(23) COMP-6
           VALUE  7951784.48263920700789242346218.

       77  FLD0210A                       PIC  9(08)V9(19) COMP-3
           VALUE  72323528.1456575562764044207.
       77  FLD0210B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0211A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0211B                       PIC S9(09)V9(07) COMP-3
           VALUE +442113770.7554604.

       77  FLD0212A                       PIC  9(10)V9(08) COMP-6
           VALUE  4892032792.55731038.
       77  FLD0212B                       PIC S9(09)V9(05) COMP-3
           VALUE -372935567.70682.

       77  FLD0213A                       PIC S9(03)       COMP-3
           VALUE -082.
       77  FLD0213B                       PIC  9(07)V9(21) COMP-3
           VALUE  7525721.770631302875997903356.

       77  FLD0214A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0214B                       PIC  9(09)V9(16) COMP-6
           VALUE  666893270.4655321508369070.

       77  FLD0215A                       PIC  9(03)V9(32) COMP-6
           VALUE  926.34033699271633999217101518297567.
       77  FLD0215B                       PIC S9(05)V9(01) COMP-3
           VALUE -18226.5.

       77  FLD0216A                       PIC S9(08)V9(02) COMP-3
           VALUE -28095374.87.
       77  FLD0216B                       PIC  9(08)V9(02) COMP-6
           VALUE  28541793.87.

       77  FLD0217A                       PIC  9(08)V9(20) COMP-6
           VALUE  74562962.48658396130792880285.
       77  FLD0217B                       PIC S9(09)V9(07) COMP-3
           VALUE +444563659.0422049.

       77  FLD0218A                       PIC S9(05)V9(01) COMP-3
           VALUE -18094.6.
       77  FLD0218B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.867255193327033602201936446363106369.

       77  FLD0219A                       PIC  9(09)V9(12) COMP-6
           VALUE  578788992.127507229135.
       77  FLD0219B                       PIC  9(10)V9(10) COMP-6
           VALUE  5297903516.0907261836.

       77  FLD0220A                       PIC  9(09)V9(12) COMP-3
           VALUE  573343525.907533679841.
       77  FLD0220B                       PIC S9(05)       COMP-3
           VALUE +14161.

       77  FLD0221A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0221B                       PIC  9(04)V9(29) COMP-6
           VALUE  8789.10367794605407176788958167890.

       77  FLD0222A                       PIC  9(09)V9(14) COMP-6
           VALUE  628182805.25174396977661.
       77  FLD0222B                       PIC S9(05)       COMP-3
           VALUE -15228.

       77  FLD0223A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0223B                       PIC  9(08)V9(18) COMP-6
           VALUE  69950927.082806102497158917.

       77  FLD0224A                       PIC  9(06)V9(25) COMP-6
           VALUE  838187.2267509891116787912324070.
       77  FLD0224B                       PIC S9(09)V9(05) COMP-3
           VALUE -382169497.04991.

       77  FLD0225A                       PIC  9(05)       COMP-6
           VALUE  13797.
       77  FLD0225B                       PIC  9(09)V9(12) COMP-3
           VALUE  572598612.808938978169.

       77  FLD0226A                       PIC  9(05)       COMP-6
           VALUE  14900.
       77  FLD0226B                       PIC S9(07)V9(01) COMP-3
           VALUE +2129995.4.

       77  FLD0227A                       PIC  9(09)V9(14) COMP-6
           VALUE  629583055.15940859997670.
       77  FLD0227B                       PIC  9(04)V9(30) COMP-6
           VALUE  8983.577034983017961522477889957372.

       77  FLD0228A                       PIC S9(07)V9(01) COMP-3
           VALUE +2225916.3.
       77  FLD0228B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.739690596877397243957830141880549490.

       77  FLD0229A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.870473603260505601753038718015886843.
       77  FLD0229B                       PIC  9(08)V9(20) COMP-6
           VALUE  73838029.76208535540081356884.

       77  FLD0230A                       PIC S9(06)V9(01) COMP-3
           VALUE +201492.2.
       77  FLD0230B                       PIC S9(02)       COMP-3
           VALUE -06.

       77  FLD0231A                       PIC  9(05)V9(28) COMP-6
           VALUE  87781.6812716511907233041256404248.
       77  FLD0231B                       PIC S9(08)V9(02) COMP-3
           VALUE -27182116.43.

       77  FLD0232A                       PIC  9(09)V9(04) COMP-6
           VALUE  356308264.5328.
       77  FLD0232B                       PIC  9(06)V9(25) COMP-3
           VALUE  833280.3014261945806495646138500.

       77  FLD0233A                       PIC  9(07)V9(21) COMP-6
           VALUE  7552156.809035388551620826547.
       77  FLD0233B                       PIC  9(08)V9(04) COMP-6
           VALUE  33739768.3403.

       77  FLD0234A                       PIC  9(08)V9(04) COMP-6
           VALUE  33831052.6754.
       77  FLD0234B                       PIC  9(09)V9(13) COMP-3
           VALUE  593899144.9424572133253.

       77  FLD0235A                       PIC S9(05)       COMP-3
           VALUE +14123.
       77  FLD0235B                       PIC S9(10)V9(08) COMP-3
           VALUE -4808329310.19295639.

       77  FLD0236A                       PIC  9(04)V9(29) COMP-3
           VALUE  8818.23528289915170574886360554955.
       77  FLD0236B                       PIC  9(08)V9(18) COMP-3
           VALUE  70480160.116860446350983693.

       77  FLD0237A                       PIC  9(08)V9(02) COMP-6
           VALUE  28742037.59.
       77  FLD0237B                       PIC  9(04)V9(29) COMP-6
           VALUE  8850.90488581330880890618573175743.

       77  FLD0238A                       PIC  9(09)V9(15) COMP-3
           VALUE  634521096.430120334908053.
       77  FLD0238B                       PIC  9(06)V9(01) COMP-6
           VALUE  198396.3.

       77  FLD0239A                       PIC  9(09)V9(16) COMP-6
           VALUE  678585779.2924817610824561.
       77  FLD0239B                       PIC  9(09)V9(14) COMP-3
           VALUE  614739880.97122655993587.

       77  FLD0240A                       PIC  9(10)V9(06) COMP-6
           VALUE  4289853576.446766.
       77  FLD0240B                       PIC  9(06)V9(25) COMP-3
           VALUE  833165.4817075836438888813972880.

       77  FLD0241A                       PIC S9(05)       COMP-3
           VALUE +14407.
       77  FLD0241B                       PIC  9(09)V9(14) COMP-6
           VALUE  608742950.23205993171444.

       77  FLD0242A                       PIC  9(10)V9(12) COMP-6
           VALUE  5860383854.989427154791.
       77  FLD0242B                       PIC S9(06)V9(01) COMP-3
           VALUE +201770.8.

       77  FLD0243A                       PIC  9(02)V9(34) COMP-3
           VALUE  97.0409660969254295181940506154205650.
       77  FLD0243B                       PIC  9(05)V9(28) COMP-6
           VALUE  86928.4847432245544318618613033322.

       77  FLD0244A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0244B                       PIC  9(09)V9(13) COMP-6
           VALUE  596454149.7067354924865.

       77  FLD0245A                       PIC S9(09)V9(05) COMP-3
           VALUE -371716886.14542.
       77  FLD0245B                       PIC  9(09)V9(15) COMP-6
           VALUE  636050719.355519267317333.

       77  FLD0246A                       PIC  9(05)V9(28) COMP-3
           VALUE  87216.9313623637143528810611314838.
       77  FLD0246B                       PIC  9(06)V9(01) COMP-6
           VALUE  208199.5.

       77  FLD0247A                       PIC  9(06)V9(25) COMP-3
           VALUE  834494.8214770686600871840710169.
       77  FLD0247B                       PIC  9(08)V9(19) COMP-3
           VALUE  73372232.8570783122181353519.

       77  FLD0248A                       PIC  9(04)V9(29) COMP-6
           VALUE  8885.56418584546814365410227765096.
       77  FLD0248B                       PIC  9(10)V9(11) COMP-6
           VALUE  5683594830.11341870550.

       77  FLD0249A                       PIC  9(09)V9(16) COMP-6
           VALUE  678470839.5950102000071524.
       77  FLD0249B                       PIC  9(09)V9(16) COMP-3
           VALUE  673175418.3146980707874718.

       77  FLD0250A                       PIC  9(09)V9(15) COMP-3
           VALUE  643468324.926731005675151.
       77  FLD0250B                       PIC  9(04)V9(30) COMP-6
           VALUE  9057.675398841628089385835664870683.

       77  FLD0251A                       PIC S9(09)V9(06) COMP-3
           VALUE +402548910.007195.
       77  FLD0251B                       PIC  9(06)V9(25) COMP-3
           VALUE  830149.1080513825338016431487631.

       77  FLD0252A                       PIC S9(05)V9(01) COMP-3
           VALUE -18339.3.
       77  FLD0252B                       PIC S9(07)V9(01) COMP-3
           VALUE +2343087.3.

       77  FLD0253A                       PIC  9(06)V9(25) COMP-3
           VALUE  822593.8518184680026124055984837.
       77  FLD0253B                       PIC  9(07)V9(01) COMP-6
           VALUE  2159897.7.

       77  FLD0254A                       PIC  9(10)V9(10) COMP-3
           VALUE  5401895692.3872574193.
       77  FLD0254B                       PIC S9(07)V9(02) COMP-3
           VALUE +2405256.16.

       77  FLD0255A                       PIC  9(02)V9(34) COMP-6
           VALUE  94.8299297085154591080424779647728428.
       77  FLD0255B                       PIC  9(10)V9(10) COMP-3
           VALUE  5408143412.7739858030.

       77  FLD0256A                       PIC S9(09)V9(08) COMP-3
           VALUE -473179644.06591722.
       77  FLD0256B                       PIC  9(04)V9(30) COMP-3
           VALUE  9107.434804383051085707734273455571.

       77  FLD0257A                       PIC  9(09)V9(12) COMP-6
           VALUE  577029491.737192756772.
       77  FLD0257B                       PIC S9(03)       COMP-3
           VALUE -084.

       77  FLD0258A                       PIC  9(10)V9(12) COMP-3
           VALUE  5908893351.960881057394.
       77  FLD0258B                       PIC  9(05)V9(27) COMP-6
           VALUE  84978.202175808337237583600654033.

       77  FLD0259A                       PIC  9(03)V9(32) COMP-6
           VALUE  937.55337057593879368511124994256533.
       77  FLD0259B                       PIC S9(09)V9(05) COMP-3
           VALUE -374669242.27931.

       77  FLD0260A                       PIC  9(05)V9(27) COMP-6
           VALUE  86648.984966754782899300835197209.
       77  FLD0260B                       PIC  9(09)V9(13) COMP-3
           VALUE  601823310.0433563187436.

       77  FLD0261A                       PIC S9(09)V9(05) COMP-3
           VALUE -374213925.47904.
       77  FLD0261B                       PIC  9(09)V9(05) COMP-6
           VALUE  379885544.06227.

       77  FLD0262A                       PIC S9(05)V9(01) COMP-3
           VALUE -17015.9.
       77  FLD0262B                       PIC  9(09)V9(17) COMP-6
           VALUE  687559565.36759821329241049.

       77  FLD0263A                       PIC  9(05)V9(26) COMP-3
           VALUE  84046.29767805690265802809335582.
       77  FLD0263B                       PIC S9(02)       COMP-3
           VALUE -06.

       77  FLD0264A                       PIC  9(03)V9(32) COMP-6
           VALUE  935.78568596491340514376133796758949.
       77  FLD0264B                       PIC  9(05)V9(01) COMP-6
           VALUE  17620.4.

       77  FLD0265A                       PIC S9(09)V9(05) COMP-3
           VALUE -380334582.15301.
       77  FLD0265B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.854231270822284560750858872779645025.

       77  FLD0266A                       PIC  9(05)V9(27) COMP-6
           VALUE  84707.693570856212872399737534578.
       77  FLD0266B                       PIC  9(02)V9(34) COMP-3
           VALUE  96.1883348354436562566149859776487573.

       77  FLD0267A                       PIC  9(03)       COMP-6
           VALUE  087.
       77  FLD0267B                       PIC S9(07)V9(01) COMP-3
           VALUE +2348814.4.

       77  FLD0268A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0268B                       PIC  9(06)V9(25) COMP-3
           VALUE  821150.0957830146774085733341053.

       77  FLD0269A                       PIC  9(08)V9(18) COMP-6
           VALUE  69955495.182247551255727557.
       77  FLD0269B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0270A                       PIC  9(08)V9(18) COMP-6
           VALUE  69584936.933990082508216801.
       77  FLD0270B                       PIC S9(04)       COMP-3
           VALUE +1200.

       77  FLD0271A                       PIC  9(10)V9(07) COMP-6
           VALUE  4478155927.4435323.
       77  FLD0271B                       PIC  9(07)V9(02) COMP-6
           VALUE  2371664.59.

       77  FLD0272A                       PIC S9(09)V9(06) COMP-3
           VALUE +411514667.070764.
       77  FLD0272B                       PIC S9(10)V9(08) COMP-3
           VALUE -4748492295.95657285.

       77  FLD0273A                       PIC  9(10)V9(07) BINARY
           VALUE  4698099460.5024867.
       77  FLD0273B                       PIC S9(10)V9(06) COMP-3
           VALUE +4338009792.593093.

       77  FLD0274A                       PIC  9(07)V9(01) COMP-6
           VALUE  2190249.4.
       77  FLD0274B                       PIC  9(10)V9(10) COMP-6
           VALUE  5271665070.2586675958.

       77  FLD0275A                       PIC  9(04)       COMP-6
           VALUE  1157.
       77  FLD0275B                       PIC S9(07)V9(02) COMP-3
           VALUE +2422980.94.

       77  FLD0276A                       PIC  9(04)V9(30) COMP-3
           VALUE  9021.044697283423507983002309629227.
       77  FLD0276B                       PIC  9(02)V9(33) COMP-6
           VALUE  94.591784695476577304873444518307223.

       77  FLD0277A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.749582162084949876756923003995325416.
       77  FLD0277B                       PIC  9(10)V9(08) COMP-6
           VALUE  4992154586.01645512.

       77  FLD0278A                       PIC  9(10)V9(06) COMP-6
           VALUE  4251062706.993476.
       77  FLD0278B                       PIC  9(03)V9(31) COMP-3
           VALUE  914.7657257947739983805490737722720.

       77  FLD0279A                       PIC S9(08)V9(02) COMP-3
           VALUE -27159201.10.
       77  FLD0279B                       PIC  9(03)V9(32) COMP-3
           VALUE  921.08160397424898579998853165307082.

       77  FLD0280A                       PIC  9(07)V9(02) COMP-6
           VALUE  2571968.92.
       77  FLD0280B                       PIC  9(08)V9(19) COMP-3
           VALUE  71229222.1254675839148262639.

       77  FLD0281A                       PIC S9(09)V9(04) COMP-3
           VALUE +342861689.3811.
       77  FLD0281B                       PIC  9(10)V9(07) COMP-6
           VALUE  4662459797.7205073.

       77  FLD0282A                       PIC S9(10)V9(07) COMP-3
           VALUE -4600147325.4430291.
       77  FLD0282B                       PIC  9(07)V9(22) COMP-6
           VALUE  7889304.3658446049271049105300.

       77  FLD0283A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0283B                       PIC S9(05)V9(01) COMP-3
           VALUE -18273.9.

       77  FLD0284A                       PIC  9(09)V9(17) COMP-6
           VALUE  689733171.20512533939802324.
       77  FLD0284B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0285A                       PIC  9(03)V9(32) COMP-6
           VALUE  928.78828230193799520009179104818031.
       77  FLD0285B                       PIC  9(08)V9(20) COMP-6
           VALUE  73692142.62351649891158444916.

       77  FLD0286A                       PIC  9(08)V9(18) COMP-3
           VALUE  70426964.322731444578806758.
       77  FLD0286B                       PIC  9(07)V9(01) COMP-6
           VALUE  2181620.7.

       77  FLD0287A                       PIC S9(07)V9(02) COMP-3
           VALUE -2521413.84.
       77  FLD0287B                       PIC  9(06)       COMP-6
           VALUE  158585.

       77  FLD0288A                       PIC  9(09)V9(17) COMP-6
           VALUE  688074525.02240640246355951.
       77  FLD0288B                       PIC  9(04)V9(29) COMP-3
           VALUE  8936.92752615119712089608583482913.

       77  FLD0289A                       PIC S9(03)       COMP-3
           VALUE -092.
       77  FLD0289B                       PIC  9(10)V9(11) COMP-6
           VALUE  5676330984.14293657540.

       77  FLD0290A                       PIC S9(09)V9(05) COMP-3
           VALUE -382951207.35442.
       77  FLD0290B                       PIC S9(03)       COMP-3
           VALUE -094.

       77  FLD0291A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.859384124391753490002088256005663424.
       77  FLD0291B                       PIC  9(06)V9(25) COMP-3
           VALUE  830008.1335268413296191170047677.

       77  FLD0292A                       PIC S9(08)V9(03) COMP-3
           VALUE +31020519.916.
       77  FLD0292B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0293A                       PIC S9(03)       COMP-3
           VALUE -093.
       77  FLD0293B                       PIC  9(08)V9(03) COMP-6
           VALUE  30744484.924.

       77  FLD0294A                       PIC S9(09)V9(06) COMP-3
           VALUE +412445339.504106.
       77  FLD0294B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0295A                       PIC S9(07)V9(02) COMP-3
           VALUE -2502548.06.
       77  FLD0295B                       PIC S9(07)V9(01) COMP-3
           VALUE +2138373.7.

       77  FLD0296A                       PIC S9(06)       COMP-3
           VALUE -160918.
       77  FLD0296B                       PIC  9(09)V9(12) COMP-3
           VALUE  574303107.736577889141.

       77  FLD0297A                       PIC  9(08)V9(03) COMP-6
           VALUE  30843552.269.
       77  FLD0297B                       PIC  9(10)V9(09) COMP-6
           VALUE  5180156945.333709295.

       77  FLD0298A                       PIC S9(10)V9(08) COMP-3
           VALUE -4831587379.88150510.
       77  FLD0298B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.983859909908295859892746193509083241.

       77  FLD0299A                       PIC  9(10)V9(13) COMP-6
           VALUE  6064872573.5835784522720.
       77  FLD0299B                       PIC  9(09)V9(16) COMP-6
           VALUE  669818284.8844781434038964.

       77  FLD0300A                       PIC  9(08)V9(20) COMP-6
           VALUE  73956142.30661028409841151187.
       77  FLD0300B                       PIC  9(09)V9(14) COMP-3
           VALUE  624082886.12038953502292.

       77  FLD0301A                       PIC S9(10)V9(07) COMP-3
           VALUE -4524568495.0704084.
       77  FLD0301B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0302A                       PIC  9(02)V9(34) COMP-6
           VALUE  94.9764690231816866017311440373305231.
       77  FLD0302B                       PIC  9(10)V9(06) COMP-6
           VALUE  4291773437.216153.

       77  FLD0303A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.998247249142951931233369577967096120.
       77  FLD0303B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0304A                       PIC S9(03)       COMP-3
           VALUE -083.
       77  FLD0304B                       PIC  9(10)V9(11) COMP-6
           VALUE  5565734306.84127234968.

       77  FLD0305A                       PIC  9(09)V9(03) COMP-6
           VALUE  328435884.788.
       77  FLD0305B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0306A                       PIC S9(03)       COMP-3
           VALUE -083.
       77  FLD0306B                       PIC S9(10)V9(08) COMP-3
           VALUE -4936418970.17687181.

       77  FLD0307A                       PIC  9(10)V9(10) COMP-3
           VALUE  5430567751.9659767416.
       77  FLD0307B                       PIC  9(03)V9(32) COMP-6
           VALUE  928.08547489686554765597747973515652.

       77  FLD0308A                       PIC  9(09)V9(05) COMP-6
           VALUE  377189267.62120.
       77  FLD0308B                       PIC  9(02)V9(34) COMP-3
           VALUE  96.4274365663057242414879510761238634.

       77  FLD0309A                       PIC  9(09)V9(03) COMP-6
           VALUE  325461096.612.
       77  FLD0309B                       PIC S9(03)       COMP-3
           VALUE -093.

       77  FLD0310A                       PIC  9(09)V9(05) COMP-6
           VALUE  377541451.37210.
       77  FLD0310B                       PIC  9(09)V9(06) COMP-6
           VALUE  416709099.760976.

       77  FLD0311A                       PIC S9(02)       COMP-3
           VALUE -06.
       77  FLD0311B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.931117203050255914931199185957666486.

       77  FLD0312A                       PIC S9(10)V9(07) COMP-3
           VALUE -4631183834.9707568.
       77  FLD0312B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0313A                       PIC  9(05)V9(27) COMP-3
           VALUE  86493.365621715367907995641871821.
       77  FLD0313B                       PIC  9(09)V9(05) COMP-6
           VALUE  375066571.23058.

       77  FLD0314A                       PIC  9(03)       COMP-6
           VALUE  088.
       77  FLD0314B                       PIC  9(08)V9(18) COMP-6
           VALUE  69720866.107690404600560896.

       77  FLD0315A                       PIC  9(07)V9(23) COMP-3
           VALUE  7933336.74589681625555215305212.
       77  FLD0315B                       PIC  9(09)V9(17) COMP-6
           VALUE  688307785.43204196306959374.

       77  FLD0316A                       PIC  9(06)V9(01) COMP-6
           VALUE  195827.4.
       77  FLD0316B                       PIC  9(10)V9(11) COMP-3
           VALUE  5611864585.06384822086.

       77  FLD0317A                       PIC  9(10)V9(08) COMP-6
           VALUE  4983225307.65216153.
       77  FLD0317B                       PIC S9(09)V9(03) COMP-3
           VALUE +331361572.492.

       77  FLD0318A                       PIC  9(08)V9(02) COMP-6
           VALUE  26926374.69.
       77  FLD0318B                       PIC  9(04)V9(29) COMP-3
           VALUE  8825.34717446214034275442372745601.

       77  FLD0319A                       PIC  9(08)V9(18) COMP-6
           VALUE  69931441.978879860243978328.
       77  FLD0319B                       PIC  9(09)V9(15) COMP-3
           VALUE  650439668.121860714578019.

       77  FLD0320A                       PIC  9(08)V9(19) COMP-6
           VALUE  71973495.8824565840274090078.
       77  FLD0320B                       PIC  9(10)V9(11) COMP-3
           VALUE  5542215777.53993832615.

       77  FLD0321A                       PIC  9(10)V9(09) COMP-3
           VALUE  5005504874.853489161.
       77  FLD0321B                       PIC  9(09)V9(16) COMP-3
           VALUE  660163921.0521921263818967.

       77  FLD0322A                       PIC S9(09)V9(07) COMP-3
           VALUE +442005310.2249054.
       77  FLD0322B                       PIC  9(09)V9(14) COMP-6
           VALUE  617916374.92097983841432.

       77  FLD0323A                       PIC S9(05)       COMP-3
           VALUE -15097.
       77  FLD0323B                       PIC  9(01)V9(35) COMP-3
           VALUE  9.73366140153258840861383305309573188.

       77  FLD0324A                       PIC  9(10)V9(11) COMP-3
           VALUE  5601604504.75820970162.
       77  FLD0324B                       PIC  9(10)V9(10) COMP-3
           VALUE  5319146871.9734047443.

       77  FLD0325A                       PIC  9(04)       COMP-6
           VALUE  1169.
       77  FLD0325B                       PIC  9(08)V9(19) COMP-3
           VALUE  72332591.2353324218528882738.

       77  FLD0326A                       PIC S9(08)V9(03) COMP-3
           VALUE +31312044.720.
       77  FLD0326B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0327A                       PIC S9(03)       COMP-3
           VALUE -090.
       77  FLD0327B                       PIC S9(07)V9(01) COMP-3
           VALUE +2122536.7.

       77  FLD0328A                       PIC  9(08)V9(19) COMP-3
           VALUE  71147504.7716873310044150002.
       77  FLD0328B                       PIC S9(09)V9(05) COMP-3
           VALUE -393175029.86891.

       77  FLD0329A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0329B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.2096907591406971249625712516717612.

       77  FLD0330A                       PIC  9(09)V9(07) COMP-6
           VALUE  445280746.1581723.
       77  FLD0330B                       PIC  9(07)V9(23) COMP-6
           VALUE  7955244.25555017788980194382020.

       77  FLD0331A                       PIC S9(07)V9(01) COMP-3
           VALUE +2232816.8.
       77  FLD0331B                       PIC  9(08)V9(02) COMP-6
           VALUE  27670053.03.

       77  FLD0332A                       PIC  9(05)V9(27) COMP-6
           VALUE  86562.988696340348315771962006692.
       77  FLD0332B                       PIC  9(09)V9(04) COMP-6
           VALUE  355930982.9079.

       77  FLD0333A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.6494138775326296908474432711955159.
       77  FLD0333B                       PIC S9(07)V9(02) COMP-3
           VALUE +2431333.31.

       77  FLD0334A                       PIC  9(08)V9(03) COMP-6
           VALUE  28999492.466.
       77  FLD0334B                       PIC  9(09)V9(03) COMP-6
           VALUE  326043905.981.

       77  FLD0335A                       PIC S9(08)V9(03) COMP-3
           VALUE +30334218.791.
       77  FLD0335B                       PIC  9(10)V9(09) COMP-6
           VALUE  5075855226.668805064.

       77  FLD0336A                       PIC  9(05)V9(27) COMP-6
           VALUE  85800.255545984371874368434873758.
       77  FLD0336B                       PIC S9(08)V9(03) COMP-3
           VALUE -29245898.644.

       77  FLD0337A                       PIC  9(08)V9(19) COMP-3
           VALUE  72003996.5448931451597047725.
       77  FLD0337B                       PIC  9(08)V9(19) COMP-3
           VALUE  71409231.4076567258318561925.

       77  FLD0338A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0338B                       PIC  9(10)V9(10) COMP-3
           VALUE  5304768900.0456310637.

       77  FLD0339A                       PIC S9(06)       COMP-3
           VALUE -160552.
       77  FLD0339B                       PIC  9(09)V9(13) COMP-3
           VALUE  594533435.7259434154840.

       77  FLD0340A                       PIC  9(10)V9(09) COMP-3
           VALUE  5028381651.473269320.
       77  FLD0340B                       PIC S9(09)V9(04) COMP-3
           VALUE -361499697.6055.

       77  FLD0341A                       PIC  9(10)V9(11) COMP-6
           VALUE  5676316159.01010966318.
       77  FLD0341B                       PIC  9(09)V9(12) COMP-3
           VALUE  572076310.146404809486.

       77  FLD0342A                       PIC S9(07)V9(01) COMP-3
           VALUE +2347143.0.
       77  FLD0342B                       PIC S9(10)V9(07) COMP-3
           VALUE -4530575977.8135124.

       77  FLD0343A                       PIC  9(08)V9(19) COMP-6
           VALUE  72866356.1504289902792663724.
       77  FLD0343B                       PIC  9(06)V9(01) COMP-6
           VALUE  195736.6.

       77  FLD0344A                       PIC  9(09)V9(07) COMP-6
           VALUE  439744878.9947105.
       77  FLD0344B                       PIC  9(04)V9(29) COMP-3
           VALUE  8815.39565612843856179381418769480.

       77  FLD0345A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0345B                       PIC  9(09)V9(06) COMP-6
           VALUE  405441574.894889.

       77  FLD0346A                       PIC  9(07)V9(22) COMP-3
           VALUE  7807860.0333687642187641131386.
       77  FLD0346B                       PIC  9(09)V9(16) COMP-3
           VALUE  674345587.8778652490268541.

       77  FLD0347A                       PIC  9(08)V9(18) COMP-3
           VALUE  70165985.253748408556617732.
       77  FLD0347B                       PIC  9(06)       COMP-6
           VALUE  158396.

       77  FLD0348A                       PIC  9(08)V9(04) COMP-6
           VALUE  33778742.7133.
       77  FLD0348B                       PIC  9(09)V9(12) COMP-6
           VALUE  575387126.330844100863.

       77  FLD0349A                       PIC  9(10)V9(09) COMP-3
           VALUE  5122785066.779668161.
       77  FLD0349B                       PIC  9(03)V9(32) COMP-3
           VALUE  924.84903066843715535583214659709483.

       77  FLD0350A                       PIC  9(02)       COMP-6
           VALUE  07.
       77  FLD0350B                       PIC  9(06)V9(25) COMP-6
           VALUE  826494.1389960360762501068165875.

       77  FLD0351A                       PIC  9(05)V9(27) COMP-6
           VALUE  84942.576912519174303639601930626.
       77  FLD0351B                       PIC  9(10)V9(10) COMP-6
           VALUE  5388327188.5283523516.

       77  FLD0352A                       PIC  9(03)V9(32) COMP-6
           VALUE  937.88592938035042489985926295048557.
       77  FLD0352B                       PIC  9(06)V9(01) COMP-6
           VALUE  195629.8.

       77  FLD0353A                       PIC S9(07)V9(02) COMP-3
           VALUE -2544588.73.
       77  FLD0353B                       PIC  9(02)V9(33) COMP-3
           VALUE  94.340663054368900652946194895775988.

       77  FLD0354A                       PIC  9(07)V9(01) COMP-6
           VALUE  2152460.4.
       77  FLD0354B                       PIC S9(08)V9(03) COMP-3
           VALUE -29015200.342.

       77  FLD0355A                       PIC  9(06)V9(01) COMP-6
           VALUE  208715.4.
       77  FLD0355B                       PIC S9(05)       COMP-3
           VALUE -15428.

       77  FLD0356A                       PIC S9(09)V9(05) COMP-3
           VALUE -391398983.37050.
       77  FLD0356B                       PIC  9(05)V9(27) COMP-6
           VALUE  84690.187478976841628508509529638.

       77  FLD0357A                       PIC  9(10)V9(10) COMP-3
           VALUE  5323345989.0667944591.
       77  FLD0357B                       PIC  9(03)       COMP-6
           VALUE  079.

       77  FLD0358A                       PIC  9(08)V9(03) COMP-6
           VALUE  29848403.943.
       77  FLD0358B                       PIC  9(09)V9(17) COMP-6
           VALUE  688595894.53938552239264936.

       77  FLD0359A                       PIC  9(07)V9(22) COMP-6
           VALUE  7654789.5985185210321333215688.
       77  FLD0359B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.927521413787718795873615817981772124.

       77  FLD0360A                       PIC S9(09)V9(06) COMP-3
           VALUE +400277612.276280.
       77  FLD0360B                       PIC  9(08)V9(02) COMP-6
           VALUE  26666225.04.

       77  FLD0361A                       PIC  9(06)V9(25) COMP-3
           VALUE  823089.8044061112361902132761315.
       77  FLD0361B                       PIC  9(05)V9(27) COMP-6
           VALUE  84762.044237681810621154454565839.

       77  FLD0362A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0362B                       PIC  9(04)V9(30) COMP-6
           VALUE  8970.899599407193836242413453874178.

       77  FLD0363A                       PIC  9(09)V9(04) COMP-6
           VALUE  358575926.2078.
       77  FLD0363B                       PIC  9(04)V9(30) COMP-3
           VALUE  9034.927431796696550847514117776881.

       77  FLD0364A                       PIC S9(04)       COMP-3
           VALUE +1234.
       77  FLD0364B                       PIC  9(06)V9(25) COMP-3
           VALUE  830028.0009277749559970516202156.

       77  FLD0365A                       PIC  9(09)V9(11) COMP-3
           VALUE  551967009.62472056151.
       77  FLD0365B                       PIC  9(09)V9(16) COMP-6
           VALUE  658782379.9892106313436102.

       77  FLD0366A                       PIC  9(06)V9(25) COMP-3
           VALUE  822414.3642778768414913770357088.
       77  FLD0366B                       PIC  9(06)V9(25) COMP-6
           VALUE  838180.2974044693099742175945721.

       77  FLD0367A                       PIC  9(09)V9(13) COMP-6
           VALUE  595975436.9256639039420.
       77  FLD0367B                       PIC S9(06)V9(01) COMP-3
           VALUE -191378.3.

       77  FLD0368A                       PIC  9(05)       COMP-6
           VALUE  15663.
       77  FLD0368B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0369A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0369B                       PIC S9(08)V9(03) COMP-3
           VALUE +31224128.387.

       77  FLD0370A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0370B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0371A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0371B                       PIC S9(03)       COMP-3
           VALUE -082.

       77  FLD0372A                       PIC  9(10)V9(09) COMP-6
           VALUE  5067586024.551302692.
       77  FLD0372B                       PIC  9(10)V9(09) COMP-3
           VALUE  5017586497.117959565.

       77  FLD0373A                       PIC  9(09)V9(16) COMP-3
           VALUE  660730415.8912360447786227.
       77  FLD0373B                       PIC S9(09)V9(04) COMP-3
           VALUE -352559577.5040.

       77  FLD0374A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0374B                       PIC  9(08)V9(19) COMP-3
           VALUE  71126449.7973442155753787119.

       77  FLD0375A                       PIC  9(07)V9(22) COMP-3
           VALUE  7816763.9605777072819847717255.
       77  FLD0375B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0376A                       PIC  9(05)V9(27) COMP-6
           VALUE  84980.958923270843996533585595898.
       77  FLD0376B                       PIC  9(10)V9(09) COMP-3
           VALUE  5240094598.000759607.

       77  FLD0377A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7759547981370871205797357106348499.
       77  FLD0377B                       PIC  9(07)V9(22) COMP-3
           VALUE  7813622.4062247550126159012506.

       77  FLD0378A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0378B                       PIC S9(06)       COMP-3
           VALUE -163135.

       77  FLD0379A                       PIC  9(10)V9(10) COMP-6
           VALUE  5351160784.1302399890.
       77  FLD0379B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0380A                       PIC  9(09)V9(03) COMP-6
           VALUE  318886259.138.
       77  FLD0380B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0381A                       PIC  9(10)V9(09) COMP-6
           VALUE  5188977124.912377281.
       77  FLD0381B                       PIC  9(03)       COMP-6
           VALUE  096.

       77  FLD0382A                       PIC  9(10)V9(10) COMP-6
           VALUE  5469463185.9002762475.
       77  FLD0382B                       PIC  9(04)       COMP-6
           VALUE  1276.

       77  FLD0383A                       PIC  9(04)V9(29) COMP-3
           VALUE  8846.28028341020278269013488170458.
       77  FLD0383B                       PIC  9(06)V9(24) COMP-3
           VALUE  801588.906111812216082057602761.

       77  FLD0384A                       PIC S9(07)V9(02) COMP-3
           VALUE +2410021.83.
       77  FLD0384B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0385A                       PIC  9(09)V9(14) COMP-6
           VALUE  616198826.41569234671408.
       77  FLD0385B                       PIC  9(04)V9(29) COMP-3
           VALUE  8914.93363280043138452413131744833.

       77  FLD0386A                       PIC  9(10)V9(11) COMP-6
           VALUE  5671006446.22052230126.
       77  FLD0386B                       PIC  9(07)V9(21) COMP-3
           VALUE  7538453.430795608589676248811.

       77  FLD0387A                       PIC  9(08)V9(03) COMP-6
           VALUE  30516405.931.
       77  FLD0387B                       PIC  9(09)V9(16) COMP-3
           VALUE  660134959.6835575095354897.

       77  FLD0388A                       PIC  9(10)V9(11) COMP-6
           VALUE  5691303425.20841603359.
       77  FLD0388B                       PIC  9(03)       COMP-6
           VALUE  099.

       77  FLD0389A                       PIC S9(10)V9(06) COMP-3
           VALUE +4300560615.719126.
       77  FLD0389B                       PIC  9(10)V9(12) COMP-6
           VALUE  5882065365.633618592156.

       77  FLD0390A                       PIC S9(02)       COMP-3
           VALUE -07.
       77  FLD0390B                       PIC  9(03)       COMP-6
           VALUE  095.

       77  FLD0391A                       PIC S9(08)V9(03) COMP-3
           VALUE +30066642.536.
       77  FLD0391B                       PIC S9(08)V9(02) COMP-3
           VALUE -26329271.26.

       77  FLD0392A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.7627258628673261320329856971511617.
       77  FLD0392B                       PIC  9(10)V9(07) COMP-6
           VALUE  4682510725.0510572.

       77  FLD0393A                       PIC  9(02)       COMP-6
           VALUE  05.
       77  FLD0393B                       PIC  9(04)V9(30) COMP-6
           VALUE  9067.420163680885991652758093550801.

       77  FLD0394A                       PIC  9(05)V9(01) COMP-6
           VALUE  16807.8.
       77  FLD0394B                       PIC S9(10)V9(08) COMP-3
           VALUE -4746288002.63585892.

       77  FLD0395A                       PIC  9(10)V9(09) COMP-3
           VALUE  5206691882.901124390.
       77  FLD0395B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0396A                       PIC  9(09)V9(06) BINARY
           VALUE  419939827.280791.
       77  FLD0396B                       PIC  9(09)V9(07) COMP-6
           VALUE  446487444.5871826.

       77  FLD0397A                       PIC  9(05)V9(27) COMP-6
           VALUE  85569.982924983467587054519754019.
       77  FLD0397B                       PIC S9(02)       COMP-3
           VALUE -07.

       77  FLD0398A                       PIC  9(05)V9(26) COMP-3
           VALUE  84110.85692078776876456913669244.
       77  FLD0398B                       PIC S9(08)V9(02) COMP-3
           VALUE -28358417.67.

       77  FLD0399A                       PIC  9(05)V9(27) COMP-3
           VALUE  86215.377080746946614198122915695.
       77  FLD0399B                       PIC  9(07)V9(02) COMP-6
           VALUE  2481207.70.

       77  FLD0400A                       PIC  9(10)V9(08) COMP-6
           VALUE  4880703034.67910082.
       77  FLD0400B                       PIC  9(06)V9(25) COMP-6
           VALUE  835199.6491942943467989834971376.

       77  FLD0401A                       PIC  9(08)V9(03) COMP-6
           VALUE  30757829.425.
       77  FLD0401B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0402A                       PIC  9(04)V9(29) COMP-3
           VALUE  8843.41306989221531686951038864208.
       77  FLD0402B                       PIC  9(08)V9(18) COMP-6
           VALUE  69652895.633901057426129455.

       77  FLD0403A                       PIC  9(10)V9(10) COMP-6
           VALUE  5351391185.2119278034.
       77  FLD0403B                       PIC  9(03)V9(32) COMP-6
           VALUE  939.96913575689089448417234962107613.

       77  FLD0404A                       PIC S9(10)V9(08) COMP-3
           VALUE -4810592903.51378177.
       77  FLD0404B                       PIC  9(09)V9(16) COMP-3
           VALUE  670850774.7441430080215241.

       77  FLD0405A                       PIC S9(09)V9(04) COMP-3
           VALUE -360620744.0007.
       77  FLD0405B                       PIC S9(05)       COMP-3
           VALUE +14133.

       77  FLD0406A                       PIC S9(07)V9(02) COMP-3
           VALUE -2503018.94.
       77  FLD0406B                       PIC  9(07)V9(23) COMP-6
           VALUE  7996063.91391730064732712435215.

       77  FLD0407A                       PIC  9(09)V9(13) COMP-3
           VALUE  592634898.8738083800598.
       77  FLD0407B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.879241102928391082826919955550692975.

       77  FLD0408A                       PIC  9(09)V9(07) COMP-6
           VALUE  438100099.1119252.
       77  FLD0408B                       PIC  9(08)V9(02) COMP-6
           VALUE  28626783.20.

       77  FLD0409A                       PIC  9(08)V9(02) COMP-6
           VALUE  28575188.65.
       77  FLD0409B                       PIC  9(09)V9(12) COMP-6
           VALUE  576691261.515216657684.

       77  FLD0410A                       PIC  9(09)V9(14) COMP-6
           VALUE  615937928.60877261130525.
       77  FLD0410B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.822719722312858170454319406417198479.

       77  FLD0411A                       PIC  9(09)V9(17) COMP-6
           VALUE  688573322.26995748847286904.
       77  FLD0411B                       PIC  9(07)V9(22) COMP-6
           VALUE  7775778.4281136710369253250973.

       77  FLD0412A                       PIC  9(09)V9(12) COMP-3
           VALUE  572677017.522024045526.
       77  FLD0412B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0413A                       PIC  9(06)V9(25) COMP-6
           VALUE  828822.6462986850728853482905833.
       77  FLD0413B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0414A                       PIC  9(05)V9(27) COMP-3
           VALUE  84413.303017262042438062508153961.
       77  FLD0414B                       PIC S9(05)       COMP-3
           VALUE -15377.

       77  FLD0415A                       PIC  9(09)V9(15) COMP-3
           VALUE  650722988.227690701812377.
       77  FLD0415B                       PIC  9(03)V9(31) COMP-6
           VALUE  919.0351051613949717733476063585840.

       77  FLD0416A                       PIC  9(09)V9(16) COMP-6
           VALUE  675584038.8269652718733482.
       77  FLD0416B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0417A                       PIC  9(03)V9(32) COMP-3
           VALUE  942.59186417160190085695603556814603.
       77  FLD0417B                       PIC  9(04)V9(29) COMP-3
           VALUE  8943.54109346381376255408213182818.

       77  FLD0418A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0418B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0419A                       PIC  9(09)V9(06) COMP-6
           VALUE  415695619.544491.
       77  FLD0419B                       PIC  9(10)V9(10) COMP-3
           VALUE  5349169017.3884820502.

       77  FLD0420A                       PIC  9(08)V9(02) COMP-6
           VALUE  26881191.37.
       77  FLD0420B                       PIC  9(04)V9(30) COMP-6
           VALUE  9092.387304867948216724471421912312.

       77  FLD0421A                       PIC  9(08)V9(19) COMP-3
           VALUE  71124707.9077118260492795798.
       77  FLD0421B                       PIC S9(06)V9(01) COMP-3
           VALUE +210383.3.

       77  FLD0422A                       PIC  9(08)V9(18) COMP-3
           VALUE  69276472.004700051510184266.
       77  FLD0422B                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7464238557165900900258748151827603.

       77  FLD0423A                       PIC  9(09)V9(13) COMP-6
           VALUE  595417774.2919815052857.
       77  FLD0423B                       PIC  9(09)V9(17) COMP-6
           VALUE  689527286.14626146441679566.

       77  FLD0424A                       PIC  9(09)V9(11) COMP-3
           VALUE  551151541.59885582085.
       77  FLD0424B                       PIC  9(08)V9(19) COMP-6
           VALUE  72724692.5117367437607640567.

       77  FLD0425A                       PIC S9(10)V9(08) COMP-3
           VALUE -4741628720.81754727.
       77  FLD0425B                       PIC  9(10)V9(12) COMP-3
           VALUE  5846836543.074439562772.

       77  FLD0426A                       PIC  9(10)V9(11) COMP-3
           VALUE  5601456695.80725313885.
       77  FLD0426B                       PIC  9(10)V9(11) COMP-6
           VALUE  5581868249.31393821280.

       77  FLD0427A                       PIC  9(09)V9(04) COMP-6
           VALUE  365284621.5641.
       77  FLD0427B                       PIC  9(07)V9(22) COMP-6
           VALUE  7792109.4871910845380824639505.

       77  FLD0428A                       PIC  9(05)V9(27) COMP-6
           VALUE  85913.234918316627730661139139556.
       77  FLD0428B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.753152813075189886404814387788064777.

       77  FLD0429A                       PIC  9(07)V9(22) COMP-3
           VALUE  7833347.6062909002113343603923.
       77  FLD0429B                       PIC  9(09)V9(06) COMP-6
           VALUE  415311789.274485.

       77  FLD0430A                       PIC  9(08)V9(03) COMP-6
           VALUE  30820998.502.
       77  FLD0430B                       PIC  9(09)V9(04) COMP-6
           VALUE  345613119.3468.

       77  FLD0431A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0431B                       PIC  9(03)V9(31) COMP-3
           VALUE  920.3928254587173674039490833820309.

       77  FLD0432A                       PIC  9(10)V9(11) COMP-3
           VALUE  5612307034.00538710745.
       77  FLD0432B                       PIC S9(06)       COMP-3
           VALUE -161655.

       77  FLD0433A                       PIC  9(08)V9(19) COMP-3
           VALUE  72012955.8244768763763943297.
       77  FLD0433B                       PIC  9(06)V9(01) COMP-6
           VALUE  206502.1.

       77  FLD0434A                       PIC S9(10)V9(07) COMP-3
           VALUE -4547054675.3415619.
       77  FLD0434B                       PIC  9(03)V9(32) COMP-3
           VALUE  931.50114075800283242045907172723673.

       77  FLD0435A                       PIC  9(03)       COMP-6
           VALUE  087.
       77  FLD0435B                       PIC  9(10)V9(12) COMP-3
           VALUE  5848414344.863717140299.

       77  FLD0436A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0436B                       PIC  9(06)V9(25) COMP-3
           VALUE  830719.5843004202551185244374210.

       77  FLD0437A                       PIC  9(09)V9(15) COMP-3
           VALUE  632897272.198471361193128.
       77  FLD0437B                       PIC  9(09)V9(15) COMP-3
           VALUE  644015379.475938010145341.

       77  FLD0438A                       PIC  9(09)V9(16) COMP-3
           VALUE  664694021.6365745390802999.
       77  FLD0438B                       PIC  9(05)V9(28) COMP-3
           VALUE  87427.7230957161255453513604152249.

       77  FLD0439A                       PIC  9(10)V9(08) COMP-6
           VALUE  4961134805.43429519.
       77  FLD0439B                       PIC  9(10)V9(11) COMP-3
           VALUE  5610850764.78219813012.

       77  FLD0440A                       PIC  9(04)V9(29) COMP-6
           VALUE  8899.07507055040514210020319296745.
       77  FLD0440B                       PIC  9(10)V9(07) COMP-6
           VALUE  4554701137.8932739.

       77  FLD0441A                       PIC  9(08)V9(19) COMP-3
           VALUE  71126905.4406556744396539215.
       77  FLD0441B                       PIC S9(10)V9(06) COMP-3
           VALUE +4339238601.837461.

       77  FLD0442A                       PIC  9(05)V9(01) COMP-6
           VALUE  16995.1.
       77  FLD0442B                       PIC  9(03)V9(31) COMP-6
           VALUE  915.7753741786495149668212434335146.

       77  FLD0443A                       PIC S9(10)V9(08) COMP-3
           VALUE -4744984255.46487689.
       77  FLD0443B                       PIC  9(09)V9(14) COMP-3
           VALUE  620915031.52970173307068.

       77  FLD0444A                       PIC  9(02)V9(33) COMP-6
           VALUE  94.673816662087151296844922399031929.
       77  FLD0444B                       PIC  9(10)V9(09) COMP-3
           VALUE  5047752845.189990011.

       77  FLD0445A                       PIC  9(10)V9(10) COMP-3
           VALUE  5416554544.5299512206.
       77  FLD0445B                       PIC S9(10)V9(07) COMP-3
           VALUE -4623541965.4562581.

       77  FLD0446A                       PIC  9(10)V9(09) COMP-3
           VALUE  5044897846.697211640.
       77  FLD0446B                       PIC  9(09)V9(16) COMP-6
           VALUE  665206327.4939082893055797.

       77  FLD0447A                       PIC  9(02)       COMP-6
           VALUE  06.
       77  FLD0447B                       PIC  9(08)V9(02) COMP-6
           VALUE  27717300.69.

       77  FLD0448A                       PIC  9(06)V9(01) COMP-6
           VALUE  186565.4.
       77  FLD0448B                       PIC  9(10)V9(10) COMP-6
           VALUE  5373290497.5367845601.

       77  FLD0449A                       PIC S9(09)V9(05) COMP-3
           VALUE -384988094.18704.
       77  FLD0449B                       PIC S9(08)V9(04) COMP-3
           VALUE +34016016.2924.

       77  FLD0450A                       PIC  9(09)V9(14) COMP-6
           VALUE  625578375.50228334588808.
       77  FLD0450B                       PIC  9(09)V9(13) COMP-6
           VALUE  597300618.6146695428718.

       77  FLD0451A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0451B                       PIC S9(07)V9(02) COMP-3
           VALUE -2517390.40.

       77  FLD0452A                       PIC  9(08)V9(02) COMP-6
           VALUE  26826484.18.
       77  FLD0452B                       PIC  9(10)V9(11) COMP-6
           VALUE  5576443525.30127562772.

       77  FLD0453A                       PIC  9(10)V9(10) COMP-6
           VALUE  5383526546.5392911909.
       77  FLD0453B                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7573296701221163829131910461001098.

       77  FLD0454A                       PIC S9(03)       COMP-3
           VALUE -090.
       77  FLD0454B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0455A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0455B                       PIC  9(05)V9(27) COMP-3
           VALUE  85105.998788168291113720442808698.

       77  FLD0456A                       PIC S9(03)       COMP-3
           VALUE -093.
       77  FLD0456B                       PIC  9(05)       COMP-6
           VALUE  15509.

       77  FLD0457A                       PIC  9(04)V9(30) COMP-6
           VALUE  9063.641671624598217249513254500925.
       77  FLD0457B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0458A                       PIC  9(02)       COMP-6
           VALUE  06.
       77  FLD0458B                       PIC  9(09)V9(03) COMP-6
           VALUE  319507540.378.

       77  FLD0459A                       PIC  9(06)V9(01) COMP-6
           VALUE  198479.9.
       77  FLD0459B                       PIC  9(10)V9(11) COMP-3
           VALUE  5635468078.16151518188.

       77  FLD0460A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0460B                       PIC  9(07)V9(22) COMP-3
           VALUE  7834589.5335320658858790920930.

       77  FLD0461A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0461B                       PIC S9(07)V9(01) COMP-3
           VALUE +2146839.2.

       77  FLD0462A                       PIC  9(08)V9(02) COMP-6
           VALUE  26776595.69.
       77  FLD0462B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.2391194548525610308331579290097579.

       77  FLD0463A                       PIC  9(05)V9(27) COMP-3
           VALUE  85490.666934027292889197724434779.
       77  FLD0463B                       PIC  9(09)V9(06) COMP-6
           VALUE  407249114.981761.

       77  FLD0464A                       PIC  9(10)V9(07) COMP-6
           VALUE  4587031190.3834293.
       77  FLD0464B                       PIC  9(08)V9(19) COMP-6
           VALUE  71857481.5704608793609509120.

       77  FLD0465A                       PIC  9(10)V9(12) COMP-3
           VALUE  5816563985.597106301028.
       77  FLD0465B                       PIC  9(06)V9(25) COMP-6
           VALUE  837937.1800695708527584315561398.

       77  FLD0466A                       PIC  9(09)V9(15) COMP-3
           VALUE  654381306.333900236715805.
       77  FLD0466B                       PIC  9(05)       COMP-6
           VALUE  14616.

       77  FLD0467A                       PIC S9(07)V9(01) COMP-3
           VALUE +2343287.0.
       77  FLD0467B                       PIC  9(04)V9(29) COMP-3
           VALUE  8929.74677715112297171629052172647.

       77  FLD0468A                       PIC S9(10)V9(06) COMP-3
           VALUE +4344132145.767680.
       77  FLD0468B                       PIC  9(08)V9(03) COMP-6
           VALUE  29592230.696.

       77  FLD0469A                       PIC  9(08)V9(18) COMP-6
           VALUE  70961503.876956555370014712.
       77  FLD0469B                       PIC  9(10)V9(09) COMP-3
           VALUE  5200119971.346918168.

       77  FLD0470A                       PIC  9(03)V9(31) COMP-3
           VALUE  913.6810028966669827710234130790922.
       77  FLD0470B                       PIC S9(09)V9(05) COMP-3
           VALUE -383130523.18889.

       77  FLD0471A                       PIC S9(07)V9(02) COMP-3
           VALUE -2507103.69.
       77  FLD0471B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0472A                       PIC  9(10)V9(09) COMP-3
           VALUE  5103990869.050332168.
       77  FLD0472B                       PIC  9(06)V9(26) COMP-3
           VALUE  843393.74409143441635450244575622.

       77  FLD0473A                       PIC  9(08)V9(20) COMP-3
           VALUE  74367162.06805468187823748849.
       77  FLD0473B                       PIC  9(08)V9(18) COMP-3
           VALUE  70143773.259305752798553612.

       77  FLD0474A                       PIC  9(08)V9(19) COMP-6
           VALUE  72625744.5118117406224200749.
       77  FLD0474B                       PIC S9(05)       COMP-3
           VALUE +13295.

       77  FLD0475A                       PIC  9(10)V9(07) COMP-6
           VALUE  4588724634.2999971.
       77  FLD0475B                       PIC S9(09)V9(06) COMP-3
           VALUE +420010897.357724.

       77  FLD0476A                       PIC  9(08)V9(02) COMP-6
           VALUE  28869933.49.
       77  FLD0476B                       PIC  9(06)V9(01) COMP-6
           VALUE  197306.5.

       77  FLD0477A                       PIC  9(08)V9(20) COMP-3
           VALUE  74492482.99155191155307420558.
       77  FLD0477B                       PIC S9(09)V9(05) COMP-3
           VALUE -380644102.28203.

       77  FLD0478A                       PIC  9(08)V9(19) COMP-6
           VALUE  72616162.5751895356550846827.
       77  FLD0478B                       PIC  9(09)V9(04) COMP-6
           VALUE  345871637.9604.

       77  FLD0479A                       PIC S9(09)V9(06) COMP-3
           VALUE +413502052.896697.
       77  FLD0479B                       PIC  9(06)V9(25) COMP-3
           VALUE  820524.8465168897276100778981344.

       77  FLD0480A                       PIC S9(06)V9(01) COMP-3
           VALUE +203017.8.
       77  FLD0480B                       PIC  9(08)V9(20) COMP-6
           VALUE  74798417.21657910502685240317.

       77  FLD0481A                       PIC  9(05)       COMP-6
           VALUE  15658.
       77  FLD0481B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.907459007614364265847939350351225584.

       77  FLD0482A                       PIC  9(08)V9(18) COMP-6
           VALUE  70905037.950447225014727337.
       77  FLD0482B                       PIC S9(10)V9(08) COMP-3
           VALUE -4922020906.16106868.

       77  FLD0483A                       PIC  9(03)       COMP-6
           VALUE  079.
       77  FLD0483B                       PIC S9(09)V9(03) COMP-3
           VALUE +323420049.144.

       77  FLD0484A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0484B                       PIC  9(09)V9(12) COMP-6
           VALUE  577123861.473882282524.

       77  FLD0485A                       PIC  9(07)V9(02) COMP-6
           VALUE  2567572.97.
       77  FLD0485B                       PIC  9(05)V9(01) COMP-6
           VALUE  16688.0.

       77  FLD0486A                       PIC  9(05)       COMP-6
           VALUE  13937.
       77  FLD0486B                       PIC  9(10)V9(07) COMP-6
           VALUE  4583814690.4965959.

       77  FLD0487A                       PIC  9(06)V9(01) COMP-6
           VALUE  209384.2.
       77  FLD0487B                       PIC  9(08)V9(18) COMP-3
           VALUE  70207035.549040885946681100.

       77  FLD0488A                       PIC S9(10)V9(07) COMP-3
           VALUE -4519198906.7966076.
       77  FLD0488B                       PIC  9(09)V9(16) COMP-6
           VALUE  669660091.3134611587906874.

       77  FLD0489A                       PIC S9(05)V9(01) COMP-3
           VALUE -17360.6.
       77  FLD0489B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.950567826331271348294649214949458837.

       77  FLD0490A                       PIC  9(10)V9(10) COMP-6
           VALUE  5352566580.2623056954.
       77  FLD0490B                       PIC  9(08)V9(02) COMP-6
           VALUE  28596817.06.

       77  FLD0491A                       PIC  9(03)V9(31) COMP-6
           VALUE  918.2459205467069507378141679510008.
       77  FLD0491B                       PIC  9(09)V9(16) COMP-3
           VALUE  661285516.5476814178759923.

       77  FLD0492A                       PIC  9(06)V9(25) COMP-6
           VALUE  819266.4570447540928199714471702.
       77  FLD0492B                       PIC S9(09)V9(04) COMP-3
           VALUE +343135449.1145.

       77  FLD0493A                       PIC S9(05)V9(01) BINARY
           VALUE -18038.5.
       77  FLD0493B                       PIC  9(06)V9(24) COMP-6
           VALUE  808734.959278862186593528349476.

       77  FLD0494A                       PIC  9(05)V9(28) COMP-6
           VALUE  87574.5417791477964719604187848744.
       77  FLD0494B                       PIC  9(10)V9(09) COMP-3
           VALUE  5133082903.157394349.

       77  FLD0495A                       PIC S9(02)       COMP-3
           VALUE -05.
       77  FLD0495B                       PIC  9(09)V9(15) COMP-6
           VALUE  646882578.915106698502768.

       77  FLD0496A                       PIC  9(06)V9(25) COMP-6
           VALUE  816763.6415427422802437718019064.
       77  FLD0496B                       PIC S9(04)       COMP-3
           VALUE +1240.

       77  FLD0497A                       PIC  9(06)V9(25) COMP-6
           VALUE  836230.6435874340415637107071233.
       77  FLD0497B                       PIC  9(09)V9(16) COMP-6
           VALUE  665491997.9684780217965567.

       77  FLD0498A                       PIC  9(10)V9(08) COMP-6
           VALUE  4792455293.49441590.
       77  FLD0498B                       PIC  9(06)V9(01) COMP-6
           VALUE  189449.4.

       77  FLD0499A                       PIC  9(02)       COMP-6
           VALUE  05.
       77  FLD0499B                       PIC  9(09)V9(15) COMP-3
           VALUE  634131211.402607308791345.


      * RESULTS-AREA.
       78  XPC-FLD0001B
           VALUE X'04'.
       78  XPC-FLD0002B
           VALUE X'01571925154608921904042517780914'.
       78  XPC-FLD0003B
           VALUE X'497691662540136914'.
       78  XPC-FLD0004B
           VALUE X'316172'.
       78  XPC-FLD0005B
           VALUE X'0326669126773C'.
       78  XPC-FLD0006B
           VALUE X'02564149945687535678828794516448398F'.
       78  XPC-FLD0007B
           VALUE X'02703102891D'.
       78  XPC-FLD0008B
           VALUE X'091D'.
       78  XPC-FLD0009B
           VALUE X'750598888818416259625343627703841F'.
       78  XPC-FLD0010B
           VALUE X'401313154225654C'.
       78  XPC-FLD0011B
           VALUE X'0716073640695890795927880390081554'.
       78  XPC-FLD0012B
           VALUE X'714856822486604356929547066F'.
       78  XPC-FLD0013B
           VALUE X'0249701360'.
       78  XPC-FLD0014B
           VALUE X'07563565'.
       78  XPC-FLD0015B
           VALUE X'496103206190910525'.
       78  XPC-FLD0016B
           VALUE X'04316078086835850C'.
       78  XPC-FLD0017B
           VALUE X'8983341087204116393039043941826093'.
       78  XPC-FLD0018B
           VALUE X'7D'.
       78  XPC-FLD0019B
           VALUE X'527908669140271D'.
       78  XPC-FLD0020B
           VALUE X'009154677345638306819F'.
       78  XPC-FLD0021B
           VALUE X'0C'.
       78  XPC-FLD0022B
           VALUE X'06800620448921426031141379553F'.
       78  XPC-FLD0023B
           VALUE X'0011865432391802879230624512274516746F'.
       78  XPC-FLD0024B
           VALUE X'081262603108476C'.
       78  XPC-FLD0025B
           VALUE X'0249748827'.
       78  XPC-FLD0026B
           VALUE X'038375719620564D'.
       78  XPC-FLD0027B
           VALUE X'08427161982877569013082921992870'.
       78  XPC-FLD0028B
           VALUE X'5D'.
       78  XPC-FLD0029B
           VALUE X'068438817718294422258378517F'.
       78  XPC-FLD0030B
           VALUE X'070264210169553353857452293F'.
       78  XPC-FLD0031B
           VALUE X'070450280588407820925311852F'.
       78  XPC-FLD0032B
           VALUE X'0947220571791D'.
       78  XPC-FLD0033B
           VALUE X'960256540212'.
       78  XPC-FLD0034B
           VALUE X'021267719C'.
       78  XPC-FLD0035B
           VALUE X'30926017'.
       78  XPC-FLD0036B
           VALUE X'84780746063121390621031281398245'.
       78  XPC-FLD0037B
           VALUE X'15352D'.
       78  XPC-FLD0038B
           VALUE X'08192466589219795159659831540467'.
       78  XPC-FLD0039B
           VALUE X'02142775'.
       78  XPC-FLD0040B
           VALUE X'328C'.
       78  XPC-FLD0041B
           VALUE X'5719955231502458548F'.
       78  XPC-FLD0042B
           VALUE X'53913067269542921267'.
       78  XPC-FLD0043B
           VALUE X'08947428650524259539551508169097361F'.
       78  XPC-FLD0044B
           VALUE X'03593279914883'.
       78  XPC-FLD0045B
           VALUE X'40565136957830'.
       78  XPC-FLD0046B
           VALUE X'086000025910646182847330010190489F'.
       78  XPC-FLD0047B
           VALUE X'500920610887845814'.
       78  XPC-FLD0048B
           VALUE X'0012727D'.
       78  XPC-FLD0049B
           VALUE X'06818217198975972105429554915463086217'.
       78  XPC-FLD0050B
           VALUE X'0079122399722566'.
       78  XPC-FLD0051B
           VALUE X'4768561362631936750203005938732530'.
       78  XPC-FLD0052B
           VALUE X'018378999229403754265F'.
       78  XPC-FLD0053B
           VALUE X'3589163888701D'.
       78  XPC-FLD0054B
           VALUE X'319288758232'.
       78  XPC-FLD0055B
           VALUE X'9048691568994934320002240F'.
       78  XPC-FLD0056B
           VALUE X'2564409583'.
       78  XPC-FLD0057B
           VALUE X'024C'.
       78  XPC-FLD0058B
           VALUE X'3436235653794C'.
       78  XPC-FLD0059B
           VALUE X'062832873919564874525472'.
       78  XPC-FLD0060B
           VALUE X'159140'.
       78  XPC-FLD0061B
           VALUE X'08166592123096498172785118185856'.
       78  XPC-FLD0062B
           VALUE X'09769550469250686264269F'.
       78  XPC-FLD0063B
           VALUE X'753004763264897311507922950F'.
       78  XPC-FLD0064B
           VALUE X'07440D'.
       78  XPC-FLD0065B
           VALUE X'05378C'.
       78  XPC-FLD0066B
           VALUE X'085085260849998822774153950376785F'.
       78  XPC-FLD0067B
           VALUE X'1D'.
       78  XPC-FLD0068B
           VALUE X'06'.
       78  XPC-FLD0069B
           VALUE X'0097'.
       78  XPC-FLD0070B
           VALUE X'8473394D'.
       78  XPC-FLD0071B
           VALUE X'1274'.
       78  XPC-FLD0072B
           VALUE X'655377313792015250284373'.
       78  XPC-FLD0073B
           VALUE X'70717240702803545859163048'.
       78  XPC-FLD0074B
           VALUE X'6009119595528942259221594213158817808F'.
       78  XPC-FLD0075B
           VALUE X'082894007C'.
       78  XPC-FLD0076B
           VALUE X'0889922269538142470324260102643165738F'.
       78  XPC-FLD0077B
           VALUE X'0297736583767979700245026833727024'.
       78  XPC-FLD0078B
           VALUE X'52639083334727222580'.
       78  XPC-FLD0079B
           VALUE X'324C'.
       78  XPC-FLD0080B
           VALUE X'3711534372339D'.
       78  XPC-FLD0081B
           VALUE X'03672069622885'.
       78  XPC-FLD0082B
           VALUE X'039908942738066827524420432382'.
       78  XPC-FLD0083B
           VALUE X'886546406C'.
       78  XPC-FLD0084B
           VALUE X'0405109331835069'.
       78  XPC-FLD0085B
           VALUE X'4354243534611629'.
       78  XPC-FLD0086B
           VALUE X'571167021401449572360F'.
       78  XPC-FLD0087B
           VALUE X'9773'.
       78  XPC-FLD0088B
           VALUE X'481540354519'.
       78  XPC-FLD0089B
           VALUE X'08552781102827879955441403577769802F'.
       78  XPC-FLD0090B
           VALUE X'00751809682D'.
       78  XPC-FLD0091B
           VALUE X'08617201884902925811235356'.
       78  XPC-FLD0092B
           VALUE X'03179100098465547968089595087804'.
       78  XPC-FLD0093B
           VALUE X'0790919325337388512409120266966F'.
       78  XPC-FLD0094B
           VALUE X'053066656460354850645F'.
       78  XPC-FLD0095B
           VALUE X'05167739798081453228562054391361'.
       78  XPC-FLD0096B
           VALUE X'0875053049076218392166026660561328'.
       78  XPC-FLD0097B
           VALUE X'076639044132902548449948199049'.
       78  XPC-FLD0098B
           VALUE X'334130309069'.
       78  XPC-FLD0099B
           VALUE X'16802810991D'.
       78  XPC-FLD0100B
           VALUE X'053883959962677607717265'.
       78  XPC-FLD0101B
           VALUE X'512112051D'.
       78  XPC-FLD0102B
           VALUE X'062599568832775289662151'.
       78  XPC-FLD0103B
           VALUE X'09'.
       78  XPC-FLD0104B
           VALUE X'0481255505832174334D'.
       78  XPC-FLD0105B
           VALUE X'0152268966'.
       78  XPC-FLD0106B
           VALUE X'02636217829D'.
       78  XPC-FLD0107B
           VALUE X'0491683543555178959039153289'.
       78  XPC-FLD0108B
           VALUE X'03863193550D'.
       78  XPC-FLD0109B
           VALUE X'00156720262660837374113498299266211F'.
       78  XPC-FLD0110B
           VALUE X'61781025727648194445507102'.
       78  XPC-FLD0111B
           VALUE X'05582373934795217912'.
       78  XPC-FLD0112B
           VALUE X'09837197320D'.
       78  XPC-FLD0113B
           VALUE X'0370'.
       78  XPC-FLD0114B
           VALUE X'873969'.
       78  XPC-FLD0115B
           VALUE X'30236778644C'.
       78  XPC-FLD0116B
           VALUE X'03'.
       78  XPC-FLD0117B
           VALUE X'013612'.
       78  XPC-FLD0118B
           VALUE X'806D'.
       78  XPC-FLD0119B
           VALUE X'0253932450'.
       78  XPC-FLD0120B
           VALUE X'067D'.
       78  XPC-FLD0121B
           VALUE X'0323330267022C'.
       78  XPC-FLD0122B
           VALUE X'2693757152'.
       78  XPC-FLD0123B
           VALUE X'07502022502690824523057244732F'.
       78  XPC-FLD0124B
           VALUE X'04223876720963152C'.
       78  XPC-FLD0125B
           VALUE X'637787216045794358443288'.
       78  XPC-FLD0126B
           VALUE X'14776980'.
       78  XPC-FLD0127B
           VALUE X'0968598991861849889506430599794838'.
       78  XPC-FLD0128B
           VALUE X'7158526709'.
       78  XPC-FLD0129B
           VALUE X'066302536762228508700376'.
       78  XPC-FLD0130B
           VALUE X'030500681275'.
       78  XPC-FLD0131B
           VALUE X'97542725692831921848454612'.
       78  XPC-FLD0132B
           VALUE X'21622287'.
       78  XPC-FLD0133B
           VALUE X'252842198D'.
       78  XPC-FLD0134B
           VALUE X'6035745627324759055021275F'.
       78  XPC-FLD0135B
           VALUE X'0089682198'.
       78  XPC-FLD0136B
           VALUE X'721064189695820607747975827F'.
       78  XPC-FLD0137B
           VALUE X'39815975038716593768839402400772088F'.
       78  XPC-FLD0138B
           VALUE X'2805087202945691003095503219810780'.
       78  XPC-FLD0139B
           VALUE X'04629717477620841718762676464393'.
       78  XPC-FLD0140B
           VALUE X'09134502802484925076953459210926666F'.
       78  XPC-FLD0141B
           VALUE X'01980465'.
       78  XPC-FLD0142B
           VALUE X'00112D'.
       78  XPC-FLD0143B
           VALUE X'04030994'.
       78  XPC-FLD0144B
           VALUE X'24553993'.
       78  XPC-FLD0145B
           VALUE X'0009479682736521'.
       78  XPC-FLD0146B
           VALUE X'05926753717490164309811F'.
       78  XPC-FLD0147B
           VALUE X'0397442042521838'.
       78  XPC-FLD0148B
           VALUE X'335821179980'.
       78  XPC-FLD0149B
           VALUE X'005D'.
       78  XPC-FLD0150B
           VALUE X'05779789481524289174174668914929497987'.
       78  XPC-FLD0151B
           VALUE X'03489779895385769491943608024F'.
       78  XPC-FLD0152B
           VALUE X'976189035330467796747200281970435753'.
       78  XPC-FLD0153B
           VALUE X'69465356575944581241088818012F'.
       78  XPC-FLD0154B
           VALUE X'040490022953226414'.
       78  XPC-FLD0155B
           VALUE X'07822691488762339967770021576143335F'.
       78  XPC-FLD0156B
           VALUE X'8985588062372004625188992577022872'.
       78  XPC-FLD0157B
           VALUE X'4359875032276696'.
       78  XPC-FLD0158B
           VALUE X'19917526243063020197192F'.
       78  XPC-FLD0159B
           VALUE X'0643529357674236912600918F'.
       78  XPC-FLD0160B
           VALUE X'04490300'.
       78  XPC-FLD0161B
           VALUE X'0795897533357509001650242908'.
       78  XPC-FLD0162B
           VALUE X'0566814386458160899086'.
       78  XPC-FLD0163B
           VALUE X'0269208611024764676855618F'.
       78  XPC-FLD0164B
           VALUE X'3001'.
       78  XPC-FLD0165B
           VALUE X'1267'.
       78  XPC-FLD0166B
           VALUE X'429599'.
       78  XPC-FLD0167B
           VALUE X'00917440942478405142746282763255'.
       78  XPC-FLD0168B
           VALUE X'04326936005661665C'.
       78  XPC-FLD0169B
           VALUE X'71534750846474368213279150'.
       78  XPC-FLD0170B
           VALUE X'02603177530164159092505813954945188016'.
       78  XPC-FLD0171B
           VALUE X'4933823716025803'.
       78  XPC-FLD0172B
           VALUE X'8903776753838588409184495731096831'.
       78  XPC-FLD0173B
           VALUE X'519945412779417204'.
       78  XPC-FLD0174B
           VALUE X'05152585493087611057'.
       78  XPC-FLD0175B
           VALUE X'051C'.
       78  XPC-FLD0176B
           VALUE X'021895219257'.
       78  XPC-FLD0177B
           VALUE X'0999225365'.
       78  XPC-FLD0178B
           VALUE X'24104366113D'.
       78  XPC-FLD0179B
           VALUE X'0664'.
       78  XPC-FLD0180B
           VALUE X'054351034931997414107F'.
       78  XPC-FLD0181B
           VALUE X'0474073583253910868D'.
       78  XPC-FLD0182B
           VALUE X'0417908352338649757839920F'.
       78  XPC-FLD0183B
           VALUE X'003C'.
       78  XPC-FLD0184B
           VALUE X'036019692D'.
       78  XPC-FLD0185B
           VALUE X'7395132638753716096465495866'.
       78  XPC-FLD0186B
           VALUE X'8407708947119312415452441200613F'.
       78  XPC-FLD0187B
           VALUE X'6497950041934480558403'.
       78  XPC-FLD0188B
           VALUE X'00471158677246608093014401354F'.
       78  XPC-FLD0189B
           VALUE X'0078359569344531809751'.
       78  XPC-FLD0190B
           VALUE X'062476651140273569806415'.
       78  XPC-FLD0191B
           VALUE X'0817437168989411478996487403492F'.
       78  XPC-FLD0192B
           VALUE X'03580342295012'.
       78  XPC-FLD0193B
           VALUE X'86499232126294976690766F'.
       78  XPC-FLD0194B
           VALUE X'0217285653058917626499679F'.
       78  XPC-FLD0195B
           VALUE X'060767'.
       78  XPC-FLD0196B
           VALUE X'0180007D'.
       78  XPC-FLD0197B
           VALUE X'05'.
       78  XPC-FLD0198B
           VALUE X'79036D'.
       78  XPC-FLD0199B
           VALUE X'045232741410605347571106449322'.
       78  XPC-FLD0200B
           VALUE X'095184480153268257'.
       78  XPC-FLD0201B
           VALUE X'0792759590444417882612526682351F'.
       78  XPC-FLD0202B
           VALUE X'037943227555010013122256395945441909'.
       78  XPC-FLD0203B
           VALUE X'05835712416517114804656539879215415F'.
       78  XPC-FLD0204B
           VALUE X'23632656'.
       78  XPC-FLD0205B
           VALUE X'288741127747638715028699'.
       78  XPC-FLD0206B
           VALUE X'70639388766434425840361654'.
       78  XPC-FLD0207B
           VALUE X'07691791385730962560263179739F'.
       78  XPC-FLD0208B
           VALUE X'21514986'.
       78  XPC-FLD0209B
           VALUE X'795271109412971503516143201296'.
       78  XPC-FLD0210B
           VALUE X'08'.
       78  XPC-FLD0211B
           VALUE X'04421137707554604C'.
       78  XPC-FLD0212B
           VALUE X'026496836026413D'.
       78  XPC-FLD0213B
           VALUE X'07525639770631302875997903356F'.
       78  XPC-FLD0214B
           VALUE X'06668932704655321508369070'.
       78  XPC-FLD0215B
           VALUE X'0173002D'.
       78  XPC-FLD0216B
           VALUE X'5663716874'.
       78  XPC-FLD0217B
           VALUE X'05191266215287889C'.
       78  XPC-FLD0218B
           VALUE X'04467255193327033602201936446363106369'.
       78  XPC-FLD0219B
           VALUE X'58766925082182334127'.
       78  XPC-FLD0220B
           VALUE X'29365D'.
       78  XPC-FLD0221B
           VALUE X'0878910367794605407176788958167890'.
       78  XPC-FLD0222B
           VALUE X'98033D'.
       78  XPC-FLD0223B
           VALUE X'69950927082806102497158917'.
       78  XPC-FLD0224B
           VALUE X'038300768427666D'.
       78  XPC-FLD0225B
           VALUE X'572612409808938978169F'.
       78  XPC-FLD0226B
           VALUE X'021150954C'.
       78  XPC-FLD0227B
           VALUE X'2038736443582994661522477889957372'.
       78  XPC-FLD0228B
           VALUE X'6560309403122602756042169858119450510F'.
       78  XPC-FLD0229B
           VALUE X'7383802976208535540081356884'.
       78  XPC-FLD0230B
           VALUE X'098D'.
       78  XPC-FLD0231B
           VALUE X'02709433475D'.
       78  XPC-FLD0232B
           VALUE X'4749842313738054193504353861500F'.
       78  XPC-FLD0233B
           VALUE X'412919251494'.
       78  XPC-FLD0234B
           VALUE X'05600680922670572133253F'.
       78  XPC-FLD0235B
           VALUE X'0480831518719295639D'.
       78  XPC-FLD0236B
           VALUE X'070471341881577547199277944F'.
       78  XPC-FLD0237B
           VALUE X'0088849488581330880890618573175743'.
       78  XPC-FLD0238B
           VALUE X'03227001'.
       78  XPC-FLD0239B
           VALUE X'29332566026370832101832F'.
       78  XPC-FLD0240B
           VALUE X'0204109650584163561111186027120F'.
       78  XPC-FLD0241B
           VALUE X'060875735723205993171444'.
       78  XPC-FLD0242B
           VALUE X'1820842D'.
       78  XPC-FLD0243B
           VALUE X'0870255257093214798613800553539476'.
       78  XPC-FLD0244B
           VALUE X'5964541497067354924865'.
       78  XPC-FLD0245B
           VALUE X'264333833210099267317333'.
       78  XPC-FLD0246B
           VALUE X'01209826'.
       78  XPC-FLD0247B
           VALUE X'742067276785553808782225359F'.
       78  XPC-FLD0248B
           VALUE X'0568358594454923286003'.
       78  XPC-FLD0249B
           VALUE X'3516462579097082707946242F'.
       78  XPC-FLD0250B
           VALUE X'9267251332164047061614164335129317'.
       78  XPC-FLD0251B
           VALUE X'3790591152463825338016431487631F'.
       78  XPC-FLD0252B
           VALUE X'023614266C'.
       78  XPC-FLD0253B
           VALUE X'21598977'.
       78  XPC-FLD0254B
           VALUE X'949043622D'.
       78  XPC-FLD0255B
           VALUE X'054081435076039155115F'.
       78  XPC-FLD0256B
           VALUE X'08751500721603051085707734273455571F'.
       78  XPC-FLD0257B
           VALUE X'408C'.
       78  XPC-FLD0258B
           VALUE X'08373758705249056762416399345967'.
       78  XPC-FLD0259B
           VALUE X'037466830472594D'.
       78  XPC-FLD0260B
           VALUE X'06017366610583895639607F'.
       78  XPC-FLD0261B
           VALUE X'00567161858323'.
       78  XPC-FLD0262B
           VALUE X'68757658126759821329241049'.
       78  XPC-FLD0263B
           VALUE X'040C'.
       78  XPC-FLD0264B
           VALUE X'166846'.
       78  XPC-FLD0265B
           VALUE X'02298778729177715439249141127220354975'.
       78  XPC-FLD0266B
           VALUE X'0115052360207692161431225486003512427F'.
       78  XPC-FLD0267B
           VALUE X'023489014C'.
       78  XPC-FLD0268B
           VALUE X'8211500957830146774085733341053F'.
       78  XPC-FLD0269B
           VALUE X'00'.
       78  XPC-FLD0270B
           VALUE X'03736D'.
       78  XPC-FLD0271B
           VALUE X'0052759203'.
       78  XPC-FLD0272B
           VALUE X'0516000696302733685D'.
       78  XPC-FLD0273B
           VALUE X'09036109253095580C'.
       78  XPC-FLD0274B
           VALUE X'52694748208586675958'.
       78  XPC-FLD0275B
           VALUE X'242413794C'.
       78  XPC-FLD0276B
           VALUE X'026452912587946930678128865110919777'.
       78  XPC-FLD0277B
           VALUE X'499215458601645512'.
       78  XPC-FLD0278B
           VALUE X'07922277502052260016194509262277280F'.
       78  XPC-FLD0279B
           VALUE X'28001839602575101420001146834692918F'.
       78  XPC-FLD0280B
           VALUE X'686572532054675839148262639F'.
       78  XPC-FLD0281B
           VALUE X'050053214871016073'.
       78  XPC-FLD0282B
           VALUE X'080366298088737049271049105300'.
       78  XPC-FLD0283B
           VALUE X'0182739D'.
       78  XPC-FLD0284B
           VALUE X'01'.
       78  XPC-FLD0285B
           VALUE X'7369214262351649891158444916'.
       78  XPC-FLD0286B
           VALUE X'82453436'.
       78  XPC-FLD0287B
           VALUE X'362829'.
       78  XPC-FLD0288B
           VALUE X'558809488025126643861391416517087F'.
       78  XPC-FLD0289B
           VALUE X'0567633089214293657540'.
       78  XPC-FLD0290B
           VALUE X'113C'.
       78  XPC-FLD0291B
           VALUE X'8300179929109657213726070068560F'.
       78  XPC-FLD0292B
           VALUE X'00'.
       78  XPC-FLD0293B
           VALUE X'030744391924'.
       78  XPC-FLD0294B
           VALUE X'09'.
       78  XPC-FLD0295B
           VALUE X'003641744D'.
       78  XPC-FLD0296B
           VALUE X'574464025736577889141F'.
       78  XPC-FLD0297B
           VALUE X'05211000497602709295'.
       78  XPC-FLD0298B
           VALUE X'09865365009908295859892746193509083241'.
       78  XPC-FLD0299B
           VALUE X'07346908584680565956758964'.
       78  XPC-FLD0300B
           VALUE X'55012674381377925092451F'.
       78  XPC-FLD0301B
           VALUE X'0C'.
       78  XPC-FLD0302B
           VALUE X'4291773342239684'.
       78  XPC-FLD0303B
           VALUE X'09'.
       78  XPC-FLD0304B
           VALUE X'0556573438984127234968'.
       78  XPC-FLD0305B
           VALUE X'5C'.
       78  XPC-FLD0306B
           VALUE X'0493641888717687181D'.
       78  XPC-FLD0307B
           VALUE X'068005145163846554765597747973515652'.
       78  XPC-FLD0308B
           VALUE X'0711937634336942757585120489238761366F'.
       78  XPC-FLD0309B
           VALUE X'093D'.
       78  XPC-FLD0310B
           VALUE X'0039167648388876'.
       78  XPC-FLD0311B
           VALUE X'3931117203050255914931199185957666486F'.
       78  XPC-FLD0312B
           VALUE X'04'.
       78  XPC-FLD0313B
           VALUE X'37515306459621'.
       78  XPC-FLD0314B
           VALUE X'69720778107690404600560896'.
       78  XPC-FLD0315B
           VALUE X'69624112217793877932514589'.
       78  XPC-FLD0316B
           VALUE X'561166875766384822086F'.
       78  XPC-FLD0317B
           VALUE X'0331361572492C'.
       78  XPC-FLD0318B
           VALUE X'754934282553785965724557627254399F'.
       78  XPC-FLD0319B
           VALUE X'0720371110100740574821997F'.
       78  XPC-FLD0320B
           VALUE X'547024228165748174212F'.
       78  XPC-FLD0321B
           VALUE X'6656687959056812873818967F'.
       78  XPC-FLD0322B
           VALUE X'017591106469607443841432'.
       78  XPC-FLD0323B
           VALUE X'0726633859846741159138616694690426812F'.
       78  XPC-FLD0324B
           VALUE X'002824576327848049573F'.
       78  XPC-FLD0325B
           VALUE X'723337602353324218528882738F'.
       78  XPC-FLD0326B
           VALUE X'049D'.
       78  XPC-FLD0327B
           VALUE X'021224467C'.
       78  XPC-FLD0328B
           VALUE X'046432253464059D'.
       78  XPC-FLD0329B
           VALUE X'0952096907591406971249625712516717612F'.
       78  XPC-FLD0330B
           VALUE X'732550190262212211019805617980'.
       78  XPC-FLD0331B
           VALUE X'2990286983'.
       78  XPC-FLD0332B
           VALUE X'03558444199192'.
       78  XPC-FLD0333B
           VALUE X'243133331C'.
       78  XPC-FLD0334B
           VALUE X'297044413515'.
       78  XPC-FLD0335B
           VALUE X'05106189445459805064'.
       78  XPC-FLD0336B
           VALUE X'29331698899D'.
       78  XPC-FLD0337B
           VALUE X'434132279525498709915609650F'.
       78  XPC-FLD0338B
           VALUE X'053047689000456310637F'.
       78  XPC-FLD0339B
           VALUE X'05943728837259434154840F'.
       78  XPC-FLD0340B
           VALUE X'3898813490788D'.
       78  XPC-FLD0341B
           VALUE X'248392469156514472666F'.
       78  XPC-FLD0342B
           VALUE X'45329231208135124D'.
       78  XPC-FLD0343B
           VALUE X'00620927'.
       78  XPC-FLD0344B
           VALUE X'606359905437156143820618581230520F'.
       78  XPC-FLD0345B
           VALUE X'0405441574894889'.
       78  XPC-FLD0346B
           VALUE X'6665377278444964848080900F'.
       78  XPC-FLD0347B
           VALUE X'324381'.
       78  XPC-FLD0348B
           VALUE X'0541608383617544100863'.
       78  XPC-FLD0349B
           VALUE X'99162869882943715535583214659709483F'.
       78  XPC-FLD0350B
           VALUE X'08264871389960360762501068165875'.
       78  XPC-FLD0351B
           VALUE X'53884121311052648707'.
       78  XPC-FLD0352B
           VALUE X'01946919'.
       78  XPC-FLD0353B
           VALUE X'94389336945631099347053805104224012F'.
       78  XPC-FLD0354B
           VALUE X'31167660742D'.
       78  XPC-FLD0355B
           VALUE X'93287C'.
       78  XPC-FLD0356B
           VALUE X'83673557978976841628508509529638'.
       78  XPC-FLD0357B
           VALUE X'0079'.
       78  XPC-FLD0358B
           VALUE X'65874749059638552239264936'.
       78  XPC-FLD0359B
           VALUE X'9526039934819852117442415817981772124F'.
       78  XPC-FLD0360B
           VALUE X'7361138723'.
       78  XPC-FLD0361B
           VALUE X'07851848643793046811367730697339'.
       78  XPC-FLD0362B
           VALUE X'8970899599407193836242413453874178'.
       78  XPC-FLD0363B
           VALUE X'04961135231796696550847514117776881F'.
       78  XPC-FLD0364B
           VALUE X'8287940009277749559970516202156F'.
       78  XPC-FLD0365B
           VALUE X'02107493896139311928536102'.
       78  XPC-FLD0366B
           VALUE X'00157659331265924684828405588633'.
       78  XPC-FLD0367B
           VALUE X'7840586C'.
       78  XPC-FLD0368B
           VALUE X'03'.
       78  XPC-FLD0369B
           VALUE X'31224128387C'.
       78  XPC-FLD0370B
           VALUE X'0C'.
       78  XPC-FLD0371B
           VALUE X'082D'.
       78  XPC-FLD0372B
           VALUE X'0049999527433343127F'.
       78  XPC-FLD0373B
           VALUE X'3525595775040D'.
       78  XPC-FLD0374B
           VALUE X'711264497973442155753787119F'.
       78  XPC-FLD0375B
           VALUE X'03'.
       78  XPC-FLD0376B
           VALUE X'5240009617041836336F'.
       78  XPC-FLD0377B
           VALUE X'78137191821795531497030218304F'.
       78  XPC-FLD0378B
           VALUE X'0163135D'.
       78  XPC-FLD0379B
           VALUE X'04'.
       78  XPC-FLD0380B
           VALUE X'9D'.
       78  XPC-FLD0381B
           VALUE X'0096'.
       78  XPC-FLD0382B
           VALUE X'1909'.
       78  XPC-FLD0383B
           VALUE X'0810435186395222418864747737642F'.
       78  XPC-FLD0384B
           VALUE X'01'.
       78  XPC-FLD0385B
           VALUE X'774134932514714546452413131744833F'.
       78  XPC-FLD0386B
           VALUE X'03467992789726692670323751189F'.
       78  XPC-FLD0387B
           VALUE X'6906513656145575095354897F'.
       78  XPC-FLD0388B
           VALUE X'0326'.
       78  XPC-FLD0389B
           VALUE X'0182625981352744592156'.
       78  XPC-FLD0390B
           VALUE X'0102'.
       78  XPC-FLD0391B
           VALUE X'00373737127C'.
       78  XPC-FLD0392B
           VALUE X'046825106292883313'.
       78  XPC-FLD0393B
           VALUE X'9072420163680885991652758093550801'.
       78  XPC-FLD0394B
           VALUE X'0474630481043585892D'.
       78  XPC-FLD0395B
           VALUE X'3C'.
       78  XPC-FLD0396B
           VALUE X'0265476173063916'.
       78  XPC-FLD0397B
           VALUE X'007D'.
       78  XPC-FLD0398B
           VALUE X'02844252852D'.
       78  XPC-FLD0399B
           VALUE X'0256742307'.
       78  XPC-FLD0400B
           VALUE X'08678350299065256532010165028624'.
       78  XPC-FLD0401B
           VALUE X'00'.
       78  XPC-FLD0402B
           VALUE X'69644052220831165210812585'.
       78  XPC-FLD0403B
           VALUE X'012518106356029089448417234962107613'.
       78  XPC-FLD0404B
           VALUE X'4814436782579247780215241F'.
       78  XPC-FLD0405B
           VALUE X'14133C'.
       78  XPC-FLD0406B
           VALUE X'049908285391730064732712435215'.
       78  XPC-FLD0407B
           VALUE X'08753049482988191082826919955550692975'.
       78  XPC-FLD0408B
           VALUE X'0947331591'.
       78  XPC-FLD0409B
           VALUE X'0605266450165216657684'.
       78  XPC-FLD0410B
           VALUE X'8786052888992391829545680593582801521F'.
       78  XPC-FLD0411B
           VALUE X'063491006980711595097943650973'.
       78  XPC-FLD0412B
           VALUE X'8D'.
       78  XPC-FLD0413B
           VALUE X'0C'.
       78  XPC-FLD0414B
           VALUE X'99790D'.
       78  XPC-FLD0415B
           VALUE X'9072627958632073487733476063585840'.
       78  XPC-FLD0416B
           VALUE X'8D'.
       78  XPC-FLD0417B
           VALUE X'988613295763541566341103816739633F'.
       78  XPC-FLD0418B
           VALUE X'00'.
       78  XPC-FLD0419B
           VALUE X'057648646369329730502F'.
       78  XPC-FLD0420B
           VALUE X'2098982695132051783275528578087688'.
       78  XPC-FLD0421B
           VALUE X'2103833C'.
       78  XPC-FLD0422B
           VALUE X'752582761957935941759741251848172397'.
       78  XPC-FLD0423B
           VALUE X'28494506043824296970249566'.
       78  XPC-FLD0424B
           VALUE X'0784268490871190770892359433'.
       78  XPC-FLD0425B
           VALUE X'01105207822256892292772F'.
       78  XPC-FLD0426B
           VALUE X'0001958844649331492605'.
       78  XPC-FLD0427B
           VALUE X'030767310512910845380824639505'.
       78  XPC-FLD0428B
           VALUE X'03481765503552540774734325168211935223'.
       78  XPC-FLD0429B
           VALUE X'0415311789274485'.
       78  XPC-FLD0430B
           VALUE X'03147921208448'.
       78  XPC-FLD0431B
           VALUE X'09203928254587173674039490833820309F'.
       78  XPC-FLD0432B
           VALUE X'0468689D'.
       78  XPC-FLD0433B
           VALUE X'02194580'.
       78  XPC-FLD0434B
           VALUE X'60684270265800283242045907172723673F'.
       78  XPC-FLD0435B
           VALUE X'05848414431863717140299F'.
       78  XPC-FLD0436B
           VALUE X'8307195843004202551185244374210F'.
       78  XPC-FLD0437B
           VALUE X'0276912651674409371338469F'.
       78  XPC-FLD0438B
           VALUE X'065939134788229547545486395847751F'.
       78  XPC-FLD0439B
           VALUE X'057198557021649332012F'.
       78  XPC-FLD0440B
           VALUE X'045546922388182033'.
       78  XPC-FLD0441B
           VALUE X'04410365507278117C'.
       78  XPC-FLD0442B
           VALUE X'0793246258213504850331787565664854'.
       78  XPC-FLD0443B
           VALUE X'12406922393517515692932F'.
       78  XPC-FLD0444B
           VALUE X'5047752750516173349F'.
       78  XPC-FLD0445B
           VALUE X'46235419654562581D'.
       78  XPC-FLD0446B
           VALUE X'03796915192033033506944203'.
       78  XPC-FLD0447B
           VALUE X'2771730669'.
       78  XPC-FLD0448B
           VALUE X'53731039321367845601'.
       78  XPC-FLD0449B
           VALUE X'0509720778947D'.
       78  XPC-FLD0450B
           VALUE X'0282777568876138030163'.
       78  XPC-FLD0451B
           VALUE X'251739040D'.
       78  XPC-FLD0452B
           VALUE X'0554961704112127562772'.
       78  XPC-FLD0453B
           VALUE X'432966208610221163829131910461001098'.
       78  XPC-FLD0454B
           VALUE X'0C'.
       78  XPC-FLD0455B
           VALUE X'085105998788168291113720442808698F'.
       78  XPC-FLD0456B
           VALUE X'015602'.
       78  XPC-FLD0457B
           VALUE X'04'.
       78  XPC-FLD0458B
           VALUE X'319507534378'.
       78  XPC-FLD0459B
           VALUE X'563566655806151518188F'.
       78  XPC-FLD0460B
           VALUE X'78345895335320658858790920930F'.
       78  XPC-FLD0461B
           VALUE X'021468392C'.
       78  XPC-FLD0462B
           VALUE X'0004508805451474389691668420709902421F'.
       78  XPC-FLD0463B
           VALUE X'0407334605648695'.
       78  XPC-FLD0464B
           VALUE X'0151737088129684206390490880'.
       78  XPC-FLD0465B
           VALUE X'04019227771758718807584315561398'.
       78  XPC-FLD0466B
           VALUE X'066690'.
       78  XPC-FLD0467B
           VALUE X'221674677715112297171629052172647F'.
       78  XPC-FLD0468B
           VALUE X'014539915072'.
       78  XPC-FLD0469B
           VALUE X'5200119971346918168F'.
       78  XPC-FLD0470B
           VALUE X'038313143686989D'.
       78  XPC-FLD0471B
           VALUE X'04'.
       78  XPC-FLD0472B
           VALUE X'014747530624073358364549755424378F'.
       78  XPC-FLD0473B
           VALUE X'044510935327360434676791101F'.
       78  XPC-FLD0474B
           VALUE X'12450D'.
       78  XPC-FLD0475B
           VALUE X'008735531657721C'.
       78  XPC-FLD0476B
           VALUE X'06726270'.
       78  XPC-FLD0477B
           VALUE X'038064410228203D'.
       78  XPC-FLD0478B
           VALUE X'02732554753853'.
       78  XPC-FLD0479B
           VALUE X'3225777432138897276100778981344F'.
       78  XPC-FLD0480B
           VALUE X'7459539941657910502685240317'.
       78  XPC-FLD0481B
           VALUE X'7907459007614364265847939350351225584F'.
       78  XPC-FLD0482B
           VALUE X'0499292594411151591D'.
       78  XPC-FLD0483B
           VALUE X'0323420128144C'.
       78  XPC-FLD0484B
           VALUE X'0577123861473882282524'.
       78  XPC-FLD0485B
           VALUE X'166880'.
       78  XPC-FLD0486B
           VALUE X'045838007534965959'.
       78  XPC-FLD0487B
           VALUE X'070416419749040885946681100F'.
       78  XPC-FLD0488B
           VALUE X'01888589981100687587906874'.
       78  XPC-FLD0489B
           VALUE X'00649432173668728651705350785050541163'.
       78  XPC-FLD0490B
           VALUE X'2396976320'.
       78  XPC-FLD0491B
           VALUE X'6612864347936019645829430F'.
       78  XPC-FLD0492B
           VALUE X'3423161826575C'.
       78  XPC-FLD0493B
           VALUE X'790696459278862186593528349476'.
       78  XPC-FLD0494B
           VALUE X'5132995328615615202F'.
       78  XPC-FLD0495B
           VALUE X'646882573915106698502768'.
       78  XPC-FLD0496B
           VALUE X'05523D'.
       78  XPC-FLD0497B
           VALUE X'06663282286120654558381205'.
       78  XPC-FLD0498B
           VALUE X'02658441'.
       78  XPC-FLD0499B
           VALUE X'0634131216402607308791345F'.

       01  FILLER       USAGE BINARY-INT VALUE 0.
           88 DO-DISP   VALUE 0.
           88 NO-DISP   VALUE 1.

       REPLACE ==DISPLAY== BY ==IF DO-DISP  DISPLAY==.
       PROCEDURE        DIVISION.
       MAIN.
      *    Test with DISPLAY on error
           PERFORM DO-CHECK.
       >> IF CHECK-PERF IS DEFINED
           SET  NO-DISP    TO TRUE
      *    some performance checks on the way...
           PERFORM DO-CHECK 10000 TIMES.
       >> END-IF
           GOBACK.

       DO-CHECK.
      *2000-TEST.

           ADD FLD0001A        TO FLD0001B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0002A        FROM FLD0002B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0003A        TO FLD0003B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0004A        FROM FLD0004B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0005A        TO FLD0005B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0006A        FROM FLD0006B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0007A        TO FLD0007B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0008A        FROM FLD0008B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0009A        TO FLD0009B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0010A        FROM FLD0010B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0011A        TO FLD0011B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0012A        FROM FLD0012B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0013A        TO FLD0013B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0014A        FROM FLD0014B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0015A        TO FLD0015B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0016A        FROM FLD0016B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0017A        TO FLD0017B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0018A        FROM FLD0018B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0019A        TO FLD0019B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0020A        FROM FLD0020B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0021A        TO FLD0021B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0022A        FROM FLD0022B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0023A        TO FLD0023B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0024A        FROM FLD0024B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0025A        TO FLD0025B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0026A        FROM FLD0026B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0027A        TO FLD0027B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0028A        FROM FLD0028B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0029A        TO FLD0029B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0030A        FROM FLD0030B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0031A        TO FLD0031B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0032A        FROM FLD0032B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0033A        TO FLD0033B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0034A        FROM FLD0034B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0035A        TO FLD0035B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0036A        FROM FLD0036B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0037A        TO FLD0037B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0038A        FROM FLD0038B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0039A        TO FLD0039B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0040A        FROM FLD0040B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0041A        TO FLD0041B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0042A        FROM FLD0042B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0043A        TO FLD0043B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0044A        FROM FLD0044B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0045A        TO FLD0045B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0046A        FROM FLD0046B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0047A        TO FLD0047B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0048A        FROM FLD0048B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0049A        TO FLD0049B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0050A        FROM FLD0050B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0051A        TO FLD0051B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0052A        FROM FLD0052B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0053A        TO FLD0053B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0054A        FROM FLD0054B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0055A        TO FLD0055B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0056A        FROM FLD0056B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0057A        TO FLD0057B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0058A        FROM FLD0058B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0059A        TO FLD0059B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0060A        FROM FLD0060B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0061A        TO FLD0061B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0062A        FROM FLD0062B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0063A        TO FLD0063B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0064A        FROM FLD0064B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0065A        TO FLD0065B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0066A        FROM FLD0066B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0067A        TO FLD0067B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0068A        FROM FLD0068B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0069A        TO FLD0069B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0070A        FROM FLD0070B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0071A        TO FLD0071B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0072A        FROM FLD0072B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0073A        TO FLD0073B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0074A        FROM FLD0074B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0075A        TO FLD0075B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0076A        FROM FLD0076B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0077A        TO FLD0077B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0078A        FROM FLD0078B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0079A        TO FLD0079B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0080A        FROM FLD0080B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0081A        TO FLD0081B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0082A        FROM FLD0082B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0083A        TO FLD0083B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0084A        FROM FLD0084B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0085A        TO FLD0085B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0086A        FROM FLD0086B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0087A        TO FLD0087B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0088A        FROM FLD0088B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0089A        TO FLD0089B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0090A        FROM FLD0090B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0091A        TO FLD0091B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0092A        FROM FLD0092B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0093A        TO FLD0093B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0094A        FROM FLD0094B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0095A        TO FLD0095B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0096A        FROM FLD0096B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0097A        TO FLD0097B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0098A        FROM FLD0098B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0099A        TO FLD0099B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0100A        FROM FLD0100B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0101A        TO FLD0101B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0102A        FROM FLD0102B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0103A        TO FLD0103B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0104A        FROM FLD0104B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0105A        TO FLD0105B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0106A        FROM FLD0106B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0107A        TO FLD0107B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0108A        FROM FLD0108B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0109A        TO FLD0109B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0110A        FROM FLD0110B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0111A        TO FLD0111B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0112A        FROM FLD0112B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0113A        TO FLD0113B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0114A        FROM FLD0114B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0115A        TO FLD0115B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0116A        FROM FLD0116B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0117A        TO FLD0117B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0118A        FROM FLD0118B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0119A        TO FLD0119B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0120A        FROM FLD0120B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0121A        TO FLD0121B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0122A        FROM FLD0122B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0123A        TO FLD0123B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0124A        FROM FLD0124B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0125A        TO FLD0125B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0126A        FROM FLD0126B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0127A        TO FLD0127B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0128A        FROM FLD0128B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0129A        TO FLD0129B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0130A        FROM FLD0130B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0131A        TO FLD0131B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0132A        FROM FLD0132B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0133A        TO FLD0133B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0134A        FROM FLD0134B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0135A        TO FLD0135B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0136A        FROM FLD0136B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0137A        TO FLD0137B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0138A        FROM FLD0138B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0139A        TO FLD0139B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0140A        FROM FLD0140B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0141A        TO FLD0141B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0142A        FROM FLD0142B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0143A        TO FLD0143B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0144A        FROM FLD0144B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0145A        TO FLD0145B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0146A        FROM FLD0146B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0147A        TO FLD0147B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0148A        FROM FLD0148B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0149A        TO FLD0149B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0150A        FROM FLD0150B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0151A        TO FLD0151B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0152A        FROM FLD0152B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0153A        TO FLD0153B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0154A        FROM FLD0154B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0155A        TO FLD0155B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0156A        FROM FLD0156B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0157A        TO FLD0157B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0158A        FROM FLD0158B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0159A        TO FLD0159B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0160A        FROM FLD0160B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0161A        TO FLD0161B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0162A        FROM FLD0162B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0163A        TO FLD0163B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0164A        FROM FLD0164B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0165A        TO FLD0165B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0166A        FROM FLD0166B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0167A        TO FLD0167B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0168A        FROM FLD0168B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0169A        TO FLD0169B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0170A        FROM FLD0170B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0171A        TO FLD0171B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0172A        FROM FLD0172B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0173A        TO FLD0173B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0174A        FROM FLD0174B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0175A        TO FLD0175B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0176A        FROM FLD0176B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0177A        TO FLD0177B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0178A        FROM FLD0178B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0179A        TO FLD0179B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0180A        FROM FLD0180B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0181A        TO FLD0181B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0182A        FROM FLD0182B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0183A        TO FLD0183B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0184A        FROM FLD0184B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0185A        TO FLD0185B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0186A        FROM FLD0186B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0187A        TO FLD0187B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0188A        FROM FLD0188B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0189A        TO FLD0189B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0190A        FROM FLD0190B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0191A        TO FLD0191B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0192A        FROM FLD0192B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0193A        TO FLD0193B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0194A        FROM FLD0194B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0195A        TO FLD0195B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0196A        FROM FLD0196B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0197A        TO FLD0197B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0198A        FROM FLD0198B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0199A        TO FLD0199B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0200A        FROM FLD0200B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0201A        TO FLD0201B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0202A        FROM FLD0202B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0203A        TO FLD0203B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0204A        FROM FLD0204B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0205A        TO FLD0205B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0206A        FROM FLD0206B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0207A        TO FLD0207B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0208A        FROM FLD0208B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0209A        TO FLD0209B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0210A        FROM FLD0210B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0211A        TO FLD0211B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0212A        FROM FLD0212B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0213A        TO FLD0213B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0214A        FROM FLD0214B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0215A        TO FLD0215B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0216A        FROM FLD0216B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0217A        TO FLD0217B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0218A        FROM FLD0218B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0219A        TO FLD0219B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0220A        FROM FLD0220B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0221A        TO FLD0221B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0222A        FROM FLD0222B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0223A        TO FLD0223B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0224A        FROM FLD0224B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0225A        TO FLD0225B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0226A        FROM FLD0226B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0227A        TO FLD0227B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0228A        FROM FLD0228B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0229A        TO FLD0229B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0230A        FROM FLD0230B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0231A        TO FLD0231B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0232A        FROM FLD0232B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0233A        TO FLD0233B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0234A        FROM FLD0234B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0235A        TO FLD0235B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0236A        FROM FLD0236B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0237A        TO FLD0237B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0238A        FROM FLD0238B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0239A        TO FLD0239B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0240A        FROM FLD0240B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0241A        TO FLD0241B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0242A        FROM FLD0242B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0243A        TO FLD0243B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0244A        FROM FLD0244B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0245A        TO FLD0245B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0246A        FROM FLD0246B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0247A        TO FLD0247B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0248A        FROM FLD0248B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0249A        TO FLD0249B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0250A        FROM FLD0250B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0251A        TO FLD0251B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0252A        FROM FLD0252B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0253A        TO FLD0253B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0254A        FROM FLD0254B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0255A        TO FLD0255B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0256A        FROM FLD0256B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0257A        TO FLD0257B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0258A        FROM FLD0258B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0259A        TO FLD0259B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0260A        FROM FLD0260B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0261A        TO FLD0261B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0262A        FROM FLD0262B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0263A        TO FLD0263B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0264A        FROM FLD0264B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0265A        TO FLD0265B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0266A        FROM FLD0266B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0267A        TO FLD0267B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0268A        FROM FLD0268B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0269A        TO FLD0269B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0270A        FROM FLD0270B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0271A        TO FLD0271B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0272A        FROM FLD0272B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0273A        TO FLD0273B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0274A        FROM FLD0274B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0275A        TO FLD0275B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0276A        FROM FLD0276B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0277A        TO FLD0277B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0278A        FROM FLD0278B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0279A        TO FLD0279B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0280A        FROM FLD0280B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0281A        TO FLD0281B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0282A        FROM FLD0282B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0283A        TO FLD0283B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0284A        FROM FLD0284B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0285A        TO FLD0285B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0286A        FROM FLD0286B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0287A        TO FLD0287B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0288A        FROM FLD0288B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0289A        TO FLD0289B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0290A        FROM FLD0290B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0291A        TO FLD0291B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0292A        FROM FLD0292B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0293A        TO FLD0293B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0294A        FROM FLD0294B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0295A        TO FLD0295B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0296A        FROM FLD0296B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0297A        TO FLD0297B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0298A        FROM FLD0298B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0299A        TO FLD0299B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0300A        FROM FLD0300B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0301A        TO FLD0301B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0302A        FROM FLD0302B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0303A        TO FLD0303B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0304A        FROM FLD0304B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0305A        TO FLD0305B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0306A        FROM FLD0306B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0307A        TO FLD0307B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0308A        FROM FLD0308B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0309A        TO FLD0309B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0310A        FROM FLD0310B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0311A        TO FLD0311B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0312A        FROM FLD0312B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0313A        TO FLD0313B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0314A        FROM FLD0314B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0315A        TO FLD0315B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0316A        FROM FLD0316B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0317A        TO FLD0317B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0318A        FROM FLD0318B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0319A        TO FLD0319B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0320A        FROM FLD0320B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0321A        TO FLD0321B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0322A        FROM FLD0322B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0323A        TO FLD0323B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0324A        FROM FLD0324B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0325A        TO FLD0325B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0326A        FROM FLD0326B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0327A        TO FLD0327B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0328A        FROM FLD0328B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0329A        TO FLD0329B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0330A        FROM FLD0330B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0331A        TO FLD0331B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0332A        FROM FLD0332B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0333A        TO FLD0333B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0334A        FROM FLD0334B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0335A        TO FLD0335B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0336A        FROM FLD0336B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0337A        TO FLD0337B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0338A        FROM FLD0338B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0339A        TO FLD0339B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0340A        FROM FLD0340B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0341A        TO FLD0341B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0342A        FROM FLD0342B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0343A        TO FLD0343B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0344A        FROM FLD0344B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0345A        TO FLD0345B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0346A        FROM FLD0346B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0347A        TO FLD0347B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0348A        FROM FLD0348B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0349A        TO FLD0349B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0350A        FROM FLD0350B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0351A        TO FLD0351B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0352A        FROM FLD0352B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0353A        TO FLD0353B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0354A        FROM FLD0354B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0355A        TO FLD0355B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0356A        FROM FLD0356B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0357A        TO FLD0357B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0358A        FROM FLD0358B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0359A        TO FLD0359B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0360A        FROM FLD0360B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0361A        TO FLD0361B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0362A        FROM FLD0362B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0363A        TO FLD0363B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0364A        FROM FLD0364B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0365A        TO FLD0365B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0366A        FROM FLD0366B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0367A        TO FLD0367B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0368A        FROM FLD0368B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0369A        TO FLD0369B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0370A        FROM FLD0370B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0371A        TO FLD0371B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0372A        FROM FLD0372B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0373A        TO FLD0373B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0374A        FROM FLD0374B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0375A        TO FLD0375B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0376A        FROM FLD0376B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0377A        TO FLD0377B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0378A        FROM FLD0378B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0379A        TO FLD0379B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0380A        FROM FLD0380B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0381A        TO FLD0381B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0382A        FROM FLD0382B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0383A        TO FLD0383B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0384A        FROM FLD0384B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0385A        TO FLD0385B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0386A        FROM FLD0386B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0387A        TO FLD0387B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0388A        FROM FLD0388B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0389A        TO FLD0389B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0390A        FROM FLD0390B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0391A        TO FLD0391B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0392A        FROM FLD0392B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0393A        TO FLD0393B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0394A        FROM FLD0394B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0395A        TO FLD0395B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0396A        FROM FLD0396B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0397A        TO FLD0397B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0398A        FROM FLD0398B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0399A        TO FLD0399B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0400A        FROM FLD0400B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0401A        TO FLD0401B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0402A        FROM FLD0402B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0403A        TO FLD0403B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0404A        FROM FLD0404B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0405A        TO FLD0405B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0406A        FROM FLD0406B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0407A        TO FLD0407B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0408A        FROM FLD0408B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0409A        TO FLD0409B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0410A        FROM FLD0410B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0411A        TO FLD0411B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0412A        FROM FLD0412B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0413A        TO FLD0413B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0414A        FROM FLD0414B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0415A        TO FLD0415B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0416A        FROM FLD0416B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0417A        TO FLD0417B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0418A        FROM FLD0418B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0419A        TO FLD0419B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0420A        FROM FLD0420B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0421A        TO FLD0421B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0422A        FROM FLD0422B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0423A        TO FLD0423B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0424A        FROM FLD0424B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0425A        TO FLD0425B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0426A        FROM FLD0426B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0427A        TO FLD0427B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0428A        FROM FLD0428B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0429A        TO FLD0429B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0430A        FROM FLD0430B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0431A        TO FLD0431B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0432A        FROM FLD0432B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0433A        TO FLD0433B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0434A        FROM FLD0434B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0435A        TO FLD0435B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0436A        FROM FLD0436B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0437A        TO FLD0437B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0438A        FROM FLD0438B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0439A        TO FLD0439B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0440A        FROM FLD0440B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0441A        TO FLD0441B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0442A        FROM FLD0442B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0443A        TO FLD0443B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0444A        FROM FLD0444B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0445A        TO FLD0445B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0446A        FROM FLD0446B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0447A        TO FLD0447B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0448A        FROM FLD0448B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0449A        TO FLD0449B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0450A        FROM FLD0450B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0451A        TO FLD0451B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0452A        FROM FLD0452B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0453A        TO FLD0453B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0454A        FROM FLD0454B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0455A        TO FLD0455B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0456A        FROM FLD0456B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0457A        TO FLD0457B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0458A        FROM FLD0458B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0459A        TO FLD0459B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0460A        FROM FLD0460B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0461A        TO FLD0461B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0462A        FROM FLD0462B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0463A        TO FLD0463B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0464A        FROM FLD0464B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0465A        TO FLD0465B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0466A        FROM FLD0466B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0467A        TO FLD0467B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0468A        FROM FLD0468B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0469A        TO FLD0469B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0470A        FROM FLD0470B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0471A        TO FLD0471B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0472A        FROM FLD0472B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0473A        TO FLD0473B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0474A        FROM FLD0474B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0475A        TO FLD0475B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0476A        FROM FLD0476B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0477A        TO FLD0477B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0478A        FROM FLD0478B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0479A        TO FLD0479B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0480A        FROM FLD0480B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0481A        TO FLD0481B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0482A        FROM FLD0482B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0483A        TO FLD0483B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0484A        FROM FLD0484B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0485A        TO FLD0485B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0486A        FROM FLD0486B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0487A        TO FLD0487B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0488A        FROM FLD0488B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0489A        TO FLD0489B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0490A        FROM FLD0490B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0491A        TO FLD0491B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0492A        FROM FLD0492B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0493A        TO FLD0493B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0494A        FROM FLD0494B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0495A        TO FLD0495B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0496A        FROM FLD0496B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0497A        TO FLD0497B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0498A        FROM FLD0498B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0499A        TO FLD0499B
               ROUNDED MODE IS NEAREST-EVEN          .

      *4000-COMPARE.

           IF FLD0001B (1:)    NOT EQUAL XPC-FLD0001B
              DISPLAY 'FLD0001B ==> ' HEX-OF (FLD0001B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0001B).
           IF FLD0002B (1:)    NOT EQUAL XPC-FLD0002B
              DISPLAY 'FLD0002B ==> ' HEX-OF (FLD0002B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0002B).
           IF FLD0003B (1:)    NOT EQUAL XPC-FLD0003B
              DISPLAY 'FLD0003B ==> ' HEX-OF (FLD0003B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0003B).
           IF FLD0004B (1:)    NOT EQUAL XPC-FLD0004B
              DISPLAY 'FLD0004B ==> ' HEX-OF (FLD0004B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0004B).
           IF FLD0005B (1:)    NOT EQUAL XPC-FLD0005B
              DISPLAY 'FLD0005B ==> ' HEX-OF (FLD0005B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0005B).
           IF FLD0006B (1:)    NOT EQUAL XPC-FLD0006B
              DISPLAY 'FLD0006B ==> ' HEX-OF (FLD0006B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0006B).
           IF FLD0007B (1:)    NOT EQUAL XPC-FLD0007B
              DISPLAY 'FLD0007B ==> ' HEX-OF (FLD0007B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0007B).
           IF FLD0008B (1:)    NOT EQUAL XPC-FLD0008B
              DISPLAY 'FLD0008B ==> ' HEX-OF (FLD0008B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0008B).
           IF FLD0009B (1:)    NOT EQUAL XPC-FLD0009B
              DISPLAY 'FLD0009B ==> ' HEX-OF (FLD0009B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0009B).
           IF FLD0010B (1:)    NOT EQUAL XPC-FLD0010B
              DISPLAY 'FLD0010B ==> ' HEX-OF (FLD0010B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0010B).
           IF FLD0011B (1:)    NOT EQUAL XPC-FLD0011B
              DISPLAY 'FLD0011B ==> ' HEX-OF (FLD0011B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0011B).
           IF FLD0012B (1:)    NOT EQUAL XPC-FLD0012B
              DISPLAY 'FLD0012B ==> ' HEX-OF (FLD0012B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0012B).
           IF FLD0013B (1:)    NOT EQUAL XPC-FLD0013B
              DISPLAY 'FLD0013B ==> ' HEX-OF (FLD0013B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0013B).
           IF FLD0014B (1:)    NOT EQUAL XPC-FLD0014B
              DISPLAY 'FLD0014B ==> ' HEX-OF (FLD0014B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0014B).
           IF FLD0015B (1:)    NOT EQUAL XPC-FLD0015B
              DISPLAY 'FLD0015B ==> ' HEX-OF (FLD0015B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0015B).
           IF FLD0016B (1:)    NOT EQUAL XPC-FLD0016B
              DISPLAY 'FLD0016B ==> ' HEX-OF (FLD0016B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0016B).
           IF FLD0017B (1:)    NOT EQUAL XPC-FLD0017B
              DISPLAY 'FLD0017B ==> ' HEX-OF (FLD0017B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0017B).
           IF FLD0018B (1:)    NOT EQUAL XPC-FLD0018B
              DISPLAY 'FLD0018B ==> ' HEX-OF (FLD0018B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0018B).
           IF FLD0019B (1:)    NOT EQUAL XPC-FLD0019B
              DISPLAY 'FLD0019B ==> ' HEX-OF (FLD0019B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0019B).
           IF FLD0020B (1:)    NOT EQUAL XPC-FLD0020B
              DISPLAY 'FLD0020B ==> ' HEX-OF (FLD0020B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0020B).
           IF FLD0021B (1:)    NOT EQUAL XPC-FLD0021B
              DISPLAY 'FLD0021B ==> ' HEX-OF (FLD0021B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0021B).
           IF FLD0022B (1:)    NOT EQUAL XPC-FLD0022B
              DISPLAY 'FLD0022B ==> ' HEX-OF (FLD0022B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0022B).
           IF FLD0023B (1:)    NOT EQUAL XPC-FLD0023B
              DISPLAY 'FLD0023B ==> ' HEX-OF (FLD0023B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0023B).
           IF FLD0024B (1:)    NOT EQUAL XPC-FLD0024B
              DISPLAY 'FLD0024B ==> ' HEX-OF (FLD0024B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0024B).
           IF FLD0025B (1:)    NOT EQUAL XPC-FLD0025B
              DISPLAY 'FLD0025B ==> ' HEX-OF (FLD0025B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0025B).
           IF FLD0026B (1:)    NOT EQUAL XPC-FLD0026B
              DISPLAY 'FLD0026B ==> ' HEX-OF (FLD0026B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0026B).
           IF FLD0027B (1:)    NOT EQUAL XPC-FLD0027B
              DISPLAY 'FLD0027B ==> ' HEX-OF (FLD0027B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0027B).
           IF FLD0028B (1:)    NOT EQUAL XPC-FLD0028B
              DISPLAY 'FLD0028B ==> ' HEX-OF (FLD0028B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0028B).
           IF FLD0029B (1:)    NOT EQUAL XPC-FLD0029B
              DISPLAY 'FLD0029B ==> ' HEX-OF (FLD0029B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0029B).
           IF FLD0030B (1:)    NOT EQUAL XPC-FLD0030B
              DISPLAY 'FLD0030B ==> ' HEX-OF (FLD0030B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0030B).
           IF FLD0031B (1:)    NOT EQUAL XPC-FLD0031B
              DISPLAY 'FLD0031B ==> ' HEX-OF (FLD0031B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0031B).
           IF FLD0032B (1:)    NOT EQUAL XPC-FLD0032B
              DISPLAY 'FLD0032B ==> ' HEX-OF (FLD0032B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0032B).
           IF FLD0033B (1:)    NOT EQUAL XPC-FLD0033B
              DISPLAY 'FLD0033B ==> ' HEX-OF (FLD0033B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0033B).
           IF FLD0034B (1:)    NOT EQUAL XPC-FLD0034B
              DISPLAY 'FLD0034B ==> ' HEX-OF (FLD0034B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0034B).
           IF FLD0035B (1:)    NOT EQUAL XPC-FLD0035B
              DISPLAY 'FLD0035B ==> ' HEX-OF (FLD0035B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0035B).
           IF FLD0036B (1:)    NOT EQUAL XPC-FLD0036B
              DISPLAY 'FLD0036B ==> ' HEX-OF (FLD0036B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0036B).
           IF FLD0037B (1:)    NOT EQUAL XPC-FLD0037B
              DISPLAY 'FLD0037B ==> ' HEX-OF (FLD0037B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0037B).
           IF FLD0038B (1:)    NOT EQUAL XPC-FLD0038B
              DISPLAY 'FLD0038B ==> ' HEX-OF (FLD0038B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0038B).
           IF FLD0039B (1:)    NOT EQUAL XPC-FLD0039B
              DISPLAY 'FLD0039B ==> ' HEX-OF (FLD0039B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0039B).
           IF FLD0040B (1:)    NOT EQUAL XPC-FLD0040B
              DISPLAY 'FLD0040B ==> ' HEX-OF (FLD0040B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0040B).
           IF FLD0041B (1:)    NOT EQUAL XPC-FLD0041B
              DISPLAY 'FLD0041B ==> ' HEX-OF (FLD0041B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0041B).
           IF FLD0042B (1:)    NOT EQUAL XPC-FLD0042B
              DISPLAY 'FLD0042B ==> ' HEX-OF (FLD0042B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0042B).
           IF FLD0043B (1:)    NOT EQUAL XPC-FLD0043B
              DISPLAY 'FLD0043B ==> ' HEX-OF (FLD0043B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0043B).
           IF FLD0044B (1:)    NOT EQUAL XPC-FLD0044B
              DISPLAY 'FLD0044B ==> ' HEX-OF (FLD0044B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0044B).
           IF FLD0045B (1:)    NOT EQUAL XPC-FLD0045B
              DISPLAY 'FLD0045B ==> ' HEX-OF (FLD0045B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0045B).
           IF FLD0046B (1:)    NOT EQUAL XPC-FLD0046B
              DISPLAY 'FLD0046B ==> ' HEX-OF (FLD0046B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0046B).
           IF FLD0047B (1:)    NOT EQUAL XPC-FLD0047B
              DISPLAY 'FLD0047B ==> ' HEX-OF (FLD0047B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0047B).
           IF FLD0048B (1:)    NOT EQUAL XPC-FLD0048B
              DISPLAY 'FLD0048B ==> ' HEX-OF (FLD0048B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0048B).
           IF FLD0049B (1:)    NOT EQUAL XPC-FLD0049B
              DISPLAY 'FLD0049B ==> ' HEX-OF (FLD0049B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0049B).
           IF FLD0050B (1:)    NOT EQUAL XPC-FLD0050B
              DISPLAY 'FLD0050B ==> ' HEX-OF (FLD0050B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0050B).
           IF FLD0051B (1:)    NOT EQUAL XPC-FLD0051B
              DISPLAY 'FLD0051B ==> ' HEX-OF (FLD0051B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0051B).
           IF FLD0052B (1:)    NOT EQUAL XPC-FLD0052B
              DISPLAY 'FLD0052B ==> ' HEX-OF (FLD0052B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0052B).
           IF FLD0053B (1:)    NOT EQUAL XPC-FLD0053B
              DISPLAY 'FLD0053B ==> ' HEX-OF (FLD0053B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0053B).
           IF FLD0054B (1:)    NOT EQUAL XPC-FLD0054B
              DISPLAY 'FLD0054B ==> ' HEX-OF (FLD0054B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0054B).
           IF FLD0055B (1:)    NOT EQUAL XPC-FLD0055B
              DISPLAY 'FLD0055B ==> ' HEX-OF (FLD0055B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0055B).
           IF FLD0056B (1:)    NOT EQUAL XPC-FLD0056B
              DISPLAY 'FLD0056B ==> ' HEX-OF (FLD0056B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0056B).
           IF FLD0057B (1:)    NOT EQUAL XPC-FLD0057B
              DISPLAY 'FLD0057B ==> ' HEX-OF (FLD0057B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0057B).
           IF FLD0058B (1:)    NOT EQUAL XPC-FLD0058B
              DISPLAY 'FLD0058B ==> ' HEX-OF (FLD0058B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0058B).
           IF FLD0059B (1:)    NOT EQUAL XPC-FLD0059B
              DISPLAY 'FLD0059B ==> ' HEX-OF (FLD0059B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0059B).
           IF FLD0060B (1:)    NOT EQUAL XPC-FLD0060B
              DISPLAY 'FLD0060B ==> ' HEX-OF (FLD0060B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0060B).
           IF FLD0061B (1:)    NOT EQUAL XPC-FLD0061B
              DISPLAY 'FLD0061B ==> ' HEX-OF (FLD0061B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0061B).
           IF FLD0062B (1:)    NOT EQUAL XPC-FLD0062B
              DISPLAY 'FLD0062B ==> ' HEX-OF (FLD0062B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0062B).
           IF FLD0063B (1:)    NOT EQUAL XPC-FLD0063B
              DISPLAY 'FLD0063B ==> ' HEX-OF (FLD0063B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0063B).
           IF FLD0064B (1:)    NOT EQUAL XPC-FLD0064B
              DISPLAY 'FLD0064B ==> ' HEX-OF (FLD0064B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0064B).
           IF FLD0065B (1:)    NOT EQUAL XPC-FLD0065B
              DISPLAY 'FLD0065B ==> ' HEX-OF (FLD0065B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0065B).
           IF FLD0066B (1:)    NOT EQUAL XPC-FLD0066B
              DISPLAY 'FLD0066B ==> ' HEX-OF (FLD0066B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0066B).
           IF FLD0067B (1:)    NOT EQUAL XPC-FLD0067B
              DISPLAY 'FLD0067B ==> ' HEX-OF (FLD0067B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0067B).
           IF FLD0068B (1:)    NOT EQUAL XPC-FLD0068B
              DISPLAY 'FLD0068B ==> ' HEX-OF (FLD0068B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0068B).
           IF FLD0069B (1:)    NOT EQUAL XPC-FLD0069B
              DISPLAY 'FLD0069B ==> ' HEX-OF (FLD0069B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0069B).
           IF FLD0070B (1:)    NOT EQUAL XPC-FLD0070B
              DISPLAY 'FLD0070B ==> ' HEX-OF (FLD0070B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0070B).
           IF FLD0071B (1:)    NOT EQUAL XPC-FLD0071B
              DISPLAY 'FLD0071B ==> ' HEX-OF (FLD0071B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0071B).
           IF FLD0072B (1:)    NOT EQUAL XPC-FLD0072B
              DISPLAY 'FLD0072B ==> ' HEX-OF (FLD0072B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0072B).
           IF FLD0073B (1:)    NOT EQUAL XPC-FLD0073B
              DISPLAY 'FLD0073B ==> ' HEX-OF (FLD0073B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0073B).
           IF FLD0074B (1:)    NOT EQUAL XPC-FLD0074B
              DISPLAY 'FLD0074B ==> ' HEX-OF (FLD0074B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0074B).
           IF FLD0075B (1:)    NOT EQUAL XPC-FLD0075B
              DISPLAY 'FLD0075B ==> ' HEX-OF (FLD0075B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0075B).
           IF FLD0076B (1:)    NOT EQUAL XPC-FLD0076B
              DISPLAY 'FLD0076B ==> ' HEX-OF (FLD0076B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0076B).
           IF FLD0077B (1:)    NOT EQUAL XPC-FLD0077B
              DISPLAY 'FLD0077B ==> ' HEX-OF (FLD0077B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0077B).
           IF FLD0078B (1:)    NOT EQUAL XPC-FLD0078B
              DISPLAY 'FLD0078B ==> ' HEX-OF (FLD0078B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0078B).
           IF FLD0079B (1:)    NOT EQUAL XPC-FLD0079B
              DISPLAY 'FLD0079B ==> ' HEX-OF (FLD0079B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0079B).
           IF FLD0080B (1:)    NOT EQUAL XPC-FLD0080B
              DISPLAY 'FLD0080B ==> ' HEX-OF (FLD0080B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0080B).
           IF FLD0081B (1:)    NOT EQUAL XPC-FLD0081B
              DISPLAY 'FLD0081B ==> ' HEX-OF (FLD0081B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0081B).
           IF FLD0082B (1:)    NOT EQUAL XPC-FLD0082B
              DISPLAY 'FLD0082B ==> ' HEX-OF (FLD0082B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0082B).
           IF FLD0083B (1:)    NOT EQUAL XPC-FLD0083B
              DISPLAY 'FLD0083B ==> ' HEX-OF (FLD0083B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0083B).
           IF FLD0084B (1:)    NOT EQUAL XPC-FLD0084B
              DISPLAY 'FLD0084B ==> ' HEX-OF (FLD0084B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0084B).
           IF FLD0085B (1:)    NOT EQUAL XPC-FLD0085B
              DISPLAY 'FLD0085B ==> ' HEX-OF (FLD0085B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0085B).
           IF FLD0086B (1:)    NOT EQUAL XPC-FLD0086B
              DISPLAY 'FLD0086B ==> ' HEX-OF (FLD0086B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0086B).
           IF FLD0087B (1:)    NOT EQUAL XPC-FLD0087B
              DISPLAY 'FLD0087B ==> ' HEX-OF (FLD0087B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0087B).
           IF FLD0088B (1:)    NOT EQUAL XPC-FLD0088B
              DISPLAY 'FLD0088B ==> ' HEX-OF (FLD0088B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0088B).
           IF FLD0089B (1:)    NOT EQUAL XPC-FLD0089B
              DISPLAY 'FLD0089B ==> ' HEX-OF (FLD0089B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0089B).
           IF FLD0090B (1:)    NOT EQUAL XPC-FLD0090B
              DISPLAY 'FLD0090B ==> ' HEX-OF (FLD0090B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0090B).
           IF FLD0091B (1:)    NOT EQUAL XPC-FLD0091B
              DISPLAY 'FLD0091B ==> ' HEX-OF (FLD0091B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0091B).
           IF FLD0092B (1:)    NOT EQUAL XPC-FLD0092B
              DISPLAY 'FLD0092B ==> ' HEX-OF (FLD0092B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0092B).
           IF FLD0093B (1:)    NOT EQUAL XPC-FLD0093B
              DISPLAY 'FLD0093B ==> ' HEX-OF (FLD0093B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0093B).
           IF FLD0094B (1:)    NOT EQUAL XPC-FLD0094B
              DISPLAY 'FLD0094B ==> ' HEX-OF (FLD0094B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0094B).
           IF FLD0095B (1:)    NOT EQUAL XPC-FLD0095B
              DISPLAY 'FLD0095B ==> ' HEX-OF (FLD0095B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0095B).
           IF FLD0096B (1:)    NOT EQUAL XPC-FLD0096B
              DISPLAY 'FLD0096B ==> ' HEX-OF (FLD0096B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0096B).
           IF FLD0097B (1:)    NOT EQUAL XPC-FLD0097B
              DISPLAY 'FLD0097B ==> ' HEX-OF (FLD0097B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0097B).
           IF FLD0098B (1:)    NOT EQUAL XPC-FLD0098B
              DISPLAY 'FLD0098B ==> ' HEX-OF (FLD0098B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0098B).
           IF FLD0099B (1:)    NOT EQUAL XPC-FLD0099B
              DISPLAY 'FLD0099B ==> ' HEX-OF (FLD0099B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0099B).
           IF FLD0100B (1:)    NOT EQUAL XPC-FLD0100B
              DISPLAY 'FLD0100B ==> ' HEX-OF (FLD0100B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0100B).
           IF FLD0101B (1:)    NOT EQUAL XPC-FLD0101B
              DISPLAY 'FLD0101B ==> ' HEX-OF (FLD0101B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0101B).
           IF FLD0102B (1:)    NOT EQUAL XPC-FLD0102B
              DISPLAY 'FLD0102B ==> ' HEX-OF (FLD0102B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0102B).
           IF FLD0103B (1:)    NOT EQUAL XPC-FLD0103B
              DISPLAY 'FLD0103B ==> ' HEX-OF (FLD0103B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0103B).
           IF FLD0104B (1:)    NOT EQUAL XPC-FLD0104B
              DISPLAY 'FLD0104B ==> ' HEX-OF (FLD0104B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0104B).
           IF FLD0105B (1:)    NOT EQUAL XPC-FLD0105B
              DISPLAY 'FLD0105B ==> ' HEX-OF (FLD0105B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0105B).
           IF FLD0106B (1:)    NOT EQUAL XPC-FLD0106B
              DISPLAY 'FLD0106B ==> ' HEX-OF (FLD0106B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0106B).
           IF FLD0107B (1:)    NOT EQUAL XPC-FLD0107B
              DISPLAY 'FLD0107B ==> ' HEX-OF (FLD0107B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0107B).
           IF FLD0108B (1:)    NOT EQUAL XPC-FLD0108B
              DISPLAY 'FLD0108B ==> ' HEX-OF (FLD0108B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0108B).
           IF FLD0109B (1:)    NOT EQUAL XPC-FLD0109B
              DISPLAY 'FLD0109B ==> ' HEX-OF (FLD0109B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0109B).
           IF FLD0110B (1:)    NOT EQUAL XPC-FLD0110B
              DISPLAY 'FLD0110B ==> ' HEX-OF (FLD0110B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0110B).
           IF FLD0111B (1:)    NOT EQUAL XPC-FLD0111B
              DISPLAY 'FLD0111B ==> ' HEX-OF (FLD0111B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0111B).
           IF FLD0112B (1:)    NOT EQUAL XPC-FLD0112B
              DISPLAY 'FLD0112B ==> ' HEX-OF (FLD0112B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0112B).
           IF FLD0113B (1:)    NOT EQUAL XPC-FLD0113B
              DISPLAY 'FLD0113B ==> ' HEX-OF (FLD0113B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0113B).
           IF FLD0114B (1:)    NOT EQUAL XPC-FLD0114B
              DISPLAY 'FLD0114B ==> ' HEX-OF (FLD0114B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0114B).
           IF FLD0115B (1:)    NOT EQUAL XPC-FLD0115B
              DISPLAY 'FLD0115B ==> ' HEX-OF (FLD0115B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0115B).
           IF FLD0116B (1:)    NOT EQUAL XPC-FLD0116B
              DISPLAY 'FLD0116B ==> ' HEX-OF (FLD0116B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0116B).
           IF FLD0117B (1:)    NOT EQUAL XPC-FLD0117B
              DISPLAY 'FLD0117B ==> ' HEX-OF (FLD0117B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0117B).
           IF FLD0118B (1:)    NOT EQUAL XPC-FLD0118B
              DISPLAY 'FLD0118B ==> ' HEX-OF (FLD0118B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0118B).
           IF FLD0119B (1:)    NOT EQUAL XPC-FLD0119B
              DISPLAY 'FLD0119B ==> ' HEX-OF (FLD0119B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0119B).
           IF FLD0120B (1:)    NOT EQUAL XPC-FLD0120B
              DISPLAY 'FLD0120B ==> ' HEX-OF (FLD0120B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0120B).
           IF FLD0121B (1:)    NOT EQUAL XPC-FLD0121B
              DISPLAY 'FLD0121B ==> ' HEX-OF (FLD0121B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0121B).
           IF FLD0122B (1:)    NOT EQUAL XPC-FLD0122B
              DISPLAY 'FLD0122B ==> ' HEX-OF (FLD0122B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0122B).
           IF FLD0123B (1:)    NOT EQUAL XPC-FLD0123B
              DISPLAY 'FLD0123B ==> ' HEX-OF (FLD0123B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0123B).
           IF FLD0124B (1:)    NOT EQUAL XPC-FLD0124B
              DISPLAY 'FLD0124B ==> ' HEX-OF (FLD0124B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0124B).
           IF FLD0125B (1:)    NOT EQUAL XPC-FLD0125B
              DISPLAY 'FLD0125B ==> ' HEX-OF (FLD0125B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0125B).
           IF FLD0126B (1:)    NOT EQUAL XPC-FLD0126B
              DISPLAY 'FLD0126B ==> ' HEX-OF (FLD0126B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0126B).
           IF FLD0127B (1:)    NOT EQUAL XPC-FLD0127B
              DISPLAY 'FLD0127B ==> ' HEX-OF (FLD0127B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0127B).
           IF FLD0128B (1:)    NOT EQUAL XPC-FLD0128B
              DISPLAY 'FLD0128B ==> ' HEX-OF (FLD0128B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0128B).
           IF FLD0129B (1:)    NOT EQUAL XPC-FLD0129B
              DISPLAY 'FLD0129B ==> ' HEX-OF (FLD0129B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0129B).
           IF FLD0130B (1:)    NOT EQUAL XPC-FLD0130B
              DISPLAY 'FLD0130B ==> ' HEX-OF (FLD0130B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0130B).
           IF FLD0131B (1:)    NOT EQUAL XPC-FLD0131B
              DISPLAY 'FLD0131B ==> ' HEX-OF (FLD0131B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0131B).
           IF FLD0132B (1:)    NOT EQUAL XPC-FLD0132B
              DISPLAY 'FLD0132B ==> ' HEX-OF (FLD0132B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0132B).
           IF FLD0133B (1:)    NOT EQUAL XPC-FLD0133B
              DISPLAY 'FLD0133B ==> ' HEX-OF (FLD0133B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0133B).
           IF FLD0134B (1:)    NOT EQUAL XPC-FLD0134B
              DISPLAY 'FLD0134B ==> ' HEX-OF (FLD0134B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0134B).
           IF FLD0135B (1:)    NOT EQUAL XPC-FLD0135B
              DISPLAY 'FLD0135B ==> ' HEX-OF (FLD0135B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0135B).
           IF FLD0136B (1:)    NOT EQUAL XPC-FLD0136B
              DISPLAY 'FLD0136B ==> ' HEX-OF (FLD0136B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0136B).
           IF FLD0137B (1:)    NOT EQUAL XPC-FLD0137B
              DISPLAY 'FLD0137B ==> ' HEX-OF (FLD0137B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0137B).
           IF FLD0138B (1:)    NOT EQUAL XPC-FLD0138B
              DISPLAY 'FLD0138B ==> ' HEX-OF (FLD0138B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0138B).
           IF FLD0139B (1:)    NOT EQUAL XPC-FLD0139B
              DISPLAY 'FLD0139B ==> ' HEX-OF (FLD0139B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0139B).
           IF FLD0140B (1:)    NOT EQUAL XPC-FLD0140B
              DISPLAY 'FLD0140B ==> ' HEX-OF (FLD0140B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0140B).
           IF FLD0141B (1:)    NOT EQUAL XPC-FLD0141B
              DISPLAY 'FLD0141B ==> ' HEX-OF (FLD0141B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0141B).
           IF FLD0142B (1:)    NOT EQUAL XPC-FLD0142B
              DISPLAY 'FLD0142B ==> ' HEX-OF (FLD0142B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0142B).
           IF FLD0143B (1:)    NOT EQUAL XPC-FLD0143B
              DISPLAY 'FLD0143B ==> ' HEX-OF (FLD0143B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0143B).
           IF FLD0144B (1:)    NOT EQUAL XPC-FLD0144B
              DISPLAY 'FLD0144B ==> ' HEX-OF (FLD0144B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0144B).
           IF FLD0145B (1:)    NOT EQUAL XPC-FLD0145B
              DISPLAY 'FLD0145B ==> ' HEX-OF (FLD0145B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0145B).
           IF FLD0146B (1:)    NOT EQUAL XPC-FLD0146B
              DISPLAY 'FLD0146B ==> ' HEX-OF (FLD0146B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0146B).
           IF FLD0147B (1:)    NOT EQUAL XPC-FLD0147B
              DISPLAY 'FLD0147B ==> ' HEX-OF (FLD0147B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0147B).
           IF FLD0148B (1:)    NOT EQUAL XPC-FLD0148B
              DISPLAY 'FLD0148B ==> ' HEX-OF (FLD0148B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0148B).
           IF FLD0149B (1:)    NOT EQUAL XPC-FLD0149B
              DISPLAY 'FLD0149B ==> ' HEX-OF (FLD0149B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0149B).
           IF FLD0150B (1:)    NOT EQUAL XPC-FLD0150B
              DISPLAY 'FLD0150B ==> ' HEX-OF (FLD0150B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0150B).
           IF FLD0151B (1:)    NOT EQUAL XPC-FLD0151B
              DISPLAY 'FLD0151B ==> ' HEX-OF (FLD0151B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0151B).
           IF FLD0152B (1:)    NOT EQUAL XPC-FLD0152B
              DISPLAY 'FLD0152B ==> ' HEX-OF (FLD0152B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0152B).
           IF FLD0153B (1:)    NOT EQUAL XPC-FLD0153B
              DISPLAY 'FLD0153B ==> ' HEX-OF (FLD0153B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0153B).
           IF FLD0154B (1:)    NOT EQUAL XPC-FLD0154B
              DISPLAY 'FLD0154B ==> ' HEX-OF (FLD0154B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0154B).
           IF FLD0155B (1:)    NOT EQUAL XPC-FLD0155B
              DISPLAY 'FLD0155B ==> ' HEX-OF (FLD0155B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0155B).
           IF FLD0156B (1:)    NOT EQUAL XPC-FLD0156B
              DISPLAY 'FLD0156B ==> ' HEX-OF (FLD0156B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0156B).
           IF FLD0157B (1:)    NOT EQUAL XPC-FLD0157B
              DISPLAY 'FLD0157B ==> ' HEX-OF (FLD0157B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0157B).
           IF FLD0158B (1:)    NOT EQUAL XPC-FLD0158B
              DISPLAY 'FLD0158B ==> ' HEX-OF (FLD0158B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0158B).
           IF FLD0159B (1:)    NOT EQUAL XPC-FLD0159B
              DISPLAY 'FLD0159B ==> ' HEX-OF (FLD0159B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0159B).
           IF FLD0160B (1:)    NOT EQUAL XPC-FLD0160B
              DISPLAY 'FLD0160B ==> ' HEX-OF (FLD0160B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0160B).
           IF FLD0161B (1:)    NOT EQUAL XPC-FLD0161B
              DISPLAY 'FLD0161B ==> ' HEX-OF (FLD0161B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0161B).
           IF FLD0162B (1:)    NOT EQUAL XPC-FLD0162B
              DISPLAY 'FLD0162B ==> ' HEX-OF (FLD0162B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0162B).
           IF FLD0163B (1:)    NOT EQUAL XPC-FLD0163B
              DISPLAY 'FLD0163B ==> ' HEX-OF (FLD0163B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0163B).
           IF FLD0164B (1:)    NOT EQUAL XPC-FLD0164B
              DISPLAY 'FLD0164B ==> ' HEX-OF (FLD0164B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0164B).
           IF FLD0165B (1:)    NOT EQUAL XPC-FLD0165B
              DISPLAY 'FLD0165B ==> ' HEX-OF (FLD0165B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0165B).
           IF FLD0166B (1:)    NOT EQUAL XPC-FLD0166B
              DISPLAY 'FLD0166B ==> ' HEX-OF (FLD0166B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0166B).
           IF FLD0167B (1:)    NOT EQUAL XPC-FLD0167B
              DISPLAY 'FLD0167B ==> ' HEX-OF (FLD0167B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0167B).
           IF FLD0168B (1:)    NOT EQUAL XPC-FLD0168B
              DISPLAY 'FLD0168B ==> ' HEX-OF (FLD0168B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0168B).
           IF FLD0169B (1:)    NOT EQUAL XPC-FLD0169B
              DISPLAY 'FLD0169B ==> ' HEX-OF (FLD0169B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0169B).
           IF FLD0170B (1:)    NOT EQUAL XPC-FLD0170B
              DISPLAY 'FLD0170B ==> ' HEX-OF (FLD0170B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0170B).
           IF FLD0171B (1:)    NOT EQUAL XPC-FLD0171B
              DISPLAY 'FLD0171B ==> ' HEX-OF (FLD0171B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0171B).
           IF FLD0172B (1:)    NOT EQUAL XPC-FLD0172B
              DISPLAY 'FLD0172B ==> ' HEX-OF (FLD0172B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0172B).
           IF FLD0173B (1:)    NOT EQUAL XPC-FLD0173B
              DISPLAY 'FLD0173B ==> ' HEX-OF (FLD0173B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0173B).
           IF FLD0174B (1:)    NOT EQUAL XPC-FLD0174B
              DISPLAY 'FLD0174B ==> ' HEX-OF (FLD0174B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0174B).
           IF FLD0175B (1:)    NOT EQUAL XPC-FLD0175B
              DISPLAY 'FLD0175B ==> ' HEX-OF (FLD0175B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0175B).
           IF FLD0176B (1:)    NOT EQUAL XPC-FLD0176B
              DISPLAY 'FLD0176B ==> ' HEX-OF (FLD0176B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0176B).
           IF FLD0177B (1:)    NOT EQUAL XPC-FLD0177B
              DISPLAY 'FLD0177B ==> ' HEX-OF (FLD0177B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0177B).
           IF FLD0178B (1:)    NOT EQUAL XPC-FLD0178B
              DISPLAY 'FLD0178B ==> ' HEX-OF (FLD0178B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0178B).
           IF FLD0179B (1:)    NOT EQUAL XPC-FLD0179B
              DISPLAY 'FLD0179B ==> ' HEX-OF (FLD0179B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0179B).
           IF FLD0180B (1:)    NOT EQUAL XPC-FLD0180B
              DISPLAY 'FLD0180B ==> ' HEX-OF (FLD0180B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0180B).
           IF FLD0181B (1:)    NOT EQUAL XPC-FLD0181B
              DISPLAY 'FLD0181B ==> ' HEX-OF (FLD0181B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0181B).
           IF FLD0182B (1:)    NOT EQUAL XPC-FLD0182B
              DISPLAY 'FLD0182B ==> ' HEX-OF (FLD0182B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0182B).
           IF FLD0183B (1:)    NOT EQUAL XPC-FLD0183B
              DISPLAY 'FLD0183B ==> ' HEX-OF (FLD0183B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0183B).
           IF FLD0184B (1:)    NOT EQUAL XPC-FLD0184B
              DISPLAY 'FLD0184B ==> ' HEX-OF (FLD0184B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0184B).
           IF FLD0185B (1:)    NOT EQUAL XPC-FLD0185B
              DISPLAY 'FLD0185B ==> ' HEX-OF (FLD0185B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0185B).
           IF FLD0186B (1:)    NOT EQUAL XPC-FLD0186B
              DISPLAY 'FLD0186B ==> ' HEX-OF (FLD0186B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0186B).
           IF FLD0187B (1:)    NOT EQUAL XPC-FLD0187B
              DISPLAY 'FLD0187B ==> ' HEX-OF (FLD0187B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0187B).
           IF FLD0188B (1:)    NOT EQUAL XPC-FLD0188B
              DISPLAY 'FLD0188B ==> ' HEX-OF (FLD0188B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0188B).
           IF FLD0189B (1:)    NOT EQUAL XPC-FLD0189B
              DISPLAY 'FLD0189B ==> ' HEX-OF (FLD0189B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0189B).
           IF FLD0190B (1:)    NOT EQUAL XPC-FLD0190B
              DISPLAY 'FLD0190B ==> ' HEX-OF (FLD0190B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0190B).
           IF FLD0191B (1:)    NOT EQUAL XPC-FLD0191B
              DISPLAY 'FLD0191B ==> ' HEX-OF (FLD0191B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0191B).
           IF FLD0192B (1:)    NOT EQUAL XPC-FLD0192B
              DISPLAY 'FLD0192B ==> ' HEX-OF (FLD0192B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0192B).
           IF FLD0193B (1:)    NOT EQUAL XPC-FLD0193B
              DISPLAY 'FLD0193B ==> ' HEX-OF (FLD0193B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0193B).
           IF FLD0194B (1:)    NOT EQUAL XPC-FLD0194B
              DISPLAY 'FLD0194B ==> ' HEX-OF (FLD0194B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0194B).
           IF FLD0195B (1:)    NOT EQUAL XPC-FLD0195B
              DISPLAY 'FLD0195B ==> ' HEX-OF (FLD0195B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0195B).
           IF FLD0196B (1:)    NOT EQUAL XPC-FLD0196B
              DISPLAY 'FLD0196B ==> ' HEX-OF (FLD0196B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0196B).
           IF FLD0197B (1:)    NOT EQUAL XPC-FLD0197B
              DISPLAY 'FLD0197B ==> ' HEX-OF (FLD0197B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0197B).
           IF FLD0198B (1:)    NOT EQUAL XPC-FLD0198B
              DISPLAY 'FLD0198B ==> ' HEX-OF (FLD0198B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0198B).
           IF FLD0199B (1:)    NOT EQUAL XPC-FLD0199B
              DISPLAY 'FLD0199B ==> ' HEX-OF (FLD0199B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0199B).
           IF FLD0200B (1:)    NOT EQUAL XPC-FLD0200B
              DISPLAY 'FLD0200B ==> ' HEX-OF (FLD0200B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0200B).
           IF FLD0201B (1:)    NOT EQUAL XPC-FLD0201B
              DISPLAY 'FLD0201B ==> ' HEX-OF (FLD0201B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0201B).
           IF FLD0202B (1:)    NOT EQUAL XPC-FLD0202B
              DISPLAY 'FLD0202B ==> ' HEX-OF (FLD0202B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0202B).
           IF FLD0203B (1:)    NOT EQUAL XPC-FLD0203B
              DISPLAY 'FLD0203B ==> ' HEX-OF (FLD0203B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0203B).
           IF FLD0204B (1:)    NOT EQUAL XPC-FLD0204B
              DISPLAY 'FLD0204B ==> ' HEX-OF (FLD0204B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0204B).
           IF FLD0205B (1:)    NOT EQUAL XPC-FLD0205B
              DISPLAY 'FLD0205B ==> ' HEX-OF (FLD0205B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0205B).
           IF FLD0206B (1:)    NOT EQUAL XPC-FLD0206B
              DISPLAY 'FLD0206B ==> ' HEX-OF (FLD0206B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0206B).
           IF FLD0207B (1:)    NOT EQUAL XPC-FLD0207B
              DISPLAY 'FLD0207B ==> ' HEX-OF (FLD0207B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0207B).
           IF FLD0208B (1:)    NOT EQUAL XPC-FLD0208B
              DISPLAY 'FLD0208B ==> ' HEX-OF (FLD0208B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0208B).
           IF FLD0209B (1:)    NOT EQUAL XPC-FLD0209B
              DISPLAY 'FLD0209B ==> ' HEX-OF (FLD0209B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0209B).
           IF FLD0210B (1:)    NOT EQUAL XPC-FLD0210B
              DISPLAY 'FLD0210B ==> ' HEX-OF (FLD0210B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0210B).
           IF FLD0211B (1:)    NOT EQUAL XPC-FLD0211B
              DISPLAY 'FLD0211B ==> ' HEX-OF (FLD0211B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0211B).
           IF FLD0212B (1:)    NOT EQUAL XPC-FLD0212B
              DISPLAY 'FLD0212B ==> ' HEX-OF (FLD0212B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0212B).
           IF FLD0213B (1:)    NOT EQUAL XPC-FLD0213B
              DISPLAY 'FLD0213B ==> ' HEX-OF (FLD0213B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0213B).
           IF FLD0214B (1:)    NOT EQUAL XPC-FLD0214B
              DISPLAY 'FLD0214B ==> ' HEX-OF (FLD0214B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0214B).
           IF FLD0215B (1:)    NOT EQUAL XPC-FLD0215B
              DISPLAY 'FLD0215B ==> ' HEX-OF (FLD0215B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0215B).
           IF FLD0216B (1:)    NOT EQUAL XPC-FLD0216B
              DISPLAY 'FLD0216B ==> ' HEX-OF (FLD0216B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0216B).
           IF FLD0217B (1:)    NOT EQUAL XPC-FLD0217B
              DISPLAY 'FLD0217B ==> ' HEX-OF (FLD0217B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0217B).
           IF FLD0218B (1:)    NOT EQUAL XPC-FLD0218B
              DISPLAY 'FLD0218B ==> ' HEX-OF (FLD0218B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0218B).
           IF FLD0219B (1:)    NOT EQUAL XPC-FLD0219B
              DISPLAY 'FLD0219B ==> ' HEX-OF (FLD0219B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0219B).
           IF FLD0220B (1:)    NOT EQUAL XPC-FLD0220B
              DISPLAY 'FLD0220B ==> ' HEX-OF (FLD0220B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0220B).
           IF FLD0221B (1:)    NOT EQUAL XPC-FLD0221B
              DISPLAY 'FLD0221B ==> ' HEX-OF (FLD0221B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0221B).
           IF FLD0222B (1:)    NOT EQUAL XPC-FLD0222B
              DISPLAY 'FLD0222B ==> ' HEX-OF (FLD0222B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0222B).
           IF FLD0223B (1:)    NOT EQUAL XPC-FLD0223B
              DISPLAY 'FLD0223B ==> ' HEX-OF (FLD0223B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0223B).
           IF FLD0224B (1:)    NOT EQUAL XPC-FLD0224B
              DISPLAY 'FLD0224B ==> ' HEX-OF (FLD0224B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0224B).
           IF FLD0225B (1:)    NOT EQUAL XPC-FLD0225B
              DISPLAY 'FLD0225B ==> ' HEX-OF (FLD0225B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0225B).
           IF FLD0226B (1:)    NOT EQUAL XPC-FLD0226B
              DISPLAY 'FLD0226B ==> ' HEX-OF (FLD0226B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0226B).
           IF FLD0227B (1:)    NOT EQUAL XPC-FLD0227B
              DISPLAY 'FLD0227B ==> ' HEX-OF (FLD0227B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0227B).
           IF FLD0228B (1:)    NOT EQUAL XPC-FLD0228B
              DISPLAY 'FLD0228B ==> ' HEX-OF (FLD0228B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0228B).
           IF FLD0229B (1:)    NOT EQUAL XPC-FLD0229B
              DISPLAY 'FLD0229B ==> ' HEX-OF (FLD0229B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0229B).
           IF FLD0230B (1:)    NOT EQUAL XPC-FLD0230B
              DISPLAY 'FLD0230B ==> ' HEX-OF (FLD0230B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0230B).
           IF FLD0231B (1:)    NOT EQUAL XPC-FLD0231B
              DISPLAY 'FLD0231B ==> ' HEX-OF (FLD0231B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0231B).
           IF FLD0232B (1:)    NOT EQUAL XPC-FLD0232B
              DISPLAY 'FLD0232B ==> ' HEX-OF (FLD0232B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0232B).
           IF FLD0233B (1:)    NOT EQUAL XPC-FLD0233B
              DISPLAY 'FLD0233B ==> ' HEX-OF (FLD0233B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0233B).
           IF FLD0234B (1:)    NOT EQUAL XPC-FLD0234B
              DISPLAY 'FLD0234B ==> ' HEX-OF (FLD0234B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0234B).
           IF FLD0235B (1:)    NOT EQUAL XPC-FLD0235B
              DISPLAY 'FLD0235B ==> ' HEX-OF (FLD0235B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0235B).
           IF FLD0236B (1:)    NOT EQUAL XPC-FLD0236B
              DISPLAY 'FLD0236B ==> ' HEX-OF (FLD0236B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0236B).
           IF FLD0237B (1:)    NOT EQUAL XPC-FLD0237B
              DISPLAY 'FLD0237B ==> ' HEX-OF (FLD0237B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0237B).
           IF FLD0238B (1:)    NOT EQUAL XPC-FLD0238B
              DISPLAY 'FLD0238B ==> ' HEX-OF (FLD0238B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0238B).
           IF FLD0239B (1:)    NOT EQUAL XPC-FLD0239B
              DISPLAY 'FLD0239B ==> ' HEX-OF (FLD0239B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0239B).
           IF FLD0240B (1:)    NOT EQUAL XPC-FLD0240B
              DISPLAY 'FLD0240B ==> ' HEX-OF (FLD0240B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0240B).
           IF FLD0241B (1:)    NOT EQUAL XPC-FLD0241B
              DISPLAY 'FLD0241B ==> ' HEX-OF (FLD0241B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0241B).
           IF FLD0242B (1:)    NOT EQUAL XPC-FLD0242B
              DISPLAY 'FLD0242B ==> ' HEX-OF (FLD0242B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0242B).
           IF FLD0243B (1:)    NOT EQUAL XPC-FLD0243B
              DISPLAY 'FLD0243B ==> ' HEX-OF (FLD0243B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0243B).
           IF FLD0244B (1:)    NOT EQUAL XPC-FLD0244B
              DISPLAY 'FLD0244B ==> ' HEX-OF (FLD0244B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0244B).
           IF FLD0245B (1:)    NOT EQUAL XPC-FLD0245B
              DISPLAY 'FLD0245B ==> ' HEX-OF (FLD0245B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0245B).
           IF FLD0246B (1:)    NOT EQUAL XPC-FLD0246B
              DISPLAY 'FLD0246B ==> ' HEX-OF (FLD0246B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0246B).
           IF FLD0247B (1:)    NOT EQUAL XPC-FLD0247B
              DISPLAY 'FLD0247B ==> ' HEX-OF (FLD0247B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0247B).
           IF FLD0248B (1:)    NOT EQUAL XPC-FLD0248B
              DISPLAY 'FLD0248B ==> ' HEX-OF (FLD0248B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0248B).
           IF FLD0249B (1:)    NOT EQUAL XPC-FLD0249B
              DISPLAY 'FLD0249B ==> ' HEX-OF (FLD0249B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0249B).
           IF FLD0250B (1:)    NOT EQUAL XPC-FLD0250B
              DISPLAY 'FLD0250B ==> ' HEX-OF (FLD0250B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0250B).
           IF FLD0251B (1:)    NOT EQUAL XPC-FLD0251B
              DISPLAY 'FLD0251B ==> ' HEX-OF (FLD0251B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0251B).
           IF FLD0252B (1:)    NOT EQUAL XPC-FLD0252B
              DISPLAY 'FLD0252B ==> ' HEX-OF (FLD0252B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0252B).
           IF FLD0253B (1:)    NOT EQUAL XPC-FLD0253B
              DISPLAY 'FLD0253B ==> ' HEX-OF (FLD0253B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0253B).
           IF FLD0254B (1:)    NOT EQUAL XPC-FLD0254B
              DISPLAY 'FLD0254B ==> ' HEX-OF (FLD0254B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0254B).
           IF FLD0255B (1:)    NOT EQUAL XPC-FLD0255B
              DISPLAY 'FLD0255B ==> ' HEX-OF (FLD0255B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0255B).
           IF FLD0256B (1:)    NOT EQUAL XPC-FLD0256B
              DISPLAY 'FLD0256B ==> ' HEX-OF (FLD0256B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0256B).
           IF FLD0257B (1:)    NOT EQUAL XPC-FLD0257B
              DISPLAY 'FLD0257B ==> ' HEX-OF (FLD0257B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0257B).
           IF FLD0258B (1:)    NOT EQUAL XPC-FLD0258B
              DISPLAY 'FLD0258B ==> ' HEX-OF (FLD0258B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0258B).
           IF FLD0259B (1:)    NOT EQUAL XPC-FLD0259B
              DISPLAY 'FLD0259B ==> ' HEX-OF (FLD0259B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0259B).
           IF FLD0260B (1:)    NOT EQUAL XPC-FLD0260B
              DISPLAY 'FLD0260B ==> ' HEX-OF (FLD0260B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0260B).
           IF FLD0261B (1:)    NOT EQUAL XPC-FLD0261B
              DISPLAY 'FLD0261B ==> ' HEX-OF (FLD0261B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0261B).
           IF FLD0262B (1:)    NOT EQUAL XPC-FLD0262B
              DISPLAY 'FLD0262B ==> ' HEX-OF (FLD0262B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0262B).
           IF FLD0263B (1:)    NOT EQUAL XPC-FLD0263B
              DISPLAY 'FLD0263B ==> ' HEX-OF (FLD0263B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0263B).
           IF FLD0264B (1:)    NOT EQUAL XPC-FLD0264B
              DISPLAY 'FLD0264B ==> ' HEX-OF (FLD0264B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0264B).
           IF FLD0265B (1:)    NOT EQUAL XPC-FLD0265B
              DISPLAY 'FLD0265B ==> ' HEX-OF (FLD0265B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0265B).
           IF FLD0266B (1:)    NOT EQUAL XPC-FLD0266B
              DISPLAY 'FLD0266B ==> ' HEX-OF (FLD0266B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0266B).
           IF FLD0267B (1:)    NOT EQUAL XPC-FLD0267B
              DISPLAY 'FLD0267B ==> ' HEX-OF (FLD0267B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0267B).
           IF FLD0268B (1:)    NOT EQUAL XPC-FLD0268B
              DISPLAY 'FLD0268B ==> ' HEX-OF (FLD0268B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0268B).
           IF FLD0269B (1:)    NOT EQUAL XPC-FLD0269B
              DISPLAY 'FLD0269B ==> ' HEX-OF (FLD0269B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0269B).
           IF FLD0270B (1:)    NOT EQUAL XPC-FLD0270B
              DISPLAY 'FLD0270B ==> ' HEX-OF (FLD0270B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0270B).
           IF FLD0271B (1:)    NOT EQUAL XPC-FLD0271B
              DISPLAY 'FLD0271B ==> ' HEX-OF (FLD0271B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0271B).
           IF FLD0272B (1:)    NOT EQUAL XPC-FLD0272B
              DISPLAY 'FLD0272B ==> ' HEX-OF (FLD0272B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0272B).
           IF FLD0273B (1:)    NOT EQUAL XPC-FLD0273B
              DISPLAY 'FLD0273B ==> ' HEX-OF (FLD0273B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0273B).
           IF FLD0274B (1:)    NOT EQUAL XPC-FLD0274B
              DISPLAY 'FLD0274B ==> ' HEX-OF (FLD0274B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0274B).
           IF FLD0275B (1:)    NOT EQUAL XPC-FLD0275B
              DISPLAY 'FLD0275B ==> ' HEX-OF (FLD0275B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0275B).
           IF FLD0276B (1:)    NOT EQUAL XPC-FLD0276B
              DISPLAY 'FLD0276B ==> ' HEX-OF (FLD0276B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0276B).
           IF FLD0277B (1:)    NOT EQUAL XPC-FLD0277B
              DISPLAY 'FLD0277B ==> ' HEX-OF (FLD0277B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0277B).
           IF FLD0278B (1:)    NOT EQUAL XPC-FLD0278B
              DISPLAY 'FLD0278B ==> ' HEX-OF (FLD0278B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0278B).
           IF FLD0279B (1:)    NOT EQUAL XPC-FLD0279B
              DISPLAY 'FLD0279B ==> ' HEX-OF (FLD0279B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0279B).
           IF FLD0280B (1:)    NOT EQUAL XPC-FLD0280B
              DISPLAY 'FLD0280B ==> ' HEX-OF (FLD0280B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0280B).
           IF FLD0281B (1:)    NOT EQUAL XPC-FLD0281B
              DISPLAY 'FLD0281B ==> ' HEX-OF (FLD0281B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0281B).
           IF FLD0282B (1:)    NOT EQUAL XPC-FLD0282B
              DISPLAY 'FLD0282B ==> ' HEX-OF (FLD0282B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0282B).
           IF FLD0283B (1:)    NOT EQUAL XPC-FLD0283B
              DISPLAY 'FLD0283B ==> ' HEX-OF (FLD0283B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0283B).
           IF FLD0284B (1:)    NOT EQUAL XPC-FLD0284B
              DISPLAY 'FLD0284B ==> ' HEX-OF (FLD0284B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0284B).
           IF FLD0285B (1:)    NOT EQUAL XPC-FLD0285B
              DISPLAY 'FLD0285B ==> ' HEX-OF (FLD0285B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0285B).
           IF FLD0286B (1:)    NOT EQUAL XPC-FLD0286B
              DISPLAY 'FLD0286B ==> ' HEX-OF (FLD0286B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0286B).
           IF FLD0287B (1:)    NOT EQUAL XPC-FLD0287B
              DISPLAY 'FLD0287B ==> ' HEX-OF (FLD0287B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0287B).
           IF FLD0288B (1:)    NOT EQUAL XPC-FLD0288B
              DISPLAY 'FLD0288B ==> ' HEX-OF (FLD0288B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0288B).
           IF FLD0289B (1:)    NOT EQUAL XPC-FLD0289B
              DISPLAY 'FLD0289B ==> ' HEX-OF (FLD0289B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0289B).
           IF FLD0290B (1:)    NOT EQUAL XPC-FLD0290B
              DISPLAY 'FLD0290B ==> ' HEX-OF (FLD0290B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0290B).
           IF FLD0291B (1:)    NOT EQUAL XPC-FLD0291B
              DISPLAY 'FLD0291B ==> ' HEX-OF (FLD0291B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0291B).
           IF FLD0292B (1:)    NOT EQUAL XPC-FLD0292B
              DISPLAY 'FLD0292B ==> ' HEX-OF (FLD0292B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0292B).
           IF FLD0293B (1:)    NOT EQUAL XPC-FLD0293B
              DISPLAY 'FLD0293B ==> ' HEX-OF (FLD0293B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0293B).
           IF FLD0294B (1:)    NOT EQUAL XPC-FLD0294B
              DISPLAY 'FLD0294B ==> ' HEX-OF (FLD0294B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0294B).
           IF FLD0295B (1:)    NOT EQUAL XPC-FLD0295B
              DISPLAY 'FLD0295B ==> ' HEX-OF (FLD0295B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0295B).
           IF FLD0296B (1:)    NOT EQUAL XPC-FLD0296B
              DISPLAY 'FLD0296B ==> ' HEX-OF (FLD0296B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0296B).
           IF FLD0297B (1:)    NOT EQUAL XPC-FLD0297B
              DISPLAY 'FLD0297B ==> ' HEX-OF (FLD0297B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0297B).
           IF FLD0298B (1:)    NOT EQUAL XPC-FLD0298B
              DISPLAY 'FLD0298B ==> ' HEX-OF (FLD0298B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0298B).
           IF FLD0299B (1:)    NOT EQUAL XPC-FLD0299B
              DISPLAY 'FLD0299B ==> ' HEX-OF (FLD0299B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0299B).
           IF FLD0300B (1:)    NOT EQUAL XPC-FLD0300B
              DISPLAY 'FLD0300B ==> ' HEX-OF (FLD0300B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0300B).
           IF FLD0301B (1:)    NOT EQUAL XPC-FLD0301B
              DISPLAY 'FLD0301B ==> ' HEX-OF (FLD0301B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0301B).
           IF FLD0302B (1:)    NOT EQUAL XPC-FLD0302B
              DISPLAY 'FLD0302B ==> ' HEX-OF (FLD0302B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0302B).
           IF FLD0303B (1:)    NOT EQUAL XPC-FLD0303B
              DISPLAY 'FLD0303B ==> ' HEX-OF (FLD0303B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0303B).
           IF FLD0304B (1:)    NOT EQUAL XPC-FLD0304B
              DISPLAY 'FLD0304B ==> ' HEX-OF (FLD0304B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0304B).
           IF FLD0305B (1:)    NOT EQUAL XPC-FLD0305B
              DISPLAY 'FLD0305B ==> ' HEX-OF (FLD0305B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0305B).
           IF FLD0306B (1:)    NOT EQUAL XPC-FLD0306B
              DISPLAY 'FLD0306B ==> ' HEX-OF (FLD0306B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0306B).
           IF FLD0307B (1:)    NOT EQUAL XPC-FLD0307B
              DISPLAY 'FLD0307B ==> ' HEX-OF (FLD0307B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0307B).
           IF FLD0308B (1:)    NOT EQUAL XPC-FLD0308B
              DISPLAY 'FLD0308B ==> ' HEX-OF (FLD0308B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0308B).
           IF FLD0309B (1:)    NOT EQUAL XPC-FLD0309B
              DISPLAY 'FLD0309B ==> ' HEX-OF (FLD0309B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0309B).
           IF FLD0310B (1:)    NOT EQUAL XPC-FLD0310B
              DISPLAY 'FLD0310B ==> ' HEX-OF (FLD0310B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0310B).
           IF FLD0311B (1:)    NOT EQUAL XPC-FLD0311B
              DISPLAY 'FLD0311B ==> ' HEX-OF (FLD0311B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0311B).
           IF FLD0312B (1:)    NOT EQUAL XPC-FLD0312B
              DISPLAY 'FLD0312B ==> ' HEX-OF (FLD0312B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0312B).
           IF FLD0313B (1:)    NOT EQUAL XPC-FLD0313B
              DISPLAY 'FLD0313B ==> ' HEX-OF (FLD0313B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0313B).
           IF FLD0314B (1:)    NOT EQUAL XPC-FLD0314B
              DISPLAY 'FLD0314B ==> ' HEX-OF (FLD0314B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0314B).
           IF FLD0315B (1:)    NOT EQUAL XPC-FLD0315B
              DISPLAY 'FLD0315B ==> ' HEX-OF (FLD0315B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0315B).
           IF FLD0316B (1:)    NOT EQUAL XPC-FLD0316B
              DISPLAY 'FLD0316B ==> ' HEX-OF (FLD0316B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0316B).
           IF FLD0317B (1:)    NOT EQUAL XPC-FLD0317B
              DISPLAY 'FLD0317B ==> ' HEX-OF (FLD0317B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0317B).
           IF FLD0318B (1:)    NOT EQUAL XPC-FLD0318B
              DISPLAY 'FLD0318B ==> ' HEX-OF (FLD0318B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0318B).
           IF FLD0319B (1:)    NOT EQUAL XPC-FLD0319B
              DISPLAY 'FLD0319B ==> ' HEX-OF (FLD0319B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0319B).
           IF FLD0320B (1:)    NOT EQUAL XPC-FLD0320B
              DISPLAY 'FLD0320B ==> ' HEX-OF (FLD0320B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0320B).
           IF FLD0321B (1:)    NOT EQUAL XPC-FLD0321B
              DISPLAY 'FLD0321B ==> ' HEX-OF (FLD0321B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0321B).
           IF FLD0322B (1:)    NOT EQUAL XPC-FLD0322B
              DISPLAY 'FLD0322B ==> ' HEX-OF (FLD0322B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0322B).
           IF FLD0323B (1:)    NOT EQUAL XPC-FLD0323B
              DISPLAY 'FLD0323B ==> ' HEX-OF (FLD0323B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0323B).
           IF FLD0324B (1:)    NOT EQUAL XPC-FLD0324B
              DISPLAY 'FLD0324B ==> ' HEX-OF (FLD0324B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0324B).
           IF FLD0325B (1:)    NOT EQUAL XPC-FLD0325B
              DISPLAY 'FLD0325B ==> ' HEX-OF (FLD0325B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0325B).
           IF FLD0326B (1:)    NOT EQUAL XPC-FLD0326B
              DISPLAY 'FLD0326B ==> ' HEX-OF (FLD0326B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0326B).
           IF FLD0327B (1:)    NOT EQUAL XPC-FLD0327B
              DISPLAY 'FLD0327B ==> ' HEX-OF (FLD0327B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0327B).
           IF FLD0328B (1:)    NOT EQUAL XPC-FLD0328B
              DISPLAY 'FLD0328B ==> ' HEX-OF (FLD0328B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0328B).
           IF FLD0329B (1:)    NOT EQUAL XPC-FLD0329B
              DISPLAY 'FLD0329B ==> ' HEX-OF (FLD0329B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0329B).
           IF FLD0330B (1:)    NOT EQUAL XPC-FLD0330B
              DISPLAY 'FLD0330B ==> ' HEX-OF (FLD0330B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0330B).
           IF FLD0331B (1:)    NOT EQUAL XPC-FLD0331B
              DISPLAY 'FLD0331B ==> ' HEX-OF (FLD0331B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0331B).
           IF FLD0332B (1:)    NOT EQUAL XPC-FLD0332B
              DISPLAY 'FLD0332B ==> ' HEX-OF (FLD0332B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0332B).
           IF FLD0333B (1:)    NOT EQUAL XPC-FLD0333B
              DISPLAY 'FLD0333B ==> ' HEX-OF (FLD0333B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0333B).
           IF FLD0334B (1:)    NOT EQUAL XPC-FLD0334B
              DISPLAY 'FLD0334B ==> ' HEX-OF (FLD0334B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0334B).
           IF FLD0335B (1:)    NOT EQUAL XPC-FLD0335B
              DISPLAY 'FLD0335B ==> ' HEX-OF (FLD0335B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0335B).
           IF FLD0336B (1:)    NOT EQUAL XPC-FLD0336B
              DISPLAY 'FLD0336B ==> ' HEX-OF (FLD0336B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0336B).
           IF FLD0337B (1:)    NOT EQUAL XPC-FLD0337B
              DISPLAY 'FLD0337B ==> ' HEX-OF (FLD0337B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0337B).
           IF FLD0338B (1:)    NOT EQUAL XPC-FLD0338B
              DISPLAY 'FLD0338B ==> ' HEX-OF (FLD0338B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0338B).
           IF FLD0339B (1:)    NOT EQUAL XPC-FLD0339B
              DISPLAY 'FLD0339B ==> ' HEX-OF (FLD0339B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0339B).
           IF FLD0340B (1:)    NOT EQUAL XPC-FLD0340B
              DISPLAY 'FLD0340B ==> ' HEX-OF (FLD0340B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0340B).
           IF FLD0341B (1:)    NOT EQUAL XPC-FLD0341B
              DISPLAY 'FLD0341B ==> ' HEX-OF (FLD0341B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0341B).
           IF FLD0342B (1:)    NOT EQUAL XPC-FLD0342B
              DISPLAY 'FLD0342B ==> ' HEX-OF (FLD0342B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0342B).
           IF FLD0343B (1:)    NOT EQUAL XPC-FLD0343B
              DISPLAY 'FLD0343B ==> ' HEX-OF (FLD0343B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0343B).
           IF FLD0344B (1:)    NOT EQUAL XPC-FLD0344B
              DISPLAY 'FLD0344B ==> ' HEX-OF (FLD0344B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0344B).
           IF FLD0345B (1:)    NOT EQUAL XPC-FLD0345B
              DISPLAY 'FLD0345B ==> ' HEX-OF (FLD0345B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0345B).
           IF FLD0346B (1:)    NOT EQUAL XPC-FLD0346B
              DISPLAY 'FLD0346B ==> ' HEX-OF (FLD0346B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0346B).
           IF FLD0347B (1:)    NOT EQUAL XPC-FLD0347B
              DISPLAY 'FLD0347B ==> ' HEX-OF (FLD0347B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0347B).
           IF FLD0348B (1:)    NOT EQUAL XPC-FLD0348B
              DISPLAY 'FLD0348B ==> ' HEX-OF (FLD0348B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0348B).
           IF FLD0349B (1:)    NOT EQUAL XPC-FLD0349B
              DISPLAY 'FLD0349B ==> ' HEX-OF (FLD0349B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0349B).
           IF FLD0350B (1:)    NOT EQUAL XPC-FLD0350B
              DISPLAY 'FLD0350B ==> ' HEX-OF (FLD0350B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0350B).
           IF FLD0351B (1:)    NOT EQUAL XPC-FLD0351B
              DISPLAY 'FLD0351B ==> ' HEX-OF (FLD0351B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0351B).
           IF FLD0352B (1:)    NOT EQUAL XPC-FLD0352B
              DISPLAY 'FLD0352B ==> ' HEX-OF (FLD0352B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0352B).
           IF FLD0353B (1:)    NOT EQUAL XPC-FLD0353B
              DISPLAY 'FLD0353B ==> ' HEX-OF (FLD0353B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0353B).
           IF FLD0354B (1:)    NOT EQUAL XPC-FLD0354B
              DISPLAY 'FLD0354B ==> ' HEX-OF (FLD0354B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0354B).
           IF FLD0355B (1:)    NOT EQUAL XPC-FLD0355B
              DISPLAY 'FLD0355B ==> ' HEX-OF (FLD0355B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0355B).
           IF FLD0356B (1:)    NOT EQUAL XPC-FLD0356B
              DISPLAY 'FLD0356B ==> ' HEX-OF (FLD0356B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0356B).
           IF FLD0357B (1:)    NOT EQUAL XPC-FLD0357B
              DISPLAY 'FLD0357B ==> ' HEX-OF (FLD0357B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0357B).
           IF FLD0358B (1:)    NOT EQUAL XPC-FLD0358B
              DISPLAY 'FLD0358B ==> ' HEX-OF (FLD0358B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0358B).
           IF FLD0359B (1:)    NOT EQUAL XPC-FLD0359B
              DISPLAY 'FLD0359B ==> ' HEX-OF (FLD0359B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0359B).
           IF FLD0360B (1:)    NOT EQUAL XPC-FLD0360B
              DISPLAY 'FLD0360B ==> ' HEX-OF (FLD0360B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0360B).
           IF FLD0361B (1:)    NOT EQUAL XPC-FLD0361B
              DISPLAY 'FLD0361B ==> ' HEX-OF (FLD0361B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0361B).
           IF FLD0362B (1:)    NOT EQUAL XPC-FLD0362B
              DISPLAY 'FLD0362B ==> ' HEX-OF (FLD0362B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0362B).
           IF FLD0363B (1:)    NOT EQUAL XPC-FLD0363B
              DISPLAY 'FLD0363B ==> ' HEX-OF (FLD0363B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0363B).
           IF FLD0364B (1:)    NOT EQUAL XPC-FLD0364B
              DISPLAY 'FLD0364B ==> ' HEX-OF (FLD0364B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0364B).
           IF FLD0365B (1:)    NOT EQUAL XPC-FLD0365B
              DISPLAY 'FLD0365B ==> ' HEX-OF (FLD0365B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0365B).
           IF FLD0366B (1:)    NOT EQUAL XPC-FLD0366B
              DISPLAY 'FLD0366B ==> ' HEX-OF (FLD0366B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0366B).
           IF FLD0367B (1:)    NOT EQUAL XPC-FLD0367B
              DISPLAY 'FLD0367B ==> ' HEX-OF (FLD0367B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0367B).
           IF FLD0368B (1:)    NOT EQUAL XPC-FLD0368B
              DISPLAY 'FLD0368B ==> ' HEX-OF (FLD0368B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0368B).
           IF FLD0369B (1:)    NOT EQUAL XPC-FLD0369B
              DISPLAY 'FLD0369B ==> ' HEX-OF (FLD0369B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0369B).
           IF FLD0370B (1:)    NOT EQUAL XPC-FLD0370B
              DISPLAY 'FLD0370B ==> ' HEX-OF (FLD0370B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0370B).
           IF FLD0371B (1:)    NOT EQUAL XPC-FLD0371B
              DISPLAY 'FLD0371B ==> ' HEX-OF (FLD0371B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0371B).
           IF FLD0372B (1:)    NOT EQUAL XPC-FLD0372B
              DISPLAY 'FLD0372B ==> ' HEX-OF (FLD0372B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0372B).
           IF FLD0373B (1:)    NOT EQUAL XPC-FLD0373B
              DISPLAY 'FLD0373B ==> ' HEX-OF (FLD0373B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0373B).
           IF FLD0374B (1:)    NOT EQUAL XPC-FLD0374B
              DISPLAY 'FLD0374B ==> ' HEX-OF (FLD0374B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0374B).
           IF FLD0375B (1:)    NOT EQUAL XPC-FLD0375B
              DISPLAY 'FLD0375B ==> ' HEX-OF (FLD0375B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0375B).
           IF FLD0376B (1:)    NOT EQUAL XPC-FLD0376B
              DISPLAY 'FLD0376B ==> ' HEX-OF (FLD0376B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0376B).
           IF FLD0377B (1:)    NOT EQUAL XPC-FLD0377B
              DISPLAY 'FLD0377B ==> ' HEX-OF (FLD0377B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0377B).
           IF FLD0378B (1:)    NOT EQUAL XPC-FLD0378B
              DISPLAY 'FLD0378B ==> ' HEX-OF (FLD0378B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0378B).
           IF FLD0379B (1:)    NOT EQUAL XPC-FLD0379B
              DISPLAY 'FLD0379B ==> ' HEX-OF (FLD0379B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0379B).
           IF FLD0380B (1:)    NOT EQUAL XPC-FLD0380B
              DISPLAY 'FLD0380B ==> ' HEX-OF (FLD0380B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0380B).
           IF FLD0381B (1:)    NOT EQUAL XPC-FLD0381B
              DISPLAY 'FLD0381B ==> ' HEX-OF (FLD0381B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0381B).
           IF FLD0382B (1:)    NOT EQUAL XPC-FLD0382B
              DISPLAY 'FLD0382B ==> ' HEX-OF (FLD0382B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0382B).
           IF FLD0383B (1:)    NOT EQUAL XPC-FLD0383B
              DISPLAY 'FLD0383B ==> ' HEX-OF (FLD0383B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0383B).
           IF FLD0384B (1:)    NOT EQUAL XPC-FLD0384B
              DISPLAY 'FLD0384B ==> ' HEX-OF (FLD0384B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0384B).
           IF FLD0385B (1:)    NOT EQUAL XPC-FLD0385B
              DISPLAY 'FLD0385B ==> ' HEX-OF (FLD0385B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0385B).
           IF FLD0386B (1:)    NOT EQUAL XPC-FLD0386B
              DISPLAY 'FLD0386B ==> ' HEX-OF (FLD0386B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0386B).
           IF FLD0387B (1:)    NOT EQUAL XPC-FLD0387B
              DISPLAY 'FLD0387B ==> ' HEX-OF (FLD0387B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0387B).
           IF FLD0388B (1:)    NOT EQUAL XPC-FLD0388B
              DISPLAY 'FLD0388B ==> ' HEX-OF (FLD0388B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0388B).
           IF FLD0389B (1:)    NOT EQUAL XPC-FLD0389B
              DISPLAY 'FLD0389B ==> ' HEX-OF (FLD0389B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0389B).
           IF FLD0390B (1:)    NOT EQUAL XPC-FLD0390B
              DISPLAY 'FLD0390B ==> ' HEX-OF (FLD0390B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0390B).
           IF FLD0391B (1:)    NOT EQUAL XPC-FLD0391B
              DISPLAY 'FLD0391B ==> ' HEX-OF (FLD0391B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0391B).
           IF FLD0392B (1:)    NOT EQUAL XPC-FLD0392B
              DISPLAY 'FLD0392B ==> ' HEX-OF (FLD0392B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0392B).
           IF FLD0393B (1:)    NOT EQUAL XPC-FLD0393B
              DISPLAY 'FLD0393B ==> ' HEX-OF (FLD0393B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0393B).
           IF FLD0394B (1:)    NOT EQUAL XPC-FLD0394B
              DISPLAY 'FLD0394B ==> ' HEX-OF (FLD0394B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0394B).
           IF FLD0395B (1:)    NOT EQUAL XPC-FLD0395B
              DISPLAY 'FLD0395B ==> ' HEX-OF (FLD0395B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0395B).
           IF FLD0396B (1:)    NOT EQUAL XPC-FLD0396B
              DISPLAY 'FLD0396B ==> ' HEX-OF (FLD0396B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0396B).
           IF FLD0397B (1:)    NOT EQUAL XPC-FLD0397B
              DISPLAY 'FLD0397B ==> ' HEX-OF (FLD0397B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0397B).
           IF FLD0398B (1:)    NOT EQUAL XPC-FLD0398B
              DISPLAY 'FLD0398B ==> ' HEX-OF (FLD0398B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0398B).
           IF FLD0399B (1:)    NOT EQUAL XPC-FLD0399B
              DISPLAY 'FLD0399B ==> ' HEX-OF (FLD0399B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0399B).
           IF FLD0400B (1:)    NOT EQUAL XPC-FLD0400B
              DISPLAY 'FLD0400B ==> ' HEX-OF (FLD0400B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0400B).
           IF FLD0401B (1:)    NOT EQUAL XPC-FLD0401B
              DISPLAY 'FLD0401B ==> ' HEX-OF (FLD0401B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0401B).
           IF FLD0402B (1:)    NOT EQUAL XPC-FLD0402B
              DISPLAY 'FLD0402B ==> ' HEX-OF (FLD0402B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0402B).
           IF FLD0403B (1:)    NOT EQUAL XPC-FLD0403B
              DISPLAY 'FLD0403B ==> ' HEX-OF (FLD0403B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0403B).
           IF FLD0404B (1:)    NOT EQUAL XPC-FLD0404B
              DISPLAY 'FLD0404B ==> ' HEX-OF (FLD0404B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0404B).
           IF FLD0405B (1:)    NOT EQUAL XPC-FLD0405B
              DISPLAY 'FLD0405B ==> ' HEX-OF (FLD0405B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0405B).
           IF FLD0406B (1:)    NOT EQUAL XPC-FLD0406B
              DISPLAY 'FLD0406B ==> ' HEX-OF (FLD0406B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0406B).
           IF FLD0407B (1:)    NOT EQUAL XPC-FLD0407B
              DISPLAY 'FLD0407B ==> ' HEX-OF (FLD0407B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0407B).
           IF FLD0408B (1:)    NOT EQUAL XPC-FLD0408B
              DISPLAY 'FLD0408B ==> ' HEX-OF (FLD0408B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0408B).
           IF FLD0409B (1:)    NOT EQUAL XPC-FLD0409B
              DISPLAY 'FLD0409B ==> ' HEX-OF (FLD0409B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0409B).
           IF FLD0410B (1:)    NOT EQUAL XPC-FLD0410B
              DISPLAY 'FLD0410B ==> ' HEX-OF (FLD0410B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0410B).
           IF FLD0411B (1:)    NOT EQUAL XPC-FLD0411B
              DISPLAY 'FLD0411B ==> ' HEX-OF (FLD0411B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0411B).
           IF FLD0412B (1:)    NOT EQUAL XPC-FLD0412B
              DISPLAY 'FLD0412B ==> ' HEX-OF (FLD0412B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0412B).
           IF FLD0413B (1:)    NOT EQUAL XPC-FLD0413B
              DISPLAY 'FLD0413B ==> ' HEX-OF (FLD0413B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0413B).
           IF FLD0414B (1:)    NOT EQUAL XPC-FLD0414B
              DISPLAY 'FLD0414B ==> ' HEX-OF (FLD0414B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0414B).
           IF FLD0415B (1:)    NOT EQUAL XPC-FLD0415B
              DISPLAY 'FLD0415B ==> ' HEX-OF (FLD0415B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0415B).
           IF FLD0416B (1:)    NOT EQUAL XPC-FLD0416B
              DISPLAY 'FLD0416B ==> ' HEX-OF (FLD0416B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0416B).
           IF FLD0417B (1:)    NOT EQUAL XPC-FLD0417B
              DISPLAY 'FLD0417B ==> ' HEX-OF (FLD0417B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0417B).
           IF FLD0418B (1:)    NOT EQUAL XPC-FLD0418B
              DISPLAY 'FLD0418B ==> ' HEX-OF (FLD0418B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0418B).
           IF FLD0419B (1:)    NOT EQUAL XPC-FLD0419B
              DISPLAY 'FLD0419B ==> ' HEX-OF (FLD0419B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0419B).
           IF FLD0420B (1:)    NOT EQUAL XPC-FLD0420B
              DISPLAY 'FLD0420B ==> ' HEX-OF (FLD0420B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0420B).
           IF FLD0421B (1:)    NOT EQUAL XPC-FLD0421B
              DISPLAY 'FLD0421B ==> ' HEX-OF (FLD0421B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0421B).
           IF FLD0422B (1:)    NOT EQUAL XPC-FLD0422B
              DISPLAY 'FLD0422B ==> ' HEX-OF (FLD0422B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0422B).
           IF FLD0423B (1:)    NOT EQUAL XPC-FLD0423B
              DISPLAY 'FLD0423B ==> ' HEX-OF (FLD0423B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0423B).
           IF FLD0424B (1:)    NOT EQUAL XPC-FLD0424B
              DISPLAY 'FLD0424B ==> ' HEX-OF (FLD0424B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0424B).
           IF FLD0425B (1:)    NOT EQUAL XPC-FLD0425B
              DISPLAY 'FLD0425B ==> ' HEX-OF (FLD0425B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0425B).
           IF FLD0426B (1:)    NOT EQUAL XPC-FLD0426B
              DISPLAY 'FLD0426B ==> ' HEX-OF (FLD0426B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0426B).
           IF FLD0427B (1:)    NOT EQUAL XPC-FLD0427B
              DISPLAY 'FLD0427B ==> ' HEX-OF (FLD0427B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0427B).
           IF FLD0428B (1:)    NOT EQUAL XPC-FLD0428B
              DISPLAY 'FLD0428B ==> ' HEX-OF (FLD0428B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0428B).
           IF FLD0429B (1:)    NOT EQUAL XPC-FLD0429B
              DISPLAY 'FLD0429B ==> ' HEX-OF (FLD0429B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0429B).
           IF FLD0430B (1:)    NOT EQUAL XPC-FLD0430B
              DISPLAY 'FLD0430B ==> ' HEX-OF (FLD0430B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0430B).
           IF FLD0431B (1:)    NOT EQUAL XPC-FLD0431B
              DISPLAY 'FLD0431B ==> ' HEX-OF (FLD0431B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0431B).
           IF FLD0432B (1:)    NOT EQUAL XPC-FLD0432B
              DISPLAY 'FLD0432B ==> ' HEX-OF (FLD0432B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0432B).
           IF FLD0433B (1:)    NOT EQUAL XPC-FLD0433B
              DISPLAY 'FLD0433B ==> ' HEX-OF (FLD0433B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0433B).
           IF FLD0434B (1:)    NOT EQUAL XPC-FLD0434B
              DISPLAY 'FLD0434B ==> ' HEX-OF (FLD0434B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0434B).
           IF FLD0435B (1:)    NOT EQUAL XPC-FLD0435B
              DISPLAY 'FLD0435B ==> ' HEX-OF (FLD0435B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0435B).
           IF FLD0436B (1:)    NOT EQUAL XPC-FLD0436B
              DISPLAY 'FLD0436B ==> ' HEX-OF (FLD0436B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0436B).
           IF FLD0437B (1:)    NOT EQUAL XPC-FLD0437B
              DISPLAY 'FLD0437B ==> ' HEX-OF (FLD0437B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0437B).
           IF FLD0438B (1:)    NOT EQUAL XPC-FLD0438B
              DISPLAY 'FLD0438B ==> ' HEX-OF (FLD0438B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0438B).
           IF FLD0439B (1:)    NOT EQUAL XPC-FLD0439B
              DISPLAY 'FLD0439B ==> ' HEX-OF (FLD0439B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0439B).
           IF FLD0440B (1:)    NOT EQUAL XPC-FLD0440B
              DISPLAY 'FLD0440B ==> ' HEX-OF (FLD0440B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0440B).
           IF FLD0441B (1:)    NOT EQUAL XPC-FLD0441B
              DISPLAY 'FLD0441B ==> ' HEX-OF (FLD0441B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0441B).
           IF FLD0442B (1:)    NOT EQUAL XPC-FLD0442B
              DISPLAY 'FLD0442B ==> ' HEX-OF (FLD0442B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0442B).
           IF FLD0443B (1:)    NOT EQUAL XPC-FLD0443B
              DISPLAY 'FLD0443B ==> ' HEX-OF (FLD0443B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0443B).
           IF FLD0444B (1:)    NOT EQUAL XPC-FLD0444B
              DISPLAY 'FLD0444B ==> ' HEX-OF (FLD0444B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0444B).
           IF FLD0445B (1:)    NOT EQUAL XPC-FLD0445B
              DISPLAY 'FLD0445B ==> ' HEX-OF (FLD0445B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0445B).
           IF FLD0446B (1:)    NOT EQUAL XPC-FLD0446B
              DISPLAY 'FLD0446B ==> ' HEX-OF (FLD0446B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0446B).
           IF FLD0447B (1:)    NOT EQUAL XPC-FLD0447B
              DISPLAY 'FLD0447B ==> ' HEX-OF (FLD0447B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0447B).
           IF FLD0448B (1:)    NOT EQUAL XPC-FLD0448B
              DISPLAY 'FLD0448B ==> ' HEX-OF (FLD0448B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0448B).
           IF FLD0449B (1:)    NOT EQUAL XPC-FLD0449B
              DISPLAY 'FLD0449B ==> ' HEX-OF (FLD0449B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0449B).
           IF FLD0450B (1:)    NOT EQUAL XPC-FLD0450B
              DISPLAY 'FLD0450B ==> ' HEX-OF (FLD0450B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0450B).
           IF FLD0451B (1:)    NOT EQUAL XPC-FLD0451B
              DISPLAY 'FLD0451B ==> ' HEX-OF (FLD0451B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0451B).
           IF FLD0452B (1:)    NOT EQUAL XPC-FLD0452B
              DISPLAY 'FLD0452B ==> ' HEX-OF (FLD0452B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0452B).
           IF FLD0453B (1:)    NOT EQUAL XPC-FLD0453B
              DISPLAY 'FLD0453B ==> ' HEX-OF (FLD0453B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0453B).
           IF FLD0454B (1:)    NOT EQUAL XPC-FLD0454B
              DISPLAY 'FLD0454B ==> ' HEX-OF (FLD0454B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0454B).
           IF FLD0455B (1:)    NOT EQUAL XPC-FLD0455B
              DISPLAY 'FLD0455B ==> ' HEX-OF (FLD0455B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0455B).
           IF FLD0456B (1:)    NOT EQUAL XPC-FLD0456B
              DISPLAY 'FLD0456B ==> ' HEX-OF (FLD0456B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0456B).
           IF FLD0457B (1:)    NOT EQUAL XPC-FLD0457B
              DISPLAY 'FLD0457B ==> ' HEX-OF (FLD0457B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0457B).
           IF FLD0458B (1:)    NOT EQUAL XPC-FLD0458B
              DISPLAY 'FLD0458B ==> ' HEX-OF (FLD0458B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0458B).
           IF FLD0459B (1:)    NOT EQUAL XPC-FLD0459B
              DISPLAY 'FLD0459B ==> ' HEX-OF (FLD0459B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0459B).
           IF FLD0460B (1:)    NOT EQUAL XPC-FLD0460B
              DISPLAY 'FLD0460B ==> ' HEX-OF (FLD0460B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0460B).
           IF FLD0461B (1:)    NOT EQUAL XPC-FLD0461B
              DISPLAY 'FLD0461B ==> ' HEX-OF (FLD0461B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0461B).
           IF FLD0462B (1:)    NOT EQUAL XPC-FLD0462B
              DISPLAY 'FLD0462B ==> ' HEX-OF (FLD0462B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0462B).
           IF FLD0463B (1:)    NOT EQUAL XPC-FLD0463B
              DISPLAY 'FLD0463B ==> ' HEX-OF (FLD0463B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0463B).
           IF FLD0464B (1:)    NOT EQUAL XPC-FLD0464B
              DISPLAY 'FLD0464B ==> ' HEX-OF (FLD0464B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0464B).
           IF FLD0465B (1:)    NOT EQUAL XPC-FLD0465B
              DISPLAY 'FLD0465B ==> ' HEX-OF (FLD0465B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0465B).
           IF FLD0466B (1:)    NOT EQUAL XPC-FLD0466B
              DISPLAY 'FLD0466B ==> ' HEX-OF (FLD0466B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0466B).
           IF FLD0467B (1:)    NOT EQUAL XPC-FLD0467B
              DISPLAY 'FLD0467B ==> ' HEX-OF (FLD0467B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0467B).
           IF FLD0468B (1:)    NOT EQUAL XPC-FLD0468B
              DISPLAY 'FLD0468B ==> ' HEX-OF (FLD0468B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0468B).
           IF FLD0469B (1:)    NOT EQUAL XPC-FLD0469B
              DISPLAY 'FLD0469B ==> ' HEX-OF (FLD0469B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0469B).
           IF FLD0470B (1:)    NOT EQUAL XPC-FLD0470B
              DISPLAY 'FLD0470B ==> ' HEX-OF (FLD0470B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0470B).
           IF FLD0471B (1:)    NOT EQUAL XPC-FLD0471B
              DISPLAY 'FLD0471B ==> ' HEX-OF (FLD0471B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0471B).
           IF FLD0472B (1:)    NOT EQUAL XPC-FLD0472B
              DISPLAY 'FLD0472B ==> ' HEX-OF (FLD0472B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0472B).
           IF FLD0473B (1:)    NOT EQUAL XPC-FLD0473B
              DISPLAY 'FLD0473B ==> ' HEX-OF (FLD0473B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0473B).
           IF FLD0474B (1:)    NOT EQUAL XPC-FLD0474B
              DISPLAY 'FLD0474B ==> ' HEX-OF (FLD0474B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0474B).
           IF FLD0475B (1:)    NOT EQUAL XPC-FLD0475B
              DISPLAY 'FLD0475B ==> ' HEX-OF (FLD0475B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0475B).
           IF FLD0476B (1:)    NOT EQUAL XPC-FLD0476B
              DISPLAY 'FLD0476B ==> ' HEX-OF (FLD0476B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0476B).
           IF FLD0477B (1:)    NOT EQUAL XPC-FLD0477B
              DISPLAY 'FLD0477B ==> ' HEX-OF (FLD0477B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0477B).
           IF FLD0478B (1:)    NOT EQUAL XPC-FLD0478B
              DISPLAY 'FLD0478B ==> ' HEX-OF (FLD0478B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0478B).
           IF FLD0479B (1:)    NOT EQUAL XPC-FLD0479B
              DISPLAY 'FLD0479B ==> ' HEX-OF (FLD0479B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0479B).
           IF FLD0480B (1:)    NOT EQUAL XPC-FLD0480B
              DISPLAY 'FLD0480B ==> ' HEX-OF (FLD0480B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0480B).
           IF FLD0481B (1:)    NOT EQUAL XPC-FLD0481B
              DISPLAY 'FLD0481B ==> ' HEX-OF (FLD0481B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0481B).
           IF FLD0482B (1:)    NOT EQUAL XPC-FLD0482B
              DISPLAY 'FLD0482B ==> ' HEX-OF (FLD0482B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0482B).
           IF FLD0483B (1:)    NOT EQUAL XPC-FLD0483B
              DISPLAY 'FLD0483B ==> ' HEX-OF (FLD0483B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0483B).
           IF FLD0484B (1:)    NOT EQUAL XPC-FLD0484B
              DISPLAY 'FLD0484B ==> ' HEX-OF (FLD0484B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0484B).
           IF FLD0485B (1:)    NOT EQUAL XPC-FLD0485B
              DISPLAY 'FLD0485B ==> ' HEX-OF (FLD0485B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0485B).
           IF FLD0486B (1:)    NOT EQUAL XPC-FLD0486B
              DISPLAY 'FLD0486B ==> ' HEX-OF (FLD0486B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0486B).
           IF FLD0487B (1:)    NOT EQUAL XPC-FLD0487B
              DISPLAY 'FLD0487B ==> ' HEX-OF (FLD0487B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0487B).
           IF FLD0488B (1:)    NOT EQUAL XPC-FLD0488B
              DISPLAY 'FLD0488B ==> ' HEX-OF (FLD0488B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0488B).
           IF FLD0489B (1:)    NOT EQUAL XPC-FLD0489B
              DISPLAY 'FLD0489B ==> ' HEX-OF (FLD0489B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0489B).
           IF FLD0490B (1:)    NOT EQUAL XPC-FLD0490B
              DISPLAY 'FLD0490B ==> ' HEX-OF (FLD0490B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0490B).
           IF FLD0491B (1:)    NOT EQUAL XPC-FLD0491B
              DISPLAY 'FLD0491B ==> ' HEX-OF (FLD0491B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0491B).
           IF FLD0492B (1:)    NOT EQUAL XPC-FLD0492B
              DISPLAY 'FLD0492B ==> ' HEX-OF (FLD0492B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0492B).
           IF FLD0493B (1:)    NOT EQUAL XPC-FLD0493B
              DISPLAY 'FLD0493B ==> ' HEX-OF (FLD0493B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0493B).
           IF FLD0494B (1:)    NOT EQUAL XPC-FLD0494B
              DISPLAY 'FLD0494B ==> ' HEX-OF (FLD0494B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0494B).
           IF FLD0495B (1:)    NOT EQUAL XPC-FLD0495B
              DISPLAY 'FLD0495B ==> ' HEX-OF (FLD0495B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0495B).
           IF FLD0496B (1:)    NOT EQUAL XPC-FLD0496B
              DISPLAY 'FLD0496B ==> ' HEX-OF (FLD0496B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0496B).
           IF FLD0497B (1:)    NOT EQUAL XPC-FLD0497B
              DISPLAY 'FLD0497B ==> ' HEX-OF (FLD0497B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0497B).
           IF FLD0498B (1:)    NOT EQUAL XPC-FLD0498B
              DISPLAY 'FLD0498B ==> ' HEX-OF (FLD0498B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0498B).
           IF FLD0499B (1:)    NOT EQUAL XPC-FLD0499B
              DISPLAY 'FLD0499B ==> ' HEX-OF (FLD0499B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0499B).