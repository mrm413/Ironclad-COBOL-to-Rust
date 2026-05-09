IDENTIFICATION DIVISION.
       PROGRAM-ID. PDTEST-MOVE1.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
       FUNCTION HEX-OF INTRINSIC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * DATA-AREA

       77 FLD0001A                       PIC  9(08)V9(19) COMP-3
           VALUE  72210483.5706116943150334464.
       77 FLD0001C                       PIC  9(01)       COMP-6.

       77 FLD0002A                       PIC  9(05)V9(26) COMP-6
           VALUE  83954.98773698940597753903603006.
       77 FLD0002C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0003A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0003C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0004A                       PIC S9(08)V9(03) COMP-3
           VALUE +31348416.669.
       77 FLD0004C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0005A                       PIC S9(07)V9(01) COMP-3
           VALUE +2337334.8.
       77 FLD0005C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0006A                       PIC  9(04)       COMP-6
           VALUE  1169.
       77 FLD0006C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0007A                       PIC S9(04)       COMP-3
           VALUE +1123.
       77 FLD0007C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0008A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0008C                       PIC S9(03)       COMP-3.

       77 FLD0009A                       PIC  9(10)V9(07) COMP-6
           VALUE  4695987895.4491957.
       77 FLD0009C                       PIC  9(05)V9(28) COMP-3.

       77 FLD0010A                       PIC  9(03)V9(32) COMP-3
           VALUE  932.59120224122482589734772773226723.
       77 FLD0010C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0011A                       PIC  9(09)V9(04) COMP-6
           VALUE  356168291.4830.
       77 FLD0011C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0012A                       PIC  9(03)       COMP-6
           VALUE  087.
       77 FLD0012C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0013A                       PIC  9(06)V9(25) COMP-6
           VALUE  829630.0004717120923913853403064.
       77 FLD0013C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0014A                       PIC  9(09)V9(13) COMP-3
           VALUE  592943121.2490873237541.
       77 FLD0014C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0015A                       PIC  9(07)V9(23) COMP-6
           VALUE  7984732.71412134533164817185024.
       77 FLD0015C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0016A                       PIC  9(05)V9(28) COMP-3
           VALUE  87275.9557853607148558694461826235.
       77 FLD0016C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0017A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0017C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0018A                       PIC  9(07)V9(21) COMP-3
           VALUE  7619026.805277494540646898713.
       77 FLD0018C                       PIC S9(01)       COMP-3.

       77 FLD0019A                       PIC S9(10)V9(08) COMP-3
           VALUE -4930528885.68236813.
       77 FLD0019C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0020A                       PIC  9(09)V9(15) COMP-3
           VALUE  643887452.720044328735582.
       77 FLD0020C                       PIC  9(09)V9(11) COMP-3.

       77 FLD0021A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.880441680787707126043528660375159233.
       77 FLD0021C                       PIC S9(01)       COMP-3.

       77 FLD0022A                       PIC  9(06)V9(24) COMP-3
           VALUE  810040.192546636172998830716096.
       77 FLD0022C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0023A                       PIC  9(02)       COMP-6
           VALUE  06.
       77 FLD0023C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0024A                       PIC  9(09)V9(03) COMP-6
           VALUE  329406009.124.
       77 FLD0024C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0025A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0025C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0026A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0026C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0027A                       PIC  9(09)V9(13) COMP-3
           VALUE  601026867.0937520818498.
       77 FLD0027C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0028A                       PIC  9(04)V9(29) COMP-6
           VALUE  8794.72782911061568000832266989164.
       77 FLD0028C                       PIC S9(01)       COMP-3.

       77 FLD0029A                       PIC  9(05)       COMP-6
           VALUE  13697.
       77 FLD0029C                       PIC  9(09)V9(17) COMP-3.

       77 FLD0030A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0030C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0031A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0031C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0032A                       PIC  9(10)V9(10) COMP-6
           VALUE  5269599769.4606222516.
       77 FLD0032C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0033A                       PIC  9(09)V9(15) COMP-3
           VALUE  641903038.069859710468278.
       77 FLD0033C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0034A                       PIC S9(02)       COMP-3
           VALUE -05.
       77 FLD0034C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0035A                       PIC  9(06)V9(25) COMP-6
           VALUE  816285.5924199176049782522568420.
       77 FLD0035C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0036A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.789384107274801127829277902492322027.
       77 FLD0036C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0037A                       PIC  9(10)V9(11) COMP-6
           VALUE  5559560836.79804091701.
       77 FLD0037C                       PIC S9(05)       COMP-3.

       77 FLD0038A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.5897506417712539139586169767426326.
       77 FLD0038C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0039A                       PIC  9(04)V9(29) COMP-3
           VALUE  8933.20399454893721014059337903745.
       77 FLD0039C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0040A                       PIC S9(06)       COMP-3
           VALUE -162227.
       77 FLD0040C                       PIC S9(03)       COMP-3.

       77 FLD0041A                       PIC  9(09)V9(17) COMP-6
           VALUE  687709210.19485042879892944.
       77 FLD0041C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0042A                       PIC  9(07)V9(22) COMP-6
           VALUE  7680734.5400734650109342283030.
       77 FLD0042C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0043A                       PIC S9(08)V9(02) COMP-3
           VALUE -28038049.48.
       77 FLD0043C                       PIC  9(04)V9(30) COMP-3.

       77 FLD0044A                       PIC  9(06)V9(01) COMP-6
           VALUE  206224.3.
       77 FLD0044C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0045A                       PIC  9(08)V9(02) COMP-6
           VALUE  28592495.81.
       77 FLD0045C                       PIC  9(09)V9(05) COMP-6.

       77 FLD0046A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0046C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0047A                       PIC  9(08)V9(02) COMP-6
           VALUE  26966592.97.
       77 FLD0047C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0048A                       PIC  9(05)V9(26) COMP-6
           VALUE  83962.84254838164429202151950448.
       77 FLD0048C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0049A                       PIC  9(09)V9(16) COMP-6
           VALUE  677621907.0336453320635428.
       77 FLD0049C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0050A                       PIC  9(09)V9(03) COMP-6
           VALUE  329667670.988.
       77 FLD0050C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0051A                       PIC  9(09)V9(15) COMP-3
           VALUE  643375703.689413991348544.
       77 FLD0051C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0052A                       PIC  9(09)V9(04) COMP-6
           VALUE  367200483.8576.
       77 FLD0052C                       PIC  9(09)V9(11) COMP-3.

       77 FLD0053A                       PIC  9(07)V9(01) COMP-6
           VALUE  2260324.6.
       77 FLD0053C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0054A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0054C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0055A                       PIC  9(09)V9(14) COMP-3
           VALUE  622232417.66982828604426.
       77 FLD0055C                       PIC  9(08)V9(17) COMP-3.

       77 FLD0056A                       PIC  9(07)V9(01) COMP-6
           VALUE  2161993.9.
       77 FLD0056C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0057A                       PIC  9(03)V9(32) COMP-6
           VALUE  929.20878243011406638629523513372987.
       77 FLD0057C                       PIC S9(02)       COMP-3.

       77 FLD0058A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.6574119281082611010447180888149887.
       77 FLD0058C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0059A                       PIC  9(07)V9(02) COMP-6
           VALUE  2566438.61.
       77 FLD0059C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0060A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.888752946983269120906356874911580234.
       77 FLD0060C                       PIC  9(06)       COMP-6.

       77 FLD0061A                       PIC  9(03)       COMP-6
           VALUE  095.
       77 FLD0061C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0062A                       PIC  9(10)V9(11) COMP-6
           VALUE  5579259193.81647705819.
       77 FLD0062C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0063A                       PIC S9(07)V9(01) COMP-3
           VALUE +2106925.6.
       77 FLD0063C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0064A                       PIC  9(06)V9(25) COMP-6
           VALUE  828553.1635867423583263757791428.
       77 FLD0064C                       PIC S9(04)       COMP-3.

       77 FLD0065A                       PIC  9(08)V9(02) COMP-6
           VALUE  26934154.73.
       77 FLD0065C                       PIC S9(04)       COMP-3.

       77 FLD0066A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0066C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0067A                       PIC S9(03)       COMP-3
           VALUE -091.
       77 FLD0067C                       PIC S9(01)       COMP-3.

       77 FLD0068A                       PIC  9(06)V9(25) COMP-6
           VALUE  838055.6814082209537986045688739.
       77 FLD0068C                       PIC  9(01)       COMP-6.

       77 FLD0069A                       PIC  9(10)V9(08) COMP-6
           VALUE  4880885916.76487937.
       77 FLD0069C                       PIC  9(03)       COMP-6.

       77 FLD0070A                       PIC  9(08)V9(18) COMP-6
           VALUE  69654747.914044090606466852.
       77 FLD0070C                       PIC S9(06)V9(01) COMP-3.

       77 FLD0071A                       PIC  9(02)       COMP-6
           VALUE  05.
       77 FLD0071C                       PIC  9(04)       COMP-6.

       77 FLD0072A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.925387953744267965916492357791867107.
       77 FLD0072C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0073A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.812328554525302504174533169134519994.
       77 FLD0073C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0074A                       PIC  9(03)V9(32) COMP-6
           VALUE  925.84903592679257400277492706663906.
       77 FLD0074C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0075A                       PIC  9(10)V9(10) COMP-3
           VALUE  5446083738.8683014381.
       77 FLD0075C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0076A                       PIC S9(07)V9(02) COMP-3
           VALUE +2412584.18.
       77 FLD0076C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0077A                       PIC  9(10)V9(08) COMP-6
           VALUE  4971042025.86989840.
       77 FLD0077C                       PIC  9(05)V9(28) COMP-6.

       77 FLD0078A                       PIC  9(06)V9(01) COMP-6
           VALUE  186044.2.
       77 FLD0078C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0079A                       PIC  9(09)V9(15) COMP-6
           VALUE  638119223.314542294289708.
       77 FLD0079C                       PIC S9(03)       COMP-3.

       77 FLD0080A                       PIC  9(07)V9(23) COMP-3
           VALUE  7905587.67133311302011122734256.
       77 FLD0080C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0081A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.951308658902108250643436804239172488.
       77 FLD0081C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0082A                       PIC S9(08)V9(02) COMP-3
           VALUE -26324419.10.
       77 FLD0082C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0083A                       PIC  9(09)V9(14) COMP-3
           VALUE  631384121.39469823891602.
       77 FLD0083C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0084A                       PIC  9(04)V9(29) COMP-3
           VALUE  8913.08379718931953483718189090723.
       77 FLD0084C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0085A                       PIC  9(05)       COMP-6
           VALUE  15779.
       77 FLD0085C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0086A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.766547774737049936177868403319735080.
       77 FLD0086C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0087A                       PIC  9(09)V9(14) COMP-6
           VALUE  617158605.01368802193411.
       77 FLD0087C                       PIC  9(04)       COMP-6.

       77 FLD0088A                       PIC  9(10)V9(12) COMP-3
           VALUE  5809468198.000283800652.
       77 FLD0088C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0089A                       PIC  9(06)V9(24) COMP-3
           VALUE  802942.222446262787727278009697.
       77 FLD0089C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0090A                       PIC S9(08)V9(02) COMP-3
           VALUE -28271627.31.
       77 FLD0090C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0091A                       PIC  9(09)V9(07) COMP-6
           VALUE  438808038.0901770.
       77 FLD0091C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0092A                       PIC S9(07)V9(01) COMP-3
           VALUE +2146587.0.
       77 FLD0092C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0093A                       PIC  9(06)V9(25) COMP-3
           VALUE  831848.6927757260396276706160278.
       77 FLD0093C                       PIC  9(07)V9(23) COMP-3.

       77 FLD0094A                       PIC  9(07)V9(01) COMP-6
           VALUE  2260698.5.
       77 FLD0094C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0095A                       PIC  9(07)V9(22) COMP-6
           VALUE  7681159.7607563408818265315858.
       77 FLD0095C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0096A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0096C                       PIC  9(05)V9(28) COMP-6.

       77 FLD0097A                       PIC  9(03)       COMP-6
           VALUE  085.
       77 FLD0097C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0098A                       PIC  9(05)V9(28) COMP-6
           VALUE  87637.1310136299430659789777564583.
       77 FLD0098C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0099A                       PIC S9(10)V9(08) COMP-3
           VALUE -4946809917.70565292.
       77 FLD0099C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0100A                       PIC  9(10)V9(09) COMP-3
           VALUE  5148281813.288457797.
       77 FLD0100C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0101A                       PIC S9(07)V9(02) COMP-3
           VALUE -2605358.58.
       77 FLD0101C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0102A                       PIC  9(05)       COMP-6
           VALUE  13880.
       77 FLD0102C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0103A                       PIC  9(03)V9(32) COMP-6
           VALUE  929.51599988912647631877916865050792.
       77 FLD0103C                       PIC  9(01)       COMP-6.

       77 FLD0104A                       PIC  9(07)V9(01) COMP-6
           VALUE  2254306.3.
       77 FLD0104C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0105A                       PIC S9(08)V9(03) COMP-3
           VALUE -29081388.428.
       77 FLD0105C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0106A                       PIC S9(02)       COMP-3
           VALUE -07.
       77 FLD0106C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0107A                       PIC  9(09)V9(16) COMP-6
           VALUE  677462443.7557797973497031.
       77 FLD0107C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0108A                       PIC  9(09)V9(14) COMP-3
           VALUE  610210882.31341436003418.
       77 FLD0108C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0109A                       PIC S9(04)       COMP-3
           VALUE +1136.
       77 FLD0109C                       PIC  9(04)V9(30) COMP-3.

       77 FLD0110A                       PIC  9(07)V9(23) COMP-3
           VALUE  7940109.55673497886841971649118.
       77 FLD0110C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0111A                       PIC  9(09)V9(03) COMP-6
           VALUE  326472185.831.
       77 FLD0111C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0112A                       PIC  9(08)V9(19) COMP-3
           VALUE  71238052.4624002697819946661.
       77 FLD0112C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0113A                       PIC  9(04)V9(30) COMP-6
           VALUE  9092.566324157485002643852567416615.
       77 FLD0113C                       PIC  9(04)       COMP-6.

       77 FLD0114A                       PIC  9(09)V9(07) COMP-6
           VALUE  437805064.1539988.
       77 FLD0114C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0115A                       PIC  9(02)V9(34) COMP-3
           VALUE  96.2362934933669089687668929400388151.
       77 FLD0115C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0116A                       PIC  9(07)V9(22) COMP-3
           VALUE  7646463.4359510952332783517704.
       77 FLD0116C                       PIC  9(01)       COMP-6.

       77 FLD0117A                       PIC  9(09)V9(14) COMP-6
           VALUE  617509561.34001855346582.
       77 FLD0117C                       PIC  9(05)       COMP-6.

       77 FLD0118A                       PIC  9(10)V9(10) COMP-3
           VALUE  5408402726.5490597358.
       77 FLD0118C                       PIC S9(03)       COMP-3.

       77 FLD0119A                       PIC S9(08)V9(03) COMP-3
           VALUE +30078875.458.
       77 FLD0119C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0120A                       PIC  9(06)V9(25) COMP-3
           VALUE  830160.1137616416714593015058198.
       77 FLD0120C                       PIC S9(02)       COMP-3.

       77 FLD0121A                       PIC S9(07)V9(01) COMP-3
           VALUE +2338292.2.
       77 FLD0121C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0122A                       PIC S9(06)V9(01) COMP-3
           VALUE -184951.8.
       77 FLD0122C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0123A                       PIC S9(02)       COMP-3
           VALUE -05.
       77 FLD0123C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0124A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0124C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0125A                       PIC  9(04)V9(29) COMP-3
           VALUE  8800.31826789913984576685379579430.
       77 FLD0125C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0126A                       PIC  9(06)V9(24) COMP-6
           VALUE  807990.071015203703552742808824.
       77 FLD0126C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0127A                       PIC  9(04)V9(30) COMP-6
           VALUE  8981.860178820127993404298649693373.
       77 FLD0127C                       PIC  9(05)V9(28) COMP-6.

       77 FLD0128A                       PIC  9(10)V9(06) COMP-6
           VALUE  4298489587.591516.
       77 FLD0128C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0129A                       PIC S9(08)V9(04) COMP-3
           VALUE +33460508.1048.
       77 FLD0129C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0130A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0130C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0131A                       PIC  9(08)V9(02) COMP-6
           VALUE  26916210.05.
       77 FLD0131C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0132A                       PIC  9(04)       COMP-6
           VALUE  1270.
       77 FLD0132C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0133A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.890353542063604619372085835493635386.
       77 FLD0133C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0134A                       PIC  9(08)V9(18) COMP-3
           VALUE  70385499.741438917187252855.
       77 FLD0134C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0135A                       PIC  9(10)V9(07) COMP-6
           VALUE  4678335500.0128495.
       77 FLD0135C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0136A                       PIC S9(05)       COMP-3
           VALUE -15169.
       77 FLD0136C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0137A                       PIC S9(08)V9(02) COMP-3
           VALUE -27190319.39.
       77 FLD0137C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0138A                       PIC S9(10)V9(08) COMP-3
           VALUE -4824223828.94490853.
       77 FLD0138C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0139A                       PIC  9(09)V9(03) COMP-6
           VALUE  319644653.394.
       77 FLD0139C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0140A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0140C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0141A                       PIC  9(09)V9(14) COMP-3
           VALUE  612266512.11346116987499.
       77 FLD0141C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0142A                       PIC  9(09)V9(04) COMP-6
           VALUE  356201246.7531.
       77 FLD0142C                       PIC S9(04)       COMP-3.

       77 FLD0143A                       PIC S9(07)V9(02) COMP-3
           VALUE -2608987.15.
       77 FLD0143C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0144A                       PIC  9(10)V9(11) COMP-6
           VALUE  5664625691.64754570216.
       77 FLD0144C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0145A                       PIC  9(09)V9(13) COMP-3
           VALUE  592809780.4295365813587.
       77 FLD0145C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0146A                       PIC S9(03)       COMP-3
           VALUE -091.
       77 FLD0146C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0147A                       PIC  9(03)       COMP-6
           VALUE  085.
       77 FLD0147C                       PIC  9(10)V9(05) COMP-6.

       77 FLD0148A                       PIC  9(04)       COMP-6
           VALUE  1189.
       77 FLD0148C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0149A                       PIC  9(05)V9(27) COMP-3
           VALUE  86469.811002464236349140946913394.
       77 FLD0149C                       PIC S9(02)       COMP-3.

       77 FLD0150A                       PIC S9(02)       COMP-3
           VALUE -06.
       77 FLD0150C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0151A                       PIC  9(09)V9(13) COMP-3
           VALUE  602633749.4884196344102.
       77 FLD0151C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0152A                       PIC S9(08)V9(02) COMP-3
           VALUE -28005400.65.
       77 FLD0152C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0153A                       PIC  9(08)V9(18) COMP-3
           VALUE  69246387.672994647033419823.
       77 FLD0153C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0154A                       PIC  9(09)V9(14) COMP-6
           VALUE  618531644.61004783714059.
       77 FLD0154C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0155A                       PIC  9(10)V9(12) COMP-3
           VALUE  5816028861.286740569980.
       77 FLD0155C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0156A                       PIC  9(02)V9(34) COMP-3
           VALUE  95.3830714078202746009083057288080453.
       77 FLD0156C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0157A                       PIC  9(09)V9(16) COMP-6
           VALUE  659745695.0483697735165833.
       77 FLD0157C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0158A                       PIC S9(09)V9(06) COMP-3
           VALUE +412656981.234114.
       77 FLD0158C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0159A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0159C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0160A                       PIC  9(08)V9(20) COMP-6
           VALUE  74656107.83998073429756914265.
       77 FLD0160C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0161A                       PIC  9(07)V9(22) COMP-6
           VALUE  7887170.9741627593626134284932.
       77 FLD0161C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0162A                       PIC S9(02)       COMP-3
           VALUE -07.
       77 FLD0162C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0163A                       PIC  9(09)V9(14) COMP-6
           VALUE  618392824.19829444403802.
       77 FLD0163C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0164A                       PIC S9(06)V9(01) COMP-3
           VALUE +204076.7.
       77 FLD0164C                       PIC  9(04)       COMP-6.

       77 FLD0165A                       PIC  9(09)V9(14) COMP-3
           VALUE  610409164.63927785695631.
       77 FLD0165C                       PIC  9(04)       COMP-6.

       77 FLD0166A                       PIC  9(07)V9(02) COMP-6
           VALUE  2460589.98.
       77 FLD0166C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0167A                       PIC S9(09)V9(03) COMP-3
           VALUE +323253458.962.
       77 FLD0167C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0168A                       PIC S9(04)       COMP-3
           VALUE +1200.
       77 FLD0168C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0169A                       PIC  9(06)V9(25) COMP-3
           VALUE  834885.7368063762329768451309064.
       77 FLD0169C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0170A                       PIC  9(08)V9(19) COMP-3
           VALUE  72325482.4666709539293663056.
       77 FLD0170C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0171A                       PIC  9(09)V9(16) COMP-6
           VALUE  675345293.4675296948086042.
       77 FLD0171C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0172A                       PIC  9(02)V9(34) COMP-3
           VALUE  96.0216523360032936373897882731398567.
       77 FLD0172C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0173A                       PIC S9(09)V9(06) COMP-3
           VALUE +412472914.336663.
       77 FLD0173C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0174A                       PIC S9(04)       COMP-3
           VALUE +1244.
       77 FLD0174C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0175A                       PIC S9(05)       COMP-3
           VALUE +13456.
       77 FLD0175C                       PIC S9(02)       COMP-3.

       77 FLD0176A                       PIC  9(07)V9(23) COMP-3
           VALUE  7902178.74582138546379894705751.
       77 FLD0176C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0177A                       PIC  9(07)V9(21) COMP-3
           VALUE  7618839.577049143496623173632.
       77 FLD0177C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0178A                       PIC  9(09)V9(04) COMP-6
           VALUE  355502105.3348.
       77 FLD0178C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0179A                       PIC  9(09)V9(05) COMP-6
           VALUE  388560564.63472.
       77 FLD0179C                       PIC  9(03)       COMP-6.

       77 FLD0180A                       PIC  9(05)V9(27) COMP-6
           VALUE  85946.157652659294079455776227405.
       77 FLD0180C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0181A                       PIC  9(06)V9(01) COMP-6
           VALUE  188908.8.
       77 FLD0181C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0182A                       PIC  9(10)V9(13) COMP-6
           VALUE  6061401860.3468300394609.
       77 FLD0182C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0183A                       PIC  9(07)V9(23) COMP-3
           VALUE  7910108.10526126539876656806882.
       77 FLD0183C                       PIC S9(02)       COMP-3.

       77 FLD0184A                       PIC  9(09)V9(15) COMP-6
           VALUE  635945742.812533687526865.
       77 FLD0184C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0185A                       PIC  9(05)       COMP-6
           VALUE  15666.
       77 FLD0185C                       PIC  9(08)V9(20) COMP-6.

       77 FLD0186A                       PIC  9(02)       COMP-6
           VALUE  07.
       77 FLD0186C                       PIC  9(05)V9(26) COMP-3.

       77 FLD0187A                       PIC  9(09)V9(13) COMP-3
           VALUE  604672028.7423602568921.
       77 FLD0187C                       PIC  9(10)V9(12) COMP-6.

       77 FLD0188A                       PIC  9(08)V9(17) COMP-3
           VALUE  68008236.87569536035724127.
       77 FLD0188C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0189A                       PIC  9(10)V9(09) COMP-3
           VALUE  5115071016.238050827.
       77 FLD0189C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0190A                       PIC  9(07)V9(02) COMP-6
           VALUE  2382137.54.
       77 FLD0190C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0191A                       PIC  9(05)       COMP-6
           VALUE  13720.
       77 FLD0191C                       PIC  9(06)V9(24) COMP-3.

       77 FLD0192A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.894259454195439840162862310535274446.
       77 FLD0192C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0193A                       PIC  9(10)V9(06) COMP-6
           VALUE  4252943677.090519.
       77 FLD0193C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0194A                       PIC  9(09)V9(06) COMP-6
           VALUE  417168379.939779.
       77 FLD0194C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0195A                       PIC  9(08)V9(02) COMP-6
           VALUE  26645846.45.
       77 FLD0195C                       PIC  9(05)       COMP-6.

       77 FLD0196A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0196C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0197A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.847788375924405590566834689525421708.
       77 FLD0197C                       PIC  9(02)       COMP-6.

       77 FLD0198A                       PIC  9(09)V9(13) COMP-3
           VALUE  593293108.5591157671643.
       77 FLD0198C                       PIC S9(05)       COMP-3.

       77 FLD0199A                       PIC  9(07)V9(02) COMP-6
           VALUE  2483287.24.
       77 FLD0199C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0200A                       PIC S9(10)V9(08) COMP-3
           VALUE -4935972790.60619176.
       77 FLD0200C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0201A                       PIC  9(04)       COMP-6
           VALUE  1282.
       77 FLD0201C                       PIC  9(07)V9(23) COMP-3.

       77 FLD0202A                       PIC S9(09)V9(04) COMP-3
           VALUE -360603443.7503.
       77 FLD0202C                       PIC  9(03)V9(32) COMP-6.

       77 FLD0203A                       PIC  9(09)V9(14) COMP-6
           VALUE  628607663.38264040253847.
       77 FLD0203C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0204A                       PIC  9(01)V9(35) COMP-3
           VALUE  9.73054030732718233664968465745914727.
       77 FLD0204C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0205A                       PIC  9(09)V9(15) COMP-6
           VALUE  648926914.508991536933990.
       77 FLD0205C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0206A                       PIC  9(06)V9(01) COMP-6
           VALUE  186967.7.
       77 FLD0206C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0207A                       PIC  9(05)V9(26) COMP-6
           VALUE  83944.39242287422553445708217623.
       77 FLD0207C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0208A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7940040016311842308027735271025449.
       77 FLD0208C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0209A                       PIC  9(03)V9(32) COMP-6
           VALUE  926.61149050802726900855077474261634.
       77 FLD0209C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0210A                       PIC  9(08)V9(19) COMP-3
           VALUE  72323528.1456575562764044207.
       77 FLD0210C                       PIC  9(01)       COMP-6.

       77 FLD0211A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0211C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0212A                       PIC  9(10)V9(08) COMP-6
           VALUE  4892032792.55731038.
       77 FLD0212C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0213A                       PIC S9(03)       COMP-3
           VALUE -082.
       77 FLD0213C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0214A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0214C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0215A                       PIC  9(03)V9(32) COMP-6
           VALUE  926.34033699271633999217101518297567.
       77 FLD0215C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0216A                       PIC S9(08)V9(02) COMP-3
           VALUE -28095374.87.
       77 FLD0216C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0217A                       PIC  9(08)V9(20) COMP-6
           VALUE  74562962.48658396130792880285.
       77 FLD0217C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0218A                       PIC S9(05)V9(01) COMP-3
           VALUE -18094.6.
       77 FLD0218C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0219A                       PIC  9(09)V9(12) COMP-6
           VALUE  578788992.127507229135.
       77 FLD0219C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0220A                       PIC  9(09)V9(12) COMP-3
           VALUE  573343525.907533679841.
       77 FLD0220C                       PIC S9(05)       COMP-3.

       77 FLD0221A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0221C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0222A                       PIC  9(09)V9(14) COMP-6
           VALUE  628182805.25174396977661.
       77 FLD0222C                       PIC S9(05)       COMP-3.

       77 FLD0223A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0223C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0224A                       PIC  9(06)V9(25) COMP-6
           VALUE  838187.2267509891116787912324070.
       77 FLD0224C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0225A                       PIC  9(05)       COMP-6
           VALUE  13797.
       77 FLD0225C                       PIC  9(09)V9(12) COMP-3.

       77 FLD0226A                       PIC  9(05)       COMP-6
           VALUE  14900.
       77 FLD0226C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0227A                       PIC  9(09)V9(14) COMP-6
           VALUE  629583055.15940859997670.
       77 FLD0227C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0228A                       PIC S9(07)V9(01) COMP-3
           VALUE +2225916.3.
       77 FLD0228C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0229A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.870473603260505601753038718015886843.
       77 FLD0229C                       PIC  9(08)V9(20) COMP-6.

       77 FLD0230A                       PIC S9(06)V9(01) COMP-3
           VALUE +201492.2.
       77 FLD0230C                       PIC S9(02)       COMP-3.

       77 FLD0231A                       PIC  9(05)V9(28) COMP-6
           VALUE  87781.6812716511907233041256404248.
       77 FLD0231C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0232A                       PIC  9(09)V9(04) COMP-6
           VALUE  356308264.5328.
       77 FLD0232C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0233A                       PIC  9(07)V9(21) COMP-6
           VALUE  7552156.809035388551620826547.
       77 FLD0233C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0234A                       PIC  9(08)V9(04) COMP-6
           VALUE  33831052.6754.
       77 FLD0234C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0235A                       PIC S9(05)       COMP-3
           VALUE +14123.
       77 FLD0235C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0236A                       PIC  9(04)V9(29) COMP-3
           VALUE  8818.23528289915170574886360554955.
       77 FLD0236C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0237A                       PIC  9(08)V9(02) COMP-6
           VALUE  28742037.59.
       77 FLD0237C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0238A                       PIC  9(09)V9(15) COMP-3
           VALUE  634521096.430120334908053.
       77 FLD0238C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0239A                       PIC  9(09)V9(16) COMP-6
           VALUE  678585779.2924817610824561.
       77 FLD0239C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0240A                       PIC  9(10)V9(06) COMP-6
           VALUE  4289853576.446766.
       77 FLD0240C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0241A                       PIC S9(05)       COMP-3
           VALUE +14407.
       77 FLD0241C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0242A                       PIC  9(10)V9(12) COMP-6
           VALUE  5860383854.989427154791.
       77 FLD0242C                       PIC S9(06)V9(01) COMP-3.

       77 FLD0243A                       PIC  9(02)V9(34) COMP-3
           VALUE  97.0409660969254295181940506154205650.
       77 FLD0243C                       PIC  9(05)V9(28) COMP-6.

       77 FLD0244A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0244C                       PIC  9(09)V9(13) COMP-6.

       77 FLD0245A                       PIC S9(09)V9(05) COMP-3
           VALUE -371716886.14542.
       77 FLD0245C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0246A                       PIC  9(05)V9(28) COMP-3
           VALUE  87216.9313623637143528810611314838.
       77 FLD0246C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0247A                       PIC  9(06)V9(25) COMP-3
           VALUE  834494.8214770686600871840710169.
       77 FLD0247C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0248A                       PIC  9(04)V9(29) COMP-6
           VALUE  8885.56418584546814365410227765096.
       77 FLD0248C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0249A                       PIC  9(09)V9(16) COMP-6
           VALUE  678470839.5950102000071524.
       77 FLD0249C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0250A                       PIC  9(09)V9(15) COMP-3
           VALUE  643468324.926731005675151.
       77 FLD0250C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0251A                       PIC S9(09)V9(06) COMP-3
           VALUE +402548910.007195.
       77 FLD0251C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0252A                       PIC S9(05)V9(01) COMP-3
           VALUE -18339.3.
       77 FLD0252C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0253A                       PIC  9(06)V9(25) COMP-3
           VALUE  822593.8518184680026124055984837.
       77 FLD0253C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0254A                       PIC  9(10)V9(10) COMP-3
           VALUE  5401895692.3872574193.
       77 FLD0254C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0255A                       PIC  9(02)V9(34) COMP-6
           VALUE  94.8299297085154591080424779647728428.
       77 FLD0255C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0256A                       PIC S9(09)V9(08) COMP-3
           VALUE -473179644.06591722.
       77 FLD0256C                       PIC  9(04)V9(30) COMP-3.

       77 FLD0257A                       PIC  9(09)V9(12) COMP-6
           VALUE  577029491.737192756772.
       77 FLD0257C                       PIC S9(03)       COMP-3.

       77 FLD0258A                       PIC  9(10)V9(12) COMP-3
           VALUE  5908893351.960881057394.
       77 FLD0258C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0259A                       PIC  9(03)V9(32) COMP-6
           VALUE  937.55337057593879368511124994256533.
       77 FLD0259C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0260A                       PIC  9(05)V9(27) COMP-6
           VALUE  86648.984966754782899300835197209.
       77 FLD0260C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0261A                       PIC S9(09)V9(05) COMP-3
           VALUE -374213925.47904.
       77 FLD0261C                       PIC  9(09)V9(05) COMP-6.

       77 FLD0262A                       PIC S9(05)V9(01) COMP-3
           VALUE -17015.9.
       77 FLD0262C                       PIC  9(09)V9(17) COMP-6.

       77 FLD0263A                       PIC  9(05)V9(26) COMP-3
           VALUE  84046.29767805690265802809335582.
       77 FLD0263C                       PIC S9(02)       COMP-3.

       77 FLD0264A                       PIC  9(03)V9(32) COMP-6
           VALUE  935.78568596491340514376133796758949.
       77 FLD0264C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0265A                       PIC S9(09)V9(05) COMP-3
           VALUE -380334582.15301.
       77 FLD0265C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0266A                       PIC  9(05)V9(27) COMP-6
           VALUE  84707.693570856212872399737534578.
       77 FLD0266C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0267A                       PIC  9(03)       COMP-6
           VALUE  087.
       77 FLD0267C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0268A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0268C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0269A                       PIC  9(08)V9(18) COMP-6
           VALUE  69955495.182247551255727557.
       77 FLD0269C                       PIC  9(01)       COMP-6.

       77 FLD0270A                       PIC  9(08)V9(18) COMP-6
           VALUE  69584936.933990082508216801.
       77 FLD0270C                       PIC S9(04)       COMP-3.

       77 FLD0271A                       PIC  9(10)V9(07) COMP-6
           VALUE  4478155927.4435323.
       77 FLD0271C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0272A                       PIC S9(09)V9(06) COMP-3
           VALUE +411514667.070764.
       77 FLD0272C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0273A                       PIC  9(10)V9(07) COMP-6
           VALUE  4698099460.5024867.
       77 FLD0273C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0274A                       PIC  9(07)V9(01) COMP-6
           VALUE  2190249.4.
       77 FLD0274C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0275A                       PIC  9(04)       COMP-6
           VALUE  1157.
       77 FLD0275C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0276A                       PIC  9(04)V9(30) COMP-3
           VALUE  9021.044697283423507983002309629227.
       77 FLD0276C                       PIC  9(02)V9(33) COMP-6.

       77 FLD0277A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.749582162084949876756923003995325416.
       77 FLD0277C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0278A                       PIC  9(10)V9(06) COMP-6
           VALUE  4251062706.993476.
       77 FLD0278C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0279A                       PIC S9(08)V9(02) COMP-3
           VALUE -27159201.10.
       77 FLD0279C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0280A                       PIC  9(07)V9(02) COMP-6
           VALUE  2571968.92.
       77 FLD0280C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0281A                       PIC S9(09)V9(04) COMP-3
           VALUE +342861689.3811.
       77 FLD0281C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0282A                       PIC S9(10)V9(07) COMP-3
           VALUE -4600147325.4430291.
       77 FLD0282C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0283A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0283C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0284A                       PIC  9(09)V9(17) COMP-6
           VALUE  689733171.20512533939802324.
       77 FLD0284C                       PIC  9(01)       COMP-6.

       77 FLD0285A                       PIC  9(03)V9(32) COMP-6
           VALUE  928.78828230193799520009179104818031.
       77 FLD0285C                       PIC  9(08)V9(20) COMP-6.

       77 FLD0286A                       PIC  9(08)V9(18) COMP-3
           VALUE  70426964.322731444578806758.
       77 FLD0286C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0287A                       PIC S9(07)V9(02) COMP-3
           VALUE -2521413.84.
       77 FLD0287C                       PIC  9(06)       COMP-6.

       77 FLD0288A                       PIC  9(09)V9(17) COMP-6
           VALUE  688074525.02240640246355951.
       77 FLD0288C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0289A                       PIC S9(03)       COMP-3
           VALUE -092.
       77 FLD0289C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0290A                       PIC S9(09)V9(05) COMP-3
           VALUE -382951207.35442.
       77 FLD0290C                       PIC S9(03)       COMP-3.

       77 FLD0291A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.859384124391753490002088256005663424.
       77 FLD0291C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0292A                       PIC S9(08)V9(03) COMP-3
           VALUE +31020519.916.
       77 FLD0292C                       PIC  9(01)       COMP-6.

       77 FLD0293A                       PIC S9(03)       COMP-3
           VALUE -093.
       77 FLD0293C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0294A                       PIC S9(09)V9(06) COMP-3
           VALUE +412445339.504106.
       77 FLD0294C                       PIC  9(01)       COMP-6.

       77 FLD0295A                       PIC S9(07)V9(02) COMP-3
           VALUE -2502548.06.
       77 FLD0295C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0296A                       PIC S9(06)       COMP-3
           VALUE -160918.
       77 FLD0296C                       PIC  9(09)V9(12) COMP-3.

       77 FLD0297A                       PIC  9(08)V9(03) COMP-6
           VALUE  30843552.269.
       77 FLD0297C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0298A                       PIC S9(10)V9(08) COMP-3
           VALUE -4831587379.88150510.
       77 FLD0298C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0299A                       PIC  9(10)V9(13) COMP-6
           VALUE  6064872573.5835784522720.
       77 FLD0299C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0300A                       PIC  9(08)V9(20) COMP-6
           VALUE  73956142.30661028409841151187.
       77 FLD0300C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0301A                       PIC S9(10)V9(07) COMP-3
           VALUE -4524568495.0704084.
       77 FLD0301C                       PIC S9(01)       COMP-3.

       77 FLD0302A                       PIC  9(02)V9(34) COMP-6
           VALUE  94.9764690231816866017311440373305231.
       77 FLD0302C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0303A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.998247249142951931233369577967096120.
       77 FLD0303C                       PIC  9(01)       COMP-6.

       77 FLD0304A                       PIC S9(03)       COMP-3
           VALUE -083.
       77 FLD0304C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0305A                       PIC  9(09)V9(03) COMP-6
           VALUE  328435884.788.
       77 FLD0305C                       PIC S9(01)       COMP-3.

       77 FLD0306A                       PIC S9(03)       COMP-3
           VALUE -083.
       77 FLD0306C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0307A                       PIC  9(10)V9(10) COMP-3
           VALUE  5430567751.9659767416.
       77 FLD0307C                       PIC  9(03)V9(32) COMP-6.

       77 FLD0308A                       PIC  9(09)V9(05) COMP-6
           VALUE  377189267.62120.
       77 FLD0308C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0309A                       PIC  9(09)V9(03) COMP-6
           VALUE  325461096.612.
       77 FLD0309C                       PIC S9(03)       COMP-3.

       77 FLD0310A                       PIC  9(09)V9(05) COMP-6
           VALUE  377541451.37210.
       77 FLD0310C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0311A                       PIC S9(02)       COMP-3
           VALUE -06.
       77 FLD0311C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0312A                       PIC S9(10)V9(07) COMP-3
           VALUE -4631183834.9707568.
       77 FLD0312C                       PIC  9(01)       COMP-6.

       77 FLD0313A                       PIC  9(05)V9(27) COMP-3
           VALUE  86493.365621715367907995641871821.
       77 FLD0313C                       PIC  9(09)V9(05) COMP-6.

       77 FLD0314A                       PIC  9(03)       COMP-6
           VALUE  088.
       77 FLD0314C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0315A                       PIC  9(07)V9(23) COMP-3
           VALUE  7933336.74589681625555215305212.
       77 FLD0315C                       PIC  9(09)V9(17) COMP-6.

       77 FLD0316A                       PIC  9(06)V9(01) COMP-6
           VALUE  195827.4.
       77 FLD0316C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0317A                       PIC  9(10)V9(08) COMP-6
           VALUE  4983225307.65216153.
       77 FLD0317C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0318A                       PIC  9(08)V9(02) COMP-6
           VALUE  26926374.69.
       77 FLD0318C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0319A                       PIC  9(08)V9(18) COMP-6
           VALUE  69931441.978879860243978328.
       77 FLD0319C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0320A                       PIC  9(08)V9(19) COMP-6
           VALUE  71973495.8824565840274090078.
       77 FLD0320C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0321A                       PIC  9(10)V9(09) COMP-3
           VALUE  5005504874.853489161.
       77 FLD0321C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0322A                       PIC S9(09)V9(07) COMP-3
           VALUE +442005310.2249054.
       77 FLD0322C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0323A                       PIC S9(05)       COMP-3
           VALUE -15097.
       77 FLD0323C                       PIC  9(01)V9(35) COMP-3.

       77 FLD0324A                       PIC  9(10)V9(11) COMP-3
           VALUE  5601604504.75820970162.
       77 FLD0324C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0325A                       PIC  9(04)       COMP-6
           VALUE  1169.
       77 FLD0325C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0326A                       PIC S9(08)V9(03) COMP-3
           VALUE +31312044.720.
       77 FLD0326C                       PIC S9(02)       COMP-3.

       77 FLD0327A                       PIC S9(03)       COMP-3
           VALUE -090.
       77 FLD0327C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0328A                       PIC  9(08)V9(19) COMP-3
           VALUE  71147504.7716873310044150002.
       77 FLD0328C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0329A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0329C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0330A                       PIC  9(09)V9(07) COMP-6
           VALUE  445280746.1581723.
       77 FLD0330C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0331A                       PIC S9(07)V9(01) COMP-3
           VALUE +2232816.8.
       77 FLD0331C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0332A                       PIC  9(05)V9(27) COMP-6
           VALUE  86562.988696340348315771962006692.
       77 FLD0332C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0333A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.6494138775326296908474432711955159.
       77 FLD0333C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0334A                       PIC  9(08)V9(03) COMP-6
           VALUE  28999492.466.
       77 FLD0334C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0335A                       PIC S9(08)V9(03) COMP-3
           VALUE +30334218.791.
       77 FLD0335C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0336A                       PIC  9(05)V9(27) COMP-6
           VALUE  85800.255545984371874368434873758.
       77 FLD0336C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0337A                       PIC  9(08)V9(19) COMP-3
           VALUE  72003996.5448931451597047725.
       77 FLD0337C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0338A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0338C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0339A                       PIC S9(06)       COMP-3
           VALUE -160552.
       77 FLD0339C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0340A                       PIC  9(10)V9(09) COMP-3
           VALUE  5028381651.473269320.
       77 FLD0340C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0341A                       PIC  9(10)V9(11) COMP-6
           VALUE  5676316159.01010966318.
       77 FLD0341C                       PIC  9(09)V9(12) COMP-3.

       77 FLD0342A                       PIC S9(07)V9(01) COMP-3
           VALUE +2347143.0.
       77 FLD0342C                       PIC S9(10)V9(07) COMP-3.

       77 FLD0343A                       PIC  9(08)V9(19) COMP-6
           VALUE  72866356.1504289902792663724.
       77 FLD0343C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0344A                       PIC  9(09)V9(07) COMP-6
           VALUE  439744878.9947105.
       77 FLD0344C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0345A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0345C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0346A                       PIC  9(07)V9(22) COMP-3
           VALUE  7807860.0333687642187641131386.
       77 FLD0346C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0347A                       PIC  9(08)V9(18) COMP-3
           VALUE  70165985.253748408556617732.
       77 FLD0347C                       PIC  9(06)       COMP-6.

       77 FLD0348A                       PIC  9(08)V9(04) COMP-6
           VALUE  33778742.7133.
       77 FLD0348C                       PIC  9(09)V9(12) COMP-6.

       77 FLD0349A                       PIC  9(10)V9(09) COMP-3
           VALUE  5122785066.779668161.
       77 FLD0349C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0350A                       PIC  9(02)       COMP-6
           VALUE  07.
       77 FLD0350C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0351A                       PIC  9(05)V9(27) COMP-6
           VALUE  84942.576912519174303639601930626.
       77 FLD0351C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0352A                       PIC  9(03)V9(32) COMP-6
           VALUE  937.88592938035042489985926295048557.
       77 FLD0352C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0353A                       PIC S9(07)V9(02) COMP-3
           VALUE -2544588.73.
       77 FLD0353C                       PIC  9(02)V9(33) COMP-3.

       77 FLD0354A                       PIC  9(07)V9(01) COMP-6
           VALUE  2152460.4.
       77 FLD0354C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0355A                       PIC  9(06)V9(01) COMP-6
           VALUE  208715.4.
       77 FLD0355C                       PIC S9(05)       COMP-3.

       77 FLD0356A                       PIC S9(09)V9(05) COMP-3
           VALUE -391398983.37050.
       77 FLD0356C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0357A                       PIC  9(10)V9(10) COMP-3
           VALUE  5323345989.0667944591.
       77 FLD0357C                       PIC  9(03)       COMP-6.

       77 FLD0358A                       PIC  9(08)V9(03) COMP-6
           VALUE  29848403.943.
       77 FLD0358C                       PIC  9(09)V9(17) COMP-6.

       77 FLD0359A                       PIC  9(07)V9(22) COMP-6
           VALUE  7654789.5985185210321333215688.
       77 FLD0359C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0360A                       PIC S9(09)V9(06) COMP-3
           VALUE +400277612.276280.
       77 FLD0360C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0361A                       PIC  9(06)V9(25) COMP-3
           VALUE  823089.8044061112361902132761315.
       77 FLD0361C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0362A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0362C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0363A                       PIC  9(09)V9(04) COMP-6
           VALUE  358575926.2078.
       77 FLD0363C                       PIC  9(04)V9(30) COMP-3.

       77 FLD0364A                       PIC S9(04)       COMP-3
           VALUE +1234.
       77 FLD0364C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0365A                       PIC  9(09)V9(11) COMP-3
           VALUE  551967009.62472056151.
       77 FLD0365C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0366A                       PIC  9(06)V9(25) COMP-3
           VALUE  822414.3642778768414913770357088.
       77 FLD0366C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0367A                       PIC  9(09)V9(13) COMP-6
           VALUE  595975436.9256639039420.
       77 FLD0367C                       PIC S9(06)V9(01) COMP-3.

       77 FLD0368A                       PIC  9(05)       COMP-6
           VALUE  15663.
       77 FLD0368C                       PIC  9(01)       COMP-6.

       77 FLD0369A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0369C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0370A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0370C                       PIC S9(01)       COMP-3.

       77 FLD0371A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0371C                       PIC S9(03)       COMP-3.

       77 FLD0372A                       PIC  9(10)V9(09) COMP-6
           VALUE  5067586024.551302692.
       77 FLD0372C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0373A                       PIC  9(09)V9(16) COMP-3
           VALUE  660730415.8912360447786227.
       77 FLD0373C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0374A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0374C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0375A                       PIC  9(07)V9(22) COMP-3
           VALUE  7816763.9605777072819847717255.
       77 FLD0375C                       PIC  9(01)       COMP-6.

       77 FLD0376A                       PIC  9(05)V9(27) COMP-6
           VALUE  84980.958923270843996533585595898.
       77 FLD0376C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0377A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7759547981370871205797357106348499.
       77 FLD0377C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0378A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0378C                       PIC S9(06)       COMP-3.

       77 FLD0379A                       PIC  9(10)V9(10) COMP-6
           VALUE  5351160784.1302399890.
       77 FLD0379C                       PIC  9(01)       COMP-6.

       77 FLD0380A                       PIC  9(09)V9(03) COMP-6
           VALUE  318886259.138.
       77 FLD0380C                       PIC S9(01)       COMP-3.

       77 FLD0381A                       PIC  9(10)V9(09) COMP-6
           VALUE  5188977124.912377281.
       77 FLD0381C                       PIC  9(03)       COMP-6.

       77 FLD0382A                       PIC  9(10)V9(10) COMP-6
           VALUE  5469463185.9002762475.
       77 FLD0382C                       PIC  9(04)       COMP-6.

       77 FLD0383A                       PIC  9(04)V9(29) COMP-3
           VALUE  8846.28028341020278269013488170458.
       77 FLD0383C                       PIC  9(06)V9(24) COMP-3.

       77 FLD0384A                       PIC S9(07)V9(02) COMP-3
           VALUE +2410021.83.
       77 FLD0384C                       PIC  9(01)       COMP-6.

       77 FLD0385A                       PIC  9(09)V9(14) COMP-6
           VALUE  616198826.41569234671408.
       77 FLD0385C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0386A                       PIC  9(10)V9(11) COMP-6
           VALUE  5671006446.22052230126.
       77 FLD0386C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0387A                       PIC  9(08)V9(03) COMP-6
           VALUE  30516405.931.
       77 FLD0387C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0388A                       PIC  9(10)V9(11) COMP-6
           VALUE  5691303425.20841603359.
       77 FLD0388C                       PIC  9(03)       COMP-6.

       77 FLD0389A                       PIC S9(10)V9(06) COMP-3
           VALUE +4300560615.719126.
       77 FLD0389C                       PIC  9(10)V9(12) COMP-6.

       77 FLD0390A                       PIC S9(02)       COMP-3
           VALUE -07.
       77 FLD0390C                       PIC  9(03)       COMP-6.

       77 FLD0391A                       PIC S9(08)V9(03) COMP-3
           VALUE +30066642.536.
       77 FLD0391C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0392A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.7627258628673261320329856971511617.
       77 FLD0392C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0393A                       PIC  9(02)       COMP-6
           VALUE  05.
       77 FLD0393C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0394A                       PIC  9(05)V9(01) COMP-6
           VALUE  16807.8.
       77 FLD0394C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0395A                       PIC  9(10)V9(09) COMP-3
           VALUE  5206691882.901124390.
       77 FLD0395C                       PIC S9(01)       COMP-3.

       77 FLD0396A                       PIC  9(09)V9(06) COMP-6
           VALUE  419939827.280791.
       77 FLD0396C                       PIC  9(09)V9(07) COMP-6.

       77 FLD0397A                       PIC  9(05)V9(27) COMP-6
           VALUE  85569.982924983467587054519754019.
       77 FLD0397C                       PIC S9(02)       COMP-3.

       77 FLD0398A                       PIC  9(05)V9(26) COMP-3
           VALUE  84110.85692078776876456913669244.
       77 FLD0398C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0399A                       PIC  9(05)V9(27) COMP-3
           VALUE  86215.377080746946614198122915695.
       77 FLD0399C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0400A                       PIC  9(10)V9(08) COMP-6
           VALUE  4880703034.67910082.
       77 FLD0400C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0401A                       PIC  9(08)V9(03) COMP-6
           VALUE  30757829.425.
       77 FLD0401C                       PIC  9(01)       COMP-6.

       77 FLD0402A                       PIC  9(04)V9(29) COMP-3
           VALUE  8843.41306989221531686951038864208.
       77 FLD0402C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0403A                       PIC  9(10)V9(10) COMP-6
           VALUE  5351391185.2119278034.
       77 FLD0403C                       PIC  9(03)V9(32) COMP-6.

       77 FLD0404A                       PIC S9(10)V9(08) COMP-3
           VALUE -4810592903.51378177.
       77 FLD0404C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0405A                       PIC S9(09)V9(04) COMP-3
           VALUE -360620744.0007.
       77 FLD0405C                       PIC S9(05)       COMP-3.

       77 FLD0406A                       PIC S9(07)V9(02) COMP-3
           VALUE -2503018.94.
       77 FLD0406C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0407A                       PIC  9(09)V9(13) COMP-3
           VALUE  592634898.8738083800598.
       77 FLD0407C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0408A                       PIC  9(09)V9(07) COMP-6
           VALUE  438100099.1119252.
       77 FLD0408C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0409A                       PIC  9(08)V9(02) COMP-6
           VALUE  28575188.65.
       77 FLD0409C                       PIC  9(09)V9(12) COMP-6.

       77 FLD0410A                       PIC  9(09)V9(14) COMP-6
           VALUE  615937928.60877261130525.
       77 FLD0410C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0411A                       PIC  9(09)V9(17) COMP-6
           VALUE  688573322.26995748847286904.
       77 FLD0411C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0412A                       PIC  9(09)V9(12) COMP-3
           VALUE  572677017.522024045526.
       77 FLD0412C                       PIC S9(01)       COMP-3.

       77 FLD0413A                       PIC  9(06)V9(25) COMP-6
           VALUE  828822.6462986850728853482905833.
       77 FLD0413C                       PIC S9(01)       COMP-3.

       77 FLD0414A                       PIC  9(05)V9(27) COMP-3
           VALUE  84413.303017262042438062508153961.
       77 FLD0414C                       PIC S9(05)       COMP-3.

       77 FLD0415A                       PIC  9(09)V9(15) COMP-3
           VALUE  650722988.227690701812377.
       77 FLD0415C                       PIC  9(03)V9(31) COMP-6.

       77 FLD0416A                       PIC  9(09)V9(16) COMP-6
           VALUE  675584038.8269652718733482.
       77 FLD0416C                       PIC S9(01)       COMP-3.

       77 FLD0417A                       PIC  9(03)V9(32) COMP-3
           VALUE  942.59186417160190085695603556814603.
       77 FLD0417C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0418A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0418C                       PIC  9(01)       COMP-6.

       77 FLD0419A                       PIC  9(09)V9(06) COMP-6
           VALUE  415695619.544491.
       77 FLD0419C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0420A                       PIC  9(08)V9(02) COMP-6
           VALUE  26881191.37.
       77 FLD0420C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0421A                       PIC  9(08)V9(19) COMP-3
           VALUE  71124707.9077118260492795798.
       77 FLD0421C                       PIC S9(06)V9(01) COMP-3.

       77 FLD0422A                       PIC  9(08)V9(18) COMP-3
           VALUE  69276472.004700051510184266.
       77 FLD0422C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0423A                       PIC  9(09)V9(13) COMP-6
           VALUE  595417774.2919815052857.
       77 FLD0423C                       PIC  9(09)V9(17) COMP-6.

       77 FLD0424A                       PIC  9(09)V9(11) COMP-3
           VALUE  551151541.59885582085.
       77 FLD0424C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0425A                       PIC S9(10)V9(08) COMP-3
           VALUE -4741628720.81754727.
       77 FLD0425C                       PIC  9(10)V9(12) COMP-3.

       77 FLD0426A                       PIC  9(10)V9(11) COMP-3
           VALUE  5601456695.80725313885.
       77 FLD0426C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0427A                       PIC  9(09)V9(04) COMP-6
           VALUE  365284621.5641.
       77 FLD0427C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0428A                       PIC  9(05)V9(27) COMP-6
           VALUE  85913.234918316627730661139139556.
       77 FLD0428C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0429A                       PIC  9(07)V9(22) COMP-3
           VALUE  7833347.6062909002113343603923.
       77 FLD0429C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0430A                       PIC  9(08)V9(03) COMP-6
           VALUE  30820998.502.
       77 FLD0430C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0431A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0431C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0432A                       PIC  9(10)V9(11) COMP-3
           VALUE  5612307034.00538710745.
       77 FLD0432C                       PIC S9(06)       COMP-3.

       77 FLD0433A                       PIC  9(08)V9(19) COMP-3
           VALUE  72012955.8244768763763943297.
       77 FLD0433C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0434A                       PIC S9(10)V9(07) COMP-3
           VALUE -4547054675.3415619.
       77 FLD0434C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0435A                       PIC  9(03)       COMP-6
           VALUE  087.
       77 FLD0435C                       PIC  9(10)V9(12) COMP-3.

       77 FLD0436A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0436C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0437A                       PIC  9(09)V9(15) COMP-3
           VALUE  632897272.198471361193128.
       77 FLD0437C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0438A                       PIC  9(09)V9(16) COMP-3
           VALUE  664694021.6365745390802999.
       77 FLD0438C                       PIC  9(05)V9(28) COMP-3.

       77 FLD0439A                       PIC  9(10)V9(08) COMP-6
           VALUE  4961134805.43429519.
       77 FLD0439C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0440A                       PIC  9(04)V9(29) COMP-6
           VALUE  8899.07507055040514210020319296745.
       77 FLD0440C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0441A                       PIC  9(08)V9(19) COMP-3
           VALUE  71126905.4406556744396539215.
       77 FLD0441C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0442A                       PIC  9(05)V9(01) COMP-6
           VALUE  16995.1.
       77 FLD0442C                       PIC  9(03)V9(31) COMP-6.

       77 FLD0443A                       PIC S9(10)V9(08) COMP-3
           VALUE -4744984255.46487689.
       77 FLD0443C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0444A                       PIC  9(02)V9(33) COMP-6
           VALUE  94.673816662087151296844922399031929.
       77 FLD0444C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0445A                       PIC  9(10)V9(10) COMP-3
           VALUE  5416554544.5299512206.
       77 FLD0445C                       PIC S9(10)V9(07) COMP-3.

       77 FLD0446A                       PIC  9(10)V9(09) COMP-3
           VALUE  5044897846.697211640.
       77 FLD0446C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0447A                       PIC  9(02)       COMP-6
           VALUE  06.
       77 FLD0447C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0448A                       PIC  9(06)V9(01) COMP-6
           VALUE  186565.4.
       77 FLD0448C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0449A                       PIC S9(09)V9(05) COMP-3
           VALUE -384988094.18704.
       77 FLD0449C                       PIC S9(08)V9(04) COMP-3.

       77 FLD0450A                       PIC  9(09)V9(14) COMP-6
           VALUE  625578375.50228334588808.
       77 FLD0450C                       PIC  9(09)V9(13) COMP-6.

       77 FLD0451A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0451C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0452A                       PIC  9(08)V9(02) COMP-6
           VALUE  26826484.18.
       77 FLD0452C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0453A                       PIC  9(10)V9(10) COMP-6
           VALUE  5383526546.5392911909.
       77 FLD0453C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0454A                       PIC S9(03)       COMP-3
           VALUE -090.
       77 FLD0454C                       PIC S9(01)       COMP-3.

       77 FLD0455A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0455C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0456A                       PIC S9(03)       COMP-3
           VALUE -093.
       77 FLD0456C                       PIC  9(05)       COMP-6.

       77 FLD0457A                       PIC  9(04)V9(30) COMP-6
           VALUE  9063.641671624598217249513254500925.
       77 FLD0457C                       PIC  9(01)       COMP-6.

       77 FLD0458A                       PIC  9(02)       COMP-6
           VALUE  06.
       77 FLD0458C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0459A                       PIC  9(06)V9(01) COMP-6
           VALUE  198479.9.
       77 FLD0459C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0460A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0460C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0461A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0461C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0462A                       PIC  9(08)V9(02) COMP-6
           VALUE  26776595.69.
       77 FLD0462C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0463A                       PIC  9(05)V9(27) COMP-3
           VALUE  85490.666934027292889197724434779.
       77 FLD0463C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0464A                       PIC  9(10)V9(07) COMP-6
           VALUE  4587031190.3834293.
       77 FLD0464C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0465A                       PIC  9(10)V9(12) COMP-3
           VALUE  5816563985.597106301028.
       77 FLD0465C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0466A                       PIC  9(09)V9(15) COMP-3
           VALUE  654381306.333900236715805.
       77 FLD0466C                       PIC  9(05)       COMP-6.

       77 FLD0467A                       PIC S9(07)V9(01) COMP-3
           VALUE +2343287.0.
       77 FLD0467C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0468A                       PIC S9(10)V9(06) COMP-3
           VALUE +4344132145.767680.
       77 FLD0468C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0469A                       PIC  9(08)V9(18) COMP-6
           VALUE  70961503.876956555370014712.
       77 FLD0469C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0470A                       PIC  9(03)V9(31) COMP-3
           VALUE  913.6810028966669827710234130790922.
       77 FLD0470C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0471A                       PIC S9(07)V9(02) COMP-3
           VALUE -2507103.69.
       77 FLD0471C                       PIC  9(01)       COMP-6.

       77 FLD0472A                       PIC  9(10)V9(09) COMP-3
           VALUE  5103990869.050332168.
       77 FLD0472C                       PIC  9(06)V9(26) COMP-3.

       77 FLD0473A                       PIC  9(08)V9(20) COMP-3
           VALUE  74367162.06805468187823748849.
       77 FLD0473C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0474A                       PIC  9(08)V9(19) COMP-6
           VALUE  72625744.5118117406224200749.
       77 FLD0474C                       PIC S9(05)       COMP-3.

       77 FLD0475A                       PIC  9(10)V9(07) COMP-6
           VALUE  4588724634.2999971.
       77 FLD0475C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0476A                       PIC  9(08)V9(02) COMP-6
           VALUE  28869933.49.
       77 FLD0476C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0477A                       PIC  9(08)V9(20) COMP-3
           VALUE  74492482.99155191155307420558.
       77 FLD0477C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0478A                       PIC  9(08)V9(19) COMP-6
           VALUE  72616162.5751895356550846827.
       77 FLD0478C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0479A                       PIC S9(09)V9(06) COMP-3
           VALUE +413502052.896697.
       77 FLD0479C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0480A                       PIC S9(06)V9(01) COMP-3
           VALUE +203017.8.
       77 FLD0480C                       PIC  9(08)V9(20) COMP-6.

       77 FLD0481A                       PIC  9(05)       COMP-6
           VALUE  15658.
       77 FLD0481C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0482A                       PIC  9(08)V9(18) COMP-6
           VALUE  70905037.950447225014727337.
       77 FLD0482C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0483A                       PIC  9(03)       COMP-6
           VALUE  079.
       77 FLD0483C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0484A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0484C                       PIC  9(09)V9(12) COMP-6.

       77 FLD0485A                       PIC  9(07)V9(02) COMP-6
           VALUE  2567572.97.
       77 FLD0485C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0486A                       PIC  9(05)       COMP-6
           VALUE  13937.
       77 FLD0486C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0487A                       PIC  9(06)V9(01) COMP-6
           VALUE  209384.2.
       77 FLD0487C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0488A                       PIC S9(10)V9(07) COMP-3
           VALUE -4519198906.7966076.
       77 FLD0488C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0489A                       PIC S9(05)V9(01) COMP-3
           VALUE -17360.6.
       77 FLD0489C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0490A                       PIC  9(10)V9(10) COMP-6
           VALUE  5352566580.2623056954.
       77 FLD0490C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0491A                       PIC  9(03)V9(31) COMP-6
           VALUE  918.2459205467069507378141679510008.
       77 FLD0491C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0492A                       PIC  9(06)V9(25) COMP-6
           VALUE  819266.4570447540928199714471702.
       77 FLD0492C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0493A                       PIC S9(05)V9(01) COMP-3
           VALUE -18038.5.
       77 FLD0493C                       PIC  9(06)V9(24) COMP-6.

       77 FLD0494A                       PIC  9(05)V9(28) COMP-6
           VALUE  87574.5417791477964719604187848744.
       77 FLD0494C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0495A                       PIC S9(02)       COMP-3
           VALUE -05.
       77 FLD0495C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0496A                       PIC  9(06)V9(25) COMP-6
           VALUE  816763.6415427422802437718019064.
       77 FLD0496C                       PIC S9(04)       COMP-3.

       77 FLD0497A                       PIC  9(06)V9(25) COMP-6
           VALUE  836230.6435874340415637107071233.
       77 FLD0497C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0498A                       PIC  9(10)V9(08) COMP-6
           VALUE  4792455293.49441590.
       77 FLD0498C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0499A                       PIC  9(02)       COMP-6
           VALUE  05.
       77 FLD0499C                       PIC  9(09)V9(15) COMP-3.

      * RESULTS-AREA
       78 XPC-FLD0001C
          VALUE X'03'.
       78 XPC-FLD0002C
          VALUE X'83954987736989405977539036030060'.
       78 XPC-FLD0003C
          VALUE X'000000000000000000'.
       78 XPC-FLD0004C
          VALUE X'484166'.
       78 XPC-FLD0005C
          VALUE X'0002337334800C'.
       78 XPC-FLD0006C
          VALUE X'01690000000000000000000000000000000F'.
       78 XPC-FLD0007C
          VALUE X'00000112300C'.
       78 XPC-FLD0008C
          VALUE X'000C'.
       78 XPC-FLD0009C
          VALUE X'878954491957000000000000000000000F'.
       78 XPC-FLD0010C
          VALUE X'000000932591202C'.
       78 XPC-FLD0011C
          VALUE X'0829148300000000000000000000000000'.
       78 XPC-FLD0012C
          VALUE X'000000870000000000000000000F'.
       78 XPC-FLD0013C
          VALUE X'0082963000'.
       78 XPC-FLD0014C
          VALUE X'09431212'.
       78 XPC-FLD0015C
          VALUE X'000798473271412134'.
       78 XPC-FLD0016C
          VALUE X'00000087275955785C'.
       78 XPC-FLD0017C
          VALUE X'0000000000000000000000000000000000'.
       78 XPC-FLD0018C
          VALUE X'6C'.
       78 XPC-FLD0019C
          VALUE X'930528885682368D'.
       78 XPC-FLD0020C
          VALUE X'064388745272004432873F'.
       78 XPC-FLD0021C
          VALUE X'9C'.
       78 XPC-FLD0022C
          VALUE X'00810040192546636172998830716F'.
       78 XPC-FLD0023C
          VALUE X'0060000000000000000000000000000000000F'.
       78 XPC-FLD0024C
          VALUE X'329406009124000C'.
       78 XPC-FLD0025C
          VALUE X'0000000000'.
       78 XPC-FLD0026C
          VALUE X'000000000000000C'.
       78 XPC-FLD0027C
          VALUE X'00268670937520818498000000000000'.
       78 XPC-FLD0028C
          VALUE X'4C'.
       78 XPC-FLD0029C
          VALUE X'000001369700000000000000000F'.
       78 XPC-FLD0030C
          VALUE X'000000000000000000000000000F'.
       78 XPC-FLD0031C
          VALUE X'000000000000000000000000000F'.
       78 XPC-FLD0032C
          VALUE X'0269599769460C'.
       78 XPC-FLD0033C
          VALUE X'641903038069'.
       78 XPC-FLD0034C
          VALUE X'000000050D'.
       78 XPC-FLD0035C
          VALUE X'08162855'.
       78 XPC-FLD0036C
          VALUE X'00009789384107274801127829277902'.
       78 XPC-FLD0037C
          VALUE X'60836C'.
       78 XPC-FLD0038C
          VALUE X'00000955897506417712539139586169'.
       78 XPC-FLD0039C
          VALUE X'00089332'.
       78 XPC-FLD0040C
          VALUE X'227D'.
       78 XPC-FLD0041C
          VALUE X'0687709210194850428F'.
       78 XPC-FLD0042C
          VALUE X'00076807345400734650'.
       78 XPC-FLD0043C
          VALUE X'08049480000000000000000000000000000F'.
       78 XPC-FLD0044C
          VALUE X'00002062243000'.
       78 XPC-FLD0045C
          VALUE X'02859249581000'.
       78 XPC-FLD0046C
          VALUE X'000000000000000000000000000000000F'.
       78 XPC-FLD0047C
          VALUE X'002696659297000000'.
       78 XPC-FLD0048C
          VALUE X'0839628C'.
       78 XPC-FLD0049C
          VALUE X'07033645332063542800000000000000000000'.
       78 XPC-FLD0050C
          VALUE X'0329667670988000'.
       78 XPC-FLD0051C
          VALUE X'5703689413991348544000000000000000'.
       78 XPC-FLD0052C
          VALUE X'036720048385760000000F'.
       78 XPC-FLD0053C
          VALUE X'0022603246000C'.
       78 XPC-FLD0054C
          VALUE X'000000000000'.
       78 XPC-FLD0055C
          VALUE X'2223241766982828604426000F'.
       78 XPC-FLD0056C
          VALUE X'0216199390'.
       78 XPC-FLD0057C
          VALUE X'029C'.
       78 XPC-FLD0058C
          VALUE X'0000000966574C'.
       78 XPC-FLD0059C
          VALUE X'000256643861000000000000'.
       78 XPC-FLD0060C
          VALUE X'000009'.
       78 XPC-FLD0061C
          VALUE X'00000950000000000000000000000000'.
       78 XPC-FLD0062C
          VALUE X'05792591938164770581900F'.
       78 XPC-FLD0063C
          VALUE X'021069256000000000000000000F'.
       78 XPC-FLD0064C
          VALUE X'08553C'.
       78 XPC-FLD0065C
          VALUE X'04154C'.
       78 XPC-FLD0066C
          VALUE X'000000000000000000000000000000000F'.
       78 XPC-FLD0067C
          VALUE X'1D'.
       78 XPC-FLD0068C
          VALUE X'05'.
       78 XPC-FLD0069C
          VALUE X'0916'.
       78 XPC-FLD0070C
          VALUE X'6547479C'.
       78 XPC-FLD0071C
          VALUE X'0005'.
       78 XPC-FLD0072C
          VALUE X'000000009925387953744267'.
       78 XPC-FLD0073C
          VALUE X'00000009812328554525302504'.
       78 XPC-FLD0074C
          VALUE X'5849035926792574002774927066639060000F'.
       78 XPC-FLD0075C
          VALUE X'060837388C'.
       78 XPC-FLD0076C
          VALUE X'0841800000000000000000000000000000000F'.
       78 XPC-FLD0077C
          VALUE X'0420258698984000000000000000000000'.
       78 XPC-FLD0078C
          VALUE X'00001860442000000000'.
       78 XPC-FLD0079C
          VALUE X'223C'.
       78 XPC-FLD0080C
          VALUE X'0079055876713C'.
       78 XPC-FLD0081C
          VALUE X'00000000099513'.
       78 XPC-FLD0082C
          VALUE X'063244191000000000000000000000'.
       78 XPC-FLD0083C
          VALUE X'138412139C'.
       78 XPC-FLD0084C
          VALUE X'0000008913083797'.
       78 XPC-FLD0085C
          VALUE X'0000015779000000'.
       78 XPC-FLD0086C
          VALUE X'000000000976654777473F'.
       78 XPC-FLD0087C
          VALUE X'8605'.
       78 XPC-FLD0088C
          VALUE X'809468198000'.
       78 XPC-FLD0089C
          VALUE X'09422224462627877272780096970000000F'.
       78 XPC-FLD0090C
          VALUE X'28271627310D'.
       78 XPC-FLD0091C
          VALUE X'38808038090177000000000000'.
       78 XPC-FLD0092C
          VALUE X'01465870000000000000000000000000'.
       78 XPC-FLD0093C
          VALUE X'0083184869277572603962767061602F'.
       78 XPC-FLD0094C
          VALUE X'000022606985000000000F'.
       78 XPC-FLD0095C
          VALUE X'06811597607563408818265315858000'.
       78 XPC-FLD0096C
          VALUE X'0000000000000000000000000000000000'.
       78 XPC-FLD0097C
          VALUE X'000000850000000000000000000000'.
       78 XPC-FLD0098C
          VALUE X'000876371310'.
       78 XPC-FLD0099C
          VALUE X'46809917705D'.
       78 XPC-FLD0100C
          VALUE X'014828181328845779700000'.
       78 XPC-FLD0101C
          VALUE X'260535858D'.
       78 XPC-FLD0102C
          VALUE X'000001388000000000000000'.
       78 XPC-FLD0103C
          VALUE X'09'.
       78 XPC-FLD0104C
          VALUE X'0000225430630000000C'.
       78 XPC-FLD0105C
          VALUE X'2908138842'.
       78 XPC-FLD0106C
          VALUE X'00000000700D'.
       78 XPC-FLD0107C
          VALUE X'0774624437557797973497031000'.
       78 XPC-FLD0108C
          VALUE X'01021088231C'.
       78 XPC-FLD0109C
          VALUE X'01136000000000000000000000000000000F'.
       78 XPC-FLD0110C
          VALUE X'07940109556734978868419716'.
       78 XPC-FLD0111C
          VALUE X'00326472185831000000'.
       78 XPC-FLD0112C
          VALUE X'07123805246C'.
       78 XPC-FLD0113C
          VALUE X'9092'.
       78 XPC-FLD0114C
          VALUE X'050641'.
       78 XPC-FLD0115C
          VALUE X'00000096236C'.
       78 XPC-FLD0116C
          VALUE X'03'.
       78 XPC-FLD0117C
          VALUE X'009561'.
       78 XPC-FLD0118C
          VALUE X'726C'.
       78 XPC-FLD0119C
          VALUE X'0007887545'.
       78 XPC-FLD0120C
          VALUE X'060C'.
       78 XPC-FLD0121C
          VALUE X'0002338292200C'.
       78 XPC-FLD0122C
          VALUE X'0018495180'.
       78 XPC-FLD0123C
          VALUE X'00000005000000000000000000000F'.
       78 XPC-FLD0124C
          VALUE X'00000000000000000C'.
       78 XPC-FLD0125C
          VALUE X'000008800318267899139845'.
       78 XPC-FLD0126C
          VALUE X'08079900'.
       78 XPC-FLD0127C
          VALUE X'0089818601788201279934042986496933'.
       78 XPC-FLD0128C
          VALUE X'9848958759'.
       78 XPC-FLD0129C
          VALUE X'003346050810480000000000'.
       78 XPC-FLD0130C
          VALUE X'000000000000'.
       78 XPC-FLD0131C
          VALUE X'26916210050000000000000000'.
       78 XPC-FLD0132C
          VALUE X'00012700'.
       78 XPC-FLD0133C
          VALUE X'000000989C'.
       78 XPC-FLD0134C
          VALUE X'0703854997414389171872528F'.
       78 XPC-FLD0135C
          VALUE X'0833550001'.
       78 XPC-FLD0136C
          VALUE X'000151690000000000000000000F'.
       78 XPC-FLD0137C
          VALUE X'31939000000000000000000000000000000F'.
       78 XPC-FLD0138C
          VALUE X'3828944908530000000000000000000000'.
       78 XPC-FLD0139C
          VALUE X'06446533940000000000000000000000'.
       78 XPC-FLD0140C
          VALUE X'00000000000000000000000000000000000F'.
       78 XPC-FLD0141C
          VALUE X'02665121'.
       78 XPC-FLD0142C
          VALUE X'01246C'.
       78 XPC-FLD0143C
          VALUE X'06089871'.
       78 XPC-FLD0144C
          VALUE X'46256916'.
       78 XPC-FLD0145C
          VALUE X'0592809780429536'.
       78 XPC-FLD0146C
          VALUE X'00000000910000000000000F'.
       78 XPC-FLD0147C
          VALUE X'0000000008500000'.
       78 XPC-FLD0148C
          VALUE X'000011890000'.
       78 XPC-FLD0149C
          VALUE X'069C'.
       78 XPC-FLD0150C
          VALUE X'06000000000000000000000000000000000000'.
       78 XPC-FLD0151C
          VALUE X'26337494884196344102000000000F'.
       78 XPC-FLD0152C
          VALUE X'006500000000000000000000000000000000'.
       78 XPC-FLD0153C
          VALUE X'92463876729946470334198230000F'.
       78 XPC-FLD0154C
          VALUE X'006185316446100478'.
       78 XPC-FLD0155C
          VALUE X'08612867405699800000000000000000000F'.
       78 XPC-FLD0156C
          VALUE X'0095383071407820274600908305728808'.
       78 XPC-FLD0157C
          VALUE X'0659745695048369'.
       78 XPC-FLD0158C
          VALUE X'41265698123411400000000F'.
       78 XPC-FLD0159C
          VALUE X'0000000000000000000000000F'.
       78 XPC-FLD0160C
          VALUE X'06561078'.
       78 XPC-FLD0161C
          VALUE X'0078871709741627593626134284'.
       78 XPC-FLD0162C
          VALUE X'0000000000700000000000'.
       78 XPC-FLD0163C
          VALUE X'0618392824198294444038020F'.
       78 XPC-FLD0164C
          VALUE X'4076'.
       78 XPC-FLD0165C
          VALUE X'9164'.
       78 XPC-FLD0166C
          VALUE X'605899'.
       78 XPC-FLD0167C
          VALUE X'02534589620000000000000000000000'.
       78 XPC-FLD0168C
          VALUE X'00000001200000000C'.
       78 XPC-FLD0169C
          VALUE X'00834885736806376232976845'.
       78 XPC-FLD0170C
          VALUE X'02466670953929366305600000000000000000'.
       78 XPC-FLD0171C
          VALUE X'0675345293467529'.
       78 XPC-FLD0172C
          VALUE X'0096021652336003293637389788273139'.
       78 XPC-FLD0173C
          VALUE X'041247291433666300'.
       78 XPC-FLD0174C
          VALUE X'00000001244000000000'.
       78 XPC-FLD0175C
          VALUE X'056C'.
       78 XPC-FLD0176C
          VALUE X'007902178745'.
       78 XPC-FLD0177C
          VALUE X'0761883957'.
       78 XPC-FLD0178C
          VALUE X'55502105334C'.
       78 XPC-FLD0179C
          VALUE X'0564'.
       78 XPC-FLD0180C
          VALUE X'000000859461576526592F'.
       78 XPC-FLD0181C
          VALUE X'0000018890880000000C'.
       78 XPC-FLD0182C
          VALUE X'0061401860346830039460900F'.
       78 XPC-FLD0183C
          VALUE X'008C'.
       78 XPC-FLD0184C
          VALUE X'059457428C'.
       78 XPC-FLD0185C
          VALUE X'0001566600000000000000000000'.
       78 XPC-FLD0186C
          VALUE X'0000700000000000000000000000000F'.
       78 XPC-FLD0187C
          VALUE X'0604672028742360256892'.
       78 XPC-FLD0188C
          VALUE X'08008236875695360357241270000F'.
       78 XPC-FLD0189C
          VALUE X'0511507101623805082700'.
       78 XPC-FLD0190C
          VALUE X'000238213754000000000000'.
       78 XPC-FLD0191C
          VALUE X'0013720000000000000000000000000F'.
       78 XPC-FLD0192C
          VALUE X'00000000098942'.
       78 XPC-FLD0193C
          VALUE X'25294367709051900000000F'.
       78 XPC-FLD0194C
          VALUE X'0417168379939779000000000F'.
       78 XPC-FLD0195C
          VALUE X'045846'.
       78 XPC-FLD0196C
          VALUE X'0000000C'.
       78 XPC-FLD0197C
          VALUE X'09'.
       78 XPC-FLD0198C
          VALUE X'93108C'.
       78 XPC-FLD0199C
          VALUE X'248328724000000000000000000000'.
       78 XPC-FLD0200C
          VALUE X'049359727906061917'.
       78 XPC-FLD0201C
          VALUE X'0000128200000000000000000000000F'.
       78 XPC-FLD0202C
          VALUE X'044375030000000000000000000000000000'.
       78 XPC-FLD0203C
          VALUE X'06633826404025384700000000000000000F'.
       78 XPC-FLD0204C
          VALUE X'00000097'.
       78 XPC-FLD0205C
          VALUE X'648926914508991536933990'.
       78 XPC-FLD0206C
          VALUE X'00186967700000000000000000'.
       78 XPC-FLD0207C
          VALUE X'00083944392422874225534457082F'.
       78 XPC-FLD0208C
          VALUE X'00000967'.
       78 XPC-FLD0209C
          VALUE X'000092661149050802726900855077'.
       78 XPC-FLD0210C
          VALUE X'08'.
       78 XPC-FLD0211C
          VALUE X'00000000000000000C'.
       78 XPC-FLD0212C
          VALUE X'089203279255731C'.
       78 XPC-FLD0213C
          VALUE X'00000082000000000000000000000F'.
       78 XPC-FLD0214C
          VALUE X'00000000000000000000000000'.
       78 XPC-FLD0215C
          VALUE X'0009263C'.
       78 XPC-FLD0216C
          VALUE X'2809537487'.
       78 XPC-FLD0217C
          VALUE X'00745629624865839C'.
       78 XPC-FLD0218C
          VALUE X'04600000000000000000000000000000000000'.
       78 XPC-FLD0219C
          VALUE X'05787889921275072291'.
       78 XPC-FLD0220C
          VALUE X'43525C'.
       78 XPC-FLD0221C
          VALUE X'0000000000000000000000000000000000'.
       78 XPC-FLD0222C
          VALUE X'82805C'.
       78 XPC-FLD0223C
          VALUE X'00000000000000000000000000'.
       78 XPC-FLD0224C
          VALUE X'000083818722675C'.
       78 XPC-FLD0225C
          VALUE X'000013797000000000000F'.
       78 XPC-FLD0226C
          VALUE X'000149000C'.
       78 XPC-FLD0227C
          VALUE X'3055159408599976700000000000000000'.
       78 XPC-FLD0228C
          VALUE X'6300000000000000000000000000000000000F'.
       78 XPC-FLD0229C
          VALUE X'0000000987047360326050560175'.
       78 XPC-FLD0230C
          VALUE X'092C'.
       78 XPC-FLD0231C
          VALUE X'00008778168C'.
       78 XPC-FLD0232C
          VALUE X'3082645328000000000000000000000F'.
       78 XPC-FLD0233C
          VALUE X'075521568090'.
       78 XPC-FLD0234C
          VALUE X'00338310526754000000000F'.
       78 XPC-FLD0235C
          VALUE X'0000001412300000000C'.
       78 XPC-FLD0236C
          VALUE X'000008818235282899151705748F'.
       78 XPC-FLD0237C
          VALUE X'0203759000000000000000000000000000'.
       78 XPC-FLD0238C
          VALUE X'05210964'.
       78 XPC-FLD0239C
          VALUE X'67858577929248176108245F'.
       78 XPC-FLD0240C
          VALUE X'8535764467660000000000000000000F'.
       78 XPC-FLD0241C
          VALUE X'000001440700000000000000'.
       78 XPC-FLD0242C
          VALUE X'3838549C'.
       78 XPC-FLD0243C
          VALUE X'0000970409660969254295181940506154'.
       78 XPC-FLD0244C
          VALUE X'0000000000000000000000'.
       78 XPC-FLD0245C
          VALUE X'371716886145420000000000'.
       78 XPC-FLD0246C
          VALUE X'00872169'.
       78 XPC-FLD0247C
          VALUE X'008344948214770686600871840F'.
       78 XPC-FLD0248C
          VALUE X'0000000888556418584546'.
       78 XPC-FLD0249C
          VALUE X'6784708395950102000071524F'.
       78 XPC-FLD0250C
          VALUE X'8324926731005675151000000000000000'.
       78 XPC-FLD0251C
          VALUE X'5489100071950000000000000000000F'.
       78 XPC-FLD0252C
          VALUE X'000183393D'.
       78 XPC-FLD0253C
          VALUE X'08225938'.
       78 XPC-FLD0254C
          VALUE X'189569238C'.
       78 XPC-FLD0255C
          VALUE X'000000000948299297085F'.
       78 XPC-FLD0256C
          VALUE X'09644065917220000000000000000000000F'.
       78 XPC-FLD0257C
          VALUE X'491C'.
       78 XPC-FLD0258C
          VALUE X'93351960881057394000000000000000'.
       78 XPC-FLD0259C
          VALUE X'000000093755337C'.
       78 XPC-FLD0260C
          VALUE X'00000866489849667547828F'.
       78 XPC-FLD0261C
          VALUE X'37421392547904'.
       78 XPC-FLD0262C
          VALUE X'00001701590000000000000000'.
       78 XPC-FLD0263C
          VALUE X'046C'.
       78 XPC-FLD0264C
          VALUE X'009357'.
       78 XPC-FLD0265C
          VALUE X'02153010000000000000000000000000000000'.
       78 XPC-FLD0266C
          VALUE X'0076935708562128723997375345780000000F'.
       78 XPC-FLD0267C
          VALUE X'000000870C'.
       78 XPC-FLD0268C
          VALUE X'0000000000000000000000000000000F'.
       78 XPC-FLD0269C
          VALUE X'05'.
       78 XPC-FLD0270C
          VALUE X'04936C'.
       78 XPC-FLD0271C
          VALUE X'0815592744'.
       78 XPC-FLD0272C
          VALUE X'0041151466707076400C'.
       78 XPC-FLD0273C
          VALUE X'04698099460502486C'.
       78 XPC-FLD0274C
          VALUE X'00021902494000000000'.
       78 XPC-FLD0275C
          VALUE X'000115700C'.
       78 XPC-FLD0276C
          VALUE X'021044697283423507983002309629227000'.
       78 XPC-FLD0277C
          VALUE X'000000000974958216'.
       78 XPC-FLD0278C
          VALUE X'07069934760000000000000000000000000F'.
       78 XPC-FLD0279C
          VALUE X'20110000000000000000000000000000000F'.
       78 XPC-FLD0280C
          VALUE X'025719689200000000000000000F'.
       78 XPC-FLD0281C
          VALUE X'003428616893811000'.
       78 XPC-FLD0282C
          VALUE X'001473254430291000000000000000'.
       78 XPC-FLD0283C
          VALUE X'0000000C'.
       78 XPC-FLD0284C
          VALUE X'01'.
       78 XPC-FLD0285C
          VALUE X'0000092878828230193799520009'.
       78 XPC-FLD0286C
          VALUE X'04269643'.
       78 XPC-FLD0287C
          VALUE X'521413'.
       78 XPC-FLD0288C
          VALUE X'452502240640246355951000000000000F'.
       78 XPC-FLD0289C
          VALUE X'0000000009200000000000'.
       78 XPC-FLD0290C
          VALUE X'207D'.
       78 XPC-FLD0291C
          VALUE X'0000098593841243917534900020882F'.
       78 XPC-FLD0292C
          VALUE X'09'.
       78 XPC-FLD0293C
          VALUE X'000000093000'.
       78 XPC-FLD0294C
          VALUE X'09'.
       78 XPC-FLD0295C
          VALUE X'025025480D'.
       78 XPC-FLD0296C
          VALUE X'000160918000000000000F'.
       78 XPC-FLD0297C
          VALUE X'00030843552269000000'.
       78 XPC-FLD0298C
          VALUE X'09881505100000000000000000000000000000'.
       78 XPC-FLD0299C
          VALUE X'00648725735835784522720000'.
       78 XPC-FLD0300C
          VALUE X'07395614230661028409841F'.
       78 XPC-FLD0301C
          VALUE X'5D'.
       78 XPC-FLD0302C
          VALUE X'0000000094976469'.
       78 XPC-FLD0303C
          VALUE X'09'.
       78 XPC-FLD0304C
          VALUE X'0000000008300000000000'.
       78 XPC-FLD0305C
          VALUE X'4C'.
       78 XPC-FLD0306C
          VALUE X'0000000008300000000D'.
       78 XPC-FLD0307C
          VALUE X'075196597674160000000000000000000000'.
       78 XPC-FLD0308C
          VALUE X'0676212000000000000000000000000000000F'.
       78 XPC-FLD0309C
          VALUE X'096C'.
       78 XPC-FLD0310C
          VALUE X'0377541451372100'.
       78 XPC-FLD0311C
          VALUE X'6000000000000000000000000000000000000F'.
       78 XPC-FLD0312C
          VALUE X'04'.
       78 XPC-FLD0313C
          VALUE X'00008649336562'.
       78 XPC-FLD0314C
          VALUE X'00000088000000000000000000'.
       78 XPC-FLD0315C
          VALUE X'00793333674589681625555215'.
       78 XPC-FLD0316C
          VALUE X'000019582740000000000F'.
       78 XPC-FLD0317C
          VALUE X'0983225307652C'.
       78 XPC-FLD0318C
          VALUE X'637469000000000000000000000000000F'.
       78 XPC-FLD0319C
          VALUE X'0069931441978879860243978F'.
       78 XPC-FLD0320C
          VALUE X'007197349588245658402F'.
       78 XPC-FLD0321C
          VALUE X'0055048748534891610000000F'.
       78 XPC-FLD0322C
          VALUE X'044200531022490540000000'.
       78 XPC-FLD0323C
          VALUE X'0700000000000000000000000000000000000F'.
       78 XPC-FLD0324C
          VALUE X'056016045047582097016F'.
       78 XPC-FLD0325C
          VALUE X'000011690000000000000000000F'.
       78 XPC-FLD0326C
          VALUE X'044C'.
       78 XPC-FLD0327C
          VALUE X'000000900D'.
       78 XPC-FLD0328C
          VALUE X'007114750477168C'.
       78 XPC-FLD0329C
          VALUE X'0000000000000000000000000000000000000F'.
       78 XPC-FLD0330C
          VALUE X'528074615817230000000000000000'.
       78 XPC-FLD0331C
          VALUE X'0223281680'.
       78 XPC-FLD0332C
          VALUE X'00000865629886'.
       78 XPC-FLD0333C
          VALUE X'000009564C'.
       78 XPC-FLD0334C
          VALUE X'028999492466'.
       78 XPC-FLD0335C
          VALUE X'00030334218791000000'.
       78 XPC-FLD0336C
          VALUE X'00085800255C'.
       78 XPC-FLD0337C
          VALUE X'720039965448931451597047725F'.
       78 XPC-FLD0338C
          VALUE X'000000000000000000000F'.
       78 XPC-FLD0339C
          VALUE X'00001605520000000000000F'.
       78 XPC-FLD0340C
          VALUE X'0283816514732C'.
       78 XPC-FLD0341C
          VALUE X'676316159010109663180F'.
       78 XPC-FLD0342C
          VALUE X'00023471430000000C'.
       78 XPC-FLD0343C
          VALUE X'08663561'.
       78 XPC-FLD0344C
          VALUE X'487899471050000000000000000000000F'.
       78 XPC-FLD0345C
          VALUE X'0000000000000000'.
       78 XPC-FLD0346C
          VALUE X'0078078600333687642187641F'.
       78 XPC-FLD0347C
          VALUE X'165985'.
       78 XPC-FLD0348C
          VALUE X'0033778742713300000000'.
       78 XPC-FLD0349C
          VALUE X'06677966816100000000000000000000000F'.
       78 XPC-FLD0350C
          VALUE X'00000070000000000000000000000000'.
       78 XPC-FLD0351C
          VALUE X'00000849425769125191'.
       78 XPC-FLD0352C
          VALUE X'00009378'.
       78 XPC-FLD0353C
          VALUE X'88730000000000000000000000000000000F'.
       78 XPC-FLD0354C
          VALUE X'02152460400C'.
       78 XPC-FLD0355C
          VALUE X'08715C'.
       78 XPC-FLD0356C
          VALUE X'98983370500000000000000000000000'.
       78 XPC-FLD0357C
          VALUE X'0989'.
       78 XPC-FLD0358C
          VALUE X'02984840394300000000000000'.
       78 XPC-FLD0359C
          VALUE X'9598518521032133321568800000000000000F'.
       78 XPC-FLD0360C
          VALUE X'0027761227'.
       78 XPC-FLD0361C
          VALUE X'23089804406111236190213276131500'.
       78 XPC-FLD0362C
          VALUE X'0000000000000000000000000000000000'.
       78 XPC-FLD0363C
          VALUE X'05926207800000000000000000000000000F'.
       78 XPC-FLD0364C
          VALUE X'0012340000000000000000000000000F'.
       78 XPC-FLD0365C
          VALUE X'05519670096247205615100000'.
       78 XPC-FLD0366C
          VALUE X'08224143642778768414913770357088'.
       78 XPC-FLD0367C
          VALUE X'9754369C'.
       78 XPC-FLD0368C
          VALUE X'03'.
       78 XPC-FLD0369C
          VALUE X'00000000000C'.
       78 XPC-FLD0370C
          VALUE X'0C'.
       78 XPC-FLD0371C
          VALUE X'000C'.
       78 XPC-FLD0372C
          VALUE X'5067586024551302692F'.
       78 XPC-FLD0373C
          VALUE X'6607304158912C'.
       78 XPC-FLD0374C
          VALUE X'000000000000000000000000000F'.
       78 XPC-FLD0375C
          VALUE X'03'.
       78 XPC-FLD0376C
          VALUE X'0000084980958923270F'.
       78 XPC-FLD0377C
          VALUE X'00000967759547981370871205797F'.
       78 XPC-FLD0378C
          VALUE X'0000000C'.
       78 XPC-FLD0379C
          VALUE X'04'.
       78 XPC-FLD0380C
          VALUE X'9C'.
       78 XPC-FLD0381C
          VALUE X'0124'.
       78 XPC-FLD0382C
          VALUE X'3185'.
       78 XPC-FLD0383C
          VALUE X'0008846280283410202782690134881F'.
       78 XPC-FLD0384C
          VALUE X'01'.
       78 XPC-FLD0385C
          VALUE X'882641569234671408000000000000000F'.
       78 XPC-FLD0386C
          VALUE X'01006446220522301260000000000F'.
       78 XPC-FLD0387C
          VALUE X'0305164059310000000000000F'.
       78 XPC-FLD0388C
          VALUE X'0425'.
       78 XPC-FLD0389C
          VALUE X'4300560615719126000000'.
       78 XPC-FLD0390C
          VALUE X'0007'.
       78 XPC-FLD0391C
          VALUE X'03006664253C'.
       78 XPC-FLD0392C
          VALUE X'000000000957627258'.
       78 XPC-FLD0393C
          VALUE X'0005000000000000000000000000000000'.
       78 XPC-FLD0394C
          VALUE X'0000001680780000000C'.
       78 XPC-FLD0395C
          VALUE X'2C'.
       78 XPC-FLD0396C
          VALUE X'4199398272807910'.
       78 XPC-FLD0397C
          VALUE X'069C'.
       78 XPC-FLD0398C
          VALUE X'00008411085C'.
       78 XPC-FLD0399C
          VALUE X'0008621537'.
       78 XPC-FLD0400C
          VALUE X'07030346791008200000000000000000'.
       78 XPC-FLD0401C
          VALUE X'09'.
       78 XPC-FLD0402C
          VALUE X'00008843413069892215316869'.
       78 XPC-FLD0403C
          VALUE X'018521192780340000000000000000000000'.
       78 XPC-FLD0404C
          VALUE X'8105929035137817700000000F'.
       78 XPC-FLD0405C
          VALUE X'20744D'.
       78 XPC-FLD0406C
          VALUE X'250301894000000000000000000000'.
       78 XPC-FLD0407C
          VALUE X'08873808380059800000000000000000000000'.
       78 XPC-FLD0408C
          VALUE X'3810009911'.
       78 XPC-FLD0409C
          VALUE X'0028575188650000000000'.
       78 XPC-FLD0410C
          VALUE X'8608772611305250000000000000000000000F'.
       78 XPC-FLD0411C
          VALUE X'085733222699574884728690400000'.
       78 XPC-FLD0412C
          VALUE X'7C'.
       78 XPC-FLD0413C
          VALUE X'2C'.
       78 XPC-FLD0414C
          VALUE X'84413C'.
       78 XPC-FLD0415C
          VALUE X'9882276907018123770000000000000000'.
       78 XPC-FLD0416C
          VALUE X'8C'.
       78 XPC-FLD0417C
          VALUE X'094259186417160190085695603556814F'.
       78 XPC-FLD0418C
          VALUE X'00'.
       78 XPC-FLD0419C
          VALUE X'004156956195444910000F'.
       78 XPC-FLD0420C
          VALUE X'1191370000000000000000000000000000'.
       78 XPC-FLD0421C
          VALUE X'1247079C'.
       78 XPC-FLD0422C
          VALUE X'720047000515101842660000000000000000'.
       78 XPC-FLD0423C
          VALUE X'59541777429198150528570000'.
       78 XPC-FLD0424C
          VALUE X'0511515415988558208500000000'.
       78 XPC-FLD0425C
          VALUE X'04741628720817547270000F'.
       78 XPC-FLD0426C
          VALUE X'0560145669580725313885'.
       78 XPC-FLD0427C
          VALUE X'052846215641000000000000000000'.
       78 XPC-FLD0428C
          VALUE X'03234918316627730661139139556000000000'.
       78 XPC-FLD0429C
          VALUE X'0007833347606290'.
       78 XPC-FLD0430C
          VALUE X'00308209985020'.
       78 XPC-FLD0431C
          VALUE X'00000000000000000000000000000000000F'.
       78 XPC-FLD0432C
          VALUE X'0307034C'.
       78 XPC-FLD0433C
          VALUE X'00129558'.
       78 XPC-FLD0434C
          VALUE X'67534156190000000000000000000000000F'.
       78 XPC-FLD0435C
          VALUE X'00000000087000000000000F'.
       78 XPC-FLD0436C
          VALUE X'0000000000000000000000000000000F'.
       78 XPC-FLD0437C
          VALUE X'0632897272198471361193128F'.
       78 XPC-FLD0438C
          VALUE X'940216365745390802999000000000000F'.
       78 XPC-FLD0439C
          VALUE X'496113480543429519000F'.
       78 XPC-FLD0440C
          VALUE X'000000088990750705'.
       78 XPC-FLD0441C
          VALUE X'00071126905440655C'.
       78 XPC-FLD0442C
          VALUE X'9951000000000000000000000000000000'.
       78 XPC-FLD0443C
          VALUE X'74498425546487689000000F'.
       78 XPC-FLD0444C
          VALUE X'0000000094673816662F'.
       78 XPC-FLD0445C
          VALUE X'54165545445299512C'.
       78 XPC-FLD0446C
          VALUE X'00448978466972116400000000'.
       78 XPC-FLD0447C
          VALUE X'0000000600'.
       78 XPC-FLD0448C
          VALUE X'00001865654000000000'.
       78 XPC-FLD0449C
          VALUE X'0849880941870D'.
       78 XPC-FLD0450C
          VALUE X'6255783755022833458880'.
       78 XPC-FLD0451C
          VALUE X'000000000C'.
       78 XPC-FLD0452C
          VALUE X'0002682648418000000000'.
       78 XPC-FLD0453C
          VALUE X'465392911909000000000000000000000000'.
       78 XPC-FLD0454C
          VALUE X'0D'.
       78 XPC-FLD0455C
          VALUE X'000000000000000000000000000000000F'.
       78 XPC-FLD0456C
          VALUE X'000093'.
       78 XPC-FLD0457C
          VALUE X'03'.
       78 XPC-FLD0458C
          VALUE X'000000006000'.
       78 XPC-FLD0459C
          VALUE X'000019847990000000000F'.
       78 XPC-FLD0460C
          VALUE X'00000000000000000000000000000F'.
       78 XPC-FLD0461C
          VALUE X'000000000C'.
       78 XPC-FLD0462C
          VALUE X'0956900000000000000000000000000000000F'.
       78 XPC-FLD0463C
          VALUE X'0000085490666934'.
       78 XPC-FLD0464C
          VALUE X'0870311903834293000000000000'.
       78 XPC-FLD0465C
          VALUE X'05639855971063010280000000000000'.
       78 XPC-FLD0466C
          VALUE X'081306'.
       78 XPC-FLD0467C
          VALUE X'328700000000000000000000000000000F'.
       78 XPC-FLD0468C
          VALUE X'044132145767'.
       78 XPC-FLD0469C
          VALUE X'0070961503876956555F'.
       78 XPC-FLD0470C
          VALUE X'000000091368100C'.
       78 XPC-FLD0471C
          VALUE X'03'.
       78 XPC-FLD0472C
          VALUE X'099086905033216800000000000000000F'.
       78 XPC-FLD0473C
          VALUE X'074367162068054681878237488F'.
       78 XPC-FLD0474C
          VALUE X'25744C'.
       78 XPC-FLD0475C
          VALUE X'588724634299997C'.
       78 XPC-FLD0476C
          VALUE X'08699334'.
       78 XPC-FLD0477C
          VALUE X'007449248299155C'.
       78 XPC-FLD0478C
          VALUE X'00726161625751'.
       78 XPC-FLD0479C
          VALUE X'5020528966970000000000000000000F'.
       78 XPC-FLD0480C
          VALUE X'0020301780000000000000000000'.
       78 XPC-FLD0481C
          VALUE X'8000000000000000000000000000000000000F'.
       78 XPC-FLD0482C
          VALUE X'0007090503795044722C'.
       78 XPC-FLD0483C
          VALUE X'0000000079000C'.
       78 XPC-FLD0484C
          VALUE X'0000000000000000000000'.
       78 XPC-FLD0485C
          VALUE X'675729'.
       78 XPC-FLD0486C
          VALUE X'000000139370000000'.
       78 XPC-FLD0487C
          VALUE X'000209384200000000000000000F'.
       78 XPC-FLD0488C
          VALUE X'05191989067966076000000000'.
       78 XPC-FLD0489C
          VALUE X'00600000000000000000000000000000000000'.
       78 XPC-FLD0490C
          VALUE X'5256658026'.
       78 XPC-FLD0491C
          VALUE X'0000009182459205467069507F'.
       78 XPC-FLD0492C
          VALUE X'0008192664570C'.
       78 XPC-FLD0493C
          VALUE X'018038500000000000000000000000'.
       78 XPC-FLD0494C
          VALUE X'0000087574541779147F'.
       78 XPC-FLD0495C
          VALUE X'000000005000000000000000'.
       78 XPC-FLD0496C
          VALUE X'06763C'.
       78 XPC-FLD0497C
          VALUE X'00008362306435874340415637'.
       78 XPC-FLD0498C
          VALUE X'04552934'.
       78 XPC-FLD0499C
          VALUE X'0000000005000000000000000F'.

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

           MOVE FLD0001A        TO FLD0001C.
           MOVE FLD0002A        TO FLD0002C.
           MOVE FLD0003A        TO FLD0003C.
           MOVE FLD0004A        TO FLD0004C.
           MOVE FLD0005A        TO FLD0005C.
           MOVE FLD0006A        TO FLD0006C.
           MOVE FLD0007A        TO FLD0007C.
           MOVE FLD0008A        TO FLD0008C.
           MOVE FLD0009A        TO FLD0009C.
           MOVE FLD0010A        TO FLD0010C.
           MOVE FLD0011A        TO FLD0011C.
           MOVE FLD0012A        TO FLD0012C.
           MOVE FLD0013A        TO FLD0013C.
           MOVE FLD0014A        TO FLD0014C.
           MOVE FLD0015A        TO FLD0015C.
           MOVE FLD0016A        TO FLD0016C.
           MOVE FLD0017A        TO FLD0017C.
           MOVE FLD0018A        TO FLD0018C.
           MOVE FLD0019A        TO FLD0019C.
           MOVE FLD0020A        TO FLD0020C.
           MOVE FLD0021A        TO FLD0021C.
           MOVE FLD0022A        TO FLD0022C.
           MOVE FLD0023A        TO FLD0023C.
           MOVE FLD0024A        TO FLD0024C.
           MOVE FLD0025A        TO FLD0025C.
           MOVE FLD0026A        TO FLD0026C.
           MOVE FLD0027A        TO FLD0027C.
           MOVE FLD0028A        TO FLD0028C.
           MOVE FLD0029A        TO FLD0029C.
           MOVE FLD0030A        TO FLD0030C.
           MOVE FLD0031A        TO FLD0031C.
           MOVE FLD0032A        TO FLD0032C.
           MOVE FLD0033A        TO FLD0033C.
           MOVE FLD0034A        TO FLD0034C.
           MOVE FLD0035A        TO FLD0035C.
           MOVE FLD0036A        TO FLD0036C.
           MOVE FLD0037A        TO FLD0037C.
           MOVE FLD0038A        TO FLD0038C.
           MOVE FLD0039A        TO FLD0039C.
           MOVE FLD0040A        TO FLD0040C.
           MOVE FLD0041A        TO FLD0041C.
           MOVE FLD0042A        TO FLD0042C.
           MOVE FLD0043A        TO FLD0043C.
           MOVE FLD0044A        TO FLD0044C.
           MOVE FLD0045A        TO FLD0045C.
           MOVE FLD0046A        TO FLD0046C.
           MOVE FLD0047A        TO FLD0047C.
           MOVE FLD0048A        TO FLD0048C.
           MOVE FLD0049A        TO FLD0049C.
           MOVE FLD0050A        TO FLD0050C.
           MOVE FLD0051A        TO FLD0051C.
           MOVE FLD0052A        TO FLD0052C.
           MOVE FLD0053A        TO FLD0053C.
           MOVE FLD0054A        TO FLD0054C.
           MOVE FLD0055A        TO FLD0055C.
           MOVE FLD0056A        TO FLD0056C.
           MOVE FLD0057A        TO FLD0057C.
           MOVE FLD0058A        TO FLD0058C.
           MOVE FLD0059A        TO FLD0059C.
           MOVE FLD0060A        TO FLD0060C.
           MOVE FLD0061A        TO FLD0061C.
           MOVE FLD0062A        TO FLD0062C.
           MOVE FLD0063A        TO FLD0063C.
           MOVE FLD0064A        TO FLD0064C.
           MOVE FLD0065A        TO FLD0065C.
           MOVE FLD0066A        TO FLD0066C.
           MOVE FLD0067A        TO FLD0067C.
           MOVE FLD0068A        TO FLD0068C.
           MOVE FLD0069A        TO FLD0069C.
           MOVE FLD0070A        TO FLD0070C.
           MOVE FLD0071A        TO FLD0071C.
           MOVE FLD0072A        TO FLD0072C.
           MOVE FLD0073A        TO FLD0073C.
           MOVE FLD0074A        TO FLD0074C.
           MOVE FLD0075A        TO FLD0075C.
           MOVE FLD0076A        TO FLD0076C.
           MOVE FLD0077A        TO FLD0077C.
           MOVE FLD0078A        TO FLD0078C.
           MOVE FLD0079A        TO FLD0079C.
           MOVE FLD0080A        TO FLD0080C.
           MOVE FLD0081A        TO FLD0081C.
           MOVE FLD0082A        TO FLD0082C.
           MOVE FLD0083A        TO FLD0083C.
           MOVE FLD0084A        TO FLD0084C.
           MOVE FLD0085A        TO FLD0085C.
           MOVE FLD0086A        TO FLD0086C.
           MOVE FLD0087A        TO FLD0087C.
           MOVE FLD0088A        TO FLD0088C.
           MOVE FLD0089A        TO FLD0089C.
           MOVE FLD0090A        TO FLD0090C.
           MOVE FLD0091A        TO FLD0091C.
           MOVE FLD0092A        TO FLD0092C.
           MOVE FLD0093A        TO FLD0093C.
           MOVE FLD0094A        TO FLD0094C.
           MOVE FLD0095A        TO FLD0095C.
           MOVE FLD0096A        TO FLD0096C.
           MOVE FLD0097A        TO FLD0097C.
           MOVE FLD0098A        TO FLD0098C.
           MOVE FLD0099A        TO FLD0099C.
           MOVE FLD0100A        TO FLD0100C.
           MOVE FLD0101A        TO FLD0101C.
           MOVE FLD0102A        TO FLD0102C.
           MOVE FLD0103A        TO FLD0103C.
           MOVE FLD0104A        TO FLD0104C.
           MOVE FLD0105A        TO FLD0105C.
           MOVE FLD0106A        TO FLD0106C.
           MOVE FLD0107A        TO FLD0107C.
           MOVE FLD0108A        TO FLD0108C.
           MOVE FLD0109A        TO FLD0109C.
           MOVE FLD0110A        TO FLD0110C.
           MOVE FLD0111A        TO FLD0111C.
           MOVE FLD0112A        TO FLD0112C.
           MOVE FLD0113A        TO FLD0113C.
           MOVE FLD0114A        TO FLD0114C.
           MOVE FLD0115A        TO FLD0115C.
           MOVE FLD0116A        TO FLD0116C.
           MOVE FLD0117A        TO FLD0117C.
           MOVE FLD0118A        TO FLD0118C.
           MOVE FLD0119A        TO FLD0119C.
           MOVE FLD0120A        TO FLD0120C.
           MOVE FLD0121A        TO FLD0121C.
           MOVE FLD0122A        TO FLD0122C.
           MOVE FLD0123A        TO FLD0123C.
           MOVE FLD0124A        TO FLD0124C.
           MOVE FLD0125A        TO FLD0125C.
           MOVE FLD0126A        TO FLD0126C.
           MOVE FLD0127A        TO FLD0127C.
           MOVE FLD0128A        TO FLD0128C.
           MOVE FLD0129A        TO FLD0129C.
           MOVE FLD0130A        TO FLD0130C.
           MOVE FLD0131A        TO FLD0131C.
           MOVE FLD0132A        TO FLD0132C.
           MOVE FLD0133A        TO FLD0133C.
           MOVE FLD0134A        TO FLD0134C.
           MOVE FLD0135A        TO FLD0135C.
           MOVE FLD0136A        TO FLD0136C.
           MOVE FLD0137A        TO FLD0137C.
           MOVE FLD0138A        TO FLD0138C.
           MOVE FLD0139A        TO FLD0139C.
           MOVE FLD0140A        TO FLD0140C.
           MOVE FLD0141A        TO FLD0141C.
           MOVE FLD0142A        TO FLD0142C.
           MOVE FLD0143A        TO FLD0143C.
           MOVE FLD0144A        TO FLD0144C.
           MOVE FLD0145A        TO FLD0145C.
           MOVE FLD0146A        TO FLD0146C.
           MOVE FLD0147A        TO FLD0147C.
           MOVE FLD0148A        TO FLD0148C.
           MOVE FLD0149A        TO FLD0149C.
           MOVE FLD0150A        TO FLD0150C.
           MOVE FLD0151A        TO FLD0151C.
           MOVE FLD0152A        TO FLD0152C.
           MOVE FLD0153A        TO FLD0153C.
           MOVE FLD0154A        TO FLD0154C.
           MOVE FLD0155A        TO FLD0155C.
           MOVE FLD0156A        TO FLD0156C.
           MOVE FLD0157A        TO FLD0157C.
           MOVE FLD0158A        TO FLD0158C.
           MOVE FLD0159A        TO FLD0159C.
           MOVE FLD0160A        TO FLD0160C.
           MOVE FLD0161A        TO FLD0161C.
           MOVE FLD0162A        TO FLD0162C.
           MOVE FLD0163A        TO FLD0163C.
           MOVE FLD0164A        TO FLD0164C.
           MOVE FLD0165A        TO FLD0165C.
           MOVE FLD0166A        TO FLD0166C.
           MOVE FLD0167A        TO FLD0167C.
           MOVE FLD0168A        TO FLD0168C.
           MOVE FLD0169A        TO FLD0169C.
           MOVE FLD0170A        TO FLD0170C.
           MOVE FLD0171A        TO FLD0171C.
           MOVE FLD0172A        TO FLD0172C.
           MOVE FLD0173A        TO FLD0173C.
           MOVE FLD0174A        TO FLD0174C.
           MOVE FLD0175A        TO FLD0175C.
           MOVE FLD0176A        TO FLD0176C.
           MOVE FLD0177A        TO FLD0177C.
           MOVE FLD0178A        TO FLD0178C.
           MOVE FLD0179A        TO FLD0179C.
           MOVE FLD0180A        TO FLD0180C.
           MOVE FLD0181A        TO FLD0181C.
           MOVE FLD0182A        TO FLD0182C.
           MOVE FLD0183A        TO FLD0183C.
           MOVE FLD0184A        TO FLD0184C.
           MOVE FLD0185A        TO FLD0185C.
           MOVE FLD0186A        TO FLD0186C.
           MOVE FLD0187A        TO FLD0187C.
           MOVE FLD0188A        TO FLD0188C.
           MOVE FLD0189A        TO FLD0189C.
           MOVE FLD0190A        TO FLD0190C.
           MOVE FLD0191A        TO FLD0191C.
           MOVE FLD0192A        TO FLD0192C.
           MOVE FLD0193A        TO FLD0193C.
           MOVE FLD0194A        TO FLD0194C.
           MOVE FLD0195A        TO FLD0195C.
           MOVE FLD0196A        TO FLD0196C.
           MOVE FLD0197A        TO FLD0197C.
           MOVE FLD0198A        TO FLD0198C.
           MOVE FLD0199A        TO FLD0199C.
           MOVE FLD0200A        TO FLD0200C.
           MOVE FLD0201A        TO FLD0201C.
           MOVE FLD0202A        TO FLD0202C.
           MOVE FLD0203A        TO FLD0203C.
           MOVE FLD0204A        TO FLD0204C.
           MOVE FLD0205A        TO FLD0205C.
           MOVE FLD0206A        TO FLD0206C.
           MOVE FLD0207A        TO FLD0207C.
           MOVE FLD0208A        TO FLD0208C.
           MOVE FLD0209A        TO FLD0209C.
           MOVE FLD0210A        TO FLD0210C.
           MOVE FLD0211A        TO FLD0211C.
           MOVE FLD0212A        TO FLD0212C.
           MOVE FLD0213A        TO FLD0213C.
           MOVE FLD0214A        TO FLD0214C.
           MOVE FLD0215A        TO FLD0215C.
           MOVE FLD0216A        TO FLD0216C.
           MOVE FLD0217A        TO FLD0217C.
           MOVE FLD0218A        TO FLD0218C.
           MOVE FLD0219A        TO FLD0219C.
           MOVE FLD0220A        TO FLD0220C.
           MOVE FLD0221A        TO FLD0221C.
           MOVE FLD0222A        TO FLD0222C.
           MOVE FLD0223A        TO FLD0223C.
           MOVE FLD0224A        TO FLD0224C.
           MOVE FLD0225A        TO FLD0225C.
           MOVE FLD0226A        TO FLD0226C.
           MOVE FLD0227A        TO FLD0227C.
           MOVE FLD0228A        TO FLD0228C.
           MOVE FLD0229A        TO FLD0229C.
           MOVE FLD0230A        TO FLD0230C.
           MOVE FLD0231A        TO FLD0231C.
           MOVE FLD0232A        TO FLD0232C.
           MOVE FLD0233A        TO FLD0233C.
           MOVE FLD0234A        TO FLD0234C.
           MOVE FLD0235A        TO FLD0235C.
           MOVE FLD0236A        TO FLD0236C.
           MOVE FLD0237A        TO FLD0237C.
           MOVE FLD0238A        TO FLD0238C.
           MOVE FLD0239A        TO FLD0239C.
           MOVE FLD0240A        TO FLD0240C.
           MOVE FLD0241A        TO FLD0241C.
           MOVE FLD0242A        TO FLD0242C.
           MOVE FLD0243A        TO FLD0243C.
           MOVE FLD0244A        TO FLD0244C.
           MOVE FLD0245A        TO FLD0245C.
           MOVE FLD0246A        TO FLD0246C.
           MOVE FLD0247A        TO FLD0247C.
           MOVE FLD0248A        TO FLD0248C.
           MOVE FLD0249A        TO FLD0249C.
           MOVE FLD0250A        TO FLD0250C.
           MOVE FLD0251A        TO FLD0251C.
           MOVE FLD0252A        TO FLD0252C.
           MOVE FLD0253A        TO FLD0253C.
           MOVE FLD0254A        TO FLD0254C.
           MOVE FLD0255A        TO FLD0255C.
           MOVE FLD0256A        TO FLD0256C.
           MOVE FLD0257A        TO FLD0257C.
           MOVE FLD0258A        TO FLD0258C.
           MOVE FLD0259A        TO FLD0259C.
           MOVE FLD0260A        TO FLD0260C.
           MOVE FLD0261A        TO FLD0261C.
           MOVE FLD0262A        TO FLD0262C.
           MOVE FLD0263A        TO FLD0263C.
           MOVE FLD0264A        TO FLD0264C.
           MOVE FLD0265A        TO FLD0265C.
           MOVE FLD0266A        TO FLD0266C.
           MOVE FLD0267A        TO FLD0267C.
           MOVE FLD0268A        TO FLD0268C.
           MOVE FLD0269A        TO FLD0269C.
           MOVE FLD0270A        TO FLD0270C.
           MOVE FLD0271A        TO FLD0271C.
           MOVE FLD0272A        TO FLD0272C.
           MOVE FLD0273A        TO FLD0273C.
           MOVE FLD0274A        TO FLD0274C.
           MOVE FLD0275A        TO FLD0275C.
           MOVE FLD0276A        TO FLD0276C.
           MOVE FLD0277A        TO FLD0277C.
           MOVE FLD0278A        TO FLD0278C.
           MOVE FLD0279A        TO FLD0279C.
           MOVE FLD0280A        TO FLD0280C.
           MOVE FLD0281A        TO FLD0281C.
           MOVE FLD0282A        TO FLD0282C.
           MOVE FLD0283A        TO FLD0283C.
           MOVE FLD0284A        TO FLD0284C.
           MOVE FLD0285A        TO FLD0285C.
           MOVE FLD0286A        TO FLD0286C.
           MOVE FLD0287A        TO FLD0287C.
           MOVE FLD0288A        TO FLD0288C.
           MOVE FLD0289A        TO FLD0289C.
           MOVE FLD0290A        TO FLD0290C.
           MOVE FLD0291A        TO FLD0291C.
           MOVE FLD0292A        TO FLD0292C.
           MOVE FLD0293A        TO FLD0293C.
           MOVE FLD0294A        TO FLD0294C.
           MOVE FLD0295A        TO FLD0295C.
           MOVE FLD0296A        TO FLD0296C.
           MOVE FLD0297A        TO FLD0297C.
           MOVE FLD0298A        TO FLD0298C.
           MOVE FLD0299A        TO FLD0299C.
           MOVE FLD0300A        TO FLD0300C.
           MOVE FLD0301A        TO FLD0301C.
           MOVE FLD0302A        TO FLD0302C.
           MOVE FLD0303A        TO FLD0303C.
           MOVE FLD0304A        TO FLD0304C.
           MOVE FLD0305A        TO FLD0305C.
           MOVE FLD0306A        TO FLD0306C.
           MOVE FLD0307A        TO FLD0307C.
           MOVE FLD0308A        TO FLD0308C.
           MOVE FLD0309A        TO FLD0309C.
           MOVE FLD0310A        TO FLD0310C.
           MOVE FLD0311A        TO FLD0311C.
           MOVE FLD0312A        TO FLD0312C.
           MOVE FLD0313A        TO FLD0313C.
           MOVE FLD0314A        TO FLD0314C.
           MOVE FLD0315A        TO FLD0315C.
           MOVE FLD0316A        TO FLD0316C.
           MOVE FLD0317A        TO FLD0317C.
           MOVE FLD0318A        TO FLD0318C.
           MOVE FLD0319A        TO FLD0319C.
           MOVE FLD0320A        TO FLD0320C.
           MOVE FLD0321A        TO FLD0321C.
           MOVE FLD0322A        TO FLD0322C.
           MOVE FLD0323A        TO FLD0323C.
           MOVE FLD0324A        TO FLD0324C.
           MOVE FLD0325A        TO FLD0325C.
           MOVE FLD0326A        TO FLD0326C.
           MOVE FLD0327A        TO FLD0327C.
           MOVE FLD0328A        TO FLD0328C.
           MOVE FLD0329A        TO FLD0329C.
           MOVE FLD0330A        TO FLD0330C.
           MOVE FLD0331A        TO FLD0331C.
           MOVE FLD0332A        TO FLD0332C.
           MOVE FLD0333A        TO FLD0333C.
           MOVE FLD0334A        TO FLD0334C.
           MOVE FLD0335A        TO FLD0335C.
           MOVE FLD0336A        TO FLD0336C.
           MOVE FLD0337A        TO FLD0337C.
           MOVE FLD0338A        TO FLD0338C.
           MOVE FLD0339A        TO FLD0339C.
           MOVE FLD0340A        TO FLD0340C.
           MOVE FLD0341A        TO FLD0341C.
           MOVE FLD0342A        TO FLD0342C.
           MOVE FLD0343A        TO FLD0343C.
           MOVE FLD0344A        TO FLD0344C.
           MOVE FLD0345A        TO FLD0345C.
           MOVE FLD0346A        TO FLD0346C.
           MOVE FLD0347A        TO FLD0347C.
           MOVE FLD0348A        TO FLD0348C.
           MOVE FLD0349A        TO FLD0349C.
           MOVE FLD0350A        TO FLD0350C.
           MOVE FLD0351A        TO FLD0351C.
           MOVE FLD0352A        TO FLD0352C.
           MOVE FLD0353A        TO FLD0353C.
           MOVE FLD0354A        TO FLD0354C.
           MOVE FLD0355A        TO FLD0355C.
           MOVE FLD0356A        TO FLD0356C.
           MOVE FLD0357A        TO FLD0357C.
           MOVE FLD0358A        TO FLD0358C.
           MOVE FLD0359A        TO FLD0359C.
           MOVE FLD0360A        TO FLD0360C.
           MOVE FLD0361A        TO FLD0361C.
           MOVE FLD0362A        TO FLD0362C.
           MOVE FLD0363A        TO FLD0363C.
           MOVE FLD0364A        TO FLD0364C.
           MOVE FLD0365A        TO FLD0365C.
           MOVE FLD0366A        TO FLD0366C.
           MOVE FLD0367A        TO FLD0367C.
           MOVE FLD0368A        TO FLD0368C.
           MOVE FLD0369A        TO FLD0369C.
           MOVE FLD0370A        TO FLD0370C.
           MOVE FLD0371A        TO FLD0371C.
           MOVE FLD0372A        TO FLD0372C.
           MOVE FLD0373A        TO FLD0373C.
           MOVE FLD0374A        TO FLD0374C.
           MOVE FLD0375A        TO FLD0375C.
           MOVE FLD0376A        TO FLD0376C.
           MOVE FLD0377A        TO FLD0377C.
           MOVE FLD0378A        TO FLD0378C.
           MOVE FLD0379A        TO FLD0379C.
           MOVE FLD0380A        TO FLD0380C.
           MOVE FLD0381A        TO FLD0381C.
           MOVE FLD0382A        TO FLD0382C.
           MOVE FLD0383A        TO FLD0383C.
           MOVE FLD0384A        TO FLD0384C.
           MOVE FLD0385A        TO FLD0385C.
           MOVE FLD0386A        TO FLD0386C.
           MOVE FLD0387A        TO FLD0387C.
           MOVE FLD0388A        TO FLD0388C.
           MOVE FLD0389A        TO FLD0389C.
           MOVE FLD0390A        TO FLD0390C.
           MOVE FLD0391A        TO FLD0391C.
           MOVE FLD0392A        TO FLD0392C.
           MOVE FLD0393A        TO FLD0393C.
           MOVE FLD0394A        TO FLD0394C.
           MOVE FLD0395A        TO FLD0395C.
           MOVE FLD0396A        TO FLD0396C.
           MOVE FLD0397A        TO FLD0397C.
           MOVE FLD0398A        TO FLD0398C.
           MOVE FLD0399A        TO FLD0399C.
           MOVE FLD0400A        TO FLD0400C.
           MOVE FLD0401A        TO FLD0401C.
           MOVE FLD0402A        TO FLD0402C.
           MOVE FLD0403A        TO FLD0403C.
           MOVE FLD0404A        TO FLD0404C.
           MOVE FLD0405A        TO FLD0405C.
           MOVE FLD0406A        TO FLD0406C.
           MOVE FLD0407A        TO FLD0407C.
           MOVE FLD0408A        TO FLD0408C.
           MOVE FLD0409A        TO FLD0409C.
           MOVE FLD0410A        TO FLD0410C.
           MOVE FLD0411A        TO FLD0411C.
           MOVE FLD0412A        TO FLD0412C.
           MOVE FLD0413A        TO FLD0413C.
           MOVE FLD0414A        TO FLD0414C.
           MOVE FLD0415A        TO FLD0415C.
           MOVE FLD0416A        TO FLD0416C.
           MOVE FLD0417A        TO FLD0417C.
           MOVE FLD0418A        TO FLD0418C.
           MOVE FLD0419A        TO FLD0419C.
           MOVE FLD0420A        TO FLD0420C.
           MOVE FLD0421A        TO FLD0421C.
           MOVE FLD0422A        TO FLD0422C.
           MOVE FLD0423A        TO FLD0423C.
           MOVE FLD0424A        TO FLD0424C.
           MOVE FLD0425A        TO FLD0425C.
           MOVE FLD0426A        TO FLD0426C.
           MOVE FLD0427A        TO FLD0427C.
           MOVE FLD0428A        TO FLD0428C.
           MOVE FLD0429A        TO FLD0429C.
           MOVE FLD0430A        TO FLD0430C.
           MOVE FLD0431A        TO FLD0431C.
           MOVE FLD0432A        TO FLD0432C.
           MOVE FLD0433A        TO FLD0433C.
           MOVE FLD0434A        TO FLD0434C.
           MOVE FLD0435A        TO FLD0435C.
           MOVE FLD0436A        TO FLD0436C.
           MOVE FLD0437A        TO FLD0437C.
           MOVE FLD0438A        TO FLD0438C.
           MOVE FLD0439A        TO FLD0439C.
           MOVE FLD0440A        TO FLD0440C.
           MOVE FLD0441A        TO FLD0441C.
           MOVE FLD0442A        TO FLD0442C.
           MOVE FLD0443A        TO FLD0443C.
           MOVE FLD0444A        TO FLD0444C.
           MOVE FLD0445A        TO FLD0445C.
           MOVE FLD0446A        TO FLD0446C.
           MOVE FLD0447A        TO FLD0447C.
           MOVE FLD0448A        TO FLD0448C.
           MOVE FLD0449A        TO FLD0449C.
           MOVE FLD0450A        TO FLD0450C.
           MOVE FLD0451A        TO FLD0451C.
           MOVE FLD0452A        TO FLD0452C.
           MOVE FLD0453A        TO FLD0453C.
           MOVE FLD0454A        TO FLD0454C.
           MOVE FLD0455A        TO FLD0455C.
           MOVE FLD0456A        TO FLD0456C.
           MOVE FLD0457A        TO FLD0457C.
           MOVE FLD0458A        TO FLD0458C.
           MOVE FLD0459A        TO FLD0459C.
           MOVE FLD0460A        TO FLD0460C.
           MOVE FLD0461A        TO FLD0461C.
           MOVE FLD0462A        TO FLD0462C.
           MOVE FLD0463A        TO FLD0463C.
           MOVE FLD0464A        TO FLD0464C.
           MOVE FLD0465A        TO FLD0465C.
           MOVE FLD0466A        TO FLD0466C.
           MOVE FLD0467A        TO FLD0467C.
           MOVE FLD0468A        TO FLD0468C.
           MOVE FLD0469A        TO FLD0469C.
           MOVE FLD0470A        TO FLD0470C.
           MOVE FLD0471A        TO FLD0471C.
           MOVE FLD0472A        TO FLD0472C.
           MOVE FLD0473A        TO FLD0473C.
           MOVE FLD0474A        TO FLD0474C.
           MOVE FLD0475A        TO FLD0475C.
           MOVE FLD0476A        TO FLD0476C.
           MOVE FLD0477A        TO FLD0477C.
           MOVE FLD0478A        TO FLD0478C.
           MOVE FLD0479A        TO FLD0479C.
           MOVE FLD0480A        TO FLD0480C.
           MOVE FLD0481A        TO FLD0481C.
           MOVE FLD0482A        TO FLD0482C.
           MOVE FLD0483A        TO FLD0483C.
           MOVE FLD0484A        TO FLD0484C.
           MOVE FLD0485A        TO FLD0485C.
           MOVE FLD0486A        TO FLD0486C.
           MOVE FLD0487A        TO FLD0487C.
           MOVE FLD0488A        TO FLD0488C.
           MOVE FLD0489A        TO FLD0489C.
           MOVE FLD0490A        TO FLD0490C.
           MOVE FLD0491A        TO FLD0491C.
           MOVE FLD0492A        TO FLD0492C.
           MOVE FLD0493A        TO FLD0493C.
           MOVE FLD0494A        TO FLD0494C.
           MOVE FLD0495A        TO FLD0495C.
           MOVE FLD0496A        TO FLD0496C.
           MOVE FLD0497A        TO FLD0497C.
           MOVE FLD0498A        TO FLD0498C.
           MOVE FLD0499A        TO FLD0499C.

       4000-COMPARE.

           IF FLD0001C (1:)    NOT EQUAL XPC-FLD0001C
              DISPLAY 'FLD0001C ==> ' HEX-OF (FLD0001C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0001C).
           IF FLD0002C (1:)    NOT EQUAL XPC-FLD0002C
              DISPLAY 'FLD0002C ==> ' HEX-OF (FLD0002C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0002C).
           IF FLD0003C (1:)    NOT EQUAL XPC-FLD0003C
              DISPLAY 'FLD0003C ==> ' HEX-OF (FLD0003C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0003C).
           IF FLD0004C (1:)    NOT EQUAL XPC-FLD0004C
              DISPLAY 'FLD0004C ==> ' HEX-OF (FLD0004C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0004C).
           IF FLD0005C (1:)    NOT EQUAL XPC-FLD0005C
              DISPLAY 'FLD0005C ==> ' HEX-OF (FLD0005C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0005C).
           IF FLD0006C (1:)    NOT EQUAL XPC-FLD0006C
              DISPLAY 'FLD0006C ==> ' HEX-OF (FLD0006C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0006C).
           IF FLD0007C (1:)    NOT EQUAL XPC-FLD0007C
              DISPLAY 'FLD0007C ==> ' HEX-OF (FLD0007C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0007C).
           IF FLD0008C (1:)    NOT EQUAL XPC-FLD0008C
              DISPLAY 'FLD0008C ==> ' HEX-OF (FLD0008C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0008C).
           IF FLD0009C (1:)    NOT EQUAL XPC-FLD0009C
              DISPLAY 'FLD0009C ==> ' HEX-OF (FLD0009C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0009C).
           IF FLD0010C (1:)    NOT EQUAL XPC-FLD0010C
              DISPLAY 'FLD0010C ==> ' HEX-OF (FLD0010C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0010C).
           IF FLD0011C (1:)    NOT EQUAL XPC-FLD0011C
              DISPLAY 'FLD0011C ==> ' HEX-OF (FLD0011C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0011C).
           IF FLD0012C (1:)    NOT EQUAL XPC-FLD0012C
              DISPLAY 'FLD0012C ==> ' HEX-OF (FLD0012C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0012C).
           IF FLD0013C (1:)    NOT EQUAL XPC-FLD0013C
              DISPLAY 'FLD0013C ==> ' HEX-OF (FLD0013C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0013C).
           IF FLD0014C (1:)    NOT EQUAL XPC-FLD0014C
              DISPLAY 'FLD0014C ==> ' HEX-OF (FLD0014C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0014C).
           IF FLD0015C (1:)    NOT EQUAL XPC-FLD0015C
              DISPLAY 'FLD0015C ==> ' HEX-OF (FLD0015C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0015C).
           IF FLD0016C (1:)    NOT EQUAL XPC-FLD0016C
              DISPLAY 'FLD0016C ==> ' HEX-OF (FLD0016C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0016C).
           IF FLD0017C (1:)    NOT EQUAL XPC-FLD0017C
              DISPLAY 'FLD0017C ==> ' HEX-OF (FLD0017C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0017C).
           IF FLD0018C (1:)    NOT EQUAL XPC-FLD0018C
              DISPLAY 'FLD0018C ==> ' HEX-OF (FLD0018C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0018C).
           IF FLD0019C (1:)    NOT EQUAL XPC-FLD0019C
              DISPLAY 'FLD0019C ==> ' HEX-OF (FLD0019C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0019C).
           IF FLD0020C (1:)    NOT EQUAL XPC-FLD0020C
              DISPLAY 'FLD0020C ==> ' HEX-OF (FLD0020C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0020C).
           IF FLD0021C (1:)    NOT EQUAL XPC-FLD0021C
              DISPLAY 'FLD0021C ==> ' HEX-OF (FLD0021C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0021C).
           IF FLD0022C (1:)    NOT EQUAL XPC-FLD0022C
              DISPLAY 'FLD0022C ==> ' HEX-OF (FLD0022C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0022C).
           IF FLD0023C (1:)    NOT EQUAL XPC-FLD0023C
              DISPLAY 'FLD0023C ==> ' HEX-OF (FLD0023C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0023C).
           IF FLD0024C (1:)    NOT EQUAL XPC-FLD0024C
              DISPLAY 'FLD0024C ==> ' HEX-OF (FLD0024C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0024C).
           IF FLD0025C (1:)    NOT EQUAL XPC-FLD0025C
              DISPLAY 'FLD0025C ==> ' HEX-OF (FLD0025C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0025C).
           IF FLD0026C (1:)    NOT EQUAL XPC-FLD0026C
              DISPLAY 'FLD0026C ==> ' HEX-OF (FLD0026C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0026C).
           IF FLD0027C (1:)    NOT EQUAL XPC-FLD0027C
              DISPLAY 'FLD0027C ==> ' HEX-OF (FLD0027C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0027C).
           IF FLD0028C (1:)    NOT EQUAL XPC-FLD0028C
              DISPLAY 'FLD0028C ==> ' HEX-OF (FLD0028C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0028C).
           IF FLD0029C (1:)    NOT EQUAL XPC-FLD0029C
              DISPLAY 'FLD0029C ==> ' HEX-OF (FLD0029C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0029C).
           IF FLD0030C (1:)    NOT EQUAL XPC-FLD0030C
              DISPLAY 'FLD0030C ==> ' HEX-OF (FLD0030C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0030C).
           IF FLD0031C (1:)    NOT EQUAL XPC-FLD0031C
              DISPLAY 'FLD0031C ==> ' HEX-OF (FLD0031C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0031C).
           IF FLD0032C (1:)    NOT EQUAL XPC-FLD0032C
              DISPLAY 'FLD0032C ==> ' HEX-OF (FLD0032C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0032C).
           IF FLD0033C (1:)    NOT EQUAL XPC-FLD0033C
              DISPLAY 'FLD0033C ==> ' HEX-OF (FLD0033C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0033C).
           IF FLD0034C (1:)    NOT EQUAL XPC-FLD0034C
              DISPLAY 'FLD0034C ==> ' HEX-OF (FLD0034C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0034C).
           IF FLD0035C (1:)    NOT EQUAL XPC-FLD0035C
              DISPLAY 'FLD0035C ==> ' HEX-OF (FLD0035C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0035C).
           IF FLD0036C (1:)    NOT EQUAL XPC-FLD0036C
              DISPLAY 'FLD0036C ==> ' HEX-OF (FLD0036C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0036C).
           IF FLD0037C (1:)    NOT EQUAL XPC-FLD0037C
              DISPLAY 'FLD0037C ==> ' HEX-OF (FLD0037C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0037C).
           IF FLD0038C (1:)    NOT EQUAL XPC-FLD0038C
              DISPLAY 'FLD0038C ==> ' HEX-OF (FLD0038C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0038C).
           IF FLD0039C (1:)    NOT EQUAL XPC-FLD0039C
              DISPLAY 'FLD0039C ==> ' HEX-OF (FLD0039C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0039C).
           IF FLD0040C (1:)    NOT EQUAL XPC-FLD0040C
              DISPLAY 'FLD0040C ==> ' HEX-OF (FLD0040C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0040C).
           IF FLD0041C (1:)    NOT EQUAL XPC-FLD0041C
              DISPLAY 'FLD0041C ==> ' HEX-OF (FLD0041C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0041C).
           IF FLD0042C (1:)    NOT EQUAL XPC-FLD0042C
              DISPLAY 'FLD0042C ==> ' HEX-OF (FLD0042C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0042C).
           IF FLD0043C (1:)    NOT EQUAL XPC-FLD0043C
              DISPLAY 'FLD0043C ==> ' HEX-OF (FLD0043C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0043C).
           IF FLD0044C (1:)    NOT EQUAL XPC-FLD0044C
              DISPLAY 'FLD0044C ==> ' HEX-OF (FLD0044C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0044C).
           IF FLD0045C (1:)    NOT EQUAL XPC-FLD0045C
              DISPLAY 'FLD0045C ==> ' HEX-OF (FLD0045C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0045C).
           IF FLD0046C (1:)    NOT EQUAL XPC-FLD0046C
              DISPLAY 'FLD0046C ==> ' HEX-OF (FLD0046C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0046C).
           IF FLD0047C (1:)    NOT EQUAL XPC-FLD0047C
              DISPLAY 'FLD0047C ==> ' HEX-OF (FLD0047C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0047C).
           IF FLD0048C (1:)    NOT EQUAL XPC-FLD0048C
              DISPLAY 'FLD0048C ==> ' HEX-OF (FLD0048C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0048C).
           IF FLD0049C (1:)    NOT EQUAL XPC-FLD0049C
              DISPLAY 'FLD0049C ==> ' HEX-OF (FLD0049C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0049C).
           IF FLD0050C (1:)    NOT EQUAL XPC-FLD0050C
              DISPLAY 'FLD0050C ==> ' HEX-OF (FLD0050C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0050C).
           IF FLD0051C (1:)    NOT EQUAL XPC-FLD0051C
              DISPLAY 'FLD0051C ==> ' HEX-OF (FLD0051C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0051C).
           IF FLD0052C (1:)    NOT EQUAL XPC-FLD0052C
              DISPLAY 'FLD0052C ==> ' HEX-OF (FLD0052C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0052C).
           IF FLD0053C (1:)    NOT EQUAL XPC-FLD0053C
              DISPLAY 'FLD0053C ==> ' HEX-OF (FLD0053C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0053C).
           IF FLD0054C (1:)    NOT EQUAL XPC-FLD0054C
              DISPLAY 'FLD0054C ==> ' HEX-OF (FLD0054C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0054C).
           IF FLD0055C (1:)    NOT EQUAL XPC-FLD0055C
              DISPLAY 'FLD0055C ==> ' HEX-OF (FLD0055C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0055C).
           IF FLD0056C (1:)    NOT EQUAL XPC-FLD0056C
              DISPLAY 'FLD0056C ==> ' HEX-OF (FLD0056C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0056C).
           IF FLD0057C (1:)    NOT EQUAL XPC-FLD0057C
              DISPLAY 'FLD0057C ==> ' HEX-OF (FLD0057C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0057C).
           IF FLD0058C (1:)    NOT EQUAL XPC-FLD0058C
              DISPLAY 'FLD0058C ==> ' HEX-OF (FLD0058C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0058C).
           IF FLD0059C (1:)    NOT EQUAL XPC-FLD0059C
              DISPLAY 'FLD0059C ==> ' HEX-OF (FLD0059C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0059C).
           IF FLD0060C (1:)    NOT EQUAL XPC-FLD0060C
              DISPLAY 'FLD0060C ==> ' HEX-OF (FLD0060C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0060C).
           IF FLD0061C (1:)    NOT EQUAL XPC-FLD0061C
              DISPLAY 'FLD0061C ==> ' HEX-OF (FLD0061C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0061C).
           IF FLD0062C (1:)    NOT EQUAL XPC-FLD0062C
              DISPLAY 'FLD0062C ==> ' HEX-OF (FLD0062C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0062C).
           IF FLD0063C (1:)    NOT EQUAL XPC-FLD0063C
              DISPLAY 'FLD0063C ==> ' HEX-OF (FLD0063C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0063C).
           IF FLD0064C (1:)    NOT EQUAL XPC-FLD0064C
              DISPLAY 'FLD0064C ==> ' HEX-OF (FLD0064C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0064C).
           IF FLD0065C (1:)    NOT EQUAL XPC-FLD0065C
              DISPLAY 'FLD0065C ==> ' HEX-OF (FLD0065C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0065C).
           IF FLD0066C (1:)    NOT EQUAL XPC-FLD0066C
              DISPLAY 'FLD0066C ==> ' HEX-OF (FLD0066C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0066C).
           IF FLD0067C (1:)    NOT EQUAL XPC-FLD0067C
              DISPLAY 'FLD0067C ==> ' HEX-OF (FLD0067C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0067C).
           IF FLD0068C (1:)    NOT EQUAL XPC-FLD0068C
              DISPLAY 'FLD0068C ==> ' HEX-OF (FLD0068C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0068C).
           IF FLD0069C (1:)    NOT EQUAL XPC-FLD0069C
              DISPLAY 'FLD0069C ==> ' HEX-OF (FLD0069C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0069C).
           IF FLD0070C (1:)    NOT EQUAL XPC-FLD0070C
              DISPLAY 'FLD0070C ==> ' HEX-OF (FLD0070C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0070C).
           IF FLD0071C (1:)    NOT EQUAL XPC-FLD0071C
              DISPLAY 'FLD0071C ==> ' HEX-OF (FLD0071C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0071C).
           IF FLD0072C (1:)    NOT EQUAL XPC-FLD0072C
              DISPLAY 'FLD0072C ==> ' HEX-OF (FLD0072C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0072C).
           IF FLD0073C (1:)    NOT EQUAL XPC-FLD0073C
              DISPLAY 'FLD0073C ==> ' HEX-OF (FLD0073C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0073C).
           IF FLD0074C (1:)    NOT EQUAL XPC-FLD0074C
              DISPLAY 'FLD0074C ==> ' HEX-OF (FLD0074C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0074C).
           IF FLD0075C (1:)    NOT EQUAL XPC-FLD0075C
              DISPLAY 'FLD0075C ==> ' HEX-OF (FLD0075C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0075C).
           IF FLD0076C (1:)    NOT EQUAL XPC-FLD0076C
              DISPLAY 'FLD0076C ==> ' HEX-OF (FLD0076C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0076C).
           IF FLD0077C (1:)    NOT EQUAL XPC-FLD0077C
              DISPLAY 'FLD0077C ==> ' HEX-OF (FLD0077C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0077C).
           IF FLD0078C (1:)    NOT EQUAL XPC-FLD0078C
              DISPLAY 'FLD0078C ==> ' HEX-OF (FLD0078C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0078C).
           IF FLD0079C (1:)    NOT EQUAL XPC-FLD0079C
              DISPLAY 'FLD0079C ==> ' HEX-OF (FLD0079C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0079C).
           IF FLD0080C (1:)    NOT EQUAL XPC-FLD0080C
              DISPLAY 'FLD0080C ==> ' HEX-OF (FLD0080C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0080C).
           IF FLD0081C (1:)    NOT EQUAL XPC-FLD0081C
              DISPLAY 'FLD0081C ==> ' HEX-OF (FLD0081C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0081C).
           IF FLD0082C (1:)    NOT EQUAL XPC-FLD0082C
              DISPLAY 'FLD0082C ==> ' HEX-OF (FLD0082C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0082C).
           IF FLD0083C (1:)    NOT EQUAL XPC-FLD0083C
              DISPLAY 'FLD0083C ==> ' HEX-OF (FLD0083C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0083C).
           IF FLD0084C (1:)    NOT EQUAL XPC-FLD0084C
              DISPLAY 'FLD0084C ==> ' HEX-OF (FLD0084C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0084C).
           IF FLD0085C (1:)    NOT EQUAL XPC-FLD0085C
              DISPLAY 'FLD0085C ==> ' HEX-OF (FLD0085C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0085C).
           IF FLD0086C (1:)    NOT EQUAL XPC-FLD0086C
              DISPLAY 'FLD0086C ==> ' HEX-OF (FLD0086C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0086C).
           IF FLD0087C (1:)    NOT EQUAL XPC-FLD0087C
              DISPLAY 'FLD0087C ==> ' HEX-OF (FLD0087C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0087C).
           IF FLD0088C (1:)    NOT EQUAL XPC-FLD0088C
              DISPLAY 'FLD0088C ==> ' HEX-OF (FLD0088C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0088C).
           IF FLD0089C (1:)    NOT EQUAL XPC-FLD0089C
              DISPLAY 'FLD0089C ==> ' HEX-OF (FLD0089C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0089C).
           IF FLD0090C (1:)    NOT EQUAL XPC-FLD0090C
              DISPLAY 'FLD0090C ==> ' HEX-OF (FLD0090C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0090C).
           IF FLD0091C (1:)    NOT EQUAL XPC-FLD0091C
              DISPLAY 'FLD0091C ==> ' HEX-OF (FLD0091C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0091C).
           IF FLD0092C (1:)    NOT EQUAL XPC-FLD0092C
              DISPLAY 'FLD0092C ==> ' HEX-OF (FLD0092C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0092C).
           IF FLD0093C (1:)    NOT EQUAL XPC-FLD0093C
              DISPLAY 'FLD0093C ==> ' HEX-OF (FLD0093C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0093C).
           IF FLD0094C (1:)    NOT EQUAL XPC-FLD0094C
              DISPLAY 'FLD0094C ==> ' HEX-OF (FLD0094C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0094C).
           IF FLD0095C (1:)    NOT EQUAL XPC-FLD0095C
              DISPLAY 'FLD0095C ==> ' HEX-OF (FLD0095C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0095C).
           IF FLD0096C (1:)    NOT EQUAL XPC-FLD0096C
              DISPLAY 'FLD0096C ==> ' HEX-OF (FLD0096C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0096C).
           IF FLD0097C (1:)    NOT EQUAL XPC-FLD0097C
              DISPLAY 'FLD0097C ==> ' HEX-OF (FLD0097C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0097C).
           IF FLD0098C (1:)    NOT EQUAL XPC-FLD0098C
              DISPLAY 'FLD0098C ==> ' HEX-OF (FLD0098C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0098C).
           IF FLD0099C (1:)    NOT EQUAL XPC-FLD0099C
              DISPLAY 'FLD0099C ==> ' HEX-OF (FLD0099C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0099C).
           IF FLD0100C (1:)    NOT EQUAL XPC-FLD0100C
              DISPLAY 'FLD0100C ==> ' HEX-OF (FLD0100C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0100C).
           IF FLD0101C (1:)    NOT EQUAL XPC-FLD0101C
              DISPLAY 'FLD0101C ==> ' HEX-OF (FLD0101C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0101C).
           IF FLD0102C (1:)    NOT EQUAL XPC-FLD0102C
              DISPLAY 'FLD0102C ==> ' HEX-OF (FLD0102C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0102C).
           IF FLD0103C (1:)    NOT EQUAL XPC-FLD0103C
              DISPLAY 'FLD0103C ==> ' HEX-OF (FLD0103C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0103C).
           IF FLD0104C (1:)    NOT EQUAL XPC-FLD0104C
              DISPLAY 'FLD0104C ==> ' HEX-OF (FLD0104C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0104C).
           IF FLD0105C (1:)    NOT EQUAL XPC-FLD0105C
              DISPLAY 'FLD0105C ==> ' HEX-OF (FLD0105C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0105C).
           IF FLD0106C (1:)    NOT EQUAL XPC-FLD0106C
              DISPLAY 'FLD0106C ==> ' HEX-OF (FLD0106C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0106C).
           IF FLD0107C (1:)    NOT EQUAL XPC-FLD0107C
              DISPLAY 'FLD0107C ==> ' HEX-OF (FLD0107C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0107C).
           IF FLD0108C (1:)    NOT EQUAL XPC-FLD0108C
              DISPLAY 'FLD0108C ==> ' HEX-OF (FLD0108C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0108C).
           IF FLD0109C (1:)    NOT EQUAL XPC-FLD0109C
              DISPLAY 'FLD0109C ==> ' HEX-OF (FLD0109C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0109C).
           IF FLD0110C (1:)    NOT EQUAL XPC-FLD0110C
              DISPLAY 'FLD0110C ==> ' HEX-OF (FLD0110C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0110C).
           IF FLD0111C (1:)    NOT EQUAL XPC-FLD0111C
              DISPLAY 'FLD0111C ==> ' HEX-OF (FLD0111C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0111C).
           IF FLD0112C (1:)    NOT EQUAL XPC-FLD0112C
              DISPLAY 'FLD0112C ==> ' HEX-OF (FLD0112C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0112C).
           IF FLD0113C (1:)    NOT EQUAL XPC-FLD0113C
              DISPLAY 'FLD0113C ==> ' HEX-OF (FLD0113C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0113C).
           IF FLD0114C (1:)    NOT EQUAL XPC-FLD0114C
              DISPLAY 'FLD0114C ==> ' HEX-OF (FLD0114C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0114C).
           IF FLD0115C (1:)    NOT EQUAL XPC-FLD0115C
              DISPLAY 'FLD0115C ==> ' HEX-OF (FLD0115C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0115C).
           IF FLD0116C (1:)    NOT EQUAL XPC-FLD0116C
              DISPLAY 'FLD0116C ==> ' HEX-OF (FLD0116C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0116C).
           IF FLD0117C (1:)    NOT EQUAL XPC-FLD0117C
              DISPLAY 'FLD0117C ==> ' HEX-OF (FLD0117C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0117C).
           IF FLD0118C (1:)    NOT EQUAL XPC-FLD0118C
              DISPLAY 'FLD0118C ==> ' HEX-OF (FLD0118C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0118C).
           IF FLD0119C (1:)    NOT EQUAL XPC-FLD0119C
              DISPLAY 'FLD0119C ==> ' HEX-OF (FLD0119C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0119C).
           IF FLD0120C (1:)    NOT EQUAL XPC-FLD0120C
              DISPLAY 'FLD0120C ==> ' HEX-OF (FLD0120C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0120C).
           IF FLD0121C (1:)    NOT EQUAL XPC-FLD0121C
              DISPLAY 'FLD0121C ==> ' HEX-OF (FLD0121C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0121C).
           IF FLD0122C (1:)    NOT EQUAL XPC-FLD0122C
              DISPLAY 'FLD0122C ==> ' HEX-OF (FLD0122C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0122C).
           IF FLD0123C (1:)    NOT EQUAL XPC-FLD0123C
              DISPLAY 'FLD0123C ==> ' HEX-OF (FLD0123C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0123C).
           IF FLD0124C (1:)    NOT EQUAL XPC-FLD0124C
              DISPLAY 'FLD0124C ==> ' HEX-OF (FLD0124C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0124C).
           IF FLD0125C (1:)    NOT EQUAL XPC-FLD0125C
              DISPLAY 'FLD0125C ==> ' HEX-OF (FLD0125C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0125C).
           IF FLD0126C (1:)    NOT EQUAL XPC-FLD0126C
              DISPLAY 'FLD0126C ==> ' HEX-OF (FLD0126C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0126C).
           IF FLD0127C (1:)    NOT EQUAL XPC-FLD0127C
              DISPLAY 'FLD0127C ==> ' HEX-OF (FLD0127C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0127C).
           IF FLD0128C (1:)    NOT EQUAL XPC-FLD0128C
              DISPLAY 'FLD0128C ==> ' HEX-OF (FLD0128C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0128C).
           IF FLD0129C (1:)    NOT EQUAL XPC-FLD0129C
              DISPLAY 'FLD0129C ==> ' HEX-OF (FLD0129C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0129C).
           IF FLD0130C (1:)    NOT EQUAL XPC-FLD0130C
              DISPLAY 'FLD0130C ==> ' HEX-OF (FLD0130C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0130C).
           IF FLD0131C (1:)    NOT EQUAL XPC-FLD0131C
              DISPLAY 'FLD0131C ==> ' HEX-OF (FLD0131C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0131C).
           IF FLD0132C (1:)    NOT EQUAL XPC-FLD0132C
              DISPLAY 'FLD0132C ==> ' HEX-OF (FLD0132C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0132C).
           IF FLD0133C (1:)    NOT EQUAL XPC-FLD0133C
              DISPLAY 'FLD0133C ==> ' HEX-OF (FLD0133C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0133C).
           IF FLD0134C (1:)    NOT EQUAL XPC-FLD0134C
              DISPLAY 'FLD0134C ==> ' HEX-OF (FLD0134C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0134C).
           IF FLD0135C (1:)    NOT EQUAL XPC-FLD0135C
              DISPLAY 'FLD0135C ==> ' HEX-OF (FLD0135C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0135C).
           IF FLD0136C (1:)    NOT EQUAL XPC-FLD0136C
              DISPLAY 'FLD0136C ==> ' HEX-OF (FLD0136C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0136C).
           IF FLD0137C (1:)    NOT EQUAL XPC-FLD0137C
              DISPLAY 'FLD0137C ==> ' HEX-OF (FLD0137C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0137C).
           IF FLD0138C (1:)    NOT EQUAL XPC-FLD0138C
              DISPLAY 'FLD0138C ==> ' HEX-OF (FLD0138C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0138C).
           IF FLD0139C (1:)    NOT EQUAL XPC-FLD0139C
              DISPLAY 'FLD0139C ==> ' HEX-OF (FLD0139C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0139C).
           IF FLD0140C (1:)    NOT EQUAL XPC-FLD0140C
              DISPLAY 'FLD0140C ==> ' HEX-OF (FLD0140C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0140C).
           IF FLD0141C (1:)    NOT EQUAL XPC-FLD0141C
              DISPLAY 'FLD0141C ==> ' HEX-OF (FLD0141C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0141C).
           IF FLD0142C (1:)    NOT EQUAL XPC-FLD0142C
              DISPLAY 'FLD0142C ==> ' HEX-OF (FLD0142C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0142C).
           IF FLD0143C (1:)    NOT EQUAL XPC-FLD0143C
              DISPLAY 'FLD0143C ==> ' HEX-OF (FLD0143C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0143C).
           IF FLD0144C (1:)    NOT EQUAL XPC-FLD0144C
              DISPLAY 'FLD0144C ==> ' HEX-OF (FLD0144C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0144C).
           IF FLD0145C (1:)    NOT EQUAL XPC-FLD0145C
              DISPLAY 'FLD0145C ==> ' HEX-OF (FLD0145C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0145C).
           IF FLD0146C (1:)    NOT EQUAL XPC-FLD0146C
              DISPLAY 'FLD0146C ==> ' HEX-OF (FLD0146C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0146C).
           IF FLD0147C (1:)    NOT EQUAL XPC-FLD0147C
              DISPLAY 'FLD0147C ==> ' HEX-OF (FLD0147C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0147C).
           IF FLD0148C (1:)    NOT EQUAL XPC-FLD0148C
              DISPLAY 'FLD0148C ==> ' HEX-OF (FLD0148C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0148C).
           IF FLD0149C (1:)    NOT EQUAL XPC-FLD0149C
              DISPLAY 'FLD0149C ==> ' HEX-OF (FLD0149C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0149C).
           IF FLD0150C (1:)    NOT EQUAL XPC-FLD0150C
              DISPLAY 'FLD0150C ==> ' HEX-OF (FLD0150C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0150C).
           IF FLD0151C (1:)    NOT EQUAL XPC-FLD0151C
              DISPLAY 'FLD0151C ==> ' HEX-OF (FLD0151C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0151C).
           IF FLD0152C (1:)    NOT EQUAL XPC-FLD0152C
              DISPLAY 'FLD0152C ==> ' HEX-OF (FLD0152C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0152C).
           IF FLD0153C (1:)    NOT EQUAL XPC-FLD0153C
              DISPLAY 'FLD0153C ==> ' HEX-OF (FLD0153C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0153C).
           IF FLD0154C (1:)    NOT EQUAL XPC-FLD0154C
              DISPLAY 'FLD0154C ==> ' HEX-OF (FLD0154C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0154C).
           IF FLD0155C (1:)    NOT EQUAL XPC-FLD0155C
              DISPLAY 'FLD0155C ==> ' HEX-OF (FLD0155C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0155C).
           IF FLD0156C (1:)    NOT EQUAL XPC-FLD0156C
              DISPLAY 'FLD0156C ==> ' HEX-OF (FLD0156C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0156C).
           IF FLD0157C (1:)    NOT EQUAL XPC-FLD0157C
              DISPLAY 'FLD0157C ==> ' HEX-OF (FLD0157C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0157C).
           IF FLD0158C (1:)    NOT EQUAL XPC-FLD0158C
              DISPLAY 'FLD0158C ==> ' HEX-OF (FLD0158C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0158C).
           IF FLD0159C (1:)    NOT EQUAL XPC-FLD0159C
              DISPLAY 'FLD0159C ==> ' HEX-OF (FLD0159C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0159C).
           IF FLD0160C (1:)    NOT EQUAL XPC-FLD0160C
              DISPLAY 'FLD0160C ==> ' HEX-OF (FLD0160C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0160C).
           IF FLD0161C (1:)    NOT EQUAL XPC-FLD0161C
              DISPLAY 'FLD0161C ==> ' HEX-OF (FLD0161C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0161C).
           IF FLD0162C (1:)    NOT EQUAL XPC-FLD0162C
              DISPLAY 'FLD0162C ==> ' HEX-OF (FLD0162C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0162C).
           IF FLD0163C (1:)    NOT EQUAL XPC-FLD0163C
              DISPLAY 'FLD0163C ==> ' HEX-OF (FLD0163C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0163C).
           IF FLD0164C (1:)    NOT EQUAL XPC-FLD0164C
              DISPLAY 'FLD0164C ==> ' HEX-OF (FLD0164C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0164C).
           IF FLD0165C (1:)    NOT EQUAL XPC-FLD0165C
              DISPLAY 'FLD0165C ==> ' HEX-OF (FLD0165C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0165C).
           IF FLD0166C (1:)    NOT EQUAL XPC-FLD0166C
              DISPLAY 'FLD0166C ==> ' HEX-OF (FLD0166C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0166C).
           IF FLD0167C (1:)    NOT EQUAL XPC-FLD0167C
              DISPLAY 'FLD0167C ==> ' HEX-OF (FLD0167C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0167C).
           IF FLD0168C (1:)    NOT EQUAL XPC-FLD0168C
              DISPLAY 'FLD0168C ==> ' HEX-OF (FLD0168C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0168C).
           IF FLD0169C (1:)    NOT EQUAL XPC-FLD0169C
              DISPLAY 'FLD0169C ==> ' HEX-OF (FLD0169C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0169C).
           IF FLD0170C (1:)    NOT EQUAL XPC-FLD0170C
              DISPLAY 'FLD0170C ==> ' HEX-OF (FLD0170C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0170C).
           IF FLD0171C (1:)    NOT EQUAL XPC-FLD0171C
              DISPLAY 'FLD0171C ==> ' HEX-OF (FLD0171C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0171C).
           IF FLD0172C (1:)    NOT EQUAL XPC-FLD0172C
              DISPLAY 'FLD0172C ==> ' HEX-OF (FLD0172C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0172C).
           IF FLD0173C (1:)    NOT EQUAL XPC-FLD0173C
              DISPLAY 'FLD0173C ==> ' HEX-OF (FLD0173C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0173C).
           IF FLD0174C (1:)    NOT EQUAL XPC-FLD0174C
              DISPLAY 'FLD0174C ==> ' HEX-OF (FLD0174C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0174C).
           IF FLD0175C (1:)    NOT EQUAL XPC-FLD0175C
              DISPLAY 'FLD0175C ==> ' HEX-OF (FLD0175C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0175C).
           IF FLD0176C (1:)    NOT EQUAL XPC-FLD0176C
              DISPLAY 'FLD0176C ==> ' HEX-OF (FLD0176C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0176C).
           IF FLD0177C (1:)    NOT EQUAL XPC-FLD0177C
              DISPLAY 'FLD0177C ==> ' HEX-OF (FLD0177C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0177C).
           IF FLD0178C (1:)    NOT EQUAL XPC-FLD0178C
              DISPLAY 'FLD0178C ==> ' HEX-OF (FLD0178C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0178C).
           IF FLD0179C (1:)    NOT EQUAL XPC-FLD0179C
              DISPLAY 'FLD0179C ==> ' HEX-OF (FLD0179C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0179C).
           IF FLD0180C (1:)    NOT EQUAL XPC-FLD0180C
              DISPLAY 'FLD0180C ==> ' HEX-OF (FLD0180C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0180C).
           IF FLD0181C (1:)    NOT EQUAL XPC-FLD0181C
              DISPLAY 'FLD0181C ==> ' HEX-OF (FLD0181C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0181C).
           IF FLD0182C (1:)    NOT EQUAL XPC-FLD0182C
              DISPLAY 'FLD0182C ==> ' HEX-OF (FLD0182C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0182C).
           IF FLD0183C (1:)    NOT EQUAL XPC-FLD0183C
              DISPLAY 'FLD0183C ==> ' HEX-OF (FLD0183C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0183C).
           IF FLD0184C (1:)    NOT EQUAL XPC-FLD0184C
              DISPLAY 'FLD0184C ==> ' HEX-OF (FLD0184C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0184C).
           IF FLD0185C (1:)    NOT EQUAL XPC-FLD0185C
              DISPLAY 'FLD0185C ==> ' HEX-OF (FLD0185C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0185C).
           IF FLD0186C (1:)    NOT EQUAL XPC-FLD0186C
              DISPLAY 'FLD0186C ==> ' HEX-OF (FLD0186C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0186C).
           IF FLD0187C (1:)    NOT EQUAL XPC-FLD0187C
              DISPLAY 'FLD0187C ==> ' HEX-OF (FLD0187C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0187C).
           IF FLD0188C (1:)    NOT EQUAL XPC-FLD0188C
              DISPLAY 'FLD0188C ==> ' HEX-OF (FLD0188C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0188C).
           IF FLD0189C (1:)    NOT EQUAL XPC-FLD0189C
              DISPLAY 'FLD0189C ==> ' HEX-OF (FLD0189C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0189C).
           IF FLD0190C (1:)    NOT EQUAL XPC-FLD0190C
              DISPLAY 'FLD0190C ==> ' HEX-OF (FLD0190C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0190C).
           IF FLD0191C (1:)    NOT EQUAL XPC-FLD0191C
              DISPLAY 'FLD0191C ==> ' HEX-OF (FLD0191C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0191C).
           IF FLD0192C (1:)    NOT EQUAL XPC-FLD0192C
              DISPLAY 'FLD0192C ==> ' HEX-OF (FLD0192C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0192C).
           IF FLD0193C (1:)    NOT EQUAL XPC-FLD0193C
              DISPLAY 'FLD0193C ==> ' HEX-OF (FLD0193C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0193C).
           IF FLD0194C (1:)    NOT EQUAL XPC-FLD0194C
              DISPLAY 'FLD0194C ==> ' HEX-OF (FLD0194C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0194C).
           IF FLD0195C (1:)    NOT EQUAL XPC-FLD0195C
              DISPLAY 'FLD0195C ==> ' HEX-OF (FLD0195C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0195C).
           IF FLD0196C (1:)    NOT EQUAL XPC-FLD0196C
              DISPLAY 'FLD0196C ==> ' HEX-OF (FLD0196C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0196C).
           IF FLD0197C (1:)    NOT EQUAL XPC-FLD0197C
              DISPLAY 'FLD0197C ==> ' HEX-OF (FLD0197C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0197C).
           IF FLD0198C (1:)    NOT EQUAL XPC-FLD0198C
              DISPLAY 'FLD0198C ==> ' HEX-OF (FLD0198C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0198C).
           IF FLD0199C (1:)    NOT EQUAL XPC-FLD0199C
              DISPLAY 'FLD0199C ==> ' HEX-OF (FLD0199C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0199C).
           IF FLD0200C (1:)    NOT EQUAL XPC-FLD0200C
              DISPLAY 'FLD0200C ==> ' HEX-OF (FLD0200C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0200C).
           IF FLD0201C (1:)    NOT EQUAL XPC-FLD0201C
              DISPLAY 'FLD0201C ==> ' HEX-OF (FLD0201C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0201C).
           IF FLD0202C (1:)    NOT EQUAL XPC-FLD0202C
              DISPLAY 'FLD0202C ==> ' HEX-OF (FLD0202C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0202C).
           IF FLD0203C (1:)    NOT EQUAL XPC-FLD0203C
              DISPLAY 'FLD0203C ==> ' HEX-OF (FLD0203C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0203C).
           IF FLD0204C (1:)    NOT EQUAL XPC-FLD0204C
              DISPLAY 'FLD0204C ==> ' HEX-OF (FLD0204C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0204C).
           IF FLD0205C (1:)    NOT EQUAL XPC-FLD0205C
              DISPLAY 'FLD0205C ==> ' HEX-OF (FLD0205C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0205C).
           IF FLD0206C (1:)    NOT EQUAL XPC-FLD0206C
              DISPLAY 'FLD0206C ==> ' HEX-OF (FLD0206C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0206C).
           IF FLD0207C (1:)    NOT EQUAL XPC-FLD0207C
              DISPLAY 'FLD0207C ==> ' HEX-OF (FLD0207C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0207C).
           IF FLD0208C (1:)    NOT EQUAL XPC-FLD0208C
              DISPLAY 'FLD0208C ==> ' HEX-OF (FLD0208C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0208C).
           IF FLD0209C (1:)    NOT EQUAL XPC-FLD0209C
              DISPLAY 'FLD0209C ==> ' HEX-OF (FLD0209C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0209C).
           IF FLD0210C (1:)    NOT EQUAL XPC-FLD0210C
              DISPLAY 'FLD0210C ==> ' HEX-OF (FLD0210C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0210C).
           IF FLD0211C (1:)    NOT EQUAL XPC-FLD0211C
              DISPLAY 'FLD0211C ==> ' HEX-OF (FLD0211C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0211C).
           IF FLD0212C (1:)    NOT EQUAL XPC-FLD0212C
              DISPLAY 'FLD0212C ==> ' HEX-OF (FLD0212C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0212C).
           IF FLD0213C (1:)    NOT EQUAL XPC-FLD0213C
              DISPLAY 'FLD0213C ==> ' HEX-OF (FLD0213C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0213C).
           IF FLD0214C (1:)    NOT EQUAL XPC-FLD0214C
              DISPLAY 'FLD0214C ==> ' HEX-OF (FLD0214C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0214C).
           IF FLD0215C (1:)    NOT EQUAL XPC-FLD0215C
              DISPLAY 'FLD0215C ==> ' HEX-OF (FLD0215C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0215C).
           IF FLD0216C (1:)    NOT EQUAL XPC-FLD0216C
              DISPLAY 'FLD0216C ==> ' HEX-OF (FLD0216C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0216C).
           IF FLD0217C (1:)    NOT EQUAL XPC-FLD0217C
              DISPLAY 'FLD0217C ==> ' HEX-OF (FLD0217C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0217C).
           IF FLD0218C (1:)    NOT EQUAL XPC-FLD0218C
              DISPLAY 'FLD0218C ==> ' HEX-OF (FLD0218C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0218C).
           IF FLD0219C (1:)    NOT EQUAL XPC-FLD0219C
              DISPLAY 'FLD0219C ==> ' HEX-OF (FLD0219C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0219C).
           IF FLD0220C (1:)    NOT EQUAL XPC-FLD0220C
              DISPLAY 'FLD0220C ==> ' HEX-OF (FLD0220C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0220C).
           IF FLD0221C (1:)    NOT EQUAL XPC-FLD0221C
              DISPLAY 'FLD0221C ==> ' HEX-OF (FLD0221C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0221C).
           IF FLD0222C (1:)    NOT EQUAL XPC-FLD0222C
              DISPLAY 'FLD0222C ==> ' HEX-OF (FLD0222C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0222C).
           IF FLD0223C (1:)    NOT EQUAL XPC-FLD0223C
              DISPLAY 'FLD0223C ==> ' HEX-OF (FLD0223C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0223C).
           IF FLD0224C (1:)    NOT EQUAL XPC-FLD0224C
              DISPLAY 'FLD0224C ==> ' HEX-OF (FLD0224C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0224C).
           IF FLD0225C (1:)    NOT EQUAL XPC-FLD0225C
              DISPLAY 'FLD0225C ==> ' HEX-OF (FLD0225C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0225C).
           IF FLD0226C (1:)    NOT EQUAL XPC-FLD0226C
              DISPLAY 'FLD0226C ==> ' HEX-OF (FLD0226C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0226C).
           IF FLD0227C (1:)    NOT EQUAL XPC-FLD0227C
              DISPLAY 'FLD0227C ==> ' HEX-OF (FLD0227C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0227C).
           IF FLD0228C (1:)    NOT EQUAL XPC-FLD0228C
              DISPLAY 'FLD0228C ==> ' HEX-OF (FLD0228C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0228C).
           IF FLD0229C (1:)    NOT EQUAL XPC-FLD0229C
              DISPLAY 'FLD0229C ==> ' HEX-OF (FLD0229C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0229C).
           IF FLD0230C (1:)    NOT EQUAL XPC-FLD0230C
              DISPLAY 'FLD0230C ==> ' HEX-OF (FLD0230C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0230C).
           IF FLD0231C (1:)    NOT EQUAL XPC-FLD0231C
              DISPLAY 'FLD0231C ==> ' HEX-OF (FLD0231C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0231C).
           IF FLD0232C (1:)    NOT EQUAL XPC-FLD0232C
              DISPLAY 'FLD0232C ==> ' HEX-OF (FLD0232C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0232C).
           IF FLD0233C (1:)    NOT EQUAL XPC-FLD0233C
              DISPLAY 'FLD0233C ==> ' HEX-OF (FLD0233C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0233C).
           IF FLD0234C (1:)    NOT EQUAL XPC-FLD0234C
              DISPLAY 'FLD0234C ==> ' HEX-OF (FLD0234C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0234C).
           IF FLD0235C (1:)    NOT EQUAL XPC-FLD0235C
              DISPLAY 'FLD0235C ==> ' HEX-OF (FLD0235C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0235C).
           IF FLD0236C (1:)    NOT EQUAL XPC-FLD0236C
              DISPLAY 'FLD0236C ==> ' HEX-OF (FLD0236C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0236C).
           IF FLD0237C (1:)    NOT EQUAL XPC-FLD0237C
              DISPLAY 'FLD0237C ==> ' HEX-OF (FLD0237C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0237C).
           IF FLD0238C (1:)    NOT EQUAL XPC-FLD0238C
              DISPLAY 'FLD0238C ==> ' HEX-OF (FLD0238C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0238C).
           IF FLD0239C (1:)    NOT EQUAL XPC-FLD0239C
              DISPLAY 'FLD0239C ==> ' HEX-OF (FLD0239C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0239C).
           IF FLD0240C (1:)    NOT EQUAL XPC-FLD0240C
              DISPLAY 'FLD0240C ==> ' HEX-OF (FLD0240C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0240C).
           IF FLD0241C (1:)    NOT EQUAL XPC-FLD0241C
              DISPLAY 'FLD0241C ==> ' HEX-OF (FLD0241C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0241C).
           IF FLD0242C (1:)    NOT EQUAL XPC-FLD0242C
              DISPLAY 'FLD0242C ==> ' HEX-OF (FLD0242C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0242C).
           IF FLD0243C (1:)    NOT EQUAL XPC-FLD0243C
              DISPLAY 'FLD0243C ==> ' HEX-OF (FLD0243C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0243C).
           IF FLD0244C (1:)    NOT EQUAL XPC-FLD0244C
              DISPLAY 'FLD0244C ==> ' HEX-OF (FLD0244C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0244C).
           IF FLD0245C (1:)    NOT EQUAL XPC-FLD0245C
              DISPLAY 'FLD0245C ==> ' HEX-OF (FLD0245C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0245C).
           IF FLD0246C (1:)    NOT EQUAL XPC-FLD0246C
              DISPLAY 'FLD0246C ==> ' HEX-OF (FLD0246C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0246C).
           IF FLD0247C (1:)    NOT EQUAL XPC-FLD0247C
              DISPLAY 'FLD0247C ==> ' HEX-OF (FLD0247C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0247C).
           IF FLD0248C (1:)    NOT EQUAL XPC-FLD0248C
              DISPLAY 'FLD0248C ==> ' HEX-OF (FLD0248C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0248C).
           IF FLD0249C (1:)    NOT EQUAL XPC-FLD0249C
              DISPLAY 'FLD0249C ==> ' HEX-OF (FLD0249C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0249C).
           IF FLD0250C (1:)    NOT EQUAL XPC-FLD0250C
              DISPLAY 'FLD0250C ==> ' HEX-OF (FLD0250C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0250C).
           IF FLD0251C (1:)    NOT EQUAL XPC-FLD0251C
              DISPLAY 'FLD0251C ==> ' HEX-OF (FLD0251C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0251C).
           IF FLD0252C (1:)    NOT EQUAL XPC-FLD0252C
              DISPLAY 'FLD0252C ==> ' HEX-OF (FLD0252C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0252C).
           IF FLD0253C (1:)    NOT EQUAL XPC-FLD0253C
              DISPLAY 'FLD0253C ==> ' HEX-OF (FLD0253C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0253C).
           IF FLD0254C (1:)    NOT EQUAL XPC-FLD0254C
              DISPLAY 'FLD0254C ==> ' HEX-OF (FLD0254C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0254C).
           IF FLD0255C (1:)    NOT EQUAL XPC-FLD0255C
              DISPLAY 'FLD0255C ==> ' HEX-OF (FLD0255C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0255C).
           IF FLD0256C (1:)    NOT EQUAL XPC-FLD0256C
              DISPLAY 'FLD0256C ==> ' HEX-OF (FLD0256C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0256C).
           IF FLD0257C (1:)    NOT EQUAL XPC-FLD0257C
              DISPLAY 'FLD0257C ==> ' HEX-OF (FLD0257C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0257C).
           IF FLD0258C (1:)    NOT EQUAL XPC-FLD0258C
              DISPLAY 'FLD0258C ==> ' HEX-OF (FLD0258C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0258C).
           IF FLD0259C (1:)    NOT EQUAL XPC-FLD0259C
              DISPLAY 'FLD0259C ==> ' HEX-OF (FLD0259C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0259C).
           IF FLD0260C (1:)    NOT EQUAL XPC-FLD0260C
              DISPLAY 'FLD0260C ==> ' HEX-OF (FLD0260C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0260C).
           IF FLD0261C (1:)    NOT EQUAL XPC-FLD0261C
              DISPLAY 'FLD0261C ==> ' HEX-OF (FLD0261C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0261C).
           IF FLD0262C (1:)    NOT EQUAL XPC-FLD0262C
              DISPLAY 'FLD0262C ==> ' HEX-OF (FLD0262C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0262C).
           IF FLD0263C (1:)    NOT EQUAL XPC-FLD0263C
              DISPLAY 'FLD0263C ==> ' HEX-OF (FLD0263C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0263C).
           IF FLD0264C (1:)    NOT EQUAL XPC-FLD0264C
              DISPLAY 'FLD0264C ==> ' HEX-OF (FLD0264C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0264C).
           IF FLD0265C (1:)    NOT EQUAL XPC-FLD0265C
              DISPLAY 'FLD0265C ==> ' HEX-OF (FLD0265C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0265C).
           IF FLD0266C (1:)    NOT EQUAL XPC-FLD0266C
              DISPLAY 'FLD0266C ==> ' HEX-OF (FLD0266C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0266C).
           IF FLD0267C (1:)    NOT EQUAL XPC-FLD0267C
              DISPLAY 'FLD0267C ==> ' HEX-OF (FLD0267C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0267C).
           IF FLD0268C (1:)    NOT EQUAL XPC-FLD0268C
              DISPLAY 'FLD0268C ==> ' HEX-OF (FLD0268C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0268C).
           IF FLD0269C (1:)    NOT EQUAL XPC-FLD0269C
              DISPLAY 'FLD0269C ==> ' HEX-OF (FLD0269C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0269C).
           IF FLD0270C (1:)    NOT EQUAL XPC-FLD0270C
              DISPLAY 'FLD0270C ==> ' HEX-OF (FLD0270C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0270C).
           IF FLD0271C (1:)    NOT EQUAL XPC-FLD0271C
              DISPLAY 'FLD0271C ==> ' HEX-OF (FLD0271C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0271C).
           IF FLD0272C (1:)    NOT EQUAL XPC-FLD0272C
              DISPLAY 'FLD0272C ==> ' HEX-OF (FLD0272C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0272C).
           IF FLD0273C (1:)    NOT EQUAL XPC-FLD0273C
              DISPLAY 'FLD0273C ==> ' HEX-OF (FLD0273C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0273C).
           IF FLD0274C (1:)    NOT EQUAL XPC-FLD0274C
              DISPLAY 'FLD0274C ==> ' HEX-OF (FLD0274C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0274C).
           IF FLD0275C (1:)    NOT EQUAL XPC-FLD0275C
              DISPLAY 'FLD0275C ==> ' HEX-OF (FLD0275C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0275C).
           IF FLD0276C (1:)    NOT EQUAL XPC-FLD0276C
              DISPLAY 'FLD0276C ==> ' HEX-OF (FLD0276C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0276C).
           IF FLD0277C (1:)    NOT EQUAL XPC-FLD0277C
              DISPLAY 'FLD0277C ==> ' HEX-OF (FLD0277C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0277C).
           IF FLD0278C (1:)    NOT EQUAL XPC-FLD0278C
              DISPLAY 'FLD0278C ==> ' HEX-OF (FLD0278C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0278C).
           IF FLD0279C (1:)    NOT EQUAL XPC-FLD0279C
              DISPLAY 'FLD0279C ==> ' HEX-OF (FLD0279C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0279C).
           IF FLD0280C (1:)    NOT EQUAL XPC-FLD0280C
              DISPLAY 'FLD0280C ==> ' HEX-OF (FLD0280C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0280C).
           IF FLD0281C (1:)    NOT EQUAL XPC-FLD0281C
              DISPLAY 'FLD0281C ==> ' HEX-OF (FLD0281C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0281C).
           IF FLD0282C (1:)    NOT EQUAL XPC-FLD0282C
              DISPLAY 'FLD0282C ==> ' HEX-OF (FLD0282C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0282C).
           IF FLD0283C (1:)    NOT EQUAL XPC-FLD0283C
              DISPLAY 'FLD0283C ==> ' HEX-OF (FLD0283C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0283C).
           IF FLD0284C (1:)    NOT EQUAL XPC-FLD0284C
              DISPLAY 'FLD0284C ==> ' HEX-OF (FLD0284C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0284C).
           IF FLD0285C (1:)    NOT EQUAL XPC-FLD0285C
              DISPLAY 'FLD0285C ==> ' HEX-OF (FLD0285C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0285C).
           IF FLD0286C (1:)    NOT EQUAL XPC-FLD0286C
              DISPLAY 'FLD0286C ==> ' HEX-OF (FLD0286C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0286C).
           IF FLD0287C (1:)    NOT EQUAL XPC-FLD0287C
              DISPLAY 'FLD0287C ==> ' HEX-OF (FLD0287C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0287C).
           IF FLD0288C (1:)    NOT EQUAL XPC-FLD0288C
              DISPLAY 'FLD0288C ==> ' HEX-OF (FLD0288C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0288C).
           IF FLD0289C (1:)    NOT EQUAL XPC-FLD0289C
              DISPLAY 'FLD0289C ==> ' HEX-OF (FLD0289C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0289C).
           IF FLD0290C (1:)    NOT EQUAL XPC-FLD0290C
              DISPLAY 'FLD0290C ==> ' HEX-OF (FLD0290C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0290C).
           IF FLD0291C (1:)    NOT EQUAL XPC-FLD0291C
              DISPLAY 'FLD0291C ==> ' HEX-OF (FLD0291C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0291C).
           IF FLD0292C (1:)    NOT EQUAL XPC-FLD0292C
              DISPLAY 'FLD0292C ==> ' HEX-OF (FLD0292C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0292C).
           IF FLD0293C (1:)    NOT EQUAL XPC-FLD0293C
              DISPLAY 'FLD0293C ==> ' HEX-OF (FLD0293C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0293C).
           IF FLD0294C (1:)    NOT EQUAL XPC-FLD0294C
              DISPLAY 'FLD0294C ==> ' HEX-OF (FLD0294C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0294C).
           IF FLD0295C (1:)    NOT EQUAL XPC-FLD0295C
              DISPLAY 'FLD0295C ==> ' HEX-OF (FLD0295C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0295C).
           IF FLD0296C (1:)    NOT EQUAL XPC-FLD0296C
              DISPLAY 'FLD0296C ==> ' HEX-OF (FLD0296C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0296C).
           IF FLD0297C (1:)    NOT EQUAL XPC-FLD0297C
              DISPLAY 'FLD0297C ==> ' HEX-OF (FLD0297C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0297C).
           IF FLD0298C (1:)    NOT EQUAL XPC-FLD0298C
              DISPLAY 'FLD0298C ==> ' HEX-OF (FLD0298C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0298C).
           IF FLD0299C (1:)    NOT EQUAL XPC-FLD0299C
              DISPLAY 'FLD0299C ==> ' HEX-OF (FLD0299C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0299C).
           IF FLD0300C (1:)    NOT EQUAL XPC-FLD0300C
              DISPLAY 'FLD0300C ==> ' HEX-OF (FLD0300C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0300C).
           IF FLD0301C (1:)    NOT EQUAL XPC-FLD0301C
              DISPLAY 'FLD0301C ==> ' HEX-OF (FLD0301C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0301C).
           IF FLD0302C (1:)    NOT EQUAL XPC-FLD0302C
              DISPLAY 'FLD0302C ==> ' HEX-OF (FLD0302C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0302C).
           IF FLD0303C (1:)    NOT EQUAL XPC-FLD0303C
              DISPLAY 'FLD0303C ==> ' HEX-OF (FLD0303C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0303C).
           IF FLD0304C (1:)    NOT EQUAL XPC-FLD0304C
              DISPLAY 'FLD0304C ==> ' HEX-OF (FLD0304C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0304C).
           IF FLD0305C (1:)    NOT EQUAL XPC-FLD0305C
              DISPLAY 'FLD0305C ==> ' HEX-OF (FLD0305C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0305C).
           IF FLD0306C (1:)    NOT EQUAL XPC-FLD0306C
              DISPLAY 'FLD0306C ==> ' HEX-OF (FLD0306C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0306C).
           IF FLD0307C (1:)    NOT EQUAL XPC-FLD0307C
              DISPLAY 'FLD0307C ==> ' HEX-OF (FLD0307C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0307C).
           IF FLD0308C (1:)    NOT EQUAL XPC-FLD0308C
              DISPLAY 'FLD0308C ==> ' HEX-OF (FLD0308C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0308C).
           IF FLD0309C (1:)    NOT EQUAL XPC-FLD0309C
              DISPLAY 'FLD0309C ==> ' HEX-OF (FLD0309C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0309C).
           IF FLD0310C (1:)    NOT EQUAL XPC-FLD0310C
              DISPLAY 'FLD0310C ==> ' HEX-OF (FLD0310C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0310C).
           IF FLD0311C (1:)    NOT EQUAL XPC-FLD0311C
              DISPLAY 'FLD0311C ==> ' HEX-OF (FLD0311C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0311C).
           IF FLD0312C (1:)    NOT EQUAL XPC-FLD0312C
              DISPLAY 'FLD0312C ==> ' HEX-OF (FLD0312C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0312C).
           IF FLD0313C (1:)    NOT EQUAL XPC-FLD0313C
              DISPLAY 'FLD0313C ==> ' HEX-OF (FLD0313C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0313C).
           IF FLD0314C (1:)    NOT EQUAL XPC-FLD0314C
              DISPLAY 'FLD0314C ==> ' HEX-OF (FLD0314C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0314C).
           IF FLD0315C (1:)    NOT EQUAL XPC-FLD0315C
              DISPLAY 'FLD0315C ==> ' HEX-OF (FLD0315C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0315C).
           IF FLD0316C (1:)    NOT EQUAL XPC-FLD0316C
              DISPLAY 'FLD0316C ==> ' HEX-OF (FLD0316C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0316C).
           IF FLD0317C (1:)    NOT EQUAL XPC-FLD0317C
              DISPLAY 'FLD0317C ==> ' HEX-OF (FLD0317C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0317C).
           IF FLD0318C (1:)    NOT EQUAL XPC-FLD0318C
              DISPLAY 'FLD0318C ==> ' HEX-OF (FLD0318C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0318C).
           IF FLD0319C (1:)    NOT EQUAL XPC-FLD0319C
              DISPLAY 'FLD0319C ==> ' HEX-OF (FLD0319C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0319C).
           IF FLD0320C (1:)    NOT EQUAL XPC-FLD0320C
              DISPLAY 'FLD0320C ==> ' HEX-OF (FLD0320C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0320C).
           IF FLD0321C (1:)    NOT EQUAL XPC-FLD0321C
              DISPLAY 'FLD0321C ==> ' HEX-OF (FLD0321C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0321C).
           IF FLD0322C (1:)    NOT EQUAL XPC-FLD0322C
              DISPLAY 'FLD0322C ==> ' HEX-OF (FLD0322C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0322C).
           IF FLD0323C (1:)    NOT EQUAL XPC-FLD0323C
              DISPLAY 'FLD0323C ==> ' HEX-OF (FLD0323C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0323C).
           IF FLD0324C (1:)    NOT EQUAL XPC-FLD0324C
              DISPLAY 'FLD0324C ==> ' HEX-OF (FLD0324C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0324C).
           IF FLD0325C (1:)    NOT EQUAL XPC-FLD0325C
              DISPLAY 'FLD0325C ==> ' HEX-OF (FLD0325C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0325C).
           IF FLD0326C (1:)    NOT EQUAL XPC-FLD0326C
              DISPLAY 'FLD0326C ==> ' HEX-OF (FLD0326C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0326C).
           IF FLD0327C (1:)    NOT EQUAL XPC-FLD0327C
              DISPLAY 'FLD0327C ==> ' HEX-OF (FLD0327C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0327C).
           IF FLD0328C (1:)    NOT EQUAL XPC-FLD0328C
              DISPLAY 'FLD0328C ==> ' HEX-OF (FLD0328C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0328C).
           IF FLD0329C (1:)    NOT EQUAL XPC-FLD0329C
              DISPLAY 'FLD0329C ==> ' HEX-OF (FLD0329C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0329C).
           IF FLD0330C (1:)    NOT EQUAL XPC-FLD0330C
              DISPLAY 'FLD0330C ==> ' HEX-OF (FLD0330C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0330C).
           IF FLD0331C (1:)    NOT EQUAL XPC-FLD0331C
              DISPLAY 'FLD0331C ==> ' HEX-OF (FLD0331C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0331C).
           IF FLD0332C (1:)    NOT EQUAL XPC-FLD0332C
              DISPLAY 'FLD0332C ==> ' HEX-OF (FLD0332C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0332C).
           IF FLD0333C (1:)    NOT EQUAL XPC-FLD0333C
              DISPLAY 'FLD0333C ==> ' HEX-OF (FLD0333C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0333C).
           IF FLD0334C (1:)    NOT EQUAL XPC-FLD0334C
              DISPLAY 'FLD0334C ==> ' HEX-OF (FLD0334C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0334C).
           IF FLD0335C (1:)    NOT EQUAL XPC-FLD0335C
              DISPLAY 'FLD0335C ==> ' HEX-OF (FLD0335C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0335C).
           IF FLD0336C (1:)    NOT EQUAL XPC-FLD0336C
              DISPLAY 'FLD0336C ==> ' HEX-OF (FLD0336C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0336C).
           IF FLD0337C (1:)    NOT EQUAL XPC-FLD0337C
              DISPLAY 'FLD0337C ==> ' HEX-OF (FLD0337C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0337C).
           IF FLD0338C (1:)    NOT EQUAL XPC-FLD0338C
              DISPLAY 'FLD0338C ==> ' HEX-OF (FLD0338C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0338C).
           IF FLD0339C (1:)    NOT EQUAL XPC-FLD0339C
              DISPLAY 'FLD0339C ==> ' HEX-OF (FLD0339C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0339C).
           IF FLD0340C (1:)    NOT EQUAL XPC-FLD0340C
              DISPLAY 'FLD0340C ==> ' HEX-OF (FLD0340C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0340C).
           IF FLD0341C (1:)    NOT EQUAL XPC-FLD0341C
              DISPLAY 'FLD0341C ==> ' HEX-OF (FLD0341C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0341C).
           IF FLD0342C (1:)    NOT EQUAL XPC-FLD0342C
              DISPLAY 'FLD0342C ==> ' HEX-OF (FLD0342C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0342C).
           IF FLD0343C (1:)    NOT EQUAL XPC-FLD0343C
              DISPLAY 'FLD0343C ==> ' HEX-OF (FLD0343C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0343C).
           IF FLD0344C (1:)    NOT EQUAL XPC-FLD0344C
              DISPLAY 'FLD0344C ==> ' HEX-OF (FLD0344C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0344C).
           IF FLD0345C (1:)    NOT EQUAL XPC-FLD0345C
              DISPLAY 'FLD0345C ==> ' HEX-OF (FLD0345C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0345C).
           IF FLD0346C (1:)    NOT EQUAL XPC-FLD0346C
              DISPLAY 'FLD0346C ==> ' HEX-OF (FLD0346C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0346C).
           IF FLD0347C (1:)    NOT EQUAL XPC-FLD0347C
              DISPLAY 'FLD0347C ==> ' HEX-OF (FLD0347C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0347C).
           IF FLD0348C (1:)    NOT EQUAL XPC-FLD0348C
              DISPLAY 'FLD0348C ==> ' HEX-OF (FLD0348C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0348C).
           IF FLD0349C (1:)    NOT EQUAL XPC-FLD0349C
              DISPLAY 'FLD0349C ==> ' HEX-OF (FLD0349C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0349C).
           IF FLD0350C (1:)    NOT EQUAL XPC-FLD0350C
              DISPLAY 'FLD0350C ==> ' HEX-OF (FLD0350C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0350C).
           IF FLD0351C (1:)    NOT EQUAL XPC-FLD0351C
              DISPLAY 'FLD0351C ==> ' HEX-OF (FLD0351C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0351C).
           IF FLD0352C (1:)    NOT EQUAL XPC-FLD0352C
              DISPLAY 'FLD0352C ==> ' HEX-OF (FLD0352C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0352C).
           IF FLD0353C (1:)    NOT EQUAL XPC-FLD0353C
              DISPLAY 'FLD0353C ==> ' HEX-OF (FLD0353C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0353C).
           IF FLD0354C (1:)    NOT EQUAL XPC-FLD0354C
              DISPLAY 'FLD0354C ==> ' HEX-OF (FLD0354C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0354C).
           IF FLD0355C (1:)    NOT EQUAL XPC-FLD0355C
              DISPLAY 'FLD0355C ==> ' HEX-OF (FLD0355C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0355C).
           IF FLD0356C (1:)    NOT EQUAL XPC-FLD0356C
              DISPLAY 'FLD0356C ==> ' HEX-OF (FLD0356C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0356C).
           IF FLD0357C (1:)    NOT EQUAL XPC-FLD0357C
              DISPLAY 'FLD0357C ==> ' HEX-OF (FLD0357C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0357C).
           IF FLD0358C (1:)    NOT EQUAL XPC-FLD0358C
              DISPLAY 'FLD0358C ==> ' HEX-OF (FLD0358C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0358C).
           IF FLD0359C (1:)    NOT EQUAL XPC-FLD0359C
              DISPLAY 'FLD0359C ==> ' HEX-OF (FLD0359C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0359C).
           IF FLD0360C (1:)    NOT EQUAL XPC-FLD0360C
              DISPLAY 'FLD0360C ==> ' HEX-OF (FLD0360C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0360C).
           IF FLD0361C (1:)    NOT EQUAL XPC-FLD0361C
              DISPLAY 'FLD0361C ==> ' HEX-OF (FLD0361C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0361C).
           IF FLD0362C (1:)    NOT EQUAL XPC-FLD0362C
              DISPLAY 'FLD0362C ==> ' HEX-OF (FLD0362C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0362C).
           IF FLD0363C (1:)    NOT EQUAL XPC-FLD0363C
              DISPLAY 'FLD0363C ==> ' HEX-OF (FLD0363C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0363C).
           IF FLD0364C (1:)    NOT EQUAL XPC-FLD0364C
              DISPLAY 'FLD0364C ==> ' HEX-OF (FLD0364C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0364C).
           IF FLD0365C (1:)    NOT EQUAL XPC-FLD0365C
              DISPLAY 'FLD0365C ==> ' HEX-OF (FLD0365C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0365C).
           IF FLD0366C (1:)    NOT EQUAL XPC-FLD0366C
              DISPLAY 'FLD0366C ==> ' HEX-OF (FLD0366C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0366C).
           IF FLD0367C (1:)    NOT EQUAL XPC-FLD0367C
              DISPLAY 'FLD0367C ==> ' HEX-OF (FLD0367C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0367C).
           IF FLD0368C (1:)    NOT EQUAL XPC-FLD0368C
              DISPLAY 'FLD0368C ==> ' HEX-OF (FLD0368C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0368C).
           IF FLD0369C (1:)    NOT EQUAL XPC-FLD0369C
              DISPLAY 'FLD0369C ==> ' HEX-OF (FLD0369C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0369C).
           IF FLD0370C (1:)    NOT EQUAL XPC-FLD0370C
              DISPLAY 'FLD0370C ==> ' HEX-OF (FLD0370C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0370C).
           IF FLD0371C (1:)    NOT EQUAL XPC-FLD0371C
              DISPLAY 'FLD0371C ==> ' HEX-OF (FLD0371C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0371C).
           IF FLD0372C (1:)    NOT EQUAL XPC-FLD0372C
              DISPLAY 'FLD0372C ==> ' HEX-OF (FLD0372C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0372C).
           IF FLD0373C (1:)    NOT EQUAL XPC-FLD0373C
              DISPLAY 'FLD0373C ==> ' HEX-OF (FLD0373C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0373C).
           IF FLD0374C (1:)    NOT EQUAL XPC-FLD0374C
              DISPLAY 'FLD0374C ==> ' HEX-OF (FLD0374C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0374C).
           IF FLD0375C (1:)    NOT EQUAL XPC-FLD0375C
              DISPLAY 'FLD0375C ==> ' HEX-OF (FLD0375C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0375C).
           IF FLD0376C (1:)    NOT EQUAL XPC-FLD0376C
              DISPLAY 'FLD0376C ==> ' HEX-OF (FLD0376C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0376C).
           IF FLD0377C (1:)    NOT EQUAL XPC-FLD0377C
              DISPLAY 'FLD0377C ==> ' HEX-OF (FLD0377C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0377C).
           IF FLD0378C (1:)    NOT EQUAL XPC-FLD0378C
              DISPLAY 'FLD0378C ==> ' HEX-OF (FLD0378C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0378C).
           IF FLD0379C (1:)    NOT EQUAL XPC-FLD0379C
              DISPLAY 'FLD0379C ==> ' HEX-OF (FLD0379C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0379C).
           IF FLD0380C (1:)    NOT EQUAL XPC-FLD0380C
              DISPLAY 'FLD0380C ==> ' HEX-OF (FLD0380C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0380C).
           IF FLD0381C (1:)    NOT EQUAL XPC-FLD0381C
              DISPLAY 'FLD0381C ==> ' HEX-OF (FLD0381C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0381C).
           IF FLD0382C (1:)    NOT EQUAL XPC-FLD0382C
              DISPLAY 'FLD0382C ==> ' HEX-OF (FLD0382C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0382C).
           IF FLD0383C (1:)    NOT EQUAL XPC-FLD0383C
              DISPLAY 'FLD0383C ==> ' HEX-OF (FLD0383C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0383C).
           IF FLD0384C (1:)    NOT EQUAL XPC-FLD0384C
              DISPLAY 'FLD0384C ==> ' HEX-OF (FLD0384C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0384C).
           IF FLD0385C (1:)    NOT EQUAL XPC-FLD0385C
              DISPLAY 'FLD0385C ==> ' HEX-OF (FLD0385C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0385C).
           IF FLD0386C (1:)    NOT EQUAL XPC-FLD0386C
              DISPLAY 'FLD0386C ==> ' HEX-OF (FLD0386C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0386C).
           IF FLD0387C (1:)    NOT EQUAL XPC-FLD0387C
              DISPLAY 'FLD0387C ==> ' HEX-OF (FLD0387C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0387C).
           IF FLD0388C (1:)    NOT EQUAL XPC-FLD0388C
              DISPLAY 'FLD0388C ==> ' HEX-OF (FLD0388C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0388C).
           IF FLD0389C (1:)    NOT EQUAL XPC-FLD0389C
              DISPLAY 'FLD0389C ==> ' HEX-OF (FLD0389C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0389C).
           IF FLD0390C (1:)    NOT EQUAL XPC-FLD0390C
              DISPLAY 'FLD0390C ==> ' HEX-OF (FLD0390C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0390C).
           IF FLD0391C (1:)    NOT EQUAL XPC-FLD0391C
              DISPLAY 'FLD0391C ==> ' HEX-OF (FLD0391C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0391C).
           IF FLD0392C (1:)    NOT EQUAL XPC-FLD0392C
              DISPLAY 'FLD0392C ==> ' HEX-OF (FLD0392C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0392C).
           IF FLD0393C (1:)    NOT EQUAL XPC-FLD0393C
              DISPLAY 'FLD0393C ==> ' HEX-OF (FLD0393C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0393C).
           IF FLD0394C (1:)    NOT EQUAL XPC-FLD0394C
              DISPLAY 'FLD0394C ==> ' HEX-OF (FLD0394C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0394C).
           IF FLD0395C (1:)    NOT EQUAL XPC-FLD0395C
              DISPLAY 'FLD0395C ==> ' HEX-OF (FLD0395C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0395C).
           IF FLD0396C (1:)    NOT EQUAL XPC-FLD0396C
              DISPLAY 'FLD0396C ==> ' HEX-OF (FLD0396C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0396C).
           IF FLD0397C (1:)    NOT EQUAL XPC-FLD0397C
              DISPLAY 'FLD0397C ==> ' HEX-OF (FLD0397C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0397C).
           IF FLD0398C (1:)    NOT EQUAL XPC-FLD0398C
              DISPLAY 'FLD0398C ==> ' HEX-OF (FLD0398C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0398C).
           IF FLD0399C (1:)    NOT EQUAL XPC-FLD0399C
              DISPLAY 'FLD0399C ==> ' HEX-OF (FLD0399C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0399C).
           IF FLD0400C (1:)    NOT EQUAL XPC-FLD0400C
              DISPLAY 'FLD0400C ==> ' HEX-OF (FLD0400C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0400C).
           IF FLD0401C (1:)    NOT EQUAL XPC-FLD0401C
              DISPLAY 'FLD0401C ==> ' HEX-OF (FLD0401C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0401C).
           IF FLD0402C (1:)    NOT EQUAL XPC-FLD0402C
              DISPLAY 'FLD0402C ==> ' HEX-OF (FLD0402C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0402C).
           IF FLD0403C (1:)    NOT EQUAL XPC-FLD0403C
              DISPLAY 'FLD0403C ==> ' HEX-OF (FLD0403C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0403C).
           IF FLD0404C (1:)    NOT EQUAL XPC-FLD0404C
              DISPLAY 'FLD0404C ==> ' HEX-OF (FLD0404C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0404C).
           IF FLD0405C (1:)    NOT EQUAL XPC-FLD0405C
              DISPLAY 'FLD0405C ==> ' HEX-OF (FLD0405C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0405C).
           IF FLD0406C (1:)    NOT EQUAL XPC-FLD0406C
              DISPLAY 'FLD0406C ==> ' HEX-OF (FLD0406C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0406C).
           IF FLD0407C (1:)    NOT EQUAL XPC-FLD0407C
              DISPLAY 'FLD0407C ==> ' HEX-OF (FLD0407C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0407C).
           IF FLD0408C (1:)    NOT EQUAL XPC-FLD0408C
              DISPLAY 'FLD0408C ==> ' HEX-OF (FLD0408C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0408C).
           IF FLD0409C (1:)    NOT EQUAL XPC-FLD0409C
              DISPLAY 'FLD0409C ==> ' HEX-OF (FLD0409C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0409C).
           IF FLD0410C (1:)    NOT EQUAL XPC-FLD0410C
              DISPLAY 'FLD0410C ==> ' HEX-OF (FLD0410C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0410C).
           IF FLD0411C (1:)    NOT EQUAL XPC-FLD0411C
              DISPLAY 'FLD0411C ==> ' HEX-OF (FLD0411C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0411C).
           IF FLD0412C (1:)    NOT EQUAL XPC-FLD0412C
              DISPLAY 'FLD0412C ==> ' HEX-OF (FLD0412C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0412C).
           IF FLD0413C (1:)    NOT EQUAL XPC-FLD0413C
              DISPLAY 'FLD0413C ==> ' HEX-OF (FLD0413C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0413C).
           IF FLD0414C (1:)    NOT EQUAL XPC-FLD0414C
              DISPLAY 'FLD0414C ==> ' HEX-OF (FLD0414C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0414C).
           IF FLD0415C (1:)    NOT EQUAL XPC-FLD0415C
              DISPLAY 'FLD0415C ==> ' HEX-OF (FLD0415C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0415C).
           IF FLD0416C (1:)    NOT EQUAL XPC-FLD0416C
              DISPLAY 'FLD0416C ==> ' HEX-OF (FLD0416C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0416C).
           IF FLD0417C (1:)    NOT EQUAL XPC-FLD0417C
              DISPLAY 'FLD0417C ==> ' HEX-OF (FLD0417C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0417C).
           IF FLD0418C (1:)    NOT EQUAL XPC-FLD0418C
              DISPLAY 'FLD0418C ==> ' HEX-OF (FLD0418C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0418C).
           IF FLD0419C (1:)    NOT EQUAL XPC-FLD0419C
              DISPLAY 'FLD0419C ==> ' HEX-OF (FLD0419C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0419C).
           IF FLD0420C (1:)    NOT EQUAL XPC-FLD0420C
              DISPLAY 'FLD0420C ==> ' HEX-OF (FLD0420C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0420C).
           IF FLD0421C (1:)    NOT EQUAL XPC-FLD0421C
              DISPLAY 'FLD0421C ==> ' HEX-OF (FLD0421C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0421C).
           IF FLD0422C (1:)    NOT EQUAL XPC-FLD0422C
              DISPLAY 'FLD0422C ==> ' HEX-OF (FLD0422C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0422C).
           IF FLD0423C (1:)    NOT EQUAL XPC-FLD0423C
              DISPLAY 'FLD0423C ==> ' HEX-OF (FLD0423C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0423C).
           IF FLD0424C (1:)    NOT EQUAL XPC-FLD0424C
              DISPLAY 'FLD0424C ==> ' HEX-OF (FLD0424C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0424C).
           IF FLD0425C (1:)    NOT EQUAL XPC-FLD0425C
              DISPLAY 'FLD0425C ==> ' HEX-OF (FLD0425C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0425C).
           IF FLD0426C (1:)    NOT EQUAL XPC-FLD0426C
              DISPLAY 'FLD0426C ==> ' HEX-OF (FLD0426C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0426C).
           IF FLD0427C (1:)    NOT EQUAL XPC-FLD0427C
              DISPLAY 'FLD0427C ==> ' HEX-OF (FLD0427C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0427C).
           IF FLD0428C (1:)    NOT EQUAL XPC-FLD0428C
              DISPLAY 'FLD0428C ==> ' HEX-OF (FLD0428C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0428C).
           IF FLD0429C (1:)    NOT EQUAL XPC-FLD0429C
              DISPLAY 'FLD0429C ==> ' HEX-OF (FLD0429C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0429C).
           IF FLD0430C (1:)    NOT EQUAL XPC-FLD0430C
              DISPLAY 'FLD0430C ==> ' HEX-OF (FLD0430C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0430C).
           IF FLD0431C (1:)    NOT EQUAL XPC-FLD0431C
              DISPLAY 'FLD0431C ==> ' HEX-OF (FLD0431C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0431C).
           IF FLD0432C (1:)    NOT EQUAL XPC-FLD0432C
              DISPLAY 'FLD0432C ==> ' HEX-OF (FLD0432C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0432C).
           IF FLD0433C (1:)    NOT EQUAL XPC-FLD0433C
              DISPLAY 'FLD0433C ==> ' HEX-OF (FLD0433C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0433C).
           IF FLD0434C (1:)    NOT EQUAL XPC-FLD0434C
              DISPLAY 'FLD0434C ==> ' HEX-OF (FLD0434C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0434C).
           IF FLD0435C (1:)    NOT EQUAL XPC-FLD0435C
              DISPLAY 'FLD0435C ==> ' HEX-OF (FLD0435C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0435C).
           IF FLD0436C (1:)    NOT EQUAL XPC-FLD0436C
              DISPLAY 'FLD0436C ==> ' HEX-OF (FLD0436C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0436C).
           IF FLD0437C (1:)    NOT EQUAL XPC-FLD0437C
              DISPLAY 'FLD0437C ==> ' HEX-OF (FLD0437C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0437C).
           IF FLD0438C (1:)    NOT EQUAL XPC-FLD0438C
              DISPLAY 'FLD0438C ==> ' HEX-OF (FLD0438C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0438C).
           IF FLD0439C (1:)    NOT EQUAL XPC-FLD0439C
              DISPLAY 'FLD0439C ==> ' HEX-OF (FLD0439C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0439C).
           IF FLD0440C (1:)    NOT EQUAL XPC-FLD0440C
              DISPLAY 'FLD0440C ==> ' HEX-OF (FLD0440C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0440C).
           IF FLD0441C (1:)    NOT EQUAL XPC-FLD0441C
              DISPLAY 'FLD0441C ==> ' HEX-OF (FLD0441C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0441C).
           IF FLD0442C (1:)    NOT EQUAL XPC-FLD0442C
              DISPLAY 'FLD0442C ==> ' HEX-OF (FLD0442C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0442C).
           IF FLD0443C (1:)    NOT EQUAL XPC-FLD0443C
              DISPLAY 'FLD0443C ==> ' HEX-OF (FLD0443C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0443C).
           IF FLD0444C (1:)    NOT EQUAL XPC-FLD0444C
              DISPLAY 'FLD0444C ==> ' HEX-OF (FLD0444C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0444C).
           IF FLD0445C (1:)    NOT EQUAL XPC-FLD0445C
              DISPLAY 'FLD0445C ==> ' HEX-OF (FLD0445C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0445C).
           IF FLD0446C (1:)    NOT EQUAL XPC-FLD0446C
              DISPLAY 'FLD0446C ==> ' HEX-OF (FLD0446C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0446C).
           IF FLD0447C (1:)    NOT EQUAL XPC-FLD0447C
              DISPLAY 'FLD0447C ==> ' HEX-OF (FLD0447C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0447C).
           IF FLD0448C (1:)    NOT EQUAL XPC-FLD0448C
              DISPLAY 'FLD0448C ==> ' HEX-OF (FLD0448C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0448C).
           IF FLD0449C (1:)    NOT EQUAL XPC-FLD0449C
              DISPLAY 'FLD0449C ==> ' HEX-OF (FLD0449C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0449C).
           IF FLD0450C (1:)    NOT EQUAL XPC-FLD0450C
              DISPLAY 'FLD0450C ==> ' HEX-OF (FLD0450C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0450C).
           IF FLD0451C (1:)    NOT EQUAL XPC-FLD0451C
              DISPLAY 'FLD0451C ==> ' HEX-OF (FLD0451C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0451C).
           IF FLD0452C (1:)    NOT EQUAL XPC-FLD0452C
              DISPLAY 'FLD0452C ==> ' HEX-OF (FLD0452C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0452C).
           IF FLD0453C (1:)    NOT EQUAL XPC-FLD0453C
              DISPLAY 'FLD0453C ==> ' HEX-OF (FLD0453C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0453C).
           IF FLD0454C (1:)    NOT EQUAL XPC-FLD0454C
              DISPLAY 'FLD0454C ==> ' HEX-OF (FLD0454C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0454C).
           IF FLD0455C (1:)    NOT EQUAL XPC-FLD0455C
              DISPLAY 'FLD0455C ==> ' HEX-OF (FLD0455C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0455C).
           IF FLD0456C (1:)    NOT EQUAL XPC-FLD0456C
              DISPLAY 'FLD0456C ==> ' HEX-OF (FLD0456C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0456C).
           IF FLD0457C (1:)    NOT EQUAL XPC-FLD0457C
              DISPLAY 'FLD0457C ==> ' HEX-OF (FLD0457C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0457C).
           IF FLD0458C (1:)    NOT EQUAL XPC-FLD0458C
              DISPLAY 'FLD0458C ==> ' HEX-OF (FLD0458C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0458C).
           IF FLD0459C (1:)    NOT EQUAL XPC-FLD0459C
              DISPLAY 'FLD0459C ==> ' HEX-OF (FLD0459C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0459C).
           IF FLD0460C (1:)    NOT EQUAL XPC-FLD0460C
              DISPLAY 'FLD0460C ==> ' HEX-OF (FLD0460C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0460C).
           IF FLD0461C (1:)    NOT EQUAL XPC-FLD0461C
              DISPLAY 'FLD0461C ==> ' HEX-OF (FLD0461C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0461C).
           IF FLD0462C (1:)    NOT EQUAL XPC-FLD0462C
              DISPLAY 'FLD0462C ==> ' HEX-OF (FLD0462C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0462C).
           IF FLD0463C (1:)    NOT EQUAL XPC-FLD0463C
              DISPLAY 'FLD0463C ==> ' HEX-OF (FLD0463C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0463C).
           IF FLD0464C (1:)    NOT EQUAL XPC-FLD0464C
              DISPLAY 'FLD0464C ==> ' HEX-OF (FLD0464C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0464C).
           IF FLD0465C (1:)    NOT EQUAL XPC-FLD0465C
              DISPLAY 'FLD0465C ==> ' HEX-OF (FLD0465C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0465C).
           IF FLD0466C (1:)    NOT EQUAL XPC-FLD0466C
              DISPLAY 'FLD0466C ==> ' HEX-OF (FLD0466C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0466C).
           IF FLD0467C (1:)    NOT EQUAL XPC-FLD0467C
              DISPLAY 'FLD0467C ==> ' HEX-OF (FLD0467C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0467C).
           IF FLD0468C (1:)    NOT EQUAL XPC-FLD0468C
              DISPLAY 'FLD0468C ==> ' HEX-OF (FLD0468C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0468C).
           IF FLD0469C (1:)    NOT EQUAL XPC-FLD0469C
              DISPLAY 'FLD0469C ==> ' HEX-OF (FLD0469C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0469C).
           IF FLD0470C (1:)    NOT EQUAL XPC-FLD0470C
              DISPLAY 'FLD0470C ==> ' HEX-OF (FLD0470C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0470C).
           IF FLD0471C (1:)    NOT EQUAL XPC-FLD0471C
              DISPLAY 'FLD0471C ==> ' HEX-OF (FLD0471C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0471C).
           IF FLD0472C (1:)    NOT EQUAL XPC-FLD0472C
              DISPLAY 'FLD0472C ==> ' HEX-OF (FLD0472C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0472C).
           IF FLD0473C (1:)    NOT EQUAL XPC-FLD0473C
              DISPLAY 'FLD0473C ==> ' HEX-OF (FLD0473C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0473C).
           IF FLD0474C (1:)    NOT EQUAL XPC-FLD0474C
              DISPLAY 'FLD0474C ==> ' HEX-OF (FLD0474C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0474C).
           IF FLD0475C (1:)    NOT EQUAL XPC-FLD0475C
              DISPLAY 'FLD0475C ==> ' HEX-OF (FLD0475C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0475C).
           IF FLD0476C (1:)    NOT EQUAL XPC-FLD0476C
              DISPLAY 'FLD0476C ==> ' HEX-OF (FLD0476C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0476C).
           IF FLD0477C (1:)    NOT EQUAL XPC-FLD0477C
              DISPLAY 'FLD0477C ==> ' HEX-OF (FLD0477C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0477C).
           IF FLD0478C (1:)    NOT EQUAL XPC-FLD0478C
              DISPLAY 'FLD0478C ==> ' HEX-OF (FLD0478C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0478C).
           IF FLD0479C (1:)    NOT EQUAL XPC-FLD0479C
              DISPLAY 'FLD0479C ==> ' HEX-OF (FLD0479C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0479C).
           IF FLD0480C (1:)    NOT EQUAL XPC-FLD0480C
              DISPLAY 'FLD0480C ==> ' HEX-OF (FLD0480C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0480C).
           IF FLD0481C (1:)    NOT EQUAL XPC-FLD0481C
              DISPLAY 'FLD0481C ==> ' HEX-OF (FLD0481C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0481C).
           IF FLD0482C (1:)    NOT EQUAL XPC-FLD0482C
              DISPLAY 'FLD0482C ==> ' HEX-OF (FLD0482C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0482C).
           IF FLD0483C (1:)    NOT EQUAL XPC-FLD0483C
              DISPLAY 'FLD0483C ==> ' HEX-OF (FLD0483C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0483C).
           IF FLD0484C (1:)    NOT EQUAL XPC-FLD0484C
              DISPLAY 'FLD0484C ==> ' HEX-OF (FLD0484C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0484C).
           IF FLD0485C (1:)    NOT EQUAL XPC-FLD0485C
              DISPLAY 'FLD0485C ==> ' HEX-OF (FLD0485C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0485C).
           IF FLD0486C (1:)    NOT EQUAL XPC-FLD0486C
              DISPLAY 'FLD0486C ==> ' HEX-OF (FLD0486C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0486C).
           IF FLD0487C (1:)    NOT EQUAL XPC-FLD0487C
              DISPLAY 'FLD0487C ==> ' HEX-OF (FLD0487C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0487C).
           IF FLD0488C (1:)    NOT EQUAL XPC-FLD0488C
              DISPLAY 'FLD0488C ==> ' HEX-OF (FLD0488C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0488C).
           IF FLD0489C (1:)    NOT EQUAL XPC-FLD0489C
              DISPLAY 'FLD0489C ==> ' HEX-OF (FLD0489C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0489C).
           IF FLD0490C (1:)    NOT EQUAL XPC-FLD0490C
              DISPLAY 'FLD0490C ==> ' HEX-OF (FLD0490C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0490C).
           IF FLD0491C (1:)    NOT EQUAL XPC-FLD0491C
              DISPLAY 'FLD0491C ==> ' HEX-OF (FLD0491C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0491C).
           IF FLD0492C (1:)    NOT EQUAL XPC-FLD0492C
              DISPLAY 'FLD0492C ==> ' HEX-OF (FLD0492C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0492C).
           IF FLD0493C (1:)    NOT EQUAL XPC-FLD0493C
              DISPLAY 'FLD0493C ==> ' HEX-OF (FLD0493C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0493C).
           IF FLD0494C (1:)    NOT EQUAL XPC-FLD0494C
              DISPLAY 'FLD0494C ==> ' HEX-OF (FLD0494C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0494C).
           IF FLD0495C (1:)    NOT EQUAL XPC-FLD0495C
              DISPLAY 'FLD0495C ==> ' HEX-OF (FLD0495C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0495C).
           IF FLD0496C (1:)    NOT EQUAL XPC-FLD0496C
              DISPLAY 'FLD0496C ==> ' HEX-OF (FLD0496C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0496C).
           IF FLD0497C (1:)    NOT EQUAL XPC-FLD0497C
              DISPLAY 'FLD0497C ==> ' HEX-OF (FLD0497C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0497C).
           IF FLD0498C (1:)    NOT EQUAL XPC-FLD0498C
              DISPLAY 'FLD0498C ==> ' HEX-OF (FLD0498C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0498C).
           IF FLD0499C (1:)    NOT EQUAL XPC-FLD0499C
              DISPLAY 'FLD0499C ==> ' HEX-OF (FLD0499C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0499C).