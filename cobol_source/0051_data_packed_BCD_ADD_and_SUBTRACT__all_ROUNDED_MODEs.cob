IDENTIFICATION DIVISION.
       PROGRAM-ID. PDTESTR2.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
       FUNCTION HEX-OF INTRINSIC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * DATA-AREA

       77  FLD0500A                       PIC S9(10)V9(08) COMP-3
           VALUE -4830218621.81680639.
       77  FLD0500B                       PIC  9(03)       COMP-6
           VALUE  087.

       77  FLD0501A                       PIC  9(09)V9(15) COMP-3
           VALUE  652910855.370784748430423.
       77  FLD0501B                       PIC  9(09)V9(14) COMP-6
           VALUE  628093348.73677369337485.

       77  FLD0502A                       PIC  9(03)       COMP-6
           VALUE  079.
       77  FLD0502B                       PIC  9(07)V9(22) COMP-6
           VALUE  7893241.6286150020034995122841.

       77  FLD0503A                       PIC  9(10)V9(11) COMP-6
           VALUE  5662523582.77427925159.
       77  FLD0503B                       PIC  9(04)V9(29) COMP-3
           VALUE  8834.70722999726620905391882843105.

       77  FLD0504A                       PIC S9(08)V9(02) COMP-3
           VALUE -28360864.01.
       77  FLD0504B                       PIC  9(10)V9(09) COMP-3
           VALUE  5000570062.577901486.

       77  FLD0505A                       PIC  9(04)V9(30) COMP-3
           VALUE  9110.332843503369248949752545740921.
       77  FLD0505B                       PIC  9(10)V9(10) COMP-3
           VALUE  5407979633.7587637822.

       77  FLD0506A                       PIC  9(10)V9(11) COMP-3
           VALUE  5546838940.35467472960.
       77  FLD0506B                       PIC S9(07)V9(01) COMP-3
           VALUE +2340559.3.

       77  FLD0507A                       PIC  9(08)V9(18) COMP-6
           VALUE  70736506.262277043521891073.
       77  FLD0507B                       PIC  9(10)V9(09) COMP-3
           VALUE  5205430142.820132166.

       77  FLD0508A                       PIC  9(09)V9(16) COMP-6
           VALUE  658855971.9467786957025623.
       77  FLD0508B                       PIC S9(09)V9(07) COMP-3
           VALUE +444447149.8618901.

       77  FLD0509A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0509B                       PIC  9(10)V9(08) COMP-6
           VALUE  4889373386.26299289.

       77  FLD0510A                       PIC  9(04)       COMP-6
           VALUE  1295.
       77  FLD0510B                       PIC S9(03)       COMP-3
           VALUE -092.

       77  FLD0511A                       PIC  9(06)V9(25) COMP-6
           VALUE  815863.7850571600624860479911149.
       77  FLD0511B                       PIC  9(10)V9(09) COMP-6
           VALUE  5256921146.480894035.

       77  FLD0512A                       PIC  9(05)       COMP-6
           VALUE  13945.
       77  FLD0512B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.908282031313487836499120930966455489.

       77  FLD0513A                       PIC  9(09)V9(15) COMP-3
           VALUE  653773832.246937192103075.
       77  FLD0513B                       PIC  9(08)V9(20) COMP-3
           VALUE  74124087.47450585089211472222.

       77  FLD0514A                       PIC  9(08)V9(18) COMP-3
           VALUE  70109343.593910689040882289.
       77  FLD0514B                       PIC  9(09)V9(04) COMP-6
           VALUE  348891343.2762.

       77  FLD0515A                       PIC  9(09)V9(16) COMP-6
           VALUE  658210435.7548693718271692.
       77  FLD0515B                       PIC  9(03)V9(32) COMP-3
           VALUE  941.14524908048735607479784448514692.

       77  FLD0516A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.884403805479323734672902901365887373.
       77  FLD0516B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0517A                       PIC  9(10)V9(07) COMP-6
           VALUE  4497620438.0577999.
       77  FLD0517B                       PIC S9(10)V9(08) COMP-3
           VALUE -4811021778.48490686.

       77  FLD0518A                       PIC  9(09)V9(16) COMP-3
           VALUE  664556684.1155496895510168.
       77  FLD0518B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0519A                       PIC  9(09)V9(14) COMP-3
           VALUE  630097608.79846921088898.
       77  FLD0519B                       PIC  9(08)V9(17) COMP-3
           VALUE  68412596.06583623975595287.

       77  FLD0520A                       PIC  9(04)V9(30) COMP-6
           VALUE  9052.329380117529744609328190563246.
       77  FLD0520B                       PIC  9(09)V9(14) COMP-3
           VALUE  610604586.65389061305717.

       77  FLD0521A                       PIC  9(05)       COMP-6
           VALUE  13956.
       77  FLD0521B                       PIC S9(05)       COMP-3
           VALUE +14099.

       77  FLD0522A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0522B                       PIC S9(09)V9(04) COMP-3
           VALUE -351067614.4076.

       77  FLD0523A                       PIC  9(08)V9(18) COMP-6
           VALUE  70807149.512639711019801325.
       77  FLD0523B                       PIC S9(08)V9(02) COMP-3
           VALUE -28004002.44.

       77  FLD0524A                       PIC S9(06)V9(01) COMP-3
           VALUE +201515.3.
       77  FLD0524B                       PIC  9(10)V9(09) COMP-3
           VALUE  5046210377.505329081.

       77  FLD0525A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0525B                       PIC  9(04)V9(29) COMP-6
           VALUE  8873.36156634660588871099662355845.

       77  FLD0526A                       PIC  9(07)V9(22) COMP-3
           VALUE  7812896.0072540409864672028561.
       77  FLD0526B                       PIC  9(07)V9(02) COMP-6
           VALUE  2461308.93.

       77  FLD0527A                       PIC  9(10)V9(12) COMP-6
           VALUE  5853770318.384275972434.
       77  FLD0527B                       PIC  9(10)V9(09) COMP-3
           VALUE  5140096263.891610339.

       77  FLD0528A                       PIC  9(10)V9(08) COMP-6
           VALUE  4856797949.89136714.
       77  FLD0528B                       PIC S9(04)       COMP-3
           VALUE +1207.

       77  FLD0529A                       PIC  9(10)V9(10) COMP-6
           VALUE  5298570971.4885653731.
       77  FLD0529B                       PIC S9(10)V9(07) COMP-3
           VALUE -4613280273.7797717.

       77  FLD0530A                       PIC  9(05)V9(28) COMP-6
           VALUE  87536.5484141958027919372398173436.
       77  FLD0530B                       PIC S9(02)       COMP-3
           VALUE -06.

       77  FLD0531A                       PIC  9(09)V9(03) COMP-6
           VALUE  317487049.751.
       77  FLD0531B                       PIC S9(07)V9(01) COMP-3
           VALUE +2322772.2.

       77  FLD0532A                       PIC  9(09)V9(15) COMP-3
           VALUE  653250626.044252880042506.
       77  FLD0532B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0533A                       PIC  9(07)V9(02) COMP-6
           VALUE  2559928.55.
       77  FLD0533B                       PIC  9(03)       COMP-6
           VALUE  086.

       77  FLD0534A                       PIC  9(09)V9(06) COMP-6
           VALUE  408226706.354108.
       77  FLD0534B                       PIC  9(10)V9(09) COMP-3
           VALUE  5204512753.981520578.

       77  FLD0535A                       PIC  9(10)V9(11) COMP-6
           VALUE  5556101599.27967472981.
       77  FLD0535B                       PIC  9(05)V9(27) COMP-3
           VALUE  85335.564071638048133650045201648.

       77  FLD0536A                       PIC S9(08)V9(03) COMP-3
           VALUE -29061270.882.
       77  FLD0536B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0537A                       PIC  9(08)V9(03) COMP-6
           VALUE  29943354.242.
       77  FLD0537B                       PIC  9(04)       COMP-6
           VALUE  1199.

       77  FLD0538A                       PIC  9(03)V9(32) COMP-3
           VALUE  922.29859860523566439383102988358587.
       77  FLD0538B                       PIC  9(04)V9(29) COMP-6
           VALUE  8861.76614320458799767266100388951.

       77  FLD0539A                       PIC  9(05)V9(27) COMP-6
           VALUE  85666.721070025741990860979058197.
       77  FLD0539B                       PIC  9(05)V9(27) COMP-3
           VALUE  84375.338828007329095015620623598.

       77  FLD0540A                       PIC S9(04)       COMP-3
           VALUE +1227.
       77  FLD0540B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0541A                       PIC  9(09)V9(05) COMP-6
           VALUE  387240740.80744.
       77  FLD0541B                       PIC  9(07)V9(22) COMP-6
           VALUE  7676023.3773886621388982121061.

       77  FLD0542A                       PIC  9(06)V9(25) COMP-3
           VALUE  831706.5789473143677668076634290.
       77  FLD0542B                       PIC  9(10)V9(11) COMP-3
           VALUE  5532908670.51828949563.

       77  FLD0543A                       PIC  9(06)V9(01) COMP-6
           VALUE  188772.9.
       77  FLD0543B                       PIC  9(07)V9(02) COMP-6
           VALUE  2581387.79.

       77  FLD0544A                       PIC  9(10)V9(09) COMP-3
           VALUE  5241766194.366106468.
       77  FLD0544B                       PIC  9(08)V9(02) COMP-6
           VALUE  27953166.13.

       77  FLD0545A                       PIC  9(09)V9(14) COMP-3
           VALUE  622229285.46684597161942.
       77  FLD0545B                       PIC  9(08)V9(19) COMP-3
           VALUE  72256359.1476747091313370674.

       77  FLD0546A                       PIC  9(06)V9(25) COMP-3
           VALUE  820358.8689269564193651262939965.
       77  FLD0546B                       PIC  9(09)V9(14) COMP-3
           VALUE  610779194.05314462508727.

       77  FLD0547A                       PIC  9(06)V9(25) COMP-3
           VALUE  821925.7242001770658035297856258.
       77  FLD0547B                       PIC S9(09)V9(04) COMP-3
           VALUE -360691511.9302.

       77  FLD0548A                       PIC  9(07)V9(23) COMP-6
           VALUE  7955385.78445739497091437897324.
       77  FLD0548B                       PIC  9(09)V9(17) COMP-6
           VALUE  689149957.90453892343663255.

       77  FLD0549A                       PIC  9(07)V9(01) COMP-6
           VALUE  2367856.7.
       77  FLD0549B                       PIC  9(09)V9(06) COMP-6
           VALUE  415548355.051954.

       77  FLD0550A                       PIC  9(09)V9(15) COMP-6
           VALUE  656651700.520587522369453.
       77  FLD0550B                       PIC  9(02)       COMP-6
           VALUE  06.

       77  FLD0551A                       PIC  9(07)V9(02) COMP-6
           VALUE  2589973.73.
       77  FLD0551B                       PIC  9(09)V9(15) COMP-3
           VALUE  652529070.867454263904505.

       77  FLD0552A                       PIC  9(10)V9(07) COMP-6
           VALUE  4579590761.6898545.
       77  FLD0552B                       PIC  9(05)       COMP-6
           VALUE  14745.

       77  FLD0553A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0553B                       PIC S9(09)V9(04) COMP-3
           VALUE -360871096.9090.

       77  FLD0554A                       PIC  9(07)V9(02) COMP-6
           VALUE  2568219.15.
       77  FLD0554B                       PIC  9(03)V9(32) COMP-3
           VALUE  932.99236247731820448336748086148872.

       77  FLD0555A                       PIC  9(09)V9(05) COMP-6
           VALUE  388184875.66560.
       77  FLD0555B                       PIC  9(10)V9(09) COMP-3
           VALUE  5217501857.988002811.

       77  FLD0556A                       PIC  9(04)V9(30) COMP-6
           VALUE  8983.209260005348140154524116951506.
       77  FLD0556B                       PIC  9(10)V9(11) COMP-6
           VALUE  5685562200.43860527368.

       77  FLD0557A                       PIC  9(09)V9(15) COMP-3
           VALUE  650877011.601572519339242.
       77  FLD0557B                       PIC S9(05)       COMP-3
           VALUE +13329.

       77  FLD0558A                       PIC  9(09)V9(13) COMP-6
           VALUE  595830550.3266489999703.
       77  FLD0558B                       PIC  9(06)V9(01) COMP-6
           VALUE  209604.9.

       77  FLD0559A                       PIC  9(10)V9(09) COMP-3
           VALUE  5242032248.235551916.
       77  FLD0559B                       PIC  9(07)V9(22) COMP-6
           VALUE  7882034.1791675385678672682843.

       77  FLD0560A                       PIC S9(09)V9(06) COMP-3
           VALUE +403640603.914505.
       77  FLD0560B                       PIC  9(09)V9(07) COMP-6
           VALUE  438743115.5223073.

       77  FLD0561A                       PIC  9(05)       COMP-6
           VALUE  14931.
       77  FLD0561B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0562A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0562B                       PIC  9(02)V9(34) COMP-6
           VALUE  95.8208334412512741096179524902254343.

       77  FLD0563A                       PIC  9(10)V9(09) COMP-3
           VALUE  5040974749.501065943.
       77  FLD0563B                       PIC S9(08)V9(03) COMP-3
           VALUE +31252590.212.

       77  FLD0564A                       PIC  9(09)V9(16) COMP-6
           VALUE  666123633.8391588462926051.
       77  FLD0564B                       PIC  9(03)V9(32) COMP-6
           VALUE  925.73034981753798966508384182816371.

       77  FLD0565A                       PIC  9(04)V9(30) COMP-6
           VALUE  8999.472704059103822515908177592791.
       77  FLD0565B                       PIC  9(06)V9(01) COMP-6
           VALUE  209088.7.

       77  FLD0566A                       PIC  9(10)V9(10) COMP-6
           VALUE  5451645287.6426646501.
       77  FLD0566B                       PIC  9(09)V9(03) COMP-6
           VALUE  317445075.017.

       77  FLD0567A                       PIC S9(07)V9(02) COMP-3
           VALUE -2621767.34.
       77  FLD0567B                       PIC  9(04)V9(29) COMP-6
           VALUE  8789.70351596639054569948257267242.

       77  FLD0568A                       PIC S9(08)V9(02) COMP-3
           VALUE -28119737.76.
       77  FLD0568B                       PIC  9(09)V9(14) COMP-6
           VALUE  616894259.97583058336459.

       77  FLD0569A                       PIC  9(10)V9(10) COMP-3
           VALUE  5301098669.5201622875.
       77  FLD0569B                       PIC S9(09)V9(06) COMP-3
           VALUE +421009403.834593.

       77  FLD0570A                       PIC  9(05)       COMP-6
           VALUE  13775.
       77  FLD0570B                       PIC  9(08)V9(19) COMP-3
           VALUE  72019797.5322646066764775696.

       77  FLD0571A                       PIC  9(10)V9(08) COMP-6
           VALUE  4995844884.12155025.
       77  FLD0571B                       PIC  9(09)V9(16) COMP-6
           VALUE  666328034.4715885039619251.

       77  FLD0572A                       PIC  9(06)V9(01) COMP-6
           VALUE  199648.9.
       77  FLD0572B                       PIC S9(06)       COMP-3
           VALUE -163410.

       77  FLD0573A                       PIC  9(10)V9(11) COMP-6
           VALUE  5579051586.61930800079.
       77  FLD0573B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.908582147727897915245875992695800960.

       77  FLD0574A                       PIC  9(10)V9(09) COMP-3
           VALUE  5021035726.447702352.
       77  FLD0574B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0575A                       PIC  9(02)V9(34) COMP-3
           VALUE  96.0495649054037059499933093320578336.
       77  FLD0575B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0576A                       PIC  9(09)V9(11) COMP-3
           VALUE  551289746.02273483895.
       77  FLD0576B                       PIC  9(10)V9(10) COMP-6
           VALUE  5275129807.0789420791.

       77  FLD0577A                       PIC S9(10)V9(06) COMP-3
           VALUE +4245433083.607936.
       77  FLD0577B                       PIC  9(02)V9(34) COMP-6
           VALUE  96.8922152301445405164770363626303151.

       77  FLD0578A                       PIC S9(07)V9(02) COMP-3
           VALUE +2444375.29.
       77  FLD0578B                       PIC  9(05)V9(01) COMP-6
           VALUE  16994.3.

       77  FLD0579A                       PIC  9(09)V9(17) COMP-6
           VALUE  688719854.55414208576740975.
       77  FLD0579B                       PIC  9(10)V9(09) COMP-3
           VALUE  5219660742.233359629.

       77  FLD0580A                       PIC S9(08)V9(04) COMP-3
           VALUE +33455460.0291.
       77  FLD0580B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.3840741032953354228141051862621679.

       77  FLD0581A                       PIC S9(08)V9(02) COMP-3
           VALUE -28271118.43.
       77  FLD0581B                       PIC  9(09)V9(15) COMP-6
           VALUE  638334092.073881143036828.

       77  FLD0582A                       PIC  9(02)V9(34) COMP-3
           VALUE  95.0957041455027018983514608407858759.
       77  FLD0582B                       PIC  9(09)V9(14) COMP-6
           VALUE  628562844.11633944753106.

       77  FLD0583A                       PIC  9(04)V9(30) COMP-3
           VALUE  9004.015213488590907431330379040446.
       77  FLD0583B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0584A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0584B                       PIC  9(02)V9(34) COMP-6
           VALUE  95.5867594557756605766485336062032729.

       77  FLD0585A                       PIC S9(10)V9(06) COMP-3
           VALUE +4326355872.600766.
       77  FLD0585B                       PIC  9(03)V9(32) COMP-6
           VALUE  926.67442032915370297985191427869722.

       77  FLD0586A                       PIC  9(05)V9(27) COMP-6
           VALUE  85722.001340062370378092282408033.
       77  FLD0586B                       PIC  9(07)V9(22) COMP-6
           VALUE  7865140.9974229868904416207442.

       77  FLD0587A                       PIC S9(09)V9(05) COMP-3
           VALUE -381433349.51035.
       77  FLD0587B                       PIC S9(04)       COMP-3
           VALUE +1221.

       77  FLD0588A                       PIC  9(10)V9(09) COMP-6
           VALUE  5181115773.570048599.
       77  FLD0588B                       PIC  9(04)V9(30) COMP-3
           VALUE  9002.074772136551272794235956098418.

       77  FLD0589A                       PIC S9(09)V9(06) COMP-3
           VALUE +401102073.275349.
       77  FLD0589B                       PIC S9(04)       COMP-3
           VALUE +1219.

       77  FLD0590A                       PIC  9(08)V9(18) COMP-3
           VALUE  70309799.830174168899787900.
       77  FLD0590B                       PIC S9(06)V9(01) COMP-3
           VALUE +203587.9.

       77  FLD0591A                       PIC  9(09)V9(12) COMP-6
           VALUE  576933255.371857245386.
       77  FLD0591B                       PIC  9(10)V9(09) COMP-3
           VALUE  5123728162.782491546.

       77  FLD0592A                       PIC  9(09)V9(15) COMP-3
           VALUE  644514829.253344467829833.
       77  FLD0592B                       PIC S9(08)V9(03) COMP-3
           VALUE -29392268.940.

       77  FLD0593A                       PIC  9(08)V9(19) COMP-3
           VALUE  72063942.4137167527995018190.
       77  FLD0593B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0594A                       PIC S9(08)V9(02) COMP-3
           VALUE -27405154.91.
       77  FLD0594B                       PIC  9(07)V9(22) COMP-3
           VALUE  7738893.5043103479483050932685.

       77  FLD0595A                       PIC  9(08)V9(18) COMP-3
           VALUE  70489201.749069052560514592.
       77  FLD0595B                       PIC  9(06)V9(25) COMP-3
           VALUE  830535.6563477365172687427730124.

       77  FLD0596A                       PIC  9(04)V9(30) COMP-6
           VALUE  9050.358418523600789740157779306173.
       77  FLD0596B                       PIC  9(09)V9(15) COMP-6
           VALUE  657865013.656926733709440.

       77  FLD0597A                       PIC S9(10)V9(07) COMP-3
           VALUE -4611492066.1642122.
       77  FLD0597B                       PIC  9(06)V9(25) COMP-6
           VALUE  816255.9991782142310157155407068.

       77  FLD0598A                       PIC  9(10)V9(12) COMP-6
           VALUE  5888650589.753158248740.
       77  FLD0598B                       PIC S9(09)V9(06) COMP-3
           VALUE +420172956.568651.

       77  FLD0599A                       PIC  9(05)V9(27) COMP-6
           VALUE  85689.140306102984379066356268594.
       77  FLD0599B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0600A                       PIC S9(09)V9(06) COMP-3
           VALUE +401694362.049109.
       77  FLD0600B                       PIC  9(06)V9(24) COMP-3
           VALUE  804504.375985138686644404515391.

       77  FLD0601A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.763793413809590537866256454435642808.
       77  FLD0601B                       PIC  9(08)V9(03) COMP-6
           VALUE  29749803.347.

       77  FLD0602A                       PIC  9(09)V9(17) COMP-6
           VALUE  685435627.00727922454291274.
       77  FLD0602B                       PIC  9(07)V9(02) COMP-6
           VALUE  2399467.62.

       77  FLD0603A                       PIC  9(09)V9(16) COMP-6
           VALUE  679265807.5584466770280300.
       77  FLD0603B                       PIC S9(05)V9(01) COMP-3
           VALUE -17089.6.

       77  FLD0604A                       PIC  9(08)V9(19) COMP-6
           VALUE  72862711.3591577502127449861.
       77  FLD0604B                       PIC  9(10)V9(11) COMP-6
           VALUE  5587264166.34705347341.

       77  FLD0605A                       PIC  9(04)       COMP-6
           VALUE  1194.
       77  FLD0605B                       PIC  9(10)V9(06) COMP-6
           VALUE  4256956703.307752.

       77  FLD0606A                       PIC  9(07)V9(23) COMP-6
           VALUE  7955557.56926823565144957228767.
       77  FLD0606B                       PIC S9(08)V9(04) COMP-3
           VALUE +33373395.9174.

       77  FLD0607A                       PIC  9(10)V9(08) COMP-6
           VALUE  4950511846.00309279.
       77  FLD0607B                       PIC  9(05)       COMP-6
           VALUE  13935.

       77  FLD0608A                       PIC  9(09)V9(03) COMP-6
           VALUE  328182518.441.
       77  FLD0608B                       PIC  9(02)V9(34) COMP-6
           VALUE  95.9183130416232931914066739409463480.

       77  FLD0609A                       PIC  9(08)V9(04) COMP-6
           VALUE  33948712.4475.
       77  FLD0609B                       PIC  9(10)V9(07) COMP-6
           VALUE  4478674210.4372267.

       77  FLD0610A                       PIC  9(06)V9(24) COMP-6
           VALUE  807988.537497822956190418608457.
       77  FLD0610B                       PIC  9(08)V9(02) COMP-6
           VALUE  28672541.25.

       77  FLD0611A                       PIC  9(07)V9(22) COMP-3
           VALUE  7747853.4043620861382350994972.
       77  FLD0611B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0612A                       PIC  9(10)V9(11) COMP-3
           VALUE  5644161799.14422944108.
       77  FLD0612B                       PIC  9(07)V9(22) COMP-6
           VALUE  7874462.2890006543691754359315.

       77  FLD0613A                       PIC  9(05)       COMP-6
           VALUE  15551.
       77  FLD0613B                       PIC S9(07)V9(01) COMP-3
           VALUE +2249276.6.

       77  FLD0614A                       PIC  9(10)V9(09) COMP-3
           VALUE  5201647014.630440546.
       77  FLD0614B                       PIC  9(09)V9(13) COMP-6
           VALUE  596348860.2168276475623.

       77  FLD0615A                       PIC S9(03)       COMP-3
           VALUE +101.
       77  FLD0615B                       PIC S9(07)V9(01) COMP-3
           VALUE +2334095.1.

       77  FLD0616A                       PIC  9(07)V9(22) COMP-3
           VALUE  7639230.3574527464782306651613.
       77  FLD0616B                       PIC  9(02)       COMP-6
           VALUE  07.

       77  FLD0617A                       PIC S9(01)       COMP-3
           VALUE -0.
       77  FLD0617B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0618A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.817148549708982763206677191192284226.
       77  FLD0618B                       PIC  9(03)       COMP-6
           VALUE  089.

       77  FLD0619A                       PIC  9(06)V9(24) COMP-3
           VALUE  801850.998363624500875346257089.
       77  FLD0619B                       PIC  9(10)V9(10) COMP-3
           VALUE  5342180526.7555677598.

       77  FLD0620A                       PIC  9(08)V9(19) COMP-6
           VALUE  71717267.3810957062023874186.
       77  FLD0620B                       PIC  9(09)V9(15) COMP-6
           VALUE  655677089.730182127702562.

       77  FLD0621A                       PIC  9(04)V9(30) COMP-3
           VALUE  9035.013690395441443570234696380794.
       77  FLD0621B                       PIC  9(08)V9(19) COMP-3
           VALUE  73424367.1686218957184166811.

       77  FLD0622A                       PIC  9(09)V9(13) COMP-3
           VALUE  592420192.5737704321761.
       77  FLD0622B                       PIC S9(09)V9(04) COMP-3
           VALUE -361821982.1111.

       77  FLD0623A                       PIC S9(03)       COMP-3
           VALUE +104.
       77  FLD0623B                       PIC  9(09)V9(15) COMP-3
           VALUE  641616818.896418195095066.

       77  FLD0624A                       PIC S9(06)       COMP-3
           VALUE -162056.
       77  FLD0624B                       PIC  9(10)V9(06) COMP-6
           VALUE  4356343039.582531.

       77  FLD0625A                       PIC  9(04)       COMP-6
           VALUE  1296.
       77  FLD0625B                       PIC  9(07)V9(22) COMP-3
           VALUE  7829547.5769811728739000500354.

       77  FLD0626A                       PIC  9(04)V9(29) COMP-3
           VALUE  8839.60373056715265072114107169909.
       77  FLD0626B                       PIC S9(09)V9(05) COMP-3
           VALUE -374265939.71690.

       77  FLD0627A                       PIC  9(04)       COMP-6
           VALUE  1093.
       77  FLD0627B                       PIC S9(07)V9(01) COMP-3
           VALUE +2323895.2.

       77  FLD0628A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.943034041886028573387079632084351032.
       77  FLD0628B                       PIC  9(08)V9(03) COMP-6
           VALUE  29681737.673.

       77  FLD0629A                       PIC  9(03)V9(32) COMP-6
           VALUE  925.54391942612090904418664649710990.
       77  FLD0629B                       PIC  9(05)V9(28) COMP-3
           VALUE  87091.5644969416202769707524566911.

       77  FLD0630A                       PIC S9(09)V9(06) COMP-3
           VALUE +400669561.119235.
       77  FLD0630B                       PIC  9(09)V9(12) COMP-6
           VALUE  575188656.368988304734.

       77  FLD0631A                       PIC  9(09)V9(15) COMP-3
           VALUE  644864894.904831453814608.
       77  FLD0631B                       PIC  9(05)V9(01) COMP-6
           VALUE  17568.5.

       77  FLD0632A                       PIC  9(08)V9(18) COMP-6
           VALUE  69998401.036213298009869276.
       77  FLD0632B                       PIC  9(10)V9(09) COMP-6
           VALUE  5082278856.741135886.

       77  FLD0633A                       PIC  9(08)V9(19) COMP-3
           VALUE  72186800.0789349095747127194.
       77  FLD0633B                       PIC S9(09)V9(03) COMP-3
           VALUE +332989951.149.

       77  FLD0634A                       PIC S9(10)V9(06) COMP-3
           VALUE +4236607402.255205.
       77  FLD0634B                       PIC  9(07)V9(23) COMP-3
           VALUE  7926419.75404680843020344127580.

       77  FLD0635A                       PIC S9(06)V9(01) COMP-3
           VALUE -190863.2.
       77  FLD0635B                       PIC  9(10)V9(11) COMP-6
           VALUE  5580856572.20784292498.

       77  FLD0636A                       PIC S9(07)V9(01) COMP-3
           VALUE +2326055.8.
       77  FLD0636B                       PIC  9(05)       COMP-6
           VALUE  15706.

       77  FLD0637A                       PIC  9(08)V9(19) COMP-3
           VALUE  73470187.3111827330475875896.
       77  FLD0637B                       PIC  9(10)V9(10) COMP-3
           VALUE  5305678545.6603405837.

       77  FLD0638A                       PIC  9(07)V9(22) COMP-6
           VALUE  7752451.2041246673721417437263.
       77  FLD0638B                       PIC  9(06)V9(25) COMP-3
           VALUE  822351.5027967045476486873667454.

       77  FLD0639A                       PIC S9(09)V9(03) COMP-3
           VALUE +320313574.327.
       77  FLD0639B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.751092072024196699686626743641681969.

       77  FLD0640A                       PIC  9(04)V9(29) COMP-3
           VALUE  8818.61493829378950692898797569796.
       77  FLD0640B                       PIC  9(03)V9(32) COMP-3
           VALUE  921.50555740058603948483550993842072.

       77  FLD0641A                       PIC  9(07)V9(22) COMP-6
           VALUE  7672056.2697199168322725881807.
       77  FLD0641B                       PIC  9(08)V9(19) COMP-6
           VALUE  72539277.3386829170512157816.

       77  FLD0642A                       PIC  9(08)V9(18) COMP-6
           VALUE  70806494.663622721041917884.
       77  FLD0642B                       PIC  9(09)V9(13) COMP-3
           VALUE  592898946.8504934912118.

       77  FLD0643A                       PIC  9(07)V9(01) COMP-6
           VALUE  2194714.9.
       77  FLD0643B                       PIC  9(08)V9(02) COMP-6
           VALUE  26711153.59.

       77  FLD0644A                       PIC  9(02)       COMP-6
           VALUE  07.
       77  FLD0644B                       PIC  9(03)V9(32) COMP-6
           VALUE  936.97460492260109532480782945640385.

       77  FLD0645A                       PIC  9(03)V9(31) COMP-3
           VALUE  913.1000502995376688630813077907077.
       77  FLD0645B                       PIC  9(07)V9(02) COMP-6
           VALUE  2467302.34.

       77  FLD0646A                       PIC  9(07)V9(21) COMP-3
           VALUE  7520596.805608434909373727350.
       77  FLD0646B                       PIC  9(09)V9(13) COMP-6
           VALUE  595843790.0187590896550.

       77  FLD0647A                       PIC S9(02)       COMP-3
           VALUE -07.
       77  FLD0647B                       PIC  9(09)V9(16) COMP-6
           VALUE  659893156.1456289340839020.

       77  FLD0648A                       PIC S9(04)       COMP-3
           VALUE +1149.
       77  FLD0648B                       PIC  9(09)V9(15) COMP-3
           VALUE  634287010.942461315643470.

       77  FLD0649A                       PIC  9(07)V9(23) COMP-3
           VALUE  7912687.10466688007798552462190.
       77  FLD0649B                       PIC  9(10)V9(09) COMP-3
           VALUE  5026519944.429308495.

       77  FLD0650A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.878734262172308433491707546636462211.
       77  FLD0650B                       PIC  9(09)V9(16) COMP-3
           VALUE  671574601.9768447094833163.

       77  FLD0651A                       PIC  9(08)V9(18) COMP-6
           VALUE  69993795.648145529231243244.
       77  FLD0651B                       PIC S9(09)V9(05) COMP-3
           VALUE -390933259.39761.

       77  FLD0652A                       PIC  9(05)V9(01) COMP-6
           VALUE  16676.6.
       77  FLD0652B                       PIC S9(07)V9(01) COMP-3
           VALUE +2109381.3.

       77  FLD0653A                       PIC  9(09)V9(14) COMP-3
           VALUE  620233215.83922497168828.
       77  FLD0653B                       PIC  9(06)       COMP-6
           VALUE  165087.

       77  FLD0654A                       PIC  9(09)V9(15) COMP-6
           VALUE  639337130.284049814932245.
       77  FLD0654B                       PIC  9(08)V9(02) COMP-6
           VALUE  27813223.51.

       77  FLD0655A                       PIC  9(06)V9(25) COMP-6
           VALUE  818013.3890362937254536745967925.
       77  FLD0655B                       PIC  9(09)V9(13) COMP-3
           VALUE  594166317.4495728227952.

       77  FLD0656A                       PIC S9(06)V9(01) COMP-3
           VALUE +200859.7.
       77  FLD0656B                       PIC  9(09)V9(15) COMP-3
           VALUE  650208537.267117914204561.

       77  FLD0657A                       PIC  9(03)V9(32) COMP-6
           VALUE  936.17194619070143168926279031438753.
       77  FLD0657B                       PIC  9(08)V9(18) COMP-3
           VALUE  70468283.988380520099781278.

       77  FLD0658A                       PIC  9(08)V9(18) COMP-3
           VALUE  70069365.832955088357891781.
       77  FLD0658B                       PIC  9(10)V9(10) COMP-3
           VALUE  5438086690.5335789596.

       77  FLD0659A                       PIC  9(04)V9(30) COMP-3
           VALUE  9044.337793801533464943531726021319.
       77  FLD0659B                       PIC  9(08)V9(19) COMP-6
           VALUE  71946522.3294514011342926096.

       77  FLD0660A                       PIC  9(10)V9(09) COMP-3
           VALUE  5240012407.843260833.
       77  FLD0660B                       PIC S9(05)       COMP-3
           VALUE -15464.

       77  FLD0661A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.5581569624071600621562083688331767.
       77  FLD0661B                       PIC  9(10)V9(11) COMP-3
           VALUE  5705409453.15247127744.

       77  FLD0662A                       PIC S9(07)V9(01) COMP-3
           VALUE +2131985.0.
       77  FLD0662B                       PIC  9(09)V9(16) COMP-6
           VALUE  669960203.6476681732324323.

       77  FLD0663A                       PIC  9(05)       COMP-6
           VALUE  15788.
       77  FLD0663B                       PIC  9(04)V9(29) COMP-6
           VALUE  8894.69232052811142885673234559362.

       77  FLD0664A                       PIC S9(05)       COMP-3
           VALUE +14371.
       77  FLD0664B                       PIC S9(09)V9(07) COMP-3
           VALUE +440580330.5288489.

       77  FLD0665A                       PIC  9(07)V9(02) COMP-6
           VALUE  2455875.37.
       77  FLD0665B                       PIC  9(09)V9(16) COMP-3
           VALUE  674160289.5706166886924393.

       77  FLD0666A                       PIC  9(05)V9(27) COMP-3
           VALUE  86015.549175288641414738322055200.
       77  FLD0666B                       PIC  9(02)       COMP-6
           VALUE  05.

       77  FLD0667A                       PIC  9(02)V9(33) COMP-3
           VALUE  94.482499794694274619644147605868056.
       77  FLD0667B                       PIC  9(09)V9(15) COMP-3
           VALUE  632143875.790169951223163.

       77  FLD0668A                       PIC  9(03)V9(32) COMP-6
           VALUE  935.15331845029669999291854765033349.
       77  FLD0668B                       PIC  9(10)V9(09) COMP-3
           VALUE  5144629393.825745911.

       77  FLD0669A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.937328225295053441001869032334070652.
       77  FLD0669B                       PIC  9(10)V9(05) COMP-6
           VALUE  3959366397.86081.

       77  FLD0670A                       PIC  9(07)V9(02) COMP-6
           VALUE  2567113.54.
       77  FLD0670B                       PIC  9(02)V9(34) COMP-3
           VALUE  97.1019073438902258210703166696475818.

       77  FLD0671A                       PIC  9(09)V9(03) COMP-6
           VALUE  326622169.718.
       77  FLD0671B                       PIC  9(06)V9(01) COMP-6
           VALUE  186874.6.

       77  FLD0672A                       PIC  9(10)V9(07) COMP-6
           VALUE  4564917934.3294549.
       77  FLD0672B                       PIC  9(09)V9(15) COMP-6
           VALUE  637002039.815689924395769.

       77  FLD0673A                       PIC  9(10)V9(06) COMP-6
           VALUE  4285002333.462958.
       77  FLD0673B                       PIC  9(07)V9(02) COMP-6
           VALUE  2489778.77.

       77  FLD0674A                       PIC  9(10)V9(10) COMP-6
           VALUE  5491650640.0821929467.
       77  FLD0674B                       PIC  9(06)V9(25) COMP-6
           VALUE  828061.3110769976525915581078152.

       77  FLD0675A                       PIC  9(05)V9(27) COMP-6
           VALUE  84609.285471017914304070473008323.
       77  FLD0675B                       PIC  9(10)V9(09) COMP-6
           VALUE  5083540664.870341840.

       77  FLD0676A                       PIC  9(03)       COMP-6
           VALUE  096.
       77  FLD0676B                       PIC  9(02)V9(34) COMP-3
           VALUE  96.4664170342459437179627457226160913.

       77  FLD0677A                       PIC S9(07)V9(01) COMP-3
           VALUE +2248183.1.
       77  FLD0677B                       PIC  9(04)V9(29) COMP-3
           VALUE  8903.66445455624266891447859961772.

       77  FLD0678A                       PIC S9(03)       COMP-3
           VALUE -092.
       77  FLD0678B                       PIC  9(05)V9(27) COMP-6
           VALUE  85887.366357613359468814451247453.

       77  FLD0679A                       PIC S9(03)       COMP-3
           VALUE -080.
       77  FLD0679B                       PIC  9(10)V9(07) COMP-6
           VALUE  4490278235.6612852.

       77  FLD0680A                       PIC S9(08)V9(02) COMP-3
           VALUE -28119381.66.
       77  FLD0680B                       PIC  9(10)V9(11) COMP-3
           VALUE  5617591008.16083600804.

       77  FLD0681A                       PIC  9(08)V9(17) COMP-3
           VALUE  68244115.95644890304868113.
       77  FLD0681B                       PIC  9(06)V9(25) COMP-3
           VALUE  821371.7547801553386932482681004.

       77  FLD0682A                       PIC S9(10)V9(08) COMP-3
           VALUE -4949729784.45772315.
       77  FLD0682B                       PIC  9(06)V9(25) COMP-3
           VALUE  831097.0812489861803129542749957.

       77  FLD0683A                       PIC  9(05)V9(28) COMP-6
           VALUE  86894.3068817851549390240961656672.
       77  FLD0683B                       PIC  9(10)V9(12) COMP-3
           VALUE  5829735573.963021888488.

       77  FLD0684A                       PIC  9(10)V9(13) COMP-6
           VALUE  6059233373.6406744915115.
       77  FLD0684B                       PIC  9(09)V9(07) COMP-6
           VALUE  438339473.7646870.

       77  FLD0685A                       PIC S9(07)V9(02) COMP-3
           VALUE -2545714.99.
       77  FLD0685B                       PIC  9(07)V9(23) COMP-3
           VALUE  7915567.03876752143500539204978.

       77  FLD0686A                       PIC  9(09)V9(14) COMP-3
           VALUE  621044693.11257093355749.
       77  FLD0686B                       PIC  9(09)V9(13) COMP-3
           VALUE  602970496.8531952591348.

       77  FLD0687A                       PIC S9(09)V9(05) COMP-3
           VALUE -394005874.76898.
       77  FLD0687B                       PIC  9(10)V9(08) COMP-6
           VALUE  4960980508.03440715.

       77  FLD0688A                       PIC  9(03)V9(32) COMP-3
           VALUE  932.26844955554755145499257196206599.
       77  FLD0688B                       PIC  9(04)       COMP-6
           VALUE  1064.

       77  FLD0689A                       PIC  9(10)V9(07) COMP-6
           VALUE  4559306991.4341932.
       77  FLD0689B                       PIC S9(08)V9(04) COMP-3
           VALUE +34024840.8710.

       77  FLD0690A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.793660005922469879990899244148749858.
       77  FLD0690B                       PIC S9(08)V9(02) COMP-3
           VALUE -28078949.75.

       77  FLD0691A                       PIC  9(09)V9(07) COMP-6
           VALUE  439500550.5938089.
       77  FLD0691B                       PIC S9(10)V9(06) COMP-3
           VALUE +4308484639.535531.

       77  FLD0692A                       PIC  9(09)V9(04) COMP-6
           VALUE  358382577.7464.
       77  FLD0692B                       PIC  9(09)V9(15) COMP-6
           VALUE  636450165.553045121846764.

       77  FLD0693A                       PIC S9(07)V9(01) COMP-3
           VALUE +2127399.6.
       77  FLD0693B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0694A                       PIC  9(09)V9(05) COMP-6
           VALUE  378019656.01658.
       77  FLD0694B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0695A                       PIC S9(09)V9(04) COMP-3
           VALUE -354304867.1111.
       77  FLD0695B                       PIC  9(09)V9(15) COMP-6
           VALUE  639721730.127885357397587.

       77  FLD0696A                       PIC  9(04)V9(30) COMP-6
           VALUE  9067.945209731629319094281527213752.
       77  FLD0696B                       PIC  9(09)V9(03) COMP-6
           VALUE  318871778.848.

       77  FLD0697A                       PIC S9(09)V9(06) COMP-3
           VALUE +414586353.841170.
       77  FLD0697B                       PIC  9(10)V9(09) COMP-6
           VALUE  5161837194.897523906.

       77  FLD0698A                       PIC  9(08)V9(18) COMP-3
           VALUE  69447533.832122987362822641.
       77  FLD0698B                       PIC S9(03)       COMP-3
           VALUE -080.

       77  FLD0699A                       PIC  9(09)V9(13) COMP-6
           VALUE  597064952.5204202445749.
       77  FLD0699B                       PIC  9(09)V9(14) COMP-3
           VALUE  630288401.27729701681147.

       77  FLD0700A                       PIC  9(06)V9(25) COMP-3
           VALUE  820234.3139012789885455845251271.
       77  FLD0700B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0701A                       PIC  9(06)V9(24) COMP-6
           VALUE  809485.363390515577641792788199.
       77  FLD0701B                       PIC  9(02)V9(34) COMP-3
           VALUE  97.0800419877562270620785511709982529.

       77  FLD0702A                       PIC  9(04)V9(30) COMP-3
           VALUE  9021.848589518318695112952809722628.
       77  FLD0702B                       PIC  9(07)V9(01) COMP-6
           VALUE  2351439.7.

       77  FLD0703A                       PIC S9(04)       COMP-3
           VALUE +1126.
       77  FLD0703B                       PIC  9(08)V9(04) COMP-6
           VALUE  33525578.1235.

       77  FLD0704A                       PIC  9(10)V9(07) COMP-6
           VALUE  4696322933.5995404.
       77  FLD0704B                       PIC  9(09)V9(14) COMP-3
           VALUE  611168884.71092423174013.

       77  FLD0705A                       PIC  9(10)V9(10) COMP-6
           VALUE  5381864238.0664638569.
       77  FLD0705B                       PIC  9(10)V9(07) COMP-6
           VALUE  4699950479.7278301.

       77  FLD0706A                       PIC  9(07)V9(22) COMP-3
           VALUE  7815442.4104873465584120140192.
       77  FLD0706B                       PIC S9(05)V9(01) COMP-3
           VALUE -17297.4.

       77  FLD0707A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0707B                       PIC  9(10)V9(09) COMP-3
           VALUE  5129442198.407349051.

       77  FLD0708A                       PIC  9(02)V9(34) COMP-3
           VALUE  95.1225570140109555339336111501324921.
       77  FLD0708B                       PIC  9(08)V9(04) COMP-6
           VALUE  33834894.3169.

       77  FLD0709A                       PIC S9(04)       COMP-3
           VALUE +1124.
       77  FLD0709B                       PIC  9(09)V9(05) COMP-6
           VALUE  379344826.68404.

       77  FLD0710A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.946833086486408515014545628218911588.
       77  FLD0710B                       PIC S9(09)V9(03) COMP-3
           VALUE +322996298.459.

       77  FLD0711A                       PIC  9(09)V9(16) COMP-6
           VALUE  677754067.1912668512888444.
       77  FLD0711B                       PIC  9(02)       COMP-6
           VALUE  06.

       77  FLD0712A                       PIC  9(09)V9(14) COMP-3
           VALUE  610433230.32745544498567.
       77  FLD0712B                       PIC S9(10)V9(08) COMP-3
           VALUE -4947392148.88603839.

       77  FLD0713A                       PIC S9(08)V9(03) COMP-3
           VALUE -29280564.557.
       77  FLD0713B                       PIC  9(07)V9(01) COMP-6
           VALUE  2168463.7.

       77  FLD0714A                       PIC  9(10)V9(07) COMP-6
           VALUE  4593980567.3719869.
       77  FLD0714B                       PIC  9(09)V9(04) COMP-6
           VALUE  347385951.5252.

       77  FLD0715A                       PIC  9(09)V9(06) COMP-6
           VALUE  406643755.503527.
       77  FLD0715B                       PIC  9(10)V9(10) COMP-6
           VALUE  5480282475.3098877685.

       77  FLD0716A                       PIC S9(08)V9(03) COMP-3
           VALUE -29497495.128.
       77  FLD0716B                       PIC  9(03)V9(31) COMP-3
           VALUE  914.3056916239737930141018296126276.

       77  FLD0717A                       PIC  9(05)V9(28) COMP-6
           VALUE  86936.9843469434133709228262887336.
       77  FLD0717B                       PIC  9(07)V9(21) COMP-6
           VALUE  7570171.861371541854879296806.

       77  FLD0718A                       PIC  9(06)       COMP-6
           VALUE  158746.
       77  FLD0718B                       PIC  9(10)V9(06) COMP-6
           VALUE  4283417063.648062.

       77  FLD0719A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0719B                       PIC  9(07)V9(02) COMP-6
           VALUE  2390904.61.

       77  FLD0720A                       PIC  9(03)       COMP-6
           VALUE  087.
       77  FLD0720B                       PIC S9(09)V9(06) COMP-3
           VALUE +404886316.426392.

       77  FLD0721A                       PIC S9(09)V9(03) COMP-3
           VALUE +332294869.962.
       77  FLD0721B                       PIC  9(07)V9(01) COMP-6
           VALUE  2285954.3.

       77  FLD0722A                       PIC S9(05)V9(01) COMP-3
           VALUE -17094.9.
       77  FLD0722B                       PIC  9(07)V9(21) COMP-3
           VALUE  7607809.920924922808538326535.

       77  FLD0723A                       PIC  9(05)V9(28) COMP-3
           VALUE  87349.0901765646254872876852459739.
       77  FLD0723B                       PIC  9(02)       COMP-6
           VALUE  07.

       77  FLD0724A                       PIC  9(09)V9(03) COMP-6
           VALUE  317474559.928.
       77  FLD0724B                       PIC  9(10)V9(09) COMP-6
           VALUE  5251486411.115240393.

       77  FLD0725A                       PIC  9(03)V9(31) COMP-6
           VALUE  915.1169879467740964074096154945436.
       77  FLD0725B                       PIC S9(09)V9(07) COMP-3
           VALUE +444412819.1361023.

       77  FLD0726A                       PIC  9(05)       COMP-6
           VALUE  14771.
       77  FLD0726B                       PIC S9(09)V9(06) COMP-3
           VALUE +401835639.675800.

       77  FLD0727A                       PIC  9(10)V9(10) COMP-3
           VALUE  5412169008.2113094177.
       77  FLD0727B                       PIC  9(09)V9(16) COMP-6
           VALUE  677439277.9021225496904889.

       77  FLD0728A                       PIC  9(09)V9(07) COMP-6
           VALUE  439411444.5456123.
       77  FLD0728B                       PIC S9(09)V9(05) COMP-3
           VALUE -371357711.97684.

       77  FLD0729A                       PIC  9(02)V9(33) COMP-6
           VALUE  94.514768998125520127473464526701718.
       77  FLD0729B                       PIC  9(07)V9(23) COMP-6
           VALUE  7959700.26538914909863819957536.

       77  FLD0730A                       PIC  9(06)V9(25) COMP-3
           VALUE  822685.8594490329412707296796725.
       77  FLD0730B                       PIC  9(09)V9(14) COMP-3
           VALUE  630270988.23946403616247.

       77  FLD0731A                       PIC  9(10)V9(12) COMP-3
           VALUE  5808279049.356201984011.
       77  FLD0731B                       PIC  9(09)V9(13) COMP-3
           VALUE  600372700.6085320949679.

       77  FLD0732A                       PIC  9(03)V9(31) COMP-6
           VALUE  915.5080332184045710519626481982413.
       77  FLD0732B                       PIC S9(04)       COMP-3
           VALUE +1229.

       77  FLD0733A                       PIC  9(09)V9(03) COMP-6
           VALUE  328019305.824.
       77  FLD0733B                       PIC  9(09)V9(15) COMP-6
           VALUE  637621846.224700750127567.

       77  FLD0734A                       PIC S9(06)       COMP-3
           VALUE -164821.
       77  FLD0734B                       PIC  9(02)       COMP-6
           VALUE  05.

       77  FLD0735A                       PIC S9(06)V9(01) COMP-3
           VALUE -190229.8.
       77  FLD0735B                       PIC  9(09)V9(15) COMP-3
           VALUE  641899075.827484955070190.

       77  FLD0736A                       PIC  9(10)V9(09) COMP-3
           VALUE  5128678158.202983894.
       77  FLD0736B                       PIC  9(07)V9(23) COMP-6
           VALUE  7952260.56216242538354777025233.

       77  FLD0737A                       PIC S9(07)V9(02) COMP-3
           VALUE -2601084.10.
       77  FLD0737B                       PIC S9(07)V9(02) COMP-3
           VALUE -2623355.12.

       77  FLD0738A                       PIC  9(10)V9(09) COMP-6
           VALUE  5071467647.954436275.
       77  FLD0738B                       PIC  9(02)V9(34) COMP-6
           VALUE  96.7470462418068333221299326396547257.

       77  FLD0739A                       PIC S9(09)V9(03) COMP-3
           VALUE +324797211.447.
       77  FLD0739B                       PIC S9(10)V9(08) COMP-3
           VALUE -4916417996.38161292.

       77  FLD0740A                       PIC S9(08)V9(03) COMP-3
           VALUE +30394739.303.
       77  FLD0740B                       PIC  9(05)V9(28) COMP-3
           VALUE  87461.9397808273024708114462555386.

       77  FLD0741A                       PIC S9(09)V9(03) COMP-3
           VALUE +322386723.831.
       77  FLD0741B                       PIC S9(09)V9(03) COMP-3
           VALUE +321782512.880.

       77  FLD0742A                       PIC  9(09)V9(06) COMP-6
           VALUE  419367234.713135.
       77  FLD0742B                       PIC S9(08)V9(03) COMP-3
           VALUE +30468212.851.

       77  FLD0743A                       PIC  9(05)V9(27) COMP-6
           VALUE  85864.867305029812794003873932524.
       77  FLD0743B                       PIC  9(06)V9(01) COMP-6
           VALUE  209820.2.

       77  FLD0744A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0744B                       PIC  9(08)V9(02) COMP-6
           VALUE  26956228.79.

       77  FLD0745A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.759709501186564217789509712019935250.
       77  FLD0745B                       PIC  9(05)       COMP-6
           VALUE  13548.

       77  FLD0746A                       PIC  9(10)V9(10) COMP-3
           VALUE  5435731573.3552813430.
       77  FLD0746B                       PIC  9(10)V9(09) COMP-3
           VALUE  5204204473.599284286.

       77  FLD0747A                       PIC  9(10)V9(11) COMP-6
           VALUE  5681676571.07930934579.
       77  FLD0747B                       PIC  9(03)V9(31) COMP-6
           VALUE  916.9159297409485986918298294767737.

       77  FLD0748A                       PIC  9(03)       COMP-6
           VALUE  086.
       77  FLD0748B                       PIC S9(05)V9(01) COMP-3
           VALUE -18032.7.

       77  FLD0749A                       PIC S9(10)V9(07) COMP-3
           VALUE -4609096560.3942379.
       77  FLD0749B                       PIC  9(06)V9(25) COMP-3
           VALUE  820519.2560948625368766329302161.

       77  FLD0750A                       PIC  9(07)V9(22) COMP-6
           VALUE  7666736.3171436386792834127845.
       77  FLD0750B                       PIC  9(08)V9(04) COMP-6
           VALUE  33966692.5145.

       77  FLD0751A                       PIC  9(02)       COMP-6
           VALUE  06.
       77  FLD0751B                       PIC S9(05)       COMP-3
           VALUE -15176.

       77  FLD0752A                       PIC  9(02)       COMP-6
           VALUE  07.
       77  FLD0752B                       PIC  9(03)V9(32) COMP-3
           VALUE  922.38508268330654527034084821934811.

       77  FLD0753A                       PIC  9(08)V9(19) COMP-3
           VALUE  73379118.3872512742247806727.
       77  FLD0753B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0754A                       PIC S9(09)V9(03) COMP-3
           VALUE +322061792.108.
       77  FLD0754B                       PIC  9(07)V9(02) COMP-6
           VALUE  2450066.21.

       77  FLD0755A                       PIC  9(06)V9(25) COMP-6
           VALUE  835592.8333445592492978448717622.
       77  FLD0755B                       PIC  9(10)V9(10) COMP-3
           VALUE  5346301002.0417645051.

       77  FLD0756A                       PIC  9(09)V9(04) COMP-6
           VALUE  366295057.8421.
       77  FLD0756B                       PIC S9(05)       COMP-3
           VALUE -15366.

       77  FLD0757A                       PIC  9(08)V9(19) COMP-3
           VALUE  71466976.1113856494283425035.
       77  FLD0757B                       PIC S9(07)V9(02) COMP-3
           VALUE +2429438.31.

       77  FLD0758A                       PIC  9(07)V9(01) COMP-6
           VALUE  2293699.9.
       77  FLD0758B                       PIC S9(06)       COMP-3
           VALUE -162229.

       77  FLD0759A                       PIC  9(03)V9(32) COMP-3
           VALUE  931.38963166127219928114300273591652.
       77  FLD0759B                       PIC  9(07)V9(21) COMP-3
           VALUE  7621303.882836163445801958005.

       77  FLD0760A                       PIC  9(06)V9(01) COMP-6
           VALUE  188511.3.
       77  FLD0760B                       PIC  9(04)V9(30) COMP-3
           VALUE  9041.413390221895163278986728982999.

       77  FLD0761A                       PIC  9(09)V9(17) COMP-3
           VALUE  690006529.44346418937726639.
       77  FLD0761B                       PIC  9(09)V9(14) COMP-6
           VALUE  629261290.31917010792085.

       77  FLD0762A                       PIC  9(09)V9(16) COMP-3
           VALUE  671435372.9957326377686399.
       77  FLD0762B                       PIC  9(07)V9(02) COMP-6
           VALUE  2591343.61.

       77  FLD0763A                       PIC  9(08)V9(19) COMP-3
           VALUE  71468145.3175585401638159055.
       77  FLD0763B                       PIC  9(06)V9(24) COMP-6
           VALUE  815545.608346078032546699887461.

       77  FLD0764A                       PIC  9(10)V9(11) COMP-3
           VALUE  5535007698.50315821329.
       77  FLD0764B                       PIC  9(10)V9(08) COMP-6
           VALUE  4979398183.62831021.

       77  FLD0765A                       PIC  9(04)V9(29) COMP-6
           VALUE  8855.80582773889624093044403707608.
       77  FLD0765B                       PIC S9(04)       COMP-3
           VALUE +1212.

       77  FLD0766A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0766B                       PIC  9(07)V9(01) COMP-6
           VALUE  2294943.2.

       77  FLD0767A                       PIC S9(10)V9(08) COMP-3
           VALUE -4848285740.27346248.
       77  FLD0767B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0768A                       PIC  9(09)V9(17) COMP-3
           VALUE  684230789.92735519854306858.
       77  FLD0768B                       PIC S9(02)       COMP-3
           VALUE -07.

       77  FLD0769A                       PIC  9(07)V9(02) COMP-6
           VALUE  2565731.27.
       77  FLD0769B                       PIC  9(09)V9(04) COMP-6
           VALUE  356094054.4649.

       77  FLD0770A                       PIC  9(09)V9(12) COMP-3
           VALUE  574214303.174467532997.
       77  FLD0770B                       PIC  9(10)V9(13) COMP-6
           VALUE  6057194691.9895736094474.

       77  FLD0771A                       PIC  9(08)V9(18) COMP-6
           VALUE  69721614.519732855175249142.
       77  FLD0771B                       PIC  9(09)V9(17) COMP-3
           VALUE  690190375.47148320843604096.

       77  FLD0772A                       PIC  9(10)V9(08) COMP-6
           VALUE  4868623585.10471993.
       77  FLD0772B                       PIC  9(10)V9(05) COMP-6
           VALUE  3959689116.24786.

       77  FLD0773A                       PIC S9(07)V9(01) COMP-3
           VALUE +2339835.9.
       77  FLD0773B                       PIC  9(03)V9(32) COMP-3
           VALUE  931.93997423560348547511011929600499.

       77  FLD0774A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0774B                       PIC S9(07)V9(02) COMP-3
           VALUE +2425891.04.

       77  FLD0775A                       PIC  9(09)V9(06) COMP-6
           VALUE  418947899.183504.
       77  FLD0775B                       PIC  9(03)V9(32) COMP-3
           VALUE  930.87735098341006789723905967548489.

       77  FLD0776A                       PIC  9(09)V9(06) COMP-6
           VALUE  418950765.017868.
       77  FLD0776B                       PIC  9(05)V9(27) COMP-6
           VALUE  84781.081485203291236985023715533.

       77  FLD0777A                       PIC S9(08)V9(03) COMP-3
           VALUE +31438250.184.
       77  FLD0777B                       PIC  9(10)V9(11) COMP-3
           VALUE  5606560858.83416754889.

       77  FLD0778A                       PIC S9(06)V9(01) COMP-3
           VALUE -192739.4.
       77  FLD0778B                       PIC  9(03)V9(31) COMP-6
           VALUE  916.8465464730475300569878527312539.

       77  FLD0779A                       PIC  9(04)V9(30) COMP-3
           VALUE  9029.333248069044692840634525055065.
       77  FLD0779B                       PIC S9(10)V9(08) COMP-3
           VALUE -4740907582.59428035.

       77  FLD0780A                       PIC  9(09)V9(03) COMP-6
           VALUE  318241207.749.
       77  FLD0780B                       PIC  9(06)V9(25) COMP-3
           VALUE  822759.6235369002419801631731388.

       77  FLD0781A                       PIC  9(10)V9(08) COMP-6
           VALUE  4967153543.73054196.
       77  FLD0781B                       PIC  9(08)V9(03) COMP-6
           VALUE  29720911.669.

       77  FLD0782A                       PIC  9(05)       COMP-6
           VALUE  13793.
       77  FLD0782B                       PIC  9(02)V9(34) COMP-6
           VALUE  95.5158015091007617236584792408393695.

       77  FLD0783A                       PIC  9(04)V9(29) COMP-3
           VALUE  8813.39219378433402773964644438819.
       77  FLD0783B                       PIC S9(10)V9(06) COMP-3
           VALUE +4236433759.282261.

       77  FLD0784A                       PIC  9(09)V9(15) COMP-3
           VALUE  641964802.793786426526878.
       77  FLD0784B                       PIC  9(06)V9(25) COMP-3
           VALUE  824637.3935062285553954097849782.

       77  FLD0785A                       PIC  9(08)V9(17) COMP-3
           VALUE  68097654.34600172362422654.
       77  FLD0785B                       PIC  9(09)V9(03) COMP-6
           VALUE  325202869.704.

       77  FLD0786A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.820249933224565186407062356011010706.
       77  FLD0786B                       PIC  9(05)V9(27) COMP-3
           VALUE  85417.725929538756979297886573476.

       77  FLD0787A                       PIC  9(10)V9(11) COMP-6
           VALUE  5592847098.07636559730.
       77  FLD0787B                       PIC  9(06)V9(01) COMP-6
           VALUE  199330.4.

       77  FLD0788A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.6557531637097668841818176588276401.
       77  FLD0788B                       PIC  9(07)V9(22) COMP-6
           VALUE  7789929.3063459995600794627534.

       77  FLD0789A                       PIC S9(05)V9(01) COMP-3
           VALUE -17101.7.
       77  FLD0789B                       PIC  9(09)V9(16) COMP-3
           VALUE  660444958.2132847496040994.

       77  FLD0790A                       PIC  9(07)V9(02) COMP-6
           VALUE  2384369.54.
       77  FLD0790B                       PIC S9(08)V9(03) COMP-3
           VALUE -29309999.122.

       77  FLD0791A                       PIC  9(03)       COMP-6
           VALUE  088.
       77  FLD0791B                       PIC  9(08)V9(20) COMP-6
           VALUE  73827325.48868294886190710712.

       77  FLD0792A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.5230059106088935649836457741912454.
       77  FLD0792B                       PIC  9(09)V9(05) COMP-6
           VALUE  379824535.06313.

       77  FLD0793A                       PIC  9(06)V9(01) COMP-6
           VALUE  199221.9.
       77  FLD0793B                       PIC  9(10)V9(11) COMP-6
           VALUE  5591577156.30166807230.

       77  FLD0794A                       PIC S9(08)V9(04) COMP-3
           VALUE +33437009.5807.
       77  FLD0794B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0795A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0795B                       PIC S9(08)V9(04) COMP-3
           VALUE +33494400.6958.

       77  FLD0796A                       PIC  9(07)V9(21) COMP-6
           VALUE  7565685.006144580171394409262.
       77  FLD0796B                       PIC  9(08)V9(19) COMP-6
           VALUE  72949831.5977354816475042298.

       77  FLD0797A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0797B                       PIC  9(09)V9(04) COMP-6
           VALUE  348777486.0252.

       77  FLD0798A                       PIC S9(09)V9(03) COMP-3
           VALUE +332243375.906.
       77  FLD0798B                       PIC  9(09)V9(16) COMP-3
           VALUE  673821443.1439371043808250.

       77  FLD0799A                       PIC  9(09)V9(17) COMP-3
           VALUE  690866271.33683375934225523.
       77  FLD0799B                       PIC  9(09)V9(11) COMP-3
           VALUE  551526790.74963362193.

       77  FLD0800A                       PIC  9(08)V9(18) COMP-3
           VALUE  70036112.416705975647346349.
       77  FLD0800B                       PIC  9(08)V9(02) COMP-6
           VALUE  26662512.18.

       77  FLD0801A                       PIC S9(09)V9(07) COMP-3
           VALUE +443093279.8052367.
       77  FLD0801B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.827967002397862694706986985693220049.

       77  FLD0802A                       PIC S9(07)V9(02) COMP-3
           VALUE +2449505.23.
       77  FLD0802B                       PIC  9(04)V9(29) COMP-3
           VALUE  8911.32090012832223102634543465683.

       77  FLD0803A                       PIC S9(05)V9(01) COMP-3
           VALUE -17467.0.
       77  FLD0803B                       PIC  9(10)V9(11) COMP-6
           VALUE  5556247901.99399698487.

       77  FLD0804A                       PIC  9(07)V9(02) COMP-6
           VALUE  2599541.84.
       77  FLD0804B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0805A                       PIC  9(07)V9(01) COMP-6
           VALUE  2358341.0.
       77  FLD0805B                       PIC  9(10)V9(08) COMP-6
           VALUE  4796323563.66873291.

       77  FLD0806A                       PIC  9(10)V9(11) COMP-3
           VALUE  5703927562.80738821850.
       77  FLD0806B                       PIC  9(09)V9(07) COMP-6
           VALUE  445849105.9648416.

       77  FLD0807A                       PIC  9(09)V9(17) COMP-6
           VALUE  689326682.16034242991696601.
       77  FLD0807B                       PIC S9(03)       COMP-3
           VALUE -090.

       77  FLD0808A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0808B                       PIC  9(10)V9(07) COMP-6
           VALUE  4574455047.5690953.

       77  FLD0809A                       PIC  9(05)V9(28) COMP-6
           VALUE  86873.4196996681751201663246320094.
       77  FLD0809B                       PIC S9(09)V9(07) COMP-3
           VALUE +440334288.3961999.

       77  FLD0810A                       PIC S9(04)       COMP-3
           VALUE +1129.
       77  FLD0810B                       PIC S9(07)V9(01) COMP-3
           VALUE +2130584.0.

       77  FLD0811A                       PIC  9(09)V9(15) COMP-6
           VALUE  648943185.643321429623142.
       77  FLD0811B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.811592432324195423021251372119877487.

       77  FLD0812A                       PIC S9(08)V9(03) COMP-3
           VALUE -29270905.795.
       77  FLD0812B                       PIC  9(08)V9(02) COMP-6
           VALUE  27514068.39.

       77  FLD0813A                       PIC  9(10)V9(08) COMP-6
           VALUE  4881724662.84412076.
       77  FLD0813B                       PIC S9(08)V9(03) COMP-3
           VALUE -29113136.400.

       77  FLD0814A                       PIC S9(02)       COMP-3
           VALUE -07.
       77  FLD0814B                       PIC  9(07)V9(21) COMP-3
           VALUE  7525112.595496631362479433846.

       77  FLD0815A                       PIC  9(06)V9(25) COMP-6
           VALUE  838676.0467962863785373883729334.
       77  FLD0815B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.3836598694868031955707010638434439.

       77  FLD0816A                       PIC  9(08)V9(18) COMP-6
           VALUE  70774184.783492177786001775.
       77  FLD0816B                       PIC  9(04)V9(29) COMP-6
           VALUE  8859.15144904112161761133847903693.

       77  FLD0817A                       PIC  9(10)V9(09) COMP-6
           VALUE  5163345142.860672476.
       77  FLD0817B                       PIC  9(10)V9(09) COMP-6
           VALUE  5158922133.304477686.

       77  FLD0818A                       PIC  9(08)V9(03) COMP-6
           VALUE  30586164.664.
       77  FLD0818B                       PIC  9(08)V9(19) COMP-6
           VALUE  71565910.0751609544843745425.

       77  FLD0819A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.844708607145921108738662042014766484.
       77  FLD0819B                       PIC S9(03)       COMP-3
           VALUE -092.

       77  FLD0820A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0820B                       PIC  9(02)V9(34) COMP-6
           VALUE  95.6537139953218984445015848905313760.

       77  FLD0821A                       PIC  9(09)V9(11) COMP-3
           VALUE  550576956.44832715942.
       77  FLD0821B                       PIC S9(09)V9(05) COMP-3
           VALUE -383656536.39422.

       77  FLD0822A                       PIC S9(05)       COMP-3
           VALUE +14037.
       77  FLD0822B                       PIC  9(04)       COMP-6
           VALUE  1092.

       77  FLD0823A                       PIC  9(08)V9(20) COMP-6
           VALUE  73880168.20028298070610617287.
       77  FLD0823B                       PIC S9(09)V9(06) COMP-3
           VALUE +410430433.569272.

       77  FLD0824A                       PIC  9(10)V9(10) COMP-6
           VALUE  5351534260.3280557920.
       77  FLD0824B                       PIC  9(09)V9(14) COMP-6
           VALUE  619637811.24301098301998.

       77  FLD0825A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0825B                       PIC S9(05)V9(01) COMP-3
           VALUE -17069.2.

       77  FLD0826A                       PIC S9(06)V9(01) COMP-3
           VALUE -190786.5.
       77  FLD0826B                       PIC S9(10)V9(08) COMP-3
           VALUE -4805976358.59735916.

       77  FLD0827A                       PIC  9(07)V9(22) COMP-6
           VALUE  7763847.1978375678261841130733.
       77  FLD0827B                       PIC  9(10)V9(07) COMP-6
           VALUE  4683286251.1747114.

       77  FLD0828A                       PIC S9(10)V9(07) COMP-3
           VALUE -4530916009.2405642.
       77  FLD0828B                       PIC S9(05)       COMP-3
           VALUE -15016.

       77  FLD0829A                       PIC  9(09)V9(17) COMP-3
           VALUE  691486534.21926165041355716.
       77  FLD0829B                       PIC  9(07)V9(23) COMP-6
           VALUE  7963194.44710118728991687930829.

       77  FLD0830A                       PIC  9(04)V9(30) COMP-6
           VALUE  8965.722935126121395654763546190224.
       77  FLD0830B                       PIC  9(10)V9(11) COMP-6
           VALUE  5655358049.53465004452.

       77  FLD0831A                       PIC  9(04)V9(30) COMP-6
           VALUE  8956.555580996397036841472072410397.
       77  FLD0831B                       PIC  9(09)V9(16) COMP-3
           VALUE  660284490.9595845246386147.

       77  FLD0832A                       PIC  9(04)       COMP-6
           VALUE  1185.
       77  FLD0832B                       PIC  9(09)V9(06) COMP-6
           VALUE  419049138.539795.

       77  FLD0833A                       PIC  9(06)V9(24) COMP-3
           VALUE  804859.798300300854911881742737.
       77  FLD0833B                       PIC  9(09)V9(16) COMP-3
           VALUE  664990588.4825918489511309.

       77  FLD0834A                       PIC  9(09)V9(04) COMP-6
           VALUE  349209744.2881.
       77  FLD0834B                       PIC  9(08)V9(19) COMP-3
           VALUE  71191898.1740956136050613167.

       77  FLD0835A                       PIC  9(08)V9(19) COMP-3
           VALUE  71178359.2779248075466114187.
       77  FLD0835B                       PIC  9(07)V9(22) COMP-6
           VALUE  7891261.8513661014763016510187.

       77  FLD0836A                       PIC  9(09)V9(07) COMP-6
           VALUE  446141389.3412962.
       77  FLD0836B                       PIC  9(09)V9(13) COMP-3
           VALUE  594066179.3005866941896.

       77  FLD0837A                       PIC  9(04)V9(30) COMP-6
           VALUE  8982.008694278872384941792006429750.
       77  FLD0837B                       PIC S9(08)V9(03) COMP-3
           VALUE -29146758.519.

       77  FLD0838A                       PIC  9(10)V9(12) COMP-6
           VALUE  5873188106.793812979233.
       77  FLD0838B                       PIC  9(07)V9(22) COMP-3
           VALUE  7748686.2151072521953665273031.

       77  FLD0839A                       PIC  9(08)V9(19) COMP-3
           VALUE  71324671.8649382605015318858.
       77  FLD0839B                       PIC  9(06)V9(01) COMP-6
           VALUE  205379.6.

       77  FLD0840A                       PIC S9(03)       COMP-3
           VALUE -094.
       77  FLD0840B                       PIC  9(04)       COMP-6
           VALUE  1059.

       77  FLD0841A                       PIC  9(08)V9(18) COMP-3
           VALUE  70179428.042996372383299785.
       77  FLD0841B                       PIC  9(06)V9(24) COMP-3
           VALUE  813553.693586876014443021176703.

       77  FLD0842A                       PIC  9(09)V9(16) COMP-3
           VALUE  661649948.5739699704112126.
       77  FLD0842B                       PIC  9(02)V9(33) COMP-6
           VALUE  94.543261545044898763734408930758945.

       77  FLD0843A                       PIC  9(06)V9(25) COMP-6
           VALUE  818928.0761087860405211813485948.
       77  FLD0843B                       PIC S9(08)V9(03) COMP-3
           VALUE +30347988.647.

       77  FLD0844A                       PIC  9(07)V9(22) COMP-6
           VALUE  7754458.9142564990247308287507.
       77  FLD0844B                       PIC  9(10)V9(07) COMP-6
           VALUE  4487113046.2525055.

       77  FLD0845A                       PIC  9(10)V9(12) COMP-3
           VALUE  5903835745.060688200425.
       77  FLD0845B                       PIC  9(09)V9(15) COMP-3
           VALUE  651184321.418812994686220.

       77  FLD0846A                       PIC  9(08)V9(03) COMP-6
           VALUE  29802576.878.
       77  FLD0846B                       PIC  9(10)V9(07) COMP-6
           VALUE  4580030325.9646085.

       77  FLD0847A                       PIC  9(05)V9(26) COMP-3
           VALUE  84041.42690564196938041163775778.
       77  FLD0847B                       PIC  9(08)V9(03) COMP-6
           VALUE  29618694.346.

       77  FLD0848A                       PIC  9(07)V9(23) COMP-3
           VALUE  7949747.62786875510656159349309.
       77  FLD0848B                       PIC  9(08)V9(19) COMP-3
           VALUE  71130247.7845018432667245633.

       77  FLD0849A                       PIC  9(09)V9(13) COMP-6
           VALUE  595598045.8961575019216.
       77  FLD0849B                       PIC  9(07)V9(21) COMP-3
           VALUE  7527838.155592773139446194363.

       77  FLD0850A                       PIC  9(09)V9(06) COMP-6
           VALUE  418716850.605351.
       77  FLD0850B                       PIC  9(09)V9(15) COMP-3
           VALUE  631787055.454641532925563.

       77  FLD0851A                       PIC S9(03)       COMP-3
           VALUE -082.
       77  FLD0851B                       PIC  9(07)V9(01) COMP-6
           VALUE  2252059.3.

       77  FLD0852A                       PIC  9(10)V9(11) COMP-3
           VALUE  5643399909.75319838462.
       77  FLD0852B                       PIC  9(08)V9(02) COMP-6
           VALUE  28682579.88.

       77  FLD0853A                       PIC  9(06)V9(24) COMP-3
           VALUE  801200.590406665469345171004533.
       77  FLD0853B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0854A                       PIC  9(01)V9(35) COMP-3
           VALUE  9.72377885073923198255840816273121163.
       77  FLD0854B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0855A                       PIC  9(08)V9(19) COMP-6
           VALUE  73562901.0042854747375429269.
       77  FLD0855B                       PIC  9(05)V9(01) COMP-6
           VALUE  16705.4.

       77  FLD0856A                       PIC  9(09)V9(04) COMP-6
           VALUE  356144099.6704.
       77  FLD0856B                       PIC S9(05)       COMP-3
           VALUE +13257.

       77  FLD0857A                       PIC  9(03)V9(31) COMP-6
           VALUE  915.3286634102202334872799838194623.
       77  FLD0857B                       PIC S9(02)       COMP-3
           VALUE -05.

       77  FLD0858A                       PIC  9(10)V9(11) COMP-6
           VALUE  5560594458.08950059131.
       77  FLD0858B                       PIC  9(08)V9(03) COMP-6
           VALUE  30966624.473.

       77  FLD0859A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0859B                       PIC  9(02)V9(34) COMP-3
           VALUE  97.1628168143447767945986015547532588.

       77  FLD0860A                       PIC  9(07)V9(02) COMP-6
           VALUE  2576407.94.
       77  FLD0860B                       PIC  9(08)V9(04) COMP-6
           VALUE  33654706.3315.

       77  FLD0861A                       PIC S9(10)V9(07) COMP-3
           VALUE -4605509961.3842453.
       77  FLD0861B                       PIC  9(04)       COMP-6
           VALUE  1091.

       77  FLD0862A                       PIC  9(07)V9(22) COMP-6
           VALUE  7652464.2157409383802502134130.
       77  FLD0862B                       PIC  9(09)V9(12) COMP-6
           VALUE  576630833.581719182134.

       77  FLD0863A                       PIC  9(05)V9(27) COMP-3
           VALUE  85070.091557533766835064170663827.
       77  FLD0863B                       PIC  9(10)V9(09) COMP-6
           VALUE  5171260723.603198217.

       77  FLD0864A                       PIC  9(10)V9(11) COMP-3
           VALUE  5711242885.34377577697.
       77  FLD0864B                       PIC  9(04)V9(29) COMP-6
           VALUE  8791.30787212824560405977081245509.

       77  FLD0865A                       PIC  9(06)V9(24) COMP-6
           VALUE  807409.725415061507725056344497.
       77  FLD0865B                       PIC S9(03)       COMP-3
           VALUE -082.

       77  FLD0866A                       PIC  9(09)V9(05) COMP-6
           VALUE  376060050.51851.
       77  FLD0866B                       PIC  9(04)V9(30) COMP-6
           VALUE  9076.867019798932068042063292523380.

       77  FLD0867A                       PIC S9(05)       COMP-3
           VALUE +14084.
       77  FLD0867B                       PIC  9(08)V9(19) COMP-6
           VALUE  72879777.6966572774526298417.

       77  FLD0868A                       PIC  9(07)V9(22) COMP-3
           VALUE  7648419.8420910554094831468319.
       77  FLD0868B                       PIC  9(10)V9(12) COMP-3
           VALUE  5849128371.667725589944.

       77  FLD0869A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0869B                       PIC  9(08)V9(17) COMP-3
           VALUE  68157822.06919422936408636.

       77  FLD0870A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0870B                       PIC  9(09)V9(15) COMP-6
           VALUE  657570531.523696821807334.

       77  FLD0871A                       PIC  9(09)V9(14) COMP-6
           VALUE  609764683.38536315982878.
       77  FLD0871B                       PIC  9(10)V9(09) COMP-3
           VALUE  5134836781.377033476.

       77  FLD0872A                       PIC  9(04)V9(29) COMP-3
           VALUE  8816.31176263962479389135751262074.
       77  FLD0872B                       PIC  9(10)V9(07) COMP-6
           VALUE  4591409950.7884903.

       77  FLD0873A                       PIC  9(07)V9(21) COMP-6
           VALUE  7561255.223942077163812314211.
       77  FLD0873B                       PIC  9(05)       COMP-6
           VALUE  15597.

       77  FLD0874A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0874B                       PIC  9(06)V9(01) COMP-6
           VALUE  188106.3.

       77  FLD0875A                       PIC S9(06)V9(01) COMP-3
           VALUE +204126.0.
       77  FLD0875B                       PIC  9(02)       COMP-6
           VALUE  06.

       77  FLD0876A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0876B                       PIC  9(07)V9(23) COMP-3
           VALUE  7928238.87607293276147402139031.

       77  FLD0877A                       PIC  9(08)V9(18) COMP-6
           VALUE  69924605.886404200827399790.
       77  FLD0877B                       PIC  9(09)V9(15) COMP-3
           VALUE  651975862.412979334514773.

       77  FLD0878A                       PIC  9(07)V9(22) COMP-3
           VALUE  7831260.9220719830993573395971.
       77  FLD0878B                       PIC  9(04)V9(29) COMP-3
           VALUE  8832.64528360225620318146866338793.

       77  FLD0879A                       PIC  9(07)V9(02) COMP-6
           VALUE  2371533.81.
       77  FLD0879B                       PIC  9(05)V9(27) COMP-3
           VALUE  85230.962794591269560129376259283.

       77  FLD0880A                       PIC S9(10)V9(06) COMP-3
           VALUE +4237732309.742536.
       77  FLD0880B                       PIC  9(05)V9(26) COMP-6
           VALUE  83915.37539577657023315282458497.

       77  FLD0881A                       PIC  9(10)V9(11) COMP-6
           VALUE  5571129514.90407404264.
       77  FLD0881B                       PIC S9(09)V9(04) COMP-3
           VALUE -360610120.1846.

       77  FLD0882A                       PIC  9(10)V9(12) COMP-6
           VALUE  5888713345.878072713546.
       77  FLD0882B                       PIC  9(09)V9(16) COMP-6
           VALUE  677832951.8186110291821933.

       77  FLD0883A                       PIC  9(09)V9(16) COMP-3
           VALUE  672192258.1526228457349247.
       77  FLD0883B                       PIC  9(07)V9(21) COMP-6
           VALUE  7561874.624389478549701948395.

       77  FLD0884A                       PIC  9(10)V9(08) COMP-6
           VALUE  4954020911.85092596.
       77  FLD0884B                       PIC  9(07)V9(21) COMP-3
           VALUE  7530519.818486510752464369033.

       77  FLD0885A                       PIC S9(05)       COMP-3
           VALUE +13360.
       77  FLD0885B                       PIC S9(05)       COMP-3
           VALUE -15432.

       77  FLD0886A                       PIC S9(09)V9(05) COMP-3
           VALUE -374529584.88504.
       77  FLD0886B                       PIC S9(09)V9(05) COMP-3
           VALUE -380480275.58811.

       77  FLD0887A                       PIC S9(07)V9(01) COMP-3
           VALUE +2114795.5.
       77  FLD0887B                       PIC  9(06)V9(25) COMP-6
           VALUE  815821.3018675709582439026235078.

       77  FLD0888A                       PIC  9(08)V9(19) COMP-6
           VALUE  73580519.1914812417586233550.
       77  FLD0888B                       PIC  9(07)V9(02) COMP-6
           VALUE  2394446.18.

       77  FLD0889A                       PIC S9(05)       COMP-3
           VALUE -15225.
       77  FLD0889B                       PIC  9(02)V9(34) COMP-3
           VALUE  96.3719675610497206186266794247785583.

       77  FLD0890A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0890B                       PIC  9(08)V9(19) COMP-3
           VALUE  72161358.3480198661490589984.

       77  FLD0891A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.7956124985634538404610793804749846.
       77  FLD0891B                       PIC  9(08)V9(19) COMP-6
           VALUE  73526985.6204998628612656830.

       77  FLD0892A                       PIC  9(10)V9(09) COMP-6
           VALUE  5079027644.377075434.
       77  FLD0892B                       PIC  9(03)       COMP-6
           VALUE  088.

       77  FLD0893A                       PIC  9(10)V9(12) COMP-3
           VALUE  5900775083.003402254888.
       77  FLD0893B                       PIC  9(02)       COMP-6
           VALUE  07.

       77  FLD0894A                       PIC  9(06)V9(25) COMP-6
           VALUE  819872.1409522375935807758651208.
       77  FLD0894B                       PIC  9(09)V9(15) COMP-6
           VALUE  655129000.141700390535959.

       77  FLD0895A                       PIC  9(10)V9(09) COMP-6
           VALUE  5099949658.575000377.
       77  FLD0895B                       PIC  9(08)V9(02) COMP-6
           VALUE  28944204.51.

       77  FLD0896A                       PIC  9(10)V9(07) COMP-6
           VALUE  4576511370.6787369.
       77  FLD0896B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0897A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.997543976245016894566219889384228736.
       77  FLD0897B                       PIC S9(09)V9(07) COMP-3
           VALUE +440492210.0858147.

       77  FLD0898A                       PIC  9(09)V9(05) COMP-6
           VALUE  378033726.09171.
       77  FLD0898B                       PIC  9(06)V9(01) COMP-6
           VALUE  199374.1.

       77  FLD0899A                       PIC  9(08)V9(20) COMP-6
           VALUE  74918436.40783237834313013081.
       77  FLD0899B                       PIC  9(09)V9(07) COMP-6
           VALUE  438142184.6749312.

       77  FLD0900A                       PIC  9(03)V9(32) COMP-6
           VALUE  929.41329164379282712360463847289793.
       77  FLD0900B                       PIC  9(06)V9(01) COMP-6
           VALUE  185639.8.

       77  FLD0901A                       PIC  9(10)V9(07) COMP-6
           VALUE  4563598931.5070740.
       77  FLD0901B                       PIC  9(01)V9(36) COMP-6
           VALUE  9.782322298369796609307513790554367005.

       77  FLD0902A                       PIC  9(05)V9(28) COMP-3
           VALUE  87405.6741908566081633580324705690.
       77  FLD0902B                       PIC  9(10)V9(09) COMP-3
           VALUE  5131137190.755751253.

       77  FLD0903A                       PIC  9(08)V9(02) COMP-6
           VALUE  28616952.10.
       77  FLD0903B                       PIC S9(02)       COMP-3
           VALUE -06.

       77  FLD0904A                       PIC S9(04)       COMP-3
           VALUE +1137.
       77  FLD0904B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0905A                       PIC  9(09)V9(04) COMP-6
           VALUE  357938124.4724.
       77  FLD0905B                       PIC  9(09)V9(04) COMP-6
           VALUE  349599231.9688.

       77  FLD0906A                       PIC  9(09)V9(16) COMP-6
           VALUE  669388906.6218295935684068.
       77  FLD0906B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0907A                       PIC S9(09)V9(05) COMP-3
           VALUE -390800584.69506.
       77  FLD0907B                       PIC  9(10)V9(11) COMP-6
           VALUE  5692874702.16027324809.

       77  FLD0908A                       PIC S9(10)V9(06) COMP-3
           VALUE +4306350776.286586.
       77  FLD0908B                       PIC  9(03)V9(31) COMP-3
           VALUE  912.0472776451683527554337160836439.

       77  FLD0909A                       PIC  9(08)V9(03) COMP-6
           VALUE  30663800.453.
       77  FLD0909B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0910A                       PIC S9(06)V9(01) COMP-3
           VALUE -193158.9.
       77  FLD0910B                       PIC  9(04)V9(30) COMP-6
           VALUE  9098.433765600096867487422969134058.

       77  FLD0911A                       PIC S9(10)V9(07) COMP-3
           VALUE -4611964452.0728980.
       77  FLD0911B                       PIC  9(08)V9(20) COMP-3
           VALUE  74305071.04102702653491974160.

       77  FLD0912A                       PIC  9(10)V9(09) COMP-3
           VALUE  5000191930.396378214.
       77  FLD0912B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0913A                       PIC S9(04)       COMP-3
           VALUE +1246.
       77  FLD0913B                       PIC  9(03)       COMP-6
           VALUE  079.

       77  FLD0914A                       PIC  9(03)V9(31) COMP-6
           VALUE  917.2012666333545505281676923914346.
       77  FLD0914B                       PIC  9(01)V9(36) COMP-3
           VALUE  9.801144784183424274459639491396956145.

       77  FLD0915A                       PIC  9(08)V9(20) COMP-6
           VALUE  74750906.49492384109464637731.
       77  FLD0915B                       PIC S9(04)       COMP-3
           VALUE +1130.

       77  FLD0916A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0916B                       PIC  9(10)V9(06) COMP-6
           VALUE  4372777685.598984.

       77  FLD0917A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0917B                       PIC  9(04)       COMP-6
           VALUE  1084.

       77  FLD0918A                       PIC  9(04)       COMP-6
           VALUE  1059.
       77  FLD0918B                       PIC  9(10)V9(11) COMP-6
           VALUE  5693106161.94893204244.

       77  FLD0919A                       PIC S9(02)       COMP-3
           VALUE -06.
       77  FLD0919B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0920A                       PIC S9(05)V9(01) COMP-3
           VALUE -17474.9.
       77  FLD0920B                       PIC  9(09)V9(16) COMP-6
           VALUE  669843285.3658151664433262.

       77  FLD0921A                       PIC  9(10)V9(10) COMP-6
           VALUE  5463494999.0456427304.
       77  FLD0921B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0922A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0922B                       PIC S9(05)V9(01) COMP-3
           VALUE -18331.8.

       77  FLD0923A                       PIC  9(06)       COMP-6
           VALUE  159582.
       77  FLD0923B                       PIC S9(04)       COMP-3
           VALUE +1310.

       77  FLD0924A                       PIC  9(10)V9(11) COMP-6
           VALUE  5650505738.70210182114.
       77  FLD0924B                       PIC  9(06)V9(25) COMP-3
           VALUE  830413.4742864166529585645548650.

       77  FLD0925A                       PIC S9(04)       COMP-3
           VALUE +1236.
       77  FLD0925B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0926A                       PIC  9(08)V9(18) COMP-6
           VALUE  69535643.175280814620720093.
       77  FLD0926B                       PIC S9(07)V9(02) COMP-3
           VALUE -2533128.95.

       77  FLD0927A                       PIC  9(06)V9(24) COMP-3
           VALUE  800954.558131814597921049880824.
       77  FLD0927B                       PIC  9(10)V9(09) COMP-3
           VALUE  5121064754.192180545.

       77  FLD0928A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0928B                       PIC  9(07)V9(02) COMP-6
           VALUE  2551694.92.

       77  FLD0929A                       PIC  9(05)V9(28) COMP-3
           VALUE  87174.0739403786824013309342262800.
       77  FLD0929B                       PIC  9(08)V9(19) COMP-3
           VALUE  71306594.2354483839338286088.

       77  FLD0930A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.911281003002671008417223674769047647.
       77  FLD0930B                       PIC  9(09)V9(13) COMP-3
           VALUE  591594874.8305130955316.

       77  FLD0931A                       PIC  9(09)V9(12) COMP-3
           VALUE  573747057.720371378408.
       77  FLD0931B                       PIC S9(07)V9(02) COMP-3
           VALUE -2503283.13.

       77  FLD0932A                       PIC  9(10)V9(09) COMP-6
           VALUE  5079506475.355934913.
       77  FLD0932B                       PIC  9(10)V9(09) COMP-6
           VALUE  5196217943.575858200.

       77  FLD0933A                       PIC  9(07)V9(22) COMP-6
           VALUE  7776883.1704294028028812135744.
       77  FLD0933B                       PIC  9(09)V9(03) COMP-6
           VALUE  328435728.864.

       77  FLD0934A                       PIC  9(05)V9(01) COMP-6
           VALUE  16899.6.
       77  FLD0934B                       PIC  9(07)V9(02) COMP-6
           VALUE  2394400.51.

       77  FLD0935A                       PIC  9(05)V9(01) COMP-6
           VALUE  16691.2.
       77  FLD0935B                       PIC  9(10)V9(08) COMP-6
           VALUE  4853829665.64275264.

       77  FLD0936A                       PIC  9(08)V9(03) COMP-6
           VALUE  29560937.131.
       77  FLD0936B                       PIC  9(02)V9(34) COMP-3
           VALUE  95.2998853185021421730027668672846630.

       77  FLD0937A                       PIC  9(02)V9(33) COMP-3
           VALUE  94.462893191714936147462822191300801.
       77  FLD0937B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0938A                       PIC  9(09)V9(12) COMP-6
           VALUE  578242437.999430092254.
       77  FLD0938B                       PIC  9(08)V9(18) COMP-6
           VALUE  70721875.972746128802270959.

       77  FLD0939A                       PIC  9(10)V9(13) COMP-6
           VALUE  6084884727.3780637401330.
       77  FLD0939B                       PIC S9(01)       COMP-3
           VALUE -0.

       77  FLD0940A                       PIC  9(09)V9(12) COMP-6
           VALUE  577997061.609985873786.
       77  FLD0940B                       PIC  9(10)V9(08) COMP-6
           VALUE  4780052522.48498546.

       77  FLD0941A                       PIC  9(09)V9(16) COMP-3
           VALUE  670449367.9367865555107641.
       77  FLD0941B                       PIC  9(09)V9(04) COMP-6
           VALUE  345028332.3540.

       77  FLD0942A                       PIC  9(10)V9(10) COMP-3
           VALUE  5309347867.8071082121.
       77  FLD0942B                       PIC  9(03)V9(32) COMP-3
           VALUE  922.70492697630424050458941565011627.

       77  FLD0943A                       PIC S9(09)V9(03) COMP-3
           VALUE +323766798.919.
       77  FLD0943B                       PIC S9(06)V9(01) COMP-3
           VALUE +203018.6.

       77  FLD0944A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.7363239628727824559462078468641266.
       77  FLD0944B                       PIC S9(07)V9(02) COMP-3
           VALUE -2600465.21.

       77  FLD0945A                       PIC  9(10)V9(10) COMP-3
           VALUE  5427766423.1255295934.
       77  FLD0945B                       PIC S9(10)V9(06) COMP-3
           VALUE +4211785767.712989.

       77  FLD0946A                       PIC S9(07)V9(02) COMP-3
           VALUE -2603132.30.
       77  FLD0946B                       PIC  9(02)V9(34) COMP-3
           VALUE  96.2407519811451561686510558502050116.

       77  FLD0947A                       PIC  9(05)V9(27) COMP-6
           VALUE  85846.989065825540787812997223227.
       77  FLD0947B                       PIC  9(09)V9(16) COMP-3
           VALUE  671942080.3697424560141371.

       77  FLD0948A                       PIC  9(04)       COMP-6
           VALUE  1058.
       77  FLD0948B                       PIC  9(07)V9(21) COMP-6
           VALUE  7582594.805549627281493485497.

       77  FLD0949A                       PIC S9(10)V9(06) COMP-3
           VALUE +4307044196.647341.
       77  FLD0949B                       PIC  9(10)V9(07) COMP-6
           VALUE  4670230467.6696332.

       77  FLD0950A                       PIC  9(09)V9(14) COMP-3
           VALUE  614898523.03850200954116.
       77  FLD0950B                       PIC  9(04)V9(30) COMP-6
           VALUE  9056.465512238127679722765606129541.

       77  FLD0951A                       PIC S9(08)V9(03) COMP-3
           VALUE +31116955.475.
       77  FLD0951B                       PIC  9(08)V9(20) COMP-6
           VALUE  74599134.92992847894313968026.

       77  FLD0952A                       PIC  9(09)V9(03) COMP-6
           VALUE  315844571.317.
       77  FLD0952B                       PIC  9(02)       COMP-6
           VALUE  06.

       77  FLD0953A                       PIC  9(06)       COMP-6
           VALUE  166635.
       77  FLD0953B                       PIC  9(10)V9(09) COMP-6
           VALUE  5187782319.462912461.

       77  FLD0954A                       PIC  9(10)V9(11) COMP-6
           VALUE  5577123049.60128579800.
       77  FLD0954B                       PIC  9(02)V9(34) COMP-3
           VALUE  97.0603521071659591790137255884474143.

       77  FLD0955A                       PIC S9(08)V9(02) COMP-3
           VALUE -27357789.23.
       77  FLD0955B                       PIC  9(06)V9(25) COMP-3
           VALUE  823687.4590304759102821208216482.

       77  FLD0956A                       PIC S9(08)V9(02) COMP-3
           VALUE -27355040.84.
       77  FLD0956B                       PIC  9(08)V9(18) COMP-3
           VALUE  70029518.862281070479269828.

       77  FLD0957A                       PIC  9(09)V9(15) COMP-6
           VALUE  637627083.330792543414133.
       77  FLD0957B                       PIC S9(04)       COMP-3
           VALUE +1212.

       77  FLD0958A                       PIC S9(08)V9(03) COMP-3
           VALUE -29370744.150.
       77  FLD0958B                       PIC  9(10)V9(06) COMP-6
           VALUE  4358178846.720288.

       77  FLD0959A                       PIC  9(06)V9(25) COMP-6
           VALUE  827211.6833605048791255853757320.
       77  FLD0959B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0960A                       PIC  9(10)V9(11) COMP-6
           VALUE  5559976801.18206716315.
       77  FLD0960B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0961A                       PIC  9(08)V9(19) COMP-6
           VALUE  72708740.7191407630868695832.
       77  FLD0961B                       PIC S9(04)       COMP-3
           VALUE +1315.

       77  FLD0962A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.8081984946274620718043024680810049.
       77  FLD0962B                       PIC  9(08)V9(17) COMP-3
           VALUE  68265700.44059103725686554.

       77  FLD0963A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.803573230667260718362854277074802666.
       77  FLD0963B                       PIC  9(09)V9(16) COMP-6
           VALUE  657950850.8072698935720268.

       77  FLD0964A                       PIC  9(09)V9(15) COMP-6
           VALUE  639504907.969730918004813.
       77  FLD0964B                       PIC  9(09)V9(13) COMP-6
           VALUE  599568613.7680703575725.

       77  FLD0965A                       PIC  9(05)       COMP-6
           VALUE  13581.
       77  FLD0965B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0966A                       PIC  9(06)V9(01) COMP-6
           VALUE  189200.6.
       77  FLD0966B                       PIC  9(06)V9(01) COMP-6
           VALUE  189757.7.

       77  FLD0967A                       PIC  9(02)       COMP-6
           VALUE  06.
       77  FLD0967B                       PIC  9(09)V9(04) COMP-6
           VALUE  356045641.3147.

       77  FLD0968A                       PIC  9(09)V9(15) COMP-6
           VALUE  649996663.320669743058033.
       77  FLD0968B                       PIC S9(04)       COMP-3
           VALUE +1132.

       77  FLD0969A                       PIC S9(05)       COMP-3
           VALUE -15366.
       77  FLD0969B                       PIC  9(09)V9(13) COMP-3
           VALUE  594539058.0989867723715.

       77  FLD0970A                       PIC  9(09)V9(14) COMP-3
           VALUE  631417540.20798013247173.
       77  FLD0970B                       PIC  9(02)V9(34) COMP-6
           VALUE  96.8862081091470539462306987843476235.

       77  FLD0971A                       PIC  9(07)V9(01) COMP-6
           VALUE  2161446.9.
       77  FLD0971B                       PIC S9(09)V9(06) COMP-3
           VALUE +400705169.115322.

       77  FLD0972A                       PIC  9(09)V9(15) COMP-6
           VALUE  647710182.878484586055378.
       77  FLD0972B                       PIC  9(05)       COMP-6
           VALUE  13649.

       77  FLD0973A                       PIC  9(05)       COMP-6
           VALUE  13817.
       77  FLD0973B                       PIC  9(06)V9(25) COMP-6
           VALUE  828260.5282429751358819203232997.

       77  FLD0974A                       PIC  9(04)       COMP-6
           VALUE  1180.
       77  FLD0974B                       PIC S9(03)       COMP-3
           VALUE +104.

       77  FLD0975A                       PIC S9(02)       COMP-3
           VALUE -06.
       77  FLD0975B                       PIC  9(09)V9(03) COMP-6
           VALUE  329183580.054.

       77  FLD0976A                       PIC S9(07)V9(01) COMP-3
           VALUE +2206144.7.
       77  FLD0976B                       PIC  9(10)V9(09) COMP-6
           VALUE  5191401776.232426046.

       77  FLD0977A                       PIC  9(09)V9(03) COMP-6
           VALUE  327431372.704.
       77  FLD0977B                       PIC S9(09)V9(05) COMP-3
           VALUE -393208707.80387.

       77  FLD0978A                       PIC  9(09)V9(16) COMP-6
           VALUE  675062190.8116747338368668.
       77  FLD0978B                       PIC S9(09)V9(06) COMP-3
           VALUE +411411057.685845.

       77  FLD0979A                       PIC  9(03)V9(32) COMP-6
           VALUE  925.33169671466619643496187563869170.
       77  FLD0979B                       PIC  9(09)V9(05) COMP-6
           VALUE  388509802.38797.

       77  FLD0980A                       PIC  9(03)V9(32) COMP-6
           VALUE  935.82234581280043794748735308530740.
       77  FLD0980B                       PIC  9(09)V9(15) COMP-6
           VALUE  647159992.565670250108667.

       77  FLD0981A                       PIC  9(06)V9(01) COMP-6
           VALUE  195132.7.
       77  FLD0981B                       PIC S9(09)V9(04) COMP-3
           VALUE -360473610.9762.

       77  FLD0982A                       PIC  9(06)V9(25) COMP-6
           VALUE  816610.1728260642955703474399342.
       77  FLD0982B                       PIC S9(08)V9(03) COMP-3
           VALUE +31469845.616.

       77  FLD0983A                       PIC  9(10)V9(09) COMP-3
           VALUE  5114754992.436914005.
       77  FLD0983B                       PIC  9(02)V9(34) COMP-6
           VALUE  95.8147071945383510538363225350622087.

       77  FLD0984A                       PIC  9(09)V9(15) COMP-3
           VALUE  632949921.330981046807551.
       77  FLD0984B                       PIC  9(10)V9(09) COMP-6
           VALUE  5090793805.153389639.

       77  FLD0985A                       PIC  9(10)V9(06) COMP-6
           VALUE  4296662473.303992.
       77  FLD0985B                       PIC  9(05)V9(28) COMP-3
           VALUE  87137.5808353749947698929645412135.

       77  FLD0986A                       PIC  9(05)       COMP-6
           VALUE  14588.
       77  FLD0986B                       PIC  9(01)       COMP-6
           VALUE  0.

       77  FLD0987A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.834402345123109956404050535638816654.
       77  FLD0987B                       PIC  9(06)V9(26) COMP-3
           VALUE  842525.10302045313661523096016026.

       77  FLD0988A                       PIC  9(01)       COMP-6
           VALUE  0.
       77  FLD0988B                       PIC S9(05)V9(01) COMP-3
           VALUE -18152.0.

       77  FLD0989A                       PIC S9(04)       COMP-3
           VALUE +1235.
       77  FLD0989B                       PIC  9(09)V9(13) COMP-3
           VALUE  593212782.9792923634499.

       77  FLD0990A                       PIC  9(07)V9(22) COMP-3
           VALUE  7806084.0781040319313888176111.
       77  FLD0990B                       PIC  9(06)V9(01) COMP-6
           VALUE  208986.1.

       77  FLD0991A                       PIC  9(06)V9(24) COMP-6
           VALUE  807774.663029880435338725419569.
       77  FLD0991B                       PIC S9(09)V9(06) COMP-3
           VALUE +403465254.324070.

       77  FLD0992A                       PIC  9(07)V9(22) COMP-6
           VALUE  7784108.2583169551867285917978.
       77  FLD0992B                       PIC  9(04)V9(29) COMP-3
           VALUE  8920.19846678347883006665597349638.

       77  FLD0993A                       PIC  9(08)V9(20) COMP-6
           VALUE  74534466.64416291111976420324.
       77  FLD0993B                       PIC S9(04)       COMP-3
           VALUE +1132.

       77  FLD0994A                       PIC  9(06)V9(24) COMP-6
           VALUE  815107.307501011568717785849003.
       77  FLD0994B                       PIC S9(10)V9(08) COMP-3
           VALUE -4847118976.22432053.

       77  FLD0995A                       PIC S9(01)       COMP-3
           VALUE +0.
       77  FLD0995B                       PIC  9(06)V9(01) COMP-6
           VALUE  188825.8.

       77  FLD0996A                       PIC  9(09)V9(14) COMP-6
           VALUE  619241405.61761309431432.
       77  FLD0996B                       PIC  9(09)V9(16) COMP-6
           VALUE  669751940.2443259384227758.

       77  FLD0997A                       PIC  9(10)V9(09) COMP-3
           VALUE  5006446394.611311356.
       77  FLD0997B                       PIC  9(10)V9(09) COMP-3
           VALUE  5005353152.147143935.

       77  FLD0998A                       PIC  9(09)V9(13) COMP-6
           VALUE  598229443.4201559374386.
       77  FLD0998B                       PIC S9(01)       COMP-3
           VALUE +0.

       77  FLD0999A                       PIC S9(03)       COMP-3
           VALUE -081.
       77  FLD0999B                       PIC S9(01)       COMP-3
           VALUE -0.

      * RESULTS-AREA.

       78  XPC-FLD0500B
           VALUE X'0709'.
       78  XPC-FLD0501B
           VALUE X'062809334873677369337485'.
       78  XPC-FLD0502B
           VALUE X'078931626286150020034995122841'.
       78  XPC-FLD0503B
           VALUE X'241748150924885620905391882843105F'.
       78  XPC-FLD0504B
           VALUE X'5028930926587901486F'.
       78  XPC-FLD0505B
           VALUE X'054079887440916072856F'.
       78  XPC-FLD0506B
           VALUE X'044983811D'.
       78  XPC-FLD0507B
           VALUE X'5276166649082409210F'.
       78  XPC-FLD0508B
           VALUE X'02144088220848886D'.
       78  XPC-FLD0509B
           VALUE X'488937338626299289'.
       78  XPC-FLD0510B
           VALUE X'387D'.
       78  XPC-FLD0511B
           VALUE X'05257737010265951195'.
       78  XPC-FLD0512B
           VALUE X'5091717968686512163500879069033544511F'.
       78  XPC-FLD0513B
           VALUE X'02789791972144304299518972222F'.
       78  XPC-FLD0514B
           VALUE X'02787819996823'.
       78  XPC-FLD0515B
           VALUE X'37690011845231452527479784448514692F'.
       78  XPC-FLD0516B
           VALUE X'00'.
       78  XPC-FLD0517B
           VALUE X'0031340134042710696D'.
       78  XPC-FLD0518B
           VALUE X'089D'.
       78  XPC-FLD0519B
           VALUE X'9851020486430545064493287F'.
       78  XPC-FLD0520B
           VALUE X'61059553432451049552742F'.
       78  XPC-FLD0521B
           VALUE X'28055C'.
       78  XPC-FLD0522B
           VALUE X'3510676144076D'.
       78  XPC-FLD0523B
           VALUE X'04280314707C'.
       78  XPC-FLD0524B
           VALUE X'5046008862205329081F'.
       78  XPC-FLD0525B
           VALUE X'0887336156634660588871099662355845'.
       78  XPC-FLD0526B
           VALUE X'0535158707'.
       78  XPC-FLD0527B
           VALUE X'0993866582275886311F'.
       78  XPC-FLD0528B
           VALUE X'06742D'.
       78  XPC-FLD0529B
           VALUE X'06852906977087937C'.
       78  XPC-FLD0530B
           VALUE X'043D'.
       78  XPC-FLD0531B
           VALUE X'098098220C'.
       78  XPC-FLD0532B
           VALUE X'6D'.
       78  XPC-FLD0533B
           VALUE X'0086'.
       78  XPC-FLD0534B
           VALUE X'4796286047627412578F'.
       78  XPC-FLD0535B
           VALUE X'086934843746367858133650045201648F'.
       78  XPC-FLD0536B
           VALUE X'0C'.
       78  XPC-FLD0537B
           VALUE X'4554'.
       78  XPC-FLD0538B
           VALUE X'0793946754459935233327882997400592'.
       78  XPC-FLD0539B
           VALUE X'070042059898033071085876599681795F'.
       78  XPC-FLD0540B
           VALUE X'07'.
       78  XPC-FLD0541B
           VALUE X'049167641848286621388982121061'.
       78  XPC-FLD0542B
           VALUE X'553207696393934218127F'.
       78  XPC-FLD0543B
           VALUE X'0277016069'.
       78  XPC-FLD0544B
           VALUE X'1381302823'.
       78  XPC-FLD0545B
           VALUE X'944856446145206807507570674F'.
       78  XPC-FLD0546B
           VALUE X'60995883518421766866790F'.
       78  XPC-FLD0547B
           VALUE X'3598695862060D'.
       78  XPC-FLD0548B
           VALUE X'68119457212008152846571817'.
       78  XPC-FLD0549B
           VALUE X'0417916211751954'.
       78  XPC-FLD0550B
           VALUE X'94'.
       78  XPC-FLD0551B
           VALUE X'0655119044597454263904505F'.
       78  XPC-FLD0552B
           VALUE X'076016'.
       78  XPC-FLD0553B
           VALUE X'3608710969090D'.
       78  XPC-FLD0554B
           VALUE X'28615763752268179551663251913851128F'.
       78  XPC-FLD0555B
           VALUE X'5605686733653602811F'.
       78  XPC-FLD0556B
           VALUE X'0568555321722934526833'.
       78  XPC-FLD0557B
           VALUE X'13329C'.
       78  XPC-FLD0558B
           VALUE X'06209454'.
       78  XPC-FLD0559B
           VALUE X'099142824147194545678672682843'.
       78  XPC-FLD0560B
           VALUE X'0351025116078023'.
       78  XPC-FLD0561B
           VALUE X'01'.
       78  XPC-FLD0562B
           VALUE X'958208334412512741096179524902254343'.
       78  XPC-FLD0563B
           VALUE X'72227339713C'.
       78  XPC-FLD0564B
           VALUE X'070810880902875461543491615817183629'.
       78  XPC-FLD0565B
           VALUE X'02090887'.
       78  XPC-FLD0566B
           VALUE X'134200212625'.
       78  XPC-FLD0567B
           VALUE X'0297763648403360945430051742732758'.
       78  XPC-FLD0568B
           VALUE X'064501399773583058336459'.
       78  XPC-FLD0569B
           VALUE X'722108073354756C'.
       78  XPC-FLD0570B
           VALUE X'720060225322646066764775696F'.
       78  XPC-FLD0571B
           VALUE X'06621729185931387539619251'.
       78  XPC-FLD0572B
           VALUE X'0363059D'.
       78  XPC-FLD0573B
           VALUE X'6527890148517897915245875992695800960F'.
       78  XPC-FLD0574B
           VALUE X'6D'.
       78  XPC-FLD0575B
           VALUE X'6C'.
       78  XPC-FLD0576B
           VALUE X'47238400610562072401'.
       78  XPC-FLD0577B
           VALUE X'805001512301445405164770363626303151'.
       78  XPC-FLD0578B
           VALUE X'273810'.
       78  XPC-FLD0579B
           VALUE X'5908380596787501715F'.
       78  XPC-FLD0580B
           VALUE X'0646450258967046645771858948137378321F'.
       78  XPC-FLD0581B
           VALUE X'610062973643881143036828'.
       78  XPC-FLD0582B
           VALUE X'062856274902063530202836'.
       78  XPC-FLD0583B
           VALUE X'4C'.
       78  XPC-FLD0584B
           VALUE X'955867594557756605766485336062032729'.
       78  XPC-FLD0585B
           VALUE X'079927518632915370297985191427869722'.
       78  XPC-FLD0586B
           VALUE X'077794189960829245200635284618'.
       78  XPC-FLD0587B
           VALUE X'02129D'.
       78  XPC-FLD0588B
           VALUE X'06771495276462448727205764043901582F'.
       78  XPC-FLD0589B
           VALUE X'01219C'.
       78  XPC-FLD0590B
           VALUE X'1062119D'.
       78  XPC-FLD0591B
           VALUE X'5700661418154348791F'.
       78  XPC-FLD0592B
           VALUE X'73907098193D'.
       78  XPC-FLD0593B
           VALUE X'038C'.
       78  XPC-FLD0594B
           VALUE X'51440484143103479483050932685F'.
       78  XPC-FLD0595B
           VALUE X'3197374054167890777833347730124F'.
       78  XPC-FLD0596B
           VALUE X'657855963298508210108650'.
       78  XPC-FLD0597B
           VALUE X'06758101650339857689842844592932'.
       78  XPC-FLD0598B
           VALUE X'468477633184507D'.
       78  XPC-FLD0599B
           VALUE X'09'.
       78  XPC-FLD0600B
           VALUE X'0889857673123861313355595484609F'.
       78  XPC-FLD0601B
           VALUE X'029749813111'.
       78  XPC-FLD0602B
           VALUE X'0303615939'.
       78  XPC-FLD0603B
           VALUE X'0487180C'.
       78  XPC-FLD0604B
           VALUE X'0551440145498789572320'.
       78  XPC-FLD0605B
           VALUE X'4256957897307752'.
       78  XPC-FLD0606B
           VALUE X'0254178383482C'.
       78  XPC-FLD0607B
           VALUE X'025781'.
       78  XPC-FLD0608B
           VALUE X'225226869583767068085933260590536520'.
       78  XPC-FLD0609B
           VALUE X'045126229228847267'.
       78  XPC-FLD0610B
           VALUE X'2786455271'.
       78  XPC-FLD0611B
           VALUE X'03'.
       78  XPC-FLD0612B
           VALUE X'062873368552287867108245640685'.
       78  XPC-FLD0613B
           VALUE X'022648276C'.
       78  XPC-FLD0614B
           VALUE X'6052981544136128984377'.
       78  XPC-FLD0615B
           VALUE X'023341961C'.
       78  XPC-FLD0616B
           VALUE X'23'.
       78  XPC-FLD0617B
           VALUE X'00'.
       78  XPC-FLD0618B
           VALUE X'0079'.
       78  XPC-FLD0619B
           VALUE X'053429823777539313843F'.
       78  XPC-FLD0620B
           VALUE X'583959822349086421500175'.
       78  XPC-FLD0621B
           VALUE X'734243671686218957184166811F'.
       78  XPC-FLD0622B
           VALUE X'9542421746848D'.
       78  XPC-FLD0623B
           VALUE X'0641616922896418195095066F'.
       78  XPC-FLD0624B
           VALUE X'4356505095582531'.
       78  XPC-FLD0625B
           VALUE X'78308435769811728739000500354F'.
       78  XPC-FLD0626B
           VALUE X'037427477932063D'.
       78  XPC-FLD0627B
           VALUE X'023249882C'.
       78  XPC-FLD0628B
           VALUE X'029681727730'.
       78  XPC-FLD0629B
           VALUE X'870915644969416202769707524566911F'.
       78  XPC-FLD0630B
           VALUE X'0174519095249753304734'.
       78  XPC-FLD0631B
           VALUE X'824634'.
       78  XPC-FLD0632B
           VALUE X'05012280455704922587'.
       78  XPC-FLD0633B
           VALUE X'0405176751228C'.
       78  XPC-FLD0634B
           VALUE X'0868098250115819156979655872420F'.
       78  XPC-FLD0635B
           VALUE X'0558066570900784292498'.
       78  XPC-FLD0636B
           VALUE X'010350'.
       78  XPC-FLD0637B
           VALUE X'053056785456603405837F'.
       78  XPC-FLD0638B
           VALUE X'9300997013279628244930563595546F'.
       78  XPC-FLD0639B
           VALUE X'04078092072024196699686626743641681969'.
       78  XPC-FLD0640B
           VALUE X'89710938089320346744415246575953928F'.
       78  XPC-FLD0641B
           VALUE X'0802113336084028338834883698'.
       78  XPC-FLD0642B
           VALUE X'05220924521868707701699F'.
       78  XPC-FLD0643B
           VALUE X'2890586849'.
       78  XPC-FLD0644B
           VALUE X'092997460492260109532480782945640385'.
       78  XPC-FLD0645B
           VALUE X'0246730234'.
       78  XPC-FLD0646B
           VALUE X'5883231932131506547457'.
       78  XPC-FLD0647B
           VALUE X'06598931491456289340839020'.
       78  XPC-FLD0648B
           VALUE X'0634285861942461315643470F'.
       78  XPC-FLD0649B
           VALUE X'5034432631533975376F'.
       78  XPC-FLD0650B
           VALUE X'6715745920981104473110079F'.
       78  XPC-FLD0651B
           VALUE X'032093946374946D'.
       78  XPC-FLD0652B
           VALUE X'020927047C'.
       78  XPC-FLD0653B
           VALUE X'165087'.
       78  XPC-FLD0654B
           VALUE X'1152390677'.
       78  XPC-FLD0655B
           VALUE X'05949843308386091165206F'.
       78  XPC-FLD0656B
           VALUE X'0650007677567117914204561F'.
       78  XPC-FLD0657B
           VALUE X'070469220160326710801212968F'.
       78  XPC-FLD0658B
           VALUE X'053680173247006238712F'.
       78  XPC-FLD0659B
           VALUE X'0719555666672452026677575531'.
       78  XPC-FLD0660B
           VALUE X'27872D'.
       78  XPC-FLD0661B
           VALUE X'570540945315247127744F'.
       78  XPC-FLD0662B
           VALUE X'06678282186476681732324323'.
       78  XPC-FLD0663B
           VALUE X'0468269232052811142885673234559362'.
       78  XPC-FLD0664B
           VALUE X'04405659595288489C'.
       78  XPC-FLD0665B
           VALUE X'6766161649406166886924393F'.
       78  XPC-FLD0666B
           VALUE X'11'.
       78  XPC-FLD0667B
           VALUE X'0632143970272669745917438F'.
       78  XPC-FLD0668B
           VALUE X'5144628458672427461F'.
       78  XPC-FLD0669B
           VALUE X'0395936639786081'.
       78  XPC-FLD0670B
           VALUE X'0164380926561097741789296833303524182F'.
       78  XPC-FLD0671B
           VALUE X'08090443'.
       78  XPC-FLD0672B
           VALUE X'927915894513764975604231'.
       78  XPC-FLD0673B
           VALUE X'0749211224'.
       78  XPC-FLD0674B
           VALUE X'08225787711159490474084418921848'.
       78  XPC-FLD0675B
           VALUE X'05083625274155812858'.
       78  XPC-FLD0676B
           VALUE X'0004664170342459437179627457226160913F'.
       78  XPC-FLD0677B
           VALUE X'708676445455624266891447859961772F'.
       78  XPC-FLD0678B
           VALUE X'85979366357613359468814451247453'.
       78  XPC-FLD0679B
           VALUE X'044902781556612852'.
       78  XPC-FLD0680B
           VALUE X'564571038982083600804F'.
       78  XPC-FLD0681B
           VALUE X'0654877112290583873743782681004F'.
       78  XPC-FLD0682B
           VALUE X'5608815389721361803129542749957F'.
       78  XPC-FLD0683B
           VALUE X'05829822468269903673643F'.
       78  XPC-FLD0684B
           VALUE X'6208938998759875'.
       78  XPC-FLD0685B
           VALUE X'0536985204876752143500539204978F'.
       78  XPC-FLD0686B
           VALUE X'00180741962593756744226F'.
       78  XPC-FLD0687B
           VALUE X'456697463326542715'.
       78  XPC-FLD0688B
           VALUE X'0131'.
       78  XPC-FLD0689B
           VALUE X'0933318323052C'.
       78  XPC-FLD0690B
           VALUE X'02807895954D'.
       78  XPC-FLD0691B
           VALUE X'04747985190129340C'.
       78  XPC-FLD0692B
           VALUE X'278067587806645121846764'.
       78  XPC-FLD0693B
           VALUE X'0C'.
       78  XPC-FLD0694B
           VALUE X'06'.
       78  XPC-FLD0695B
           VALUE X'285416863016785357397587'.
       78  XPC-FLD0696B
           VALUE X'318862710902'.
       78  XPC-FLD0697B
           VALUE X'05576423548738693906'.
       78  XPC-FLD0698B
           VALUE X'614D'.
       78  XPC-FLD0699B
           VALUE X'22735335379771726138637F'.
       78  XPC-FLD0700B
           VALUE X'4D'.
       78  XPC-FLD0701B
           VALUE X'0824434325033338688548667501709982529F'.
       78  XPC-FLD0702B
           VALUE X'23424179'.
       78  XPC-FLD0703B
           VALUE X'335267041235'.
       78  XPC-FLD0704B
           VALUE X'08515404888861616825987F'.
       78  XPC-FLD0705B
           VALUE X'000818147177942940'.
       78  XPC-FLD0706B
           VALUE X'0327398D'.
       78  XPC-FLD0707B
           VALUE X'5129442198407349051F'.
       78  XPC-FLD0708B
           VALUE X'338347991943'.
       78  XPC-FLD0709B
           VALUE X'37934595068404'.
       78  XPC-FLD0710B
           VALUE X'0322996288513C'.
       78  XPC-FLD0711B
           VALUE X'73'.
       78  XPC-FLD0712B
           VALUE X'0555782537921349383D'.
       78  XPC-FLD0713B
           VALUE X'71121009'.
       78  XPC-FLD0714B
           VALUE X'02465946158468'.
       78  XPC-FLD0715B
           VALUE X'58869262308134147685'.
       78  XPC-FLD0716B
           VALUE X'04094336916239737930141018296126276F'.
       78  XPC-FLD0717B
           VALUE X'7570171861371541854879296806'.
       78  XPC-FLD0718B
           VALUE X'4283258317648062'.
       78  XPC-FLD0719B
           VALUE X'0239090461'.
       78  XPC-FLD0720B
           VALUE X'404886229426392C'.
       78  XPC-FLD0721B
           VALUE X'45808243'.
       78  XPC-FLD0722B
           VALUE X'07624904820924922808538326535F'.
       78  XPC-FLD0723B
           VALUE X'56'.
       78  XPC-FLD0724B
           VALUE X'04934011851187240393'.
       78  XPC-FLD0725B
           VALUE X'04444128191361023C'.
       78  XPC-FLD0726B
           VALUE X'401820868675800C'.
       78  XPC-FLD0727B
           VALUE X'00896082861134319673904889'.
       78  XPC-FLD0728B
           VALUE X'081076915652245D'.
       78  XPC-FLD0729B
           VALUE X'795979478015814722415832704883'.
       78  XPC-FLD0730B
           VALUE X'62944830238001500322120F'.
       78  XPC-FLD0731B
           VALUE X'04086517499647340789789F'.
       78  XPC-FLD0732B
           VALUE X'00313C'.
       78  XPC-FLD0733B
           VALUE X'965641152048700750127567'.
       78  XPC-FLD0734B
           VALUE X'26'.
       78  XPC-FLD0735B
           VALUE X'0641708846027484955070190F'.
       78  XPC-FLD0736B
           VALUE X'072589764082146861645222974767'.
       78  XPC-FLD0737B
           VALUE X'522443922D'.
       78  XPC-FLD0738B
           VALUE X'512073900331931666778700673603452743'.
       78  XPC-FLD0739B
           VALUE X'0459162078493461292D'.
       78  XPC-FLD0740B
           VALUE X'072773632191726975291885537444614F'.
       78  XPC-FLD0741B
           VALUE X'0644169236711C'.
       78  XPC-FLD0742B
           VALUE X'88899021862D'.
       78  XPC-FLD0743B
           VALUE X'02956850'.
       78  XPC-FLD0744B
           VALUE X'2695622879'.
       78  XPC-FLD0745B
           VALUE X'013558'.
       78  XPC-FLD0746B
           VALUE X'0231527099755997057F'.
       78  XPC-FLD0747B
           VALUE X'4879952390867385986918298294767737'.
       78  XPC-FLD0748B
           VALUE X'0181187D'.
       78  XPC-FLD0749B
           VALUE X'2760411381430374631233670697839F'.
       78  XPC-FLD0750B
           VALUE X'262999561974'.
       78  XPC-FLD0751B
           VALUE X'15170D'.
       78  XPC-FLD0752B
           VALUE X'91538508268330654527034084821934811F'.
       78  XPC-FLD0753B
           VALUE X'9C'.
       78  XPC-FLD0754B
           VALUE X'0961172590'.
       78  XPC-FLD0755B
           VALUE X'053471365948751090643F'.
       78  XPC-FLD0756B
           VALUE X'10424D'.
       78  XPC-FLD0757B
           VALUE X'242943831C'.
       78  XPC-FLD0758B
           VALUE X'0455928D'.
       78  XPC-FLD0759B
           VALUE X'07622235272467824718001239148F'.
       78  XPC-FLD0760B
           VALUE X'09469886609778104836721013271017001F'.
       78  XPC-FLD0761B
           VALUE X'031926781976263429729812'.
       78  XPC-FLD0762B
           VALUE X'0884402939'.
       78  XPC-FLD0763B
           VALUE X'283690925904618196362605387461'.
       78  XPC-FLD0764B
           VALUE X'055560951487484800'.
       78  XPC-FLD0765B
           VALUE X'01212C'.
       78  XPC-FLD0766B
           VALUE X'22949432'.
       78  XPC-FLD0767B
           VALUE X'1D'.
       78  XPC-FLD0768B
           VALUE X'096D'.
       78  XPC-FLD0769B
           VALUE X'03586597857349'.
       78  XPC-FLD0770B
           VALUE X'054829803888151060764504'.
       78  XPC-FLD0771B
           VALUE X'075991198999121606361129010F'.
       78  XPC-FLD0772B
           VALUE X'0090893446885686'.
       78  XPC-FLD0773B
           VALUE X'76783997423560348547511011929600499F'.
       78  XPC-FLD0774B
           VALUE X'242589104C'.
       78  XPC-FLD0775B
           VALUE X'83006085498341006789723905967548489F'.
       78  XPC-FLD0776B
           VALUE X'65983936382796708763014976284467'.
       78  XPC-FLD0777B
           VALUE X'563799910901816754889F'.
       78  XPC-FLD0778B
           VALUE X'6562465464730475300569878527312539'.
       78  XPC-FLD0779B
           VALUE X'0474089855326103228D'.
       78  XPC-FLD0780B
           VALUE X'4184481254630997580198368268612F'.
       78  XPC-FLD0781B
           VALUE X'029720911669'.
       78  XPC-FLD0782B
           VALUE X'974841984908992382763415207591606305'.
       78  XPC-FLD0783B
           VALUE X'04236442572674454C'.
       78  XPC-FLD0784B
           VALUE X'1401654002801979714825902150218F'.
       78  XPC-FLD0785B
           VALUE X'393300524051'.
       78  XPC-FLD0786B
           VALUE X'085407905679605532414111479511120F'.
       78  XPC-FLD0787B
           VALUE X'00464285'.
       78  XPC-FLD0788B
           VALUE X'077898336505928358503125785716'.
       78  XPC-FLD0789B
           VALUE X'6604278565132847496040994F'.
       78  XPC-FLD0790B
           VALUE X'31694368662D'.
       78  XPC-FLD0791B
           VALUE X'7382741348868294886190710712'.
       78  XPC-FLD0792B
           VALUE X'37982443954012'.
       78  XPC-FLD0793B
           VALUE X'0559177637820166807230'.
       78  XPC-FLD0794B
           VALUE X'0D'.
       78  XPC-FLD0795B
           VALUE X'0334944006958C'.
       78  XPC-FLD0796B
           VALUE X'0653841465915909014761098205'.
       78  XPC-FLD0797B
           VALUE X'03487774860252'.
       78  XPC-FLD0798B
           VALUE X'3415780672379371043808250F'.
       78  XPC-FLD0799B
           VALUE X'024239306208646738127F'.
       78  XPC-FLD0800B
           VALUE X'4337360023'.
       78  XPC-FLD0801B
           VALUE X'9633203702397862694706986985693220049F'.
       78  XPC-FLD0802B
           VALUE X'059390909987167776897365456534317F'.
       78  XPC-FLD0803B
           VALUE X'0555623043499399698487'.
       78  XPC-FLD0804B
           VALUE X'02'.
       78  XPC-FLD0805B
           VALUE X'479868190466873291'.
       78  XPC-FLD0806B
           VALUE X'2580784568425466'.
       78  XPC-FLD0807B
           VALUE X'592C'.
       78  XPC-FLD0808B
           VALUE X'045744550475690953'.
       78  XPC-FLD0809B
           VALUE X'04404211618158996C'.
       78  XPC-FLD0810B
           VALUE X'021294550C'.
       78  XPC-FLD0811B
           VALUE X'5454913861947337423021251372119877487F'.
       78  XPC-FLD0812B
           VALUE X'5678497418'.
       78  XPC-FLD0813B
           VALUE X'29113136400D'.
       78  XPC-FLD0814B
           VALUE X'07525119595496631362479433846F'.
       78  XPC-FLD0815B
           VALUE X'0714304561558653405839436344638434439F'.
       78  XPC-FLD0816B
           VALUE X'0532563204313666438416366152096307'.
       78  XPC-FLD0817B
           VALUE X'00322267276165150162'.
       78  XPC-FLD0818B
           VALUE X'0409797454111609544843745425'.
       78  XPC-FLD0819B
           VALUE X'082D'.
       78  XPC-FLD0820B
           VALUE X'956537139953218984445015848905313760'.
       78  XPC-FLD0821B
           VALUE X'038365653639422D'.
       78  XPC-FLD0822B
           VALUE X'2945'.
       78  XPC-FLD0823B
           VALUE X'484310601769554C'.
       78  XPC-FLD0824B
           VALUE X'073189644908504480898002'.
       78  XPC-FLD0825B
           VALUE X'0170692D'.
       78  XPC-FLD0826B
           VALUE X'0480578557209735916D'.
       78  XPC-FLD0827B
           VALUE X'046910500983725490'.
       78  XPC-FLD0828B
           VALUE X'00993C'.
       78  XPC-FLD0829B
           VALUE X'944972866636283770347403930829'.
       78  XPC-FLD0830B
           VALUE X'0565534908381171491840'.
       78  XPC-FLD0831B
           VALUE X'6602934475151655210356515F'.
       78  XPC-FLD0832B
           VALUE X'0419047953539795'.
       78  XPC-FLD0833B
           VALUE X'6657954482808921498060428F'.
       78  XPC-FLD0834B
           VALUE X'780178461140043863949386833F'.
       78  XPC-FLD0835B
           VALUE X'090696211292909090229130697187'.
       78  XPC-FLD0836B
           VALUE X'01479247899592904941896F'.
       78  XPC-FLD0837B
           VALUE X'29146758519D'.
       78  XPC-FLD0838B
           VALUE X'54394205787057270376334726969F'.
       78  XPC-FLD0839B
           VALUE X'05300514'.
       78  XPC-FLD0840B
           VALUE X'1153'.
       78  XPC-FLD0841B
           VALUE X'0992981736583248397742806176703F'.
       78  XPC-FLD0842B
           VALUE X'054030708425366313836265591069241055'.
       78  XPC-FLD0843B
           VALUE X'31166916723C'.
       78  XPC-FLD0844B
           VALUE X'044793585873382490'.
       78  XPC-FLD0845B
           VALUE X'0555020066479501195111220F'.
       78  XPC-FLD0846B
           VALUE X'045502277490866085'.
       78  XPC-FLD0847B
           VALUE X'029702735772'.
       78  XPC-FLD0848B
           VALUE X'631805001566330881601629698F'.
       78  XPC-FLD0849B
           VALUE X'03125884051750275061046194363F'.
       78  XPC-FLD0850B
           VALUE X'0213070204849290532925563F'.
       78  XPC-FLD0851B
           VALUE X'22519773'.
       78  XPC-FLD0852B
           VALUE X'1471732987'.
       78  XPC-FLD0853B
           VALUE X'0C'.
       78  XPC-FLD0854B
           VALUE X'09'.
       78  XPC-FLD0855B
           VALUE X'796064'.
       78  XPC-FLD0856B
           VALUE X'30842D'.
       78  XPC-FLD0857B
           VALUE X'011C'.
       78  XPC-FLD0858B
           VALUE X'029627833617'.
       78  XPC-FLD0859B
           VALUE X'0971628168143447767945986015547532588F'.
       78  XPC-FLD0860B
           VALUE X'310782983915'.
       78  XPC-FLD0861B
           VALUE X'1091'.
       78  XPC-FLD0862B
           VALUE X'0568978369365978243754'.
       78  XPC-FLD0863B
           VALUE X'05171345793694755750'.
       78  XPC-FLD0864B
           VALUE X'0409403590364872439594022918754491'.
       78  XPC-FLD0865B
           VALUE X'328C'.
       78  XPC-FLD0866B
           VALUE X'0973651490201067931957936707476620'.
       78  XPC-FLD0867B
           VALUE X'0728938616966572774526298417'.
       78  XPC-FLD0868B
           VALUE X'05841479951825634534535F'.
       78  XPC-FLD0869B
           VALUE X'6815782206919422936408636F'.
       78  XPC-FLD0870B
           VALUE X'657570531523696821807334'.
       78  XPC-FLD0871B
           VALUE X'5744601464762396635F'.
       78  XPC-FLD0872B
           VALUE X'045914011344767276'.
       78  XPC-FLD0873B
           VALUE X'076853'.
       78  XPC-FLD0874B
           VALUE X'01881063'.
       78  XPC-FLD0875B
           VALUE X'32'.
       78  XPC-FLD0876B
           VALUE X'0792823887607293276147402139031F'.
       78  XPC-FLD0877B
           VALUE X'0651975862412979334514773F'.
       78  XPC-FLD0878B
           VALUE X'242827678838084315415812843661207F'.
       78  XPC-FLD0879B
           VALUE X'056764772794591269560129376259283F'.
       78  XPC-FLD0880B
           VALUE X'04839436714022342976684717541503'.
       78  XPC-FLD0881B
           VALUE X'2105193947195C'.
       78  XPC-FLD0882B
           VALUE X'02108803940594616843638067'.
       78  XPC-FLD0883B
           VALUE X'9754132777012324284626648395'.
       78  XPC-FLD0884B
           VALUE X'06490392032439449247535630967F'.
       78  XPC-FLD0885B
           VALUE X'02072D'.
       78  XPC-FLD0886B
           VALUE X'000595069070307D'.
       78  XPC-FLD0887B
           VALUE X'09306168018675709582439026235078'.
       78  XPC-FLD0888B
           VALUE X'0118607301'.
       78  XPC-FLD0889B
           VALUE X'0286280324389502793813733205752214417F'.
       78  XPC-FLD0890B
           VALUE X'721613583480198661490589984F'.
       78  XPC-FLD0891B
           VALUE X'0735270814161123614247195235'.
       78  XPC-FLD0892B
           VALUE X'0556'.
       78  XPC-FLD0893B
           VALUE X'07'.
       78  XPC-FLD0894B
           VALUE X'654309128000748152942379'.
       78  XPC-FLD0895B
           VALUE X'2889386308'.
       78  XPC-FLD0896B
           VALUE X'0D'.
       78  XPC-FLD0897B
           VALUE X'04404922200833587C'.
       78  XPC-FLD0898B
           VALUE X'08343520'.
       78  XPC-FLD0899B
           VALUE X'5130606210827636'.
       78  XPC-FLD0900B
           VALUE X'01847104'.
       78  XPC-FLD0901B
           VALUE X'01289396298369796609307513790554367005'.
       78  XPC-FLD0902B
           VALUE X'5131049785081560397F'.
       78  XPC-FLD0903B
           VALUE X'046C'.
       78  XPC-FLD0904B
           VALUE X'7D'.
       78  XPC-FLD0905B
           VALUE X'07075373564412'.
       78  XPC-FLD0906B
           VALUE X'07'.
       78  XPC-FLD0907B
           VALUE X'0530207411746521324809'.
       78  XPC-FLD0908B
           VALUE X'08642393083548316472445662839163561F'.
       78  XPC-FLD0909B
           VALUE X'00'.
       78  XPC-FLD0910B
           VALUE X'2257333765600096867487422969134058'.
       78  XPC-FLD0911B
           VALUE X'03765938103187097346508025840F'.
       78  XPC-FLD0912B
           VALUE X'00'.
       78  XPC-FLD0913B
           VALUE X'0325'.
       78  XPC-FLD0914B
           VALUE X'7400121849171126253708052900037643855F'.
       78  XPC-FLD0915B
           VALUE X'02036C'.
       78  XPC-FLD0916B
           VALUE X'4372777685598984'.
       78  XPC-FLD0917B
           VALUE X'1084'.
       78  XPC-FLD0918B
           VALUE X'0569310510294893204244'.
       78  XPC-FLD0919B
           VALUE X'6D'.
       78  XPC-FLD0920B
           VALUE X'06698607602658151664433262'.
       78  XPC-FLD0921B
           VALUE X'0C'.
       78  XPC-FLD0922B
           VALUE X'0183318D'.
       78  XPC-FLD0923B
           VALUE X'00892C'.
       78  XPC-FLD0924B
           VALUE X'6753252278154044870414354451350F'.
       78  XPC-FLD0925B
           VALUE X'6C'.
       78  XPC-FLD0926B
           VALUE X'206877212D'.
       78  XPC-FLD0927B
           VALUE X'5121865708750312359F'.
       78  XPC-FLD0928B
           VALUE X'0255169492'.
       78  XPC-FLD0929B
           VALUE X'713937683093887626162299398F'.
       78  XPC-FLD0930B
           VALUE X'05915948649192320925289F'.
       78  XPC-FLD0931B
           VALUE X'124377459C'.
       78  XPC-FLD0932B
           VALUE X'00116711468219923287'.
       78  XPC-FLD0933B
           VALUE X'328435728864'.
       78  XPC-FLD0934B
           VALUE X'0237750091'.
       78  XPC-FLD0935B
           VALUE X'485384635684275264'.
       78  XPC-FLD0936B
           VALUE X'0418311146814978578269972331327153370F'.
       78  XPC-FLD0937B
           VALUE X'05'.
       78  XPC-FLD0938B
           VALUE X'07520562026683963451729041'.
       78  XPC-FLD0939B
           VALUE X'7C'.
       78  XPC-FLD0940B
           VALUE X'420205546087499959'.
       78  XPC-FLD0941B
           VALUE X'03450283323540'.
       78  XPC-FLD0942B
           VALUE X'94510218123579575949541058434988373F'.
       78  XPC-FLD0943B
           VALUE X'9698175C'.
       78  XPC-FLD0944B
           VALUE X'260056094D'.
       78  XPC-FLD0945B
           VALUE X'09639552190838519C'.
       78  XPC-FLD0946B
           VALUE X'0285407519811451561686510558502050116F'.
       78  XPC-FLD0947B
           VALUE X'6720279273588082815549249F'.
       78  XPC-FLD0948B
           VALUE X'7581536805549627281493485497'.
       78  XPC-FLD0949B
           VALUE X'089772746643169742'.
       78  XPC-FLD0950B
           VALUE X'9466572989771413480277234393870459'.
       78  XPC-FLD0951B
           VALUE X'0571609040492847894313968026'.
       78  XPC-FLD0952B
           VALUE X'65'.
       78  XPC-FLD0953B
           VALUE X'05187948954462912461'.
       78  XPC-FLD0954B
           VALUE X'0525409336908340408209862744115525857F'.
       78  XPC-FLD0955B
           VALUE X'5341017709695240897178791783518F'.
       78  XPC-FLD0956B
           VALUE X'097384559702281070479269828F'.
       78  XPC-FLD0957B
           VALUE X'01212C'.
       78  XPC-FLD0958B
           VALUE X'4387549590870288'.
       78  XPC-FLD0959B
           VALUE X'1C'.
       78  XPC-FLD0960B
           VALUE X'1D'.
       78  XPC-FLD0961B
           VALUE X'00056C'.
       78  XPC-FLD0962B
           VALUE X'6826560363239254262940347F'.
       78  XPC-FLD0963B
           VALUE X'06579508606108431242392875'.
       78  XPC-FLD0964B
           VALUE X'0399362942016605604323'.
       78  XPC-FLD0965B
           VALUE X'01'.
       78  XPC-FLD0966B
           VALUE X'00005571'.
       78  XPC-FLD0967B
           VALUE X'03560456473147'.
       78  XPC-FLD0968B
           VALUE X'05531D'.
       78  XPC-FLD0969B
           VALUE X'05945236920989867723715F'.
       78  XPC-FLD0970B
           VALUE X'433217720233246760537693012156523765'.
       78  XPC-FLD0971B
           VALUE X'402866616015322C'.
       78  XPC-FLD0972B
           VALUE X'096534'.
       78  XPC-FLD0973B
           VALUE X'08420775282429751358819203232997'.
       78  XPC-FLD0974B
           VALUE X'076D'.
       78  XPC-FLD0975B
           VALUE X'329183574054'.
       78  XPC-FLD0976B
           VALUE X'05189195631532426046'.
       78  XPC-FLD0977B
           VALUE X'006577733509987D'.
       78  XPC-FLD0978B
           VALUE X'263651133125830D'.
       78  XPC-FLD0979B
           VALUE X'38851072771967'.
       78  XPC-FLD0980B
           VALUE X'647159056743324437308229'.
       78  XPC-FLD0981B
           VALUE X'3602784782762D'.
       78  XPC-FLD0982B
           VALUE X'30653235444C'.
       78  XPC-FLD0983B
           VALUE X'882516211995383510538363225350622087'.
       78  XPC-FLD0984B
           VALUE X'04457843883822408592'.
       78  XPC-FLD0985B
           VALUE X'496108848273749947698929645412135F'.
       78  XPC-FLD0986B
           VALUE X'08'.
       78  XPC-FLD0987B
           VALUE X'084253493742279825972518736421080F'.
       78  XPC-FLD0988B
           VALUE X'0181520D'.
       78  XPC-FLD0989B
           VALUE X'05932140179792923634499F'.
       78  XPC-FLD0990B
           VALUE X'05970979'.
       78  XPC-FLD0991B
           VALUE X'404273028987099C'.
       78  XPC-FLD0992B
           VALUE X'518805985017170789852514182650362F'.
       78  XPC-FLD0993B
           VALUE X'05599C'.
       78  XPC-FLD0994B
           VALUE X'0484793408353182154D'.
       78  XPC-FLD0995B
           VALUE X'01888258'.
       78  XPC-FLD0996B
           VALUE X'00505105346267128441084558'.
       78  XPC-FLD0997B
           VALUE X'0011799546758455291F'.
       78  XPC-FLD0998B
           VALUE X'3D'.
       78  XPC-FLD0999B
           VALUE X'1D'.

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

           SUBTRACT FLD0500A        FROM FLD0500B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0501A        TO FLD0501B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0502A        FROM FLD0502B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0503A        TO FLD0503B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0504A        FROM FLD0504B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0505A        TO FLD0505B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0506A        FROM FLD0506B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0507A        TO FLD0507B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0508A        FROM FLD0508B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0509A        TO FLD0509B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0510A        FROM FLD0510B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0511A        TO FLD0511B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0512A        FROM FLD0512B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0513A        TO FLD0513B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0514A        FROM FLD0514B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0515A        TO FLD0515B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0516A        FROM FLD0516B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0517A        TO FLD0517B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0518A        FROM FLD0518B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0519A        TO FLD0519B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0520A        FROM FLD0520B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0521A        TO FLD0521B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0522A        FROM FLD0522B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0523A        TO FLD0523B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0524A        FROM FLD0524B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0525A        TO FLD0525B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0526A        FROM FLD0526B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0527A        TO FLD0527B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0528A        FROM FLD0528B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0529A        TO FLD0529B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0530A        FROM FLD0530B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0531A        TO FLD0531B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0532A        FROM FLD0532B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0533A        TO FLD0533B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0534A        FROM FLD0534B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0535A        TO FLD0535B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0536A        FROM FLD0536B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0537A        TO FLD0537B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0538A        FROM FLD0538B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0539A        TO FLD0539B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0540A        FROM FLD0540B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0541A        TO FLD0541B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0542A        FROM FLD0542B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0543A        TO FLD0543B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0544A        FROM FLD0544B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0545A        TO FLD0545B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0546A        FROM FLD0546B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0547A        TO FLD0547B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0548A        FROM FLD0548B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0549A        TO FLD0549B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0550A        FROM FLD0550B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0551A        TO FLD0551B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0552A        FROM FLD0552B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0553A        TO FLD0553B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0554A        FROM FLD0554B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0555A        TO FLD0555B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0556A        FROM FLD0556B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0557A        TO FLD0557B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0558A        FROM FLD0558B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0559A        TO FLD0559B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0560A        FROM FLD0560B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0561A        TO FLD0561B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0562A        FROM FLD0562B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0563A        TO FLD0563B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0564A        FROM FLD0564B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0565A        TO FLD0565B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0566A        FROM FLD0566B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0567A        TO FLD0567B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0568A        FROM FLD0568B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0569A        TO FLD0569B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0570A        FROM FLD0570B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0571A        TO FLD0571B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0572A        FROM FLD0572B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0573A        TO FLD0573B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0574A        FROM FLD0574B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0575A        TO FLD0575B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0576A        FROM FLD0576B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0577A        TO FLD0577B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0578A        FROM FLD0578B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0579A        TO FLD0579B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0580A        FROM FLD0580B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0581A        TO FLD0581B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0582A        FROM FLD0582B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0583A        TO FLD0583B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0584A        FROM FLD0584B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0585A        TO FLD0585B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0586A        FROM FLD0586B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0587A        TO FLD0587B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0588A        FROM FLD0588B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0589A        TO FLD0589B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0590A        FROM FLD0590B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0591A        TO FLD0591B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0592A        FROM FLD0592B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0593A        TO FLD0593B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0594A        FROM FLD0594B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0595A        TO FLD0595B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0596A        FROM FLD0596B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0597A        TO FLD0597B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0598A        FROM FLD0598B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0599A        TO FLD0599B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0600A        FROM FLD0600B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0601A        TO FLD0601B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0602A        FROM FLD0602B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0603A        TO FLD0603B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0604A        FROM FLD0604B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0605A        TO FLD0605B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0606A        FROM FLD0606B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0607A        TO FLD0607B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0608A        FROM FLD0608B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0609A        TO FLD0609B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0610A        FROM FLD0610B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0611A        TO FLD0611B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0612A        FROM FLD0612B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0613A        TO FLD0613B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0614A        FROM FLD0614B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0615A        TO FLD0615B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0616A        FROM FLD0616B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0617A        TO FLD0617B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0618A        FROM FLD0618B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0619A        TO FLD0619B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0620A        FROM FLD0620B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0621A        TO FLD0621B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0622A        FROM FLD0622B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0623A        TO FLD0623B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0624A        FROM FLD0624B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0625A        TO FLD0625B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0626A        FROM FLD0626B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0627A        TO FLD0627B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0628A        FROM FLD0628B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0629A        TO FLD0629B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0630A        FROM FLD0630B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0631A        TO FLD0631B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0632A        FROM FLD0632B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0633A        TO FLD0633B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0634A        FROM FLD0634B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0635A        TO FLD0635B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0636A        FROM FLD0636B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0637A        TO FLD0637B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0638A        FROM FLD0638B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0639A        TO FLD0639B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0640A        FROM FLD0640B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0641A        TO FLD0641B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0642A        FROM FLD0642B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0643A        TO FLD0643B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0644A        FROM FLD0644B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0645A        TO FLD0645B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0646A        FROM FLD0646B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0647A        TO FLD0647B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0648A        FROM FLD0648B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0649A        TO FLD0649B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0650A        FROM FLD0650B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0651A        TO FLD0651B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0652A        FROM FLD0652B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0653A        TO FLD0653B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0654A        FROM FLD0654B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0655A        TO FLD0655B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0656A        FROM FLD0656B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0657A        TO FLD0657B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0658A        FROM FLD0658B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0659A        TO FLD0659B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0660A        FROM FLD0660B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0661A        TO FLD0661B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0662A        FROM FLD0662B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0663A        TO FLD0663B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0664A        FROM FLD0664B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0665A        TO FLD0665B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0666A        FROM FLD0666B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0667A        TO FLD0667B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0668A        FROM FLD0668B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0669A        TO FLD0669B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0670A        FROM FLD0670B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0671A        TO FLD0671B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0672A        FROM FLD0672B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0673A        TO FLD0673B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0674A        FROM FLD0674B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0675A        TO FLD0675B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0676A        FROM FLD0676B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0677A        TO FLD0677B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0678A        FROM FLD0678B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0679A        TO FLD0679B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0680A        FROM FLD0680B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0681A        TO FLD0681B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0682A        FROM FLD0682B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0683A        TO FLD0683B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0684A        FROM FLD0684B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0685A        TO FLD0685B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0686A        FROM FLD0686B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0687A        TO FLD0687B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0688A        FROM FLD0688B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0689A        TO FLD0689B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0690A        FROM FLD0690B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0691A        TO FLD0691B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0692A        FROM FLD0692B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0693A        TO FLD0693B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0694A        FROM FLD0694B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0695A        TO FLD0695B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0696A        FROM FLD0696B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0697A        TO FLD0697B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0698A        FROM FLD0698B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0699A        TO FLD0699B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0700A        FROM FLD0700B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0701A        TO FLD0701B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0702A        FROM FLD0702B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0703A        TO FLD0703B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0704A        FROM FLD0704B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0705A        TO FLD0705B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0706A        FROM FLD0706B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0707A        TO FLD0707B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0708A        FROM FLD0708B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0709A        TO FLD0709B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0710A        FROM FLD0710B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0711A        TO FLD0711B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0712A        FROM FLD0712B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0713A        TO FLD0713B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0714A        FROM FLD0714B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0715A        TO FLD0715B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0716A        FROM FLD0716B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0717A        TO FLD0717B
               ROUNDED MODE IS PROHIBITED
              ON SIZE ERROR CONTINUE
             NOT ON SIZE ERROR DISPLAY 'MISSING EC-SIZE FLD0717B'.
           SUBTRACT FLD0718A        FROM FLD0718B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0719A        TO FLD0719B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0720A        FROM FLD0720B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0721A        TO FLD0721B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0722A        FROM FLD0722B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0723A        TO FLD0723B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0724A        FROM FLD0724B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0725A        TO FLD0725B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0726A        FROM FLD0726B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0727A        TO FLD0727B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0728A        FROM FLD0728B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0729A        TO FLD0729B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0730A        FROM FLD0730B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0731A        TO FLD0731B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0732A        FROM FLD0732B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0733A        TO FLD0733B
               ROUNDED MODE IS PROHIBITED
                 ON SIZE ERROR DISPLAY 'UNEXPECTED EC-SIZE FLD0733B'.
           SUBTRACT FLD0734A        FROM FLD0734B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0735A        TO FLD0735B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0736A        FROM FLD0736B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0737A        TO FLD0737B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0738A        FROM FLD0738B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0739A        TO FLD0739B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0740A        FROM FLD0740B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0741A        TO FLD0741B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0742A        FROM FLD0742B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0743A        TO FLD0743B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0744A        FROM FLD0744B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0745A        TO FLD0745B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0746A        FROM FLD0746B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0747A        TO FLD0747B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0748A        FROM FLD0748B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0749A        TO FLD0749B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0750A        FROM FLD0750B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0751A        TO FLD0751B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0752A        FROM FLD0752B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0753A        TO FLD0753B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0754A        FROM FLD0754B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0755A        TO FLD0755B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0756A        FROM FLD0756B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0757A        TO FLD0757B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0758A        FROM FLD0758B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0759A        TO FLD0759B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0760A        FROM FLD0760B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0761A        TO FLD0761B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0762A        FROM FLD0762B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0763A        TO FLD0763B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0764A        FROM FLD0764B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0765A        TO FLD0765B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0766A        FROM FLD0766B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0767A        TO FLD0767B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0768A        FROM FLD0768B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0769A        TO FLD0769B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0770A        FROM FLD0770B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0771A        TO FLD0771B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0772A        FROM FLD0772B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0773A        TO FLD0773B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0774A        FROM FLD0774B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0775A        TO FLD0775B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0776A        FROM FLD0776B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0777A        TO FLD0777B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0778A        FROM FLD0778B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0779A        TO FLD0779B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0780A        FROM FLD0780B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0781A        TO FLD0781B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0782A        FROM FLD0782B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0783A        TO FLD0783B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0784A        FROM FLD0784B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0785A        TO FLD0785B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0786A        FROM FLD0786B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0787A        TO FLD0787B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0788A        FROM FLD0788B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0789A        TO FLD0789B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0790A        FROM FLD0790B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0791A        TO FLD0791B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0792A        FROM FLD0792B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0793A        TO FLD0793B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0794A        FROM FLD0794B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0795A        TO FLD0795B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0796A        FROM FLD0796B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0797A        TO FLD0797B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0798A        FROM FLD0798B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0799A        TO FLD0799B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0800A        FROM FLD0800B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0801A        TO FLD0801B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0802A        FROM FLD0802B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0803A        TO FLD0803B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0804A        FROM FLD0804B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0805A        TO FLD0805B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0806A        FROM FLD0806B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0807A        TO FLD0807B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0808A        FROM FLD0808B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0809A        TO FLD0809B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0810A        FROM FLD0810B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0811A        TO FLD0811B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0812A        FROM FLD0812B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0813A        TO FLD0813B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0814A        FROM FLD0814B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0815A        TO FLD0815B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0816A        FROM FLD0816B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0817A        TO FLD0817B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0818A        FROM FLD0818B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0819A        TO FLD0819B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0820A        FROM FLD0820B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0821A        TO FLD0821B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0822A        FROM FLD0822B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0823A        TO FLD0823B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0824A        FROM FLD0824B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0825A        TO FLD0825B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0826A        FROM FLD0826B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0827A        TO FLD0827B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0828A        FROM FLD0828B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0829A        TO FLD0829B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0830A        FROM FLD0830B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0831A        TO FLD0831B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0832A        FROM FLD0832B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0833A        TO FLD0833B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0834A        FROM FLD0834B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0835A        TO FLD0835B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0836A        FROM FLD0836B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0837A        TO FLD0837B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0838A        FROM FLD0838B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0839A        TO FLD0839B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0840A        FROM FLD0840B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0841A        TO FLD0841B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0842A        FROM FLD0842B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0843A        TO FLD0843B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0844A        FROM FLD0844B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0845A        TO FLD0845B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0846A        FROM FLD0846B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0847A        TO FLD0847B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0848A        FROM FLD0848B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0849A        TO FLD0849B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0850A        FROM FLD0850B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0851A        TO FLD0851B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0852A        FROM FLD0852B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0853A        TO FLD0853B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0854A        FROM FLD0854B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0855A        TO FLD0855B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0856A        FROM FLD0856B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0857A        TO FLD0857B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0858A        FROM FLD0858B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0859A        TO FLD0859B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0860A        FROM FLD0860B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0861A        TO FLD0861B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0862A        FROM FLD0862B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0863A        TO FLD0863B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0864A        FROM FLD0864B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0865A        TO FLD0865B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0866A        FROM FLD0866B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0867A        TO FLD0867B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0868A        FROM FLD0868B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0869A        TO FLD0869B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0870A        FROM FLD0870B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0871A        TO FLD0871B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0872A        FROM FLD0872B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0873A        TO FLD0873B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0874A        FROM FLD0874B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0875A        TO FLD0875B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0876A        FROM FLD0876B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0877A        TO FLD0877B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0878A        FROM FLD0878B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0879A        TO FLD0879B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0880A        FROM FLD0880B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0881A        TO FLD0881B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0882A        FROM FLD0882B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0883A        TO FLD0883B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0884A        FROM FLD0884B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0885A        TO FLD0885B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0886A        FROM FLD0886B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0887A        TO FLD0887B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0888A        FROM FLD0888B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0889A        TO FLD0889B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0890A        FROM FLD0890B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0891A        TO FLD0891B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0892A        FROM FLD0892B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0893A        TO FLD0893B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0894A        FROM FLD0894B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0895A        TO FLD0895B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0896A        FROM FLD0896B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0897A        TO FLD0897B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0898A        FROM FLD0898B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0899A        TO FLD0899B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0900A        FROM FLD0900B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0901A        TO FLD0901B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0902A        FROM FLD0902B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0903A        TO FLD0903B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0904A        FROM FLD0904B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0905A        TO FLD0905B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0906A        FROM FLD0906B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0907A        TO FLD0907B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0908A        FROM FLD0908B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0909A        TO FLD0909B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0910A        FROM FLD0910B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0911A        TO FLD0911B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0912A        FROM FLD0912B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0913A        TO FLD0913B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0914A        FROM FLD0914B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0915A        TO FLD0915B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0916A        FROM FLD0916B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0917A        TO FLD0917B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0918A        FROM FLD0918B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0919A        TO FLD0919B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0920A        FROM FLD0920B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0921A        TO FLD0921B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0922A        FROM FLD0922B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0923A        TO FLD0923B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0924A        FROM FLD0924B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0925A        TO FLD0925B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0926A        FROM FLD0926B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0927A        TO FLD0927B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0928A        FROM FLD0928B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0929A        TO FLD0929B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0930A        FROM FLD0930B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0931A        TO FLD0931B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0932A        FROM FLD0932B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0933A        TO FLD0933B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0934A        FROM FLD0934B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0935A        TO FLD0935B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0936A        FROM FLD0936B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0937A        TO FLD0937B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0938A        FROM FLD0938B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0939A        TO FLD0939B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0940A        FROM FLD0940B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0941A        TO FLD0941B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0942A        FROM FLD0942B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0943A        TO FLD0943B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0944A        FROM FLD0944B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0945A        TO FLD0945B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0946A        FROM FLD0946B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0947A        TO FLD0947B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0948A        FROM FLD0948B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0949A        TO FLD0949B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0950A        FROM FLD0950B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0951A        TO FLD0951B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0952A        FROM FLD0952B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0953A        TO FLD0953B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0954A        FROM FLD0954B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0955A        TO FLD0955B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0956A        FROM FLD0956B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0957A        TO FLD0957B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0958A        FROM FLD0958B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0959A        TO FLD0959B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0960A        FROM FLD0960B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0961A        TO FLD0961B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0962A        FROM FLD0962B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0963A        TO FLD0963B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0964A        FROM FLD0964B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0965A        TO FLD0965B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0966A        FROM FLD0966B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0967A        TO FLD0967B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0968A        FROM FLD0968B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0969A        TO FLD0969B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0970A        FROM FLD0970B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0971A        TO FLD0971B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0972A        FROM FLD0972B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0973A        TO FLD0973B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0974A        FROM FLD0974B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0975A        TO FLD0975B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0976A        FROM FLD0976B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0977A        TO FLD0977B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0978A        FROM FLD0978B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0979A        TO FLD0979B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0980A        FROM FLD0980B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0981A        TO FLD0981B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0982A        FROM FLD0982B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0983A        TO FLD0983B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0984A        FROM FLD0984B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0985A        TO FLD0985B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0986A        FROM FLD0986B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0987A        TO FLD0987B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0988A        FROM FLD0988B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0989A        TO FLD0989B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0990A        FROM FLD0990B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0991A        TO FLD0991B
               ROUNDED MODE IS TOWARD-LESSER         .
           SUBTRACT FLD0992A        FROM FLD0992B
               ROUNDED MODE IS TRUNCATION            .
           ADD FLD0993A        TO FLD0993B
               ROUNDED MODE IS AWAY-FROM-ZERO        .
           SUBTRACT FLD0994A        FROM FLD0994B
               ROUNDED MODE IS NEAREST-AWAY-FROM-ZERO.
           ADD FLD0995A        TO FLD0995B
               ROUNDED MODE IS NEAREST-EVEN          .
           SUBTRACT FLD0996A        FROM FLD0996B
               ROUNDED MODE IS NEAREST-TOWARD-ZERO   .
           ADD FLD0997A        TO FLD0997B
               ROUNDED MODE IS PROHIBITED            .
           SUBTRACT FLD0998A        FROM FLD0998B
               ROUNDED MODE IS TOWARD-GREATER        .
           ADD FLD0999A        TO FLD0999B
               ROUNDED MODE IS TOWARD-LESSER         .

      *4000-COMPARE.

           IF FLD0500B (1:)    NOT EQUAL XPC-FLD0500B
              DISPLAY 'FLD0500B ==> ' HEX-OF (FLD0500B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0500B).
           IF FLD0501B (1:)    NOT EQUAL XPC-FLD0501B
              DISPLAY 'FLD0501B ==> ' HEX-OF (FLD0501B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0501B).
           IF FLD0502B (1:)    NOT EQUAL XPC-FLD0502B
              DISPLAY 'FLD0502B ==> ' HEX-OF (FLD0502B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0502B).
           IF FLD0503B (1:)    NOT EQUAL XPC-FLD0503B
              DISPLAY 'FLD0503B ==> ' HEX-OF (FLD0503B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0503B).
           IF FLD0504B (1:)    NOT EQUAL XPC-FLD0504B
              DISPLAY 'FLD0504B ==> ' HEX-OF (FLD0504B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0504B).
           IF FLD0505B (1:)    NOT EQUAL XPC-FLD0505B
              DISPLAY 'FLD0505B ==> ' HEX-OF (FLD0505B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0505B).
           IF FLD0506B (1:)    NOT EQUAL XPC-FLD0506B
              DISPLAY 'FLD0506B ==> ' HEX-OF (FLD0506B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0506B).
           IF FLD0507B (1:)    NOT EQUAL XPC-FLD0507B
              DISPLAY 'FLD0507B ==> ' HEX-OF (FLD0507B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0507B).
           IF FLD0508B (1:)    NOT EQUAL XPC-FLD0508B
              DISPLAY 'FLD0508B ==> ' HEX-OF (FLD0508B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0508B).
           IF FLD0509B (1:)    NOT EQUAL XPC-FLD0509B
              DISPLAY 'FLD0509B ==> ' HEX-OF (FLD0509B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0509B).
           IF FLD0510B (1:)    NOT EQUAL XPC-FLD0510B
              DISPLAY 'FLD0510B ==> ' HEX-OF (FLD0510B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0510B).
           IF FLD0511B (1:)    NOT EQUAL XPC-FLD0511B
              DISPLAY 'FLD0511B ==> ' HEX-OF (FLD0511B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0511B).
           IF FLD0512B (1:)    NOT EQUAL XPC-FLD0512B
              DISPLAY 'FLD0512B ==> ' HEX-OF (FLD0512B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0512B).
           IF FLD0513B (1:)    NOT EQUAL XPC-FLD0513B
              DISPLAY 'FLD0513B ==> ' HEX-OF (FLD0513B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0513B).
           IF FLD0514B (1:)    NOT EQUAL XPC-FLD0514B
              DISPLAY 'FLD0514B ==> ' HEX-OF (FLD0514B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0514B).
           IF FLD0515B (1:)    NOT EQUAL XPC-FLD0515B
              DISPLAY 'FLD0515B ==> ' HEX-OF (FLD0515B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0515B).
           IF FLD0516B (1:)    NOT EQUAL XPC-FLD0516B
              DISPLAY 'FLD0516B ==> ' HEX-OF (FLD0516B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0516B).
           IF FLD0517B (1:)    NOT EQUAL XPC-FLD0517B
              DISPLAY 'FLD0517B ==> ' HEX-OF (FLD0517B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0517B).
           IF FLD0518B (1:)    NOT EQUAL XPC-FLD0518B
              DISPLAY 'FLD0518B ==> ' HEX-OF (FLD0518B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0518B).
           IF FLD0519B (1:)    NOT EQUAL XPC-FLD0519B
              DISPLAY 'FLD0519B ==> ' HEX-OF (FLD0519B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0519B).
           IF FLD0520B (1:)    NOT EQUAL XPC-FLD0520B
              DISPLAY 'FLD0520B ==> ' HEX-OF (FLD0520B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0520B).
           IF FLD0521B (1:)    NOT EQUAL XPC-FLD0521B
              DISPLAY 'FLD0521B ==> ' HEX-OF (FLD0521B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0521B).
           IF FLD0522B (1:)    NOT EQUAL XPC-FLD0522B
              DISPLAY 'FLD0522B ==> ' HEX-OF (FLD0522B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0522B).
           IF FLD0523B (1:)    NOT EQUAL XPC-FLD0523B
              DISPLAY 'FLD0523B ==> ' HEX-OF (FLD0523B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0523B).
           IF FLD0524B (1:)    NOT EQUAL XPC-FLD0524B
              DISPLAY 'FLD0524B ==> ' HEX-OF (FLD0524B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0524B).
           IF FLD0525B (1:)    NOT EQUAL XPC-FLD0525B
              DISPLAY 'FLD0525B ==> ' HEX-OF (FLD0525B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0525B).
           IF FLD0526B (1:)    NOT EQUAL XPC-FLD0526B
              DISPLAY 'FLD0526B ==> ' HEX-OF (FLD0526B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0526B).
           IF FLD0527B (1:)    NOT EQUAL XPC-FLD0527B
              DISPLAY 'FLD0527B ==> ' HEX-OF (FLD0527B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0527B).
           IF FLD0528B (1:)    NOT EQUAL XPC-FLD0528B
              DISPLAY 'FLD0528B ==> ' HEX-OF (FLD0528B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0528B).
           IF FLD0529B (1:)    NOT EQUAL XPC-FLD0529B
              DISPLAY 'FLD0529B ==> ' HEX-OF (FLD0529B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0529B).
           IF FLD0530B (1:)    NOT EQUAL XPC-FLD0530B
              DISPLAY 'FLD0530B ==> ' HEX-OF (FLD0530B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0530B).
           IF FLD0531B (1:)    NOT EQUAL XPC-FLD0531B
              DISPLAY 'FLD0531B ==> ' HEX-OF (FLD0531B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0531B).
           IF FLD0532B (1:)    NOT EQUAL XPC-FLD0532B
              DISPLAY 'FLD0532B ==> ' HEX-OF (FLD0532B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0532B).
           IF FLD0533B (1:)    NOT EQUAL XPC-FLD0533B
              DISPLAY 'FLD0533B ==> ' HEX-OF (FLD0533B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0533B).
           IF FLD0534B (1:)    NOT EQUAL XPC-FLD0534B
              DISPLAY 'FLD0534B ==> ' HEX-OF (FLD0534B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0534B).
           IF FLD0535B (1:)    NOT EQUAL XPC-FLD0535B
              DISPLAY 'FLD0535B ==> ' HEX-OF (FLD0535B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0535B).
           IF FLD0536B (1:)    NOT EQUAL XPC-FLD0536B
              DISPLAY 'FLD0536B ==> ' HEX-OF (FLD0536B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0536B).
           IF FLD0537B (1:)    NOT EQUAL XPC-FLD0537B
              DISPLAY 'FLD0537B ==> ' HEX-OF (FLD0537B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0537B).
           IF FLD0538B (1:)    NOT EQUAL XPC-FLD0538B
              DISPLAY 'FLD0538B ==> ' HEX-OF (FLD0538B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0538B).
           IF FLD0539B (1:)    NOT EQUAL XPC-FLD0539B
              DISPLAY 'FLD0539B ==> ' HEX-OF (FLD0539B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0539B).
           IF FLD0540B (1:)    NOT EQUAL XPC-FLD0540B
              DISPLAY 'FLD0540B ==> ' HEX-OF (FLD0540B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0540B).
           IF FLD0541B (1:)    NOT EQUAL XPC-FLD0541B
              DISPLAY 'FLD0541B ==> ' HEX-OF (FLD0541B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0541B).
           IF FLD0542B (1:)    NOT EQUAL XPC-FLD0542B
              DISPLAY 'FLD0542B ==> ' HEX-OF (FLD0542B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0542B).
           IF FLD0543B (1:)    NOT EQUAL XPC-FLD0543B
              DISPLAY 'FLD0543B ==> ' HEX-OF (FLD0543B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0543B).
           IF FLD0544B (1:)    NOT EQUAL XPC-FLD0544B
              DISPLAY 'FLD0544B ==> ' HEX-OF (FLD0544B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0544B).
           IF FLD0545B (1:)    NOT EQUAL XPC-FLD0545B
              DISPLAY 'FLD0545B ==> ' HEX-OF (FLD0545B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0545B).
           IF FLD0546B (1:)    NOT EQUAL XPC-FLD0546B
              DISPLAY 'FLD0546B ==> ' HEX-OF (FLD0546B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0546B).
           IF FLD0547B (1:)    NOT EQUAL XPC-FLD0547B
              DISPLAY 'FLD0547B ==> ' HEX-OF (FLD0547B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0547B).
           IF FLD0548B (1:)    NOT EQUAL XPC-FLD0548B
              DISPLAY 'FLD0548B ==> ' HEX-OF (FLD0548B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0548B).
           IF FLD0549B (1:)    NOT EQUAL XPC-FLD0549B
              DISPLAY 'FLD0549B ==> ' HEX-OF (FLD0549B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0549B).
           IF FLD0550B (1:)    NOT EQUAL XPC-FLD0550B
              DISPLAY 'FLD0550B ==> ' HEX-OF (FLD0550B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0550B).
           IF FLD0551B (1:)    NOT EQUAL XPC-FLD0551B
              DISPLAY 'FLD0551B ==> ' HEX-OF (FLD0551B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0551B).
           IF FLD0552B (1:)    NOT EQUAL XPC-FLD0552B
              DISPLAY 'FLD0552B ==> ' HEX-OF (FLD0552B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0552B).
           IF FLD0553B (1:)    NOT EQUAL XPC-FLD0553B
              DISPLAY 'FLD0553B ==> ' HEX-OF (FLD0553B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0553B).
           IF FLD0554B (1:)    NOT EQUAL XPC-FLD0554B
              DISPLAY 'FLD0554B ==> ' HEX-OF (FLD0554B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0554B).
           IF FLD0555B (1:)    NOT EQUAL XPC-FLD0555B
              DISPLAY 'FLD0555B ==> ' HEX-OF (FLD0555B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0555B).
           IF FLD0556B (1:)    NOT EQUAL XPC-FLD0556B
              DISPLAY 'FLD0556B ==> ' HEX-OF (FLD0556B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0556B).
           IF FLD0557B (1:)    NOT EQUAL XPC-FLD0557B
              DISPLAY 'FLD0557B ==> ' HEX-OF (FLD0557B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0557B).
           IF FLD0558B (1:)    NOT EQUAL XPC-FLD0558B
              DISPLAY 'FLD0558B ==> ' HEX-OF (FLD0558B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0558B).
           IF FLD0559B (1:)    NOT EQUAL XPC-FLD0559B
              DISPLAY 'FLD0559B ==> ' HEX-OF (FLD0559B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0559B).
           IF FLD0560B (1:)    NOT EQUAL XPC-FLD0560B
              DISPLAY 'FLD0560B ==> ' HEX-OF (FLD0560B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0560B).
           IF FLD0561B (1:)    NOT EQUAL XPC-FLD0561B
              DISPLAY 'FLD0561B ==> ' HEX-OF (FLD0561B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0561B).
           IF FLD0562B (1:)    NOT EQUAL XPC-FLD0562B
              DISPLAY 'FLD0562B ==> ' HEX-OF (FLD0562B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0562B).
           IF FLD0563B (1:)    NOT EQUAL XPC-FLD0563B
              DISPLAY 'FLD0563B ==> ' HEX-OF (FLD0563B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0563B).
           IF FLD0564B (1:)    NOT EQUAL XPC-FLD0564B
              DISPLAY 'FLD0564B ==> ' HEX-OF (FLD0564B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0564B).
           IF FLD0565B (1:)    NOT EQUAL XPC-FLD0565B
              DISPLAY 'FLD0565B ==> ' HEX-OF (FLD0565B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0565B).
           IF FLD0566B (1:)    NOT EQUAL XPC-FLD0566B
              DISPLAY 'FLD0566B ==> ' HEX-OF (FLD0566B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0566B).
           IF FLD0567B (1:)    NOT EQUAL XPC-FLD0567B
              DISPLAY 'FLD0567B ==> ' HEX-OF (FLD0567B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0567B).
           IF FLD0568B (1:)    NOT EQUAL XPC-FLD0568B
              DISPLAY 'FLD0568B ==> ' HEX-OF (FLD0568B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0568B).
           IF FLD0569B (1:)    NOT EQUAL XPC-FLD0569B
              DISPLAY 'FLD0569B ==> ' HEX-OF (FLD0569B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0569B).
           IF FLD0570B (1:)    NOT EQUAL XPC-FLD0570B
              DISPLAY 'FLD0570B ==> ' HEX-OF (FLD0570B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0570B).
           IF FLD0571B (1:)    NOT EQUAL XPC-FLD0571B
              DISPLAY 'FLD0571B ==> ' HEX-OF (FLD0571B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0571B).
           IF FLD0572B (1:)    NOT EQUAL XPC-FLD0572B
              DISPLAY 'FLD0572B ==> ' HEX-OF (FLD0572B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0572B).
           IF FLD0573B (1:)    NOT EQUAL XPC-FLD0573B
              DISPLAY 'FLD0573B ==> ' HEX-OF (FLD0573B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0573B).
           IF FLD0574B (1:)    NOT EQUAL XPC-FLD0574B
              DISPLAY 'FLD0574B ==> ' HEX-OF (FLD0574B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0574B).
           IF FLD0575B (1:)    NOT EQUAL XPC-FLD0575B
              DISPLAY 'FLD0575B ==> ' HEX-OF (FLD0575B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0575B).
           IF FLD0576B (1:)    NOT EQUAL XPC-FLD0576B
              DISPLAY 'FLD0576B ==> ' HEX-OF (FLD0576B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0576B).
           IF FLD0577B (1:)    NOT EQUAL XPC-FLD0577B
              DISPLAY 'FLD0577B ==> ' HEX-OF (FLD0577B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0577B).
           IF FLD0578B (1:)    NOT EQUAL XPC-FLD0578B
              DISPLAY 'FLD0578B ==> ' HEX-OF (FLD0578B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0578B).
           IF FLD0579B (1:)    NOT EQUAL XPC-FLD0579B
              DISPLAY 'FLD0579B ==> ' HEX-OF (FLD0579B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0579B).
           IF FLD0580B (1:)    NOT EQUAL XPC-FLD0580B
              DISPLAY 'FLD0580B ==> ' HEX-OF (FLD0580B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0580B).
           IF FLD0581B (1:)    NOT EQUAL XPC-FLD0581B
              DISPLAY 'FLD0581B ==> ' HEX-OF (FLD0581B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0581B).
           IF FLD0582B (1:)    NOT EQUAL XPC-FLD0582B
              DISPLAY 'FLD0582B ==> ' HEX-OF (FLD0582B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0582B).
           IF FLD0583B (1:)    NOT EQUAL XPC-FLD0583B
              DISPLAY 'FLD0583B ==> ' HEX-OF (FLD0583B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0583B).
           IF FLD0584B (1:)    NOT EQUAL XPC-FLD0584B
              DISPLAY 'FLD0584B ==> ' HEX-OF (FLD0584B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0584B).
           IF FLD0585B (1:)    NOT EQUAL XPC-FLD0585B
              DISPLAY 'FLD0585B ==> ' HEX-OF (FLD0585B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0585B).
           IF FLD0586B (1:)    NOT EQUAL XPC-FLD0586B
              DISPLAY 'FLD0586B ==> ' HEX-OF (FLD0586B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0586B).
           IF FLD0587B (1:)    NOT EQUAL XPC-FLD0587B
              DISPLAY 'FLD0587B ==> ' HEX-OF (FLD0587B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0587B).
           IF FLD0588B (1:)    NOT EQUAL XPC-FLD0588B
              DISPLAY 'FLD0588B ==> ' HEX-OF (FLD0588B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0588B).
           IF FLD0589B (1:)    NOT EQUAL XPC-FLD0589B
              DISPLAY 'FLD0589B ==> ' HEX-OF (FLD0589B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0589B).
           IF FLD0590B (1:)    NOT EQUAL XPC-FLD0590B
              DISPLAY 'FLD0590B ==> ' HEX-OF (FLD0590B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0590B).
           IF FLD0591B (1:)    NOT EQUAL XPC-FLD0591B
              DISPLAY 'FLD0591B ==> ' HEX-OF (FLD0591B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0591B).
           IF FLD0592B (1:)    NOT EQUAL XPC-FLD0592B
              DISPLAY 'FLD0592B ==> ' HEX-OF (FLD0592B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0592B).
           IF FLD0593B (1:)    NOT EQUAL XPC-FLD0593B
              DISPLAY 'FLD0593B ==> ' HEX-OF (FLD0593B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0593B).
           IF FLD0594B (1:)    NOT EQUAL XPC-FLD0594B
              DISPLAY 'FLD0594B ==> ' HEX-OF (FLD0594B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0594B).
           IF FLD0595B (1:)    NOT EQUAL XPC-FLD0595B
              DISPLAY 'FLD0595B ==> ' HEX-OF (FLD0595B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0595B).
           IF FLD0596B (1:)    NOT EQUAL XPC-FLD0596B
              DISPLAY 'FLD0596B ==> ' HEX-OF (FLD0596B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0596B).
           IF FLD0597B (1:)    NOT EQUAL XPC-FLD0597B
              DISPLAY 'FLD0597B ==> ' HEX-OF (FLD0597B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0597B).
           IF FLD0598B (1:)    NOT EQUAL XPC-FLD0598B
              DISPLAY 'FLD0598B ==> ' HEX-OF (FLD0598B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0598B).
           IF FLD0599B (1:)    NOT EQUAL XPC-FLD0599B
              DISPLAY 'FLD0599B ==> ' HEX-OF (FLD0599B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0599B).
           IF FLD0600B (1:)    NOT EQUAL XPC-FLD0600B
              DISPLAY 'FLD0600B ==> ' HEX-OF (FLD0600B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0600B).
           IF FLD0601B (1:)    NOT EQUAL XPC-FLD0601B
              DISPLAY 'FLD0601B ==> ' HEX-OF (FLD0601B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0601B).
           IF FLD0602B (1:)    NOT EQUAL XPC-FLD0602B
              DISPLAY 'FLD0602B ==> ' HEX-OF (FLD0602B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0602B).
           IF FLD0603B (1:)    NOT EQUAL XPC-FLD0603B
              DISPLAY 'FLD0603B ==> ' HEX-OF (FLD0603B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0603B).
           IF FLD0604B (1:)    NOT EQUAL XPC-FLD0604B
              DISPLAY 'FLD0604B ==> ' HEX-OF (FLD0604B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0604B).
           IF FLD0605B (1:)    NOT EQUAL XPC-FLD0605B
              DISPLAY 'FLD0605B ==> ' HEX-OF (FLD0605B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0605B).
           IF FLD0606B (1:)    NOT EQUAL XPC-FLD0606B
              DISPLAY 'FLD0606B ==> ' HEX-OF (FLD0606B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0606B).
           IF FLD0607B (1:)    NOT EQUAL XPC-FLD0607B
              DISPLAY 'FLD0607B ==> ' HEX-OF (FLD0607B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0607B).
           IF FLD0608B (1:)    NOT EQUAL XPC-FLD0608B
              DISPLAY 'FLD0608B ==> ' HEX-OF (FLD0608B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0608B).
           IF FLD0609B (1:)    NOT EQUAL XPC-FLD0609B
              DISPLAY 'FLD0609B ==> ' HEX-OF (FLD0609B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0609B).
           IF FLD0610B (1:)    NOT EQUAL XPC-FLD0610B
              DISPLAY 'FLD0610B ==> ' HEX-OF (FLD0610B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0610B).
           IF FLD0611B (1:)    NOT EQUAL XPC-FLD0611B
              DISPLAY 'FLD0611B ==> ' HEX-OF (FLD0611B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0611B).
           IF FLD0612B (1:)    NOT EQUAL XPC-FLD0612B
              DISPLAY 'FLD0612B ==> ' HEX-OF (FLD0612B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0612B).
           IF FLD0613B (1:)    NOT EQUAL XPC-FLD0613B
              DISPLAY 'FLD0613B ==> ' HEX-OF (FLD0613B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0613B).
           IF FLD0614B (1:)    NOT EQUAL XPC-FLD0614B
              DISPLAY 'FLD0614B ==> ' HEX-OF (FLD0614B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0614B).
           IF FLD0615B (1:)    NOT EQUAL XPC-FLD0615B
              DISPLAY 'FLD0615B ==> ' HEX-OF (FLD0615B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0615B).
           IF FLD0616B (1:)    NOT EQUAL XPC-FLD0616B
              DISPLAY 'FLD0616B ==> ' HEX-OF (FLD0616B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0616B).
           IF FLD0617B (1:)    NOT EQUAL XPC-FLD0617B
              DISPLAY 'FLD0617B ==> ' HEX-OF (FLD0617B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0617B).
           IF FLD0618B (1:)    NOT EQUAL XPC-FLD0618B
              DISPLAY 'FLD0618B ==> ' HEX-OF (FLD0618B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0618B).
           IF FLD0619B (1:)    NOT EQUAL XPC-FLD0619B
              DISPLAY 'FLD0619B ==> ' HEX-OF (FLD0619B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0619B).
           IF FLD0620B (1:)    NOT EQUAL XPC-FLD0620B
              DISPLAY 'FLD0620B ==> ' HEX-OF (FLD0620B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0620B).
           IF FLD0621B (1:)    NOT EQUAL XPC-FLD0621B
              DISPLAY 'FLD0621B ==> ' HEX-OF (FLD0621B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0621B).
           IF FLD0622B (1:)    NOT EQUAL XPC-FLD0622B
              DISPLAY 'FLD0622B ==> ' HEX-OF (FLD0622B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0622B).
           IF FLD0623B (1:)    NOT EQUAL XPC-FLD0623B
              DISPLAY 'FLD0623B ==> ' HEX-OF (FLD0623B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0623B).
           IF FLD0624B (1:)    NOT EQUAL XPC-FLD0624B
              DISPLAY 'FLD0624B ==> ' HEX-OF (FLD0624B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0624B).
           IF FLD0625B (1:)    NOT EQUAL XPC-FLD0625B
              DISPLAY 'FLD0625B ==> ' HEX-OF (FLD0625B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0625B).
           IF FLD0626B (1:)    NOT EQUAL XPC-FLD0626B
              DISPLAY 'FLD0626B ==> ' HEX-OF (FLD0626B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0626B).
           IF FLD0627B (1:)    NOT EQUAL XPC-FLD0627B
              DISPLAY 'FLD0627B ==> ' HEX-OF (FLD0627B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0627B).
           IF FLD0628B (1:)    NOT EQUAL XPC-FLD0628B
              DISPLAY 'FLD0628B ==> ' HEX-OF (FLD0628B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0628B).
           IF FLD0629B (1:)    NOT EQUAL XPC-FLD0629B
              DISPLAY 'FLD0629B ==> ' HEX-OF (FLD0629B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0629B).
           IF FLD0630B (1:)    NOT EQUAL XPC-FLD0630B
              DISPLAY 'FLD0630B ==> ' HEX-OF (FLD0630B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0630B).
           IF FLD0631B (1:)    NOT EQUAL XPC-FLD0631B
              DISPLAY 'FLD0631B ==> ' HEX-OF (FLD0631B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0631B).
           IF FLD0632B (1:)    NOT EQUAL XPC-FLD0632B
              DISPLAY 'FLD0632B ==> ' HEX-OF (FLD0632B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0632B).
           IF FLD0633B (1:)    NOT EQUAL XPC-FLD0633B
              DISPLAY 'FLD0633B ==> ' HEX-OF (FLD0633B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0633B).
           IF FLD0634B (1:)    NOT EQUAL XPC-FLD0634B
              DISPLAY 'FLD0634B ==> ' HEX-OF (FLD0634B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0634B).
           IF FLD0635B (1:)    NOT EQUAL XPC-FLD0635B
              DISPLAY 'FLD0635B ==> ' HEX-OF (FLD0635B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0635B).
           IF FLD0636B (1:)    NOT EQUAL XPC-FLD0636B
              DISPLAY 'FLD0636B ==> ' HEX-OF (FLD0636B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0636B).
           IF FLD0637B (1:)    NOT EQUAL XPC-FLD0637B
              DISPLAY 'FLD0637B ==> ' HEX-OF (FLD0637B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0637B).
           IF FLD0638B (1:)    NOT EQUAL XPC-FLD0638B
              DISPLAY 'FLD0638B ==> ' HEX-OF (FLD0638B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0638B).
           IF FLD0639B (1:)    NOT EQUAL XPC-FLD0639B
              DISPLAY 'FLD0639B ==> ' HEX-OF (FLD0639B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0639B).
           IF FLD0640B (1:)    NOT EQUAL XPC-FLD0640B
              DISPLAY 'FLD0640B ==> ' HEX-OF (FLD0640B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0640B).
           IF FLD0641B (1:)    NOT EQUAL XPC-FLD0641B
              DISPLAY 'FLD0641B ==> ' HEX-OF (FLD0641B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0641B).
           IF FLD0642B (1:)    NOT EQUAL XPC-FLD0642B
              DISPLAY 'FLD0642B ==> ' HEX-OF (FLD0642B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0642B).
           IF FLD0643B (1:)    NOT EQUAL XPC-FLD0643B
              DISPLAY 'FLD0643B ==> ' HEX-OF (FLD0643B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0643B).
           IF FLD0644B (1:)    NOT EQUAL XPC-FLD0644B
              DISPLAY 'FLD0644B ==> ' HEX-OF (FLD0644B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0644B).
           IF FLD0645B (1:)    NOT EQUAL XPC-FLD0645B
              DISPLAY 'FLD0645B ==> ' HEX-OF (FLD0645B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0645B).
           IF FLD0646B (1:)    NOT EQUAL XPC-FLD0646B
              DISPLAY 'FLD0646B ==> ' HEX-OF (FLD0646B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0646B).
           IF FLD0647B (1:)    NOT EQUAL XPC-FLD0647B
              DISPLAY 'FLD0647B ==> ' HEX-OF (FLD0647B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0647B).
           IF FLD0648B (1:)    NOT EQUAL XPC-FLD0648B
              DISPLAY 'FLD0648B ==> ' HEX-OF (FLD0648B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0648B).
           IF FLD0649B (1:)    NOT EQUAL XPC-FLD0649B
              DISPLAY 'FLD0649B ==> ' HEX-OF (FLD0649B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0649B).
           IF FLD0650B (1:)    NOT EQUAL XPC-FLD0650B
              DISPLAY 'FLD0650B ==> ' HEX-OF (FLD0650B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0650B).
           IF FLD0651B (1:)    NOT EQUAL XPC-FLD0651B
              DISPLAY 'FLD0651B ==> ' HEX-OF (FLD0651B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0651B).
           IF FLD0652B (1:)    NOT EQUAL XPC-FLD0652B
              DISPLAY 'FLD0652B ==> ' HEX-OF (FLD0652B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0652B).
           IF FLD0653B (1:)    NOT EQUAL XPC-FLD0653B
              DISPLAY 'FLD0653B ==> ' HEX-OF (FLD0653B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0653B).
           IF FLD0654B (1:)    NOT EQUAL XPC-FLD0654B
              DISPLAY 'FLD0654B ==> ' HEX-OF (FLD0654B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0654B).
           IF FLD0655B (1:)    NOT EQUAL XPC-FLD0655B
              DISPLAY 'FLD0655B ==> ' HEX-OF (FLD0655B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0655B).
           IF FLD0656B (1:)    NOT EQUAL XPC-FLD0656B
              DISPLAY 'FLD0656B ==> ' HEX-OF (FLD0656B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0656B).
           IF FLD0657B (1:)    NOT EQUAL XPC-FLD0657B
              DISPLAY 'FLD0657B ==> ' HEX-OF (FLD0657B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0657B).
           IF FLD0658B (1:)    NOT EQUAL XPC-FLD0658B
              DISPLAY 'FLD0658B ==> ' HEX-OF (FLD0658B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0658B).
           IF FLD0659B (1:)    NOT EQUAL XPC-FLD0659B
              DISPLAY 'FLD0659B ==> ' HEX-OF (FLD0659B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0659B).
           IF FLD0660B (1:)    NOT EQUAL XPC-FLD0660B
              DISPLAY 'FLD0660B ==> ' HEX-OF (FLD0660B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0660B).
           IF FLD0661B (1:)    NOT EQUAL XPC-FLD0661B
              DISPLAY 'FLD0661B ==> ' HEX-OF (FLD0661B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0661B).
           IF FLD0662B (1:)    NOT EQUAL XPC-FLD0662B
              DISPLAY 'FLD0662B ==> ' HEX-OF (FLD0662B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0662B).
           IF FLD0663B (1:)    NOT EQUAL XPC-FLD0663B
              DISPLAY 'FLD0663B ==> ' HEX-OF (FLD0663B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0663B).
           IF FLD0664B (1:)    NOT EQUAL XPC-FLD0664B
              DISPLAY 'FLD0664B ==> ' HEX-OF (FLD0664B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0664B).
           IF FLD0665B (1:)    NOT EQUAL XPC-FLD0665B
              DISPLAY 'FLD0665B ==> ' HEX-OF (FLD0665B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0665B).
           IF FLD0666B (1:)    NOT EQUAL XPC-FLD0666B
              DISPLAY 'FLD0666B ==> ' HEX-OF (FLD0666B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0666B).
           IF FLD0667B (1:)    NOT EQUAL XPC-FLD0667B
              DISPLAY 'FLD0667B ==> ' HEX-OF (FLD0667B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0667B).
           IF FLD0668B (1:)    NOT EQUAL XPC-FLD0668B
              DISPLAY 'FLD0668B ==> ' HEX-OF (FLD0668B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0668B).
           IF FLD0669B (1:)    NOT EQUAL XPC-FLD0669B
              DISPLAY 'FLD0669B ==> ' HEX-OF (FLD0669B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0669B).
           IF FLD0670B (1:)    NOT EQUAL XPC-FLD0670B
              DISPLAY 'FLD0670B ==> ' HEX-OF (FLD0670B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0670B).
           IF FLD0671B (1:)    NOT EQUAL XPC-FLD0671B
              DISPLAY 'FLD0671B ==> ' HEX-OF (FLD0671B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0671B).
           IF FLD0672B (1:)    NOT EQUAL XPC-FLD0672B
              DISPLAY 'FLD0672B ==> ' HEX-OF (FLD0672B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0672B).
           IF FLD0673B (1:)    NOT EQUAL XPC-FLD0673B
              DISPLAY 'FLD0673B ==> ' HEX-OF (FLD0673B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0673B).
           IF FLD0674B (1:)    NOT EQUAL XPC-FLD0674B
              DISPLAY 'FLD0674B ==> ' HEX-OF (FLD0674B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0674B).
           IF FLD0675B (1:)    NOT EQUAL XPC-FLD0675B
              DISPLAY 'FLD0675B ==> ' HEX-OF (FLD0675B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0675B).
           IF FLD0676B (1:)    NOT EQUAL XPC-FLD0676B
              DISPLAY 'FLD0676B ==> ' HEX-OF (FLD0676B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0676B).
           IF FLD0677B (1:)    NOT EQUAL XPC-FLD0677B
              DISPLAY 'FLD0677B ==> ' HEX-OF (FLD0677B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0677B).
           IF FLD0678B (1:)    NOT EQUAL XPC-FLD0678B
              DISPLAY 'FLD0678B ==> ' HEX-OF (FLD0678B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0678B).
           IF FLD0679B (1:)    NOT EQUAL XPC-FLD0679B
              DISPLAY 'FLD0679B ==> ' HEX-OF (FLD0679B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0679B).
           IF FLD0680B (1:)    NOT EQUAL XPC-FLD0680B
              DISPLAY 'FLD0680B ==> ' HEX-OF (FLD0680B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0680B).
           IF FLD0681B (1:)    NOT EQUAL XPC-FLD0681B
              DISPLAY 'FLD0681B ==> ' HEX-OF (FLD0681B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0681B).
           IF FLD0682B (1:)    NOT EQUAL XPC-FLD0682B
              DISPLAY 'FLD0682B ==> ' HEX-OF (FLD0682B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0682B).
           IF FLD0683B (1:)    NOT EQUAL XPC-FLD0683B
              DISPLAY 'FLD0683B ==> ' HEX-OF (FLD0683B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0683B).
           IF FLD0684B (1:)    NOT EQUAL XPC-FLD0684B
              DISPLAY 'FLD0684B ==> ' HEX-OF (FLD0684B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0684B).
           IF FLD0685B (1:)    NOT EQUAL XPC-FLD0685B
              DISPLAY 'FLD0685B ==> ' HEX-OF (FLD0685B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0685B).
           IF FLD0686B (1:)    NOT EQUAL XPC-FLD0686B
              DISPLAY 'FLD0686B ==> ' HEX-OF (FLD0686B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0686B).
           IF FLD0687B (1:)    NOT EQUAL XPC-FLD0687B
              DISPLAY 'FLD0687B ==> ' HEX-OF (FLD0687B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0687B).
           IF FLD0688B (1:)    NOT EQUAL XPC-FLD0688B
              DISPLAY 'FLD0688B ==> ' HEX-OF (FLD0688B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0688B).
           IF FLD0689B (1:)    NOT EQUAL XPC-FLD0689B
              DISPLAY 'FLD0689B ==> ' HEX-OF (FLD0689B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0689B).
           IF FLD0690B (1:)    NOT EQUAL XPC-FLD0690B
              DISPLAY 'FLD0690B ==> ' HEX-OF (FLD0690B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0690B).
           IF FLD0691B (1:)    NOT EQUAL XPC-FLD0691B
              DISPLAY 'FLD0691B ==> ' HEX-OF (FLD0691B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0691B).
           IF FLD0692B (1:)    NOT EQUAL XPC-FLD0692B
              DISPLAY 'FLD0692B ==> ' HEX-OF (FLD0692B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0692B).
           IF FLD0693B (1:)    NOT EQUAL XPC-FLD0693B
              DISPLAY 'FLD0693B ==> ' HEX-OF (FLD0693B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0693B).
           IF FLD0694B (1:)    NOT EQUAL XPC-FLD0694B
              DISPLAY 'FLD0694B ==> ' HEX-OF (FLD0694B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0694B).
           IF FLD0695B (1:)    NOT EQUAL XPC-FLD0695B
              DISPLAY 'FLD0695B ==> ' HEX-OF (FLD0695B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0695B).
           IF FLD0696B (1:)    NOT EQUAL XPC-FLD0696B
              DISPLAY 'FLD0696B ==> ' HEX-OF (FLD0696B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0696B).
           IF FLD0697B (1:)    NOT EQUAL XPC-FLD0697B
              DISPLAY 'FLD0697B ==> ' HEX-OF (FLD0697B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0697B).
           IF FLD0698B (1:)    NOT EQUAL XPC-FLD0698B
              DISPLAY 'FLD0698B ==> ' HEX-OF (FLD0698B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0698B).
           IF FLD0699B (1:)    NOT EQUAL XPC-FLD0699B
              DISPLAY 'FLD0699B ==> ' HEX-OF (FLD0699B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0699B).
           IF FLD0700B (1:)    NOT EQUAL XPC-FLD0700B
              DISPLAY 'FLD0700B ==> ' HEX-OF (FLD0700B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0700B).
           IF FLD0701B (1:)    NOT EQUAL XPC-FLD0701B
              DISPLAY 'FLD0701B ==> ' HEX-OF (FLD0701B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0701B).
           IF FLD0702B (1:)    NOT EQUAL XPC-FLD0702B
              DISPLAY 'FLD0702B ==> ' HEX-OF (FLD0702B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0702B).
           IF FLD0703B (1:)    NOT EQUAL XPC-FLD0703B
              DISPLAY 'FLD0703B ==> ' HEX-OF (FLD0703B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0703B).
           IF FLD0704B (1:)    NOT EQUAL XPC-FLD0704B
              DISPLAY 'FLD0704B ==> ' HEX-OF (FLD0704B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0704B).
           IF FLD0705B (1:)    NOT EQUAL XPC-FLD0705B
              DISPLAY 'FLD0705B ==> ' HEX-OF (FLD0705B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0705B).
           IF FLD0706B (1:)    NOT EQUAL XPC-FLD0706B
              DISPLAY 'FLD0706B ==> ' HEX-OF (FLD0706B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0706B).
           IF FLD0707B (1:)    NOT EQUAL XPC-FLD0707B
              DISPLAY 'FLD0707B ==> ' HEX-OF (FLD0707B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0707B).
           IF FLD0708B (1:)    NOT EQUAL XPC-FLD0708B
              DISPLAY 'FLD0708B ==> ' HEX-OF (FLD0708B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0708B).
           IF FLD0709B (1:)    NOT EQUAL XPC-FLD0709B
              DISPLAY 'FLD0709B ==> ' HEX-OF (FLD0709B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0709B).
           IF FLD0710B (1:)    NOT EQUAL XPC-FLD0710B
              DISPLAY 'FLD0710B ==> ' HEX-OF (FLD0710B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0710B).
           IF FLD0711B (1:)    NOT EQUAL XPC-FLD0711B
              DISPLAY 'FLD0711B ==> ' HEX-OF (FLD0711B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0711B).
           IF FLD0712B (1:)    NOT EQUAL XPC-FLD0712B
              DISPLAY 'FLD0712B ==> ' HEX-OF (FLD0712B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0712B).
           IF FLD0713B (1:)    NOT EQUAL XPC-FLD0713B
              DISPLAY 'FLD0713B ==> ' HEX-OF (FLD0713B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0713B).
           IF FLD0714B (1:)    NOT EQUAL XPC-FLD0714B
              DISPLAY 'FLD0714B ==> ' HEX-OF (FLD0714B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0714B).
           IF FLD0715B (1:)    NOT EQUAL XPC-FLD0715B
              DISPLAY 'FLD0715B ==> ' HEX-OF (FLD0715B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0715B).
           IF FLD0716B (1:)    NOT EQUAL XPC-FLD0716B
              DISPLAY 'FLD0716B ==> ' HEX-OF (FLD0716B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0716B).
           IF FLD0717B (1:)    NOT EQUAL XPC-FLD0717B
              DISPLAY 'FLD0717B ==> ' HEX-OF (FLD0717B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0717B).
           IF FLD0718B (1:)    NOT EQUAL XPC-FLD0718B
              DISPLAY 'FLD0718B ==> ' HEX-OF (FLD0718B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0718B).
           IF FLD0719B (1:)    NOT EQUAL XPC-FLD0719B
              DISPLAY 'FLD0719B ==> ' HEX-OF (FLD0719B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0719B).
           IF FLD0720B (1:)    NOT EQUAL XPC-FLD0720B
              DISPLAY 'FLD0720B ==> ' HEX-OF (FLD0720B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0720B).
           IF FLD0721B (1:)    NOT EQUAL XPC-FLD0721B
              DISPLAY 'FLD0721B ==> ' HEX-OF (FLD0721B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0721B).
           IF FLD0722B (1:)    NOT EQUAL XPC-FLD0722B
              DISPLAY 'FLD0722B ==> ' HEX-OF (FLD0722B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0722B).
           IF FLD0723B (1:)    NOT EQUAL XPC-FLD0723B
              DISPLAY 'FLD0723B ==> ' HEX-OF (FLD0723B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0723B).
           IF FLD0724B (1:)    NOT EQUAL XPC-FLD0724B
              DISPLAY 'FLD0724B ==> ' HEX-OF (FLD0724B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0724B).
           IF FLD0725B (1:)    NOT EQUAL XPC-FLD0725B
              DISPLAY 'FLD0725B ==> ' HEX-OF (FLD0725B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0725B).
           IF FLD0726B (1:)    NOT EQUAL XPC-FLD0726B
              DISPLAY 'FLD0726B ==> ' HEX-OF (FLD0726B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0726B).
           IF FLD0727B (1:)    NOT EQUAL XPC-FLD0727B
              DISPLAY 'FLD0727B ==> ' HEX-OF (FLD0727B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0727B).
           IF FLD0728B (1:)    NOT EQUAL XPC-FLD0728B
              DISPLAY 'FLD0728B ==> ' HEX-OF (FLD0728B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0728B).
           IF FLD0729B (1:)    NOT EQUAL XPC-FLD0729B
              DISPLAY 'FLD0729B ==> ' HEX-OF (FLD0729B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0729B).
           IF FLD0730B (1:)    NOT EQUAL XPC-FLD0730B
              DISPLAY 'FLD0730B ==> ' HEX-OF (FLD0730B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0730B).
           IF FLD0731B (1:)    NOT EQUAL XPC-FLD0731B
              DISPLAY 'FLD0731B ==> ' HEX-OF (FLD0731B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0731B).
           IF FLD0732B (1:)    NOT EQUAL XPC-FLD0732B
              DISPLAY 'FLD0732B ==> ' HEX-OF (FLD0732B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0732B).
           IF FLD0733B (1:)    NOT EQUAL XPC-FLD0733B
              DISPLAY 'FLD0733B ==> ' HEX-OF (FLD0733B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0733B).
           IF FLD0734B (1:)    NOT EQUAL XPC-FLD0734B
              DISPLAY 'FLD0734B ==> ' HEX-OF (FLD0734B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0734B).
           IF FLD0735B (1:)    NOT EQUAL XPC-FLD0735B
              DISPLAY 'FLD0735B ==> ' HEX-OF (FLD0735B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0735B).
           IF FLD0736B (1:)    NOT EQUAL XPC-FLD0736B
              DISPLAY 'FLD0736B ==> ' HEX-OF (FLD0736B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0736B).
           IF FLD0737B (1:)    NOT EQUAL XPC-FLD0737B
              DISPLAY 'FLD0737B ==> ' HEX-OF (FLD0737B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0737B).
           IF FLD0738B (1:)    NOT EQUAL XPC-FLD0738B
              DISPLAY 'FLD0738B ==> ' HEX-OF (FLD0738B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0738B).
           IF FLD0739B (1:)    NOT EQUAL XPC-FLD0739B
              DISPLAY 'FLD0739B ==> ' HEX-OF (FLD0739B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0739B).
           IF FLD0740B (1:)    NOT EQUAL XPC-FLD0740B
              DISPLAY 'FLD0740B ==> ' HEX-OF (FLD0740B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0740B).
           IF FLD0741B (1:)    NOT EQUAL XPC-FLD0741B
              DISPLAY 'FLD0741B ==> ' HEX-OF (FLD0741B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0741B).
           IF FLD0742B (1:)    NOT EQUAL XPC-FLD0742B
              DISPLAY 'FLD0742B ==> ' HEX-OF (FLD0742B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0742B).
           IF FLD0743B (1:)    NOT EQUAL XPC-FLD0743B
              DISPLAY 'FLD0743B ==> ' HEX-OF (FLD0743B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0743B).
           IF FLD0744B (1:)    NOT EQUAL XPC-FLD0744B
              DISPLAY 'FLD0744B ==> ' HEX-OF (FLD0744B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0744B).
           IF FLD0745B (1:)    NOT EQUAL XPC-FLD0745B
              DISPLAY 'FLD0745B ==> ' HEX-OF (FLD0745B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0745B).
           IF FLD0746B (1:)    NOT EQUAL XPC-FLD0746B
              DISPLAY 'FLD0746B ==> ' HEX-OF (FLD0746B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0746B).
           IF FLD0747B (1:)    NOT EQUAL XPC-FLD0747B
              DISPLAY 'FLD0747B ==> ' HEX-OF (FLD0747B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0747B).
           IF FLD0748B (1:)    NOT EQUAL XPC-FLD0748B
              DISPLAY 'FLD0748B ==> ' HEX-OF (FLD0748B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0748B).
           IF FLD0749B (1:)    NOT EQUAL XPC-FLD0749B
              DISPLAY 'FLD0749B ==> ' HEX-OF (FLD0749B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0749B).
           IF FLD0750B (1:)    NOT EQUAL XPC-FLD0750B
              DISPLAY 'FLD0750B ==> ' HEX-OF (FLD0750B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0750B).
           IF FLD0751B (1:)    NOT EQUAL XPC-FLD0751B
              DISPLAY 'FLD0751B ==> ' HEX-OF (FLD0751B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0751B).
           IF FLD0752B (1:)    NOT EQUAL XPC-FLD0752B
              DISPLAY 'FLD0752B ==> ' HEX-OF (FLD0752B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0752B).
           IF FLD0753B (1:)    NOT EQUAL XPC-FLD0753B
              DISPLAY 'FLD0753B ==> ' HEX-OF (FLD0753B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0753B).
           IF FLD0754B (1:)    NOT EQUAL XPC-FLD0754B
              DISPLAY 'FLD0754B ==> ' HEX-OF (FLD0754B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0754B).
           IF FLD0755B (1:)    NOT EQUAL XPC-FLD0755B
              DISPLAY 'FLD0755B ==> ' HEX-OF (FLD0755B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0755B).
           IF FLD0756B (1:)    NOT EQUAL XPC-FLD0756B
              DISPLAY 'FLD0756B ==> ' HEX-OF (FLD0756B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0756B).
           IF FLD0757B (1:)    NOT EQUAL XPC-FLD0757B
              DISPLAY 'FLD0757B ==> ' HEX-OF (FLD0757B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0757B).
           IF FLD0758B (1:)    NOT EQUAL XPC-FLD0758B
              DISPLAY 'FLD0758B ==> ' HEX-OF (FLD0758B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0758B).
           IF FLD0759B (1:)    NOT EQUAL XPC-FLD0759B
              DISPLAY 'FLD0759B ==> ' HEX-OF (FLD0759B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0759B).
           IF FLD0760B (1:)    NOT EQUAL XPC-FLD0760B
              DISPLAY 'FLD0760B ==> ' HEX-OF (FLD0760B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0760B).
           IF FLD0761B (1:)    NOT EQUAL XPC-FLD0761B
              DISPLAY 'FLD0761B ==> ' HEX-OF (FLD0761B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0761B).
           IF FLD0762B (1:)    NOT EQUAL XPC-FLD0762B
              DISPLAY 'FLD0762B ==> ' HEX-OF (FLD0762B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0762B).
           IF FLD0763B (1:)    NOT EQUAL XPC-FLD0763B
              DISPLAY 'FLD0763B ==> ' HEX-OF (FLD0763B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0763B).
           IF FLD0764B (1:)    NOT EQUAL XPC-FLD0764B
              DISPLAY 'FLD0764B ==> ' HEX-OF (FLD0764B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0764B).
           IF FLD0765B (1:)    NOT EQUAL XPC-FLD0765B
              DISPLAY 'FLD0765B ==> ' HEX-OF (FLD0765B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0765B).
           IF FLD0766B (1:)    NOT EQUAL XPC-FLD0766B
              DISPLAY 'FLD0766B ==> ' HEX-OF (FLD0766B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0766B).
           IF FLD0767B (1:)    NOT EQUAL XPC-FLD0767B
              DISPLAY 'FLD0767B ==> ' HEX-OF (FLD0767B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0767B).
           IF FLD0768B (1:)    NOT EQUAL XPC-FLD0768B
              DISPLAY 'FLD0768B ==> ' HEX-OF (FLD0768B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0768B).
           IF FLD0769B (1:)    NOT EQUAL XPC-FLD0769B
              DISPLAY 'FLD0769B ==> ' HEX-OF (FLD0769B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0769B).
           IF FLD0770B (1:)    NOT EQUAL XPC-FLD0770B
              DISPLAY 'FLD0770B ==> ' HEX-OF (FLD0770B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0770B).
           IF FLD0771B (1:)    NOT EQUAL XPC-FLD0771B
              DISPLAY 'FLD0771B ==> ' HEX-OF (FLD0771B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0771B).
           IF FLD0772B (1:)    NOT EQUAL XPC-FLD0772B
              DISPLAY 'FLD0772B ==> ' HEX-OF (FLD0772B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0772B).
           IF FLD0773B (1:)    NOT EQUAL XPC-FLD0773B
              DISPLAY 'FLD0773B ==> ' HEX-OF (FLD0773B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0773B).
           IF FLD0774B (1:)    NOT EQUAL XPC-FLD0774B
              DISPLAY 'FLD0774B ==> ' HEX-OF (FLD0774B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0774B).
           IF FLD0775B (1:)    NOT EQUAL XPC-FLD0775B
              DISPLAY 'FLD0775B ==> ' HEX-OF (FLD0775B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0775B).
           IF FLD0776B (1:)    NOT EQUAL XPC-FLD0776B
              DISPLAY 'FLD0776B ==> ' HEX-OF (FLD0776B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0776B).
           IF FLD0777B (1:)    NOT EQUAL XPC-FLD0777B
              DISPLAY 'FLD0777B ==> ' HEX-OF (FLD0777B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0777B).
           IF FLD0778B (1:)    NOT EQUAL XPC-FLD0778B
              DISPLAY 'FLD0778B ==> ' HEX-OF (FLD0778B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0778B).
           IF FLD0779B (1:)    NOT EQUAL XPC-FLD0779B
              DISPLAY 'FLD0779B ==> ' HEX-OF (FLD0779B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0779B).
           IF FLD0780B (1:)    NOT EQUAL XPC-FLD0780B
              DISPLAY 'FLD0780B ==> ' HEX-OF (FLD0780B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0780B).
           IF FLD0781B (1:)    NOT EQUAL XPC-FLD0781B
              DISPLAY 'FLD0781B ==> ' HEX-OF (FLD0781B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0781B).
           IF FLD0782B (1:)    NOT EQUAL XPC-FLD0782B
              DISPLAY 'FLD0782B ==> ' HEX-OF (FLD0782B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0782B).
           IF FLD0783B (1:)    NOT EQUAL XPC-FLD0783B
              DISPLAY 'FLD0783B ==> ' HEX-OF (FLD0783B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0783B).
           IF FLD0784B (1:)    NOT EQUAL XPC-FLD0784B
              DISPLAY 'FLD0784B ==> ' HEX-OF (FLD0784B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0784B).
           IF FLD0785B (1:)    NOT EQUAL XPC-FLD0785B
              DISPLAY 'FLD0785B ==> ' HEX-OF (FLD0785B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0785B).
           IF FLD0786B (1:)    NOT EQUAL XPC-FLD0786B
              DISPLAY 'FLD0786B ==> ' HEX-OF (FLD0786B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0786B).
           IF FLD0787B (1:)    NOT EQUAL XPC-FLD0787B
              DISPLAY 'FLD0787B ==> ' HEX-OF (FLD0787B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0787B).
           IF FLD0788B (1:)    NOT EQUAL XPC-FLD0788B
              DISPLAY 'FLD0788B ==> ' HEX-OF (FLD0788B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0788B).
           IF FLD0789B (1:)    NOT EQUAL XPC-FLD0789B
              DISPLAY 'FLD0789B ==> ' HEX-OF (FLD0789B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0789B).
           IF FLD0790B (1:)    NOT EQUAL XPC-FLD0790B
              DISPLAY 'FLD0790B ==> ' HEX-OF (FLD0790B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0790B).
           IF FLD0791B (1:)    NOT EQUAL XPC-FLD0791B
              DISPLAY 'FLD0791B ==> ' HEX-OF (FLD0791B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0791B).
           IF FLD0792B (1:)    NOT EQUAL XPC-FLD0792B
              DISPLAY 'FLD0792B ==> ' HEX-OF (FLD0792B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0792B).
           IF FLD0793B (1:)    NOT EQUAL XPC-FLD0793B
              DISPLAY 'FLD0793B ==> ' HEX-OF (FLD0793B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0793B).
           IF FLD0794B (1:)    NOT EQUAL XPC-FLD0794B
              DISPLAY 'FLD0794B ==> ' HEX-OF (FLD0794B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0794B).
           IF FLD0795B (1:)    NOT EQUAL XPC-FLD0795B
              DISPLAY 'FLD0795B ==> ' HEX-OF (FLD0795B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0795B).
           IF FLD0796B (1:)    NOT EQUAL XPC-FLD0796B
              DISPLAY 'FLD0796B ==> ' HEX-OF (FLD0796B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0796B).
           IF FLD0797B (1:)    NOT EQUAL XPC-FLD0797B
              DISPLAY 'FLD0797B ==> ' HEX-OF (FLD0797B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0797B).
           IF FLD0798B (1:)    NOT EQUAL XPC-FLD0798B
              DISPLAY 'FLD0798B ==> ' HEX-OF (FLD0798B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0798B).
           IF FLD0799B (1:)    NOT EQUAL XPC-FLD0799B
              DISPLAY 'FLD0799B ==> ' HEX-OF (FLD0799B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0799B).
           IF FLD0800B (1:)    NOT EQUAL XPC-FLD0800B
              DISPLAY 'FLD0800B ==> ' HEX-OF (FLD0800B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0800B).
           IF FLD0801B (1:)    NOT EQUAL XPC-FLD0801B
              DISPLAY 'FLD0801B ==> ' HEX-OF (FLD0801B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0801B).
           IF FLD0802B (1:)    NOT EQUAL XPC-FLD0802B
              DISPLAY 'FLD0802B ==> ' HEX-OF (FLD0802B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0802B).
           IF FLD0803B (1:)    NOT EQUAL XPC-FLD0803B
              DISPLAY 'FLD0803B ==> ' HEX-OF (FLD0803B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0803B).
           IF FLD0804B (1:)    NOT EQUAL XPC-FLD0804B
              DISPLAY 'FLD0804B ==> ' HEX-OF (FLD0804B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0804B).
           IF FLD0805B (1:)    NOT EQUAL XPC-FLD0805B
              DISPLAY 'FLD0805B ==> ' HEX-OF (FLD0805B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0805B).
           IF FLD0806B (1:)    NOT EQUAL XPC-FLD0806B
              DISPLAY 'FLD0806B ==> ' HEX-OF (FLD0806B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0806B).
           IF FLD0807B (1:)    NOT EQUAL XPC-FLD0807B
              DISPLAY 'FLD0807B ==> ' HEX-OF (FLD0807B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0807B).
           IF FLD0808B (1:)    NOT EQUAL XPC-FLD0808B
              DISPLAY 'FLD0808B ==> ' HEX-OF (FLD0808B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0808B).
           IF FLD0809B (1:)    NOT EQUAL XPC-FLD0809B
              DISPLAY 'FLD0809B ==> ' HEX-OF (FLD0809B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0809B).
           IF FLD0810B (1:)    NOT EQUAL XPC-FLD0810B
              DISPLAY 'FLD0810B ==> ' HEX-OF (FLD0810B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0810B).
           IF FLD0811B (1:)    NOT EQUAL XPC-FLD0811B
              DISPLAY 'FLD0811B ==> ' HEX-OF (FLD0811B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0811B).
           IF FLD0812B (1:)    NOT EQUAL XPC-FLD0812B
              DISPLAY 'FLD0812B ==> ' HEX-OF (FLD0812B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0812B).
           IF FLD0813B (1:)    NOT EQUAL XPC-FLD0813B
              DISPLAY 'FLD0813B ==> ' HEX-OF (FLD0813B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0813B).
           IF FLD0814B (1:)    NOT EQUAL XPC-FLD0814B
              DISPLAY 'FLD0814B ==> ' HEX-OF (FLD0814B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0814B).
           IF FLD0815B (1:)    NOT EQUAL XPC-FLD0815B
              DISPLAY 'FLD0815B ==> ' HEX-OF (FLD0815B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0815B).
           IF FLD0816B (1:)    NOT EQUAL XPC-FLD0816B
              DISPLAY 'FLD0816B ==> ' HEX-OF (FLD0816B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0816B).
           IF FLD0817B (1:)    NOT EQUAL XPC-FLD0817B
              DISPLAY 'FLD0817B ==> ' HEX-OF (FLD0817B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0817B).
           IF FLD0818B (1:)    NOT EQUAL XPC-FLD0818B
              DISPLAY 'FLD0818B ==> ' HEX-OF (FLD0818B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0818B).
           IF FLD0819B (1:)    NOT EQUAL XPC-FLD0819B
              DISPLAY 'FLD0819B ==> ' HEX-OF (FLD0819B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0819B).
           IF FLD0820B (1:)    NOT EQUAL XPC-FLD0820B
              DISPLAY 'FLD0820B ==> ' HEX-OF (FLD0820B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0820B).
           IF FLD0821B (1:)    NOT EQUAL XPC-FLD0821B
              DISPLAY 'FLD0821B ==> ' HEX-OF (FLD0821B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0821B).
           IF FLD0822B (1:)    NOT EQUAL XPC-FLD0822B
              DISPLAY 'FLD0822B ==> ' HEX-OF (FLD0822B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0822B).
           IF FLD0823B (1:)    NOT EQUAL XPC-FLD0823B
              DISPLAY 'FLD0823B ==> ' HEX-OF (FLD0823B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0823B).
           IF FLD0824B (1:)    NOT EQUAL XPC-FLD0824B
              DISPLAY 'FLD0824B ==> ' HEX-OF (FLD0824B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0824B).
           IF FLD0825B (1:)    NOT EQUAL XPC-FLD0825B
              DISPLAY 'FLD0825B ==> ' HEX-OF (FLD0825B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0825B).
           IF FLD0826B (1:)    NOT EQUAL XPC-FLD0826B
              DISPLAY 'FLD0826B ==> ' HEX-OF (FLD0826B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0826B).
           IF FLD0827B (1:)    NOT EQUAL XPC-FLD0827B
              DISPLAY 'FLD0827B ==> ' HEX-OF (FLD0827B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0827B).
           IF FLD0828B (1:)    NOT EQUAL XPC-FLD0828B
              DISPLAY 'FLD0828B ==> ' HEX-OF (FLD0828B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0828B).
           IF FLD0829B (1:)    NOT EQUAL XPC-FLD0829B
              DISPLAY 'FLD0829B ==> ' HEX-OF (FLD0829B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0829B).
           IF FLD0830B (1:)    NOT EQUAL XPC-FLD0830B
              DISPLAY 'FLD0830B ==> ' HEX-OF (FLD0830B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0830B).
           IF FLD0831B (1:)    NOT EQUAL XPC-FLD0831B
              DISPLAY 'FLD0831B ==> ' HEX-OF (FLD0831B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0831B).
           IF FLD0832B (1:)    NOT EQUAL XPC-FLD0832B
              DISPLAY 'FLD0832B ==> ' HEX-OF (FLD0832B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0832B).
           IF FLD0833B (1:)    NOT EQUAL XPC-FLD0833B
              DISPLAY 'FLD0833B ==> ' HEX-OF (FLD0833B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0833B).
           IF FLD0834B (1:)    NOT EQUAL XPC-FLD0834B
              DISPLAY 'FLD0834B ==> ' HEX-OF (FLD0834B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0834B).
           IF FLD0835B (1:)    NOT EQUAL XPC-FLD0835B
              DISPLAY 'FLD0835B ==> ' HEX-OF (FLD0835B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0835B).
           IF FLD0836B (1:)    NOT EQUAL XPC-FLD0836B
              DISPLAY 'FLD0836B ==> ' HEX-OF (FLD0836B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0836B).
           IF FLD0837B (1:)    NOT EQUAL XPC-FLD0837B
              DISPLAY 'FLD0837B ==> ' HEX-OF (FLD0837B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0837B).
           IF FLD0838B (1:)    NOT EQUAL XPC-FLD0838B
              DISPLAY 'FLD0838B ==> ' HEX-OF (FLD0838B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0838B).
           IF FLD0839B (1:)    NOT EQUAL XPC-FLD0839B
              DISPLAY 'FLD0839B ==> ' HEX-OF (FLD0839B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0839B).
           IF FLD0840B (1:)    NOT EQUAL XPC-FLD0840B
              DISPLAY 'FLD0840B ==> ' HEX-OF (FLD0840B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0840B).
           IF FLD0841B (1:)    NOT EQUAL XPC-FLD0841B
              DISPLAY 'FLD0841B ==> ' HEX-OF (FLD0841B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0841B).
           IF FLD0842B (1:)    NOT EQUAL XPC-FLD0842B
              DISPLAY 'FLD0842B ==> ' HEX-OF (FLD0842B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0842B).
           IF FLD0843B (1:)    NOT EQUAL XPC-FLD0843B
              DISPLAY 'FLD0843B ==> ' HEX-OF (FLD0843B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0843B).
           IF FLD0844B (1:)    NOT EQUAL XPC-FLD0844B
              DISPLAY 'FLD0844B ==> ' HEX-OF (FLD0844B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0844B).
           IF FLD0845B (1:)    NOT EQUAL XPC-FLD0845B
              DISPLAY 'FLD0845B ==> ' HEX-OF (FLD0845B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0845B).
           IF FLD0846B (1:)    NOT EQUAL XPC-FLD0846B
              DISPLAY 'FLD0846B ==> ' HEX-OF (FLD0846B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0846B).
           IF FLD0847B (1:)    NOT EQUAL XPC-FLD0847B
              DISPLAY 'FLD0847B ==> ' HEX-OF (FLD0847B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0847B).
           IF FLD0848B (1:)    NOT EQUAL XPC-FLD0848B
              DISPLAY 'FLD0848B ==> ' HEX-OF (FLD0848B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0848B).
           IF FLD0849B (1:)    NOT EQUAL XPC-FLD0849B
              DISPLAY 'FLD0849B ==> ' HEX-OF (FLD0849B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0849B).
           IF FLD0850B (1:)    NOT EQUAL XPC-FLD0850B
              DISPLAY 'FLD0850B ==> ' HEX-OF (FLD0850B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0850B).
           IF FLD0851B (1:)    NOT EQUAL XPC-FLD0851B
              DISPLAY 'FLD0851B ==> ' HEX-OF (FLD0851B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0851B).
           IF FLD0852B (1:)    NOT EQUAL XPC-FLD0852B
              DISPLAY 'FLD0852B ==> ' HEX-OF (FLD0852B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0852B).
           IF FLD0853B (1:)    NOT EQUAL XPC-FLD0853B
              DISPLAY 'FLD0853B ==> ' HEX-OF (FLD0853B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0853B).
           IF FLD0854B (1:)    NOT EQUAL XPC-FLD0854B
              DISPLAY 'FLD0854B ==> ' HEX-OF (FLD0854B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0854B).
           IF FLD0855B (1:)    NOT EQUAL XPC-FLD0855B
              DISPLAY 'FLD0855B ==> ' HEX-OF (FLD0855B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0855B).
           IF FLD0856B (1:)    NOT EQUAL XPC-FLD0856B
              DISPLAY 'FLD0856B ==> ' HEX-OF (FLD0856B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0856B).
           IF FLD0857B (1:)    NOT EQUAL XPC-FLD0857B
              DISPLAY 'FLD0857B ==> ' HEX-OF (FLD0857B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0857B).
           IF FLD0858B (1:)    NOT EQUAL XPC-FLD0858B
              DISPLAY 'FLD0858B ==> ' HEX-OF (FLD0858B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0858B).
           IF FLD0859B (1:)    NOT EQUAL XPC-FLD0859B
              DISPLAY 'FLD0859B ==> ' HEX-OF (FLD0859B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0859B).
           IF FLD0860B (1:)    NOT EQUAL XPC-FLD0860B
              DISPLAY 'FLD0860B ==> ' HEX-OF (FLD0860B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0860B).
           IF FLD0861B (1:)    NOT EQUAL XPC-FLD0861B
              DISPLAY 'FLD0861B ==> ' HEX-OF (FLD0861B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0861B).
           IF FLD0862B (1:)    NOT EQUAL XPC-FLD0862B
              DISPLAY 'FLD0862B ==> ' HEX-OF (FLD0862B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0862B).
           IF FLD0863B (1:)    NOT EQUAL XPC-FLD0863B
              DISPLAY 'FLD0863B ==> ' HEX-OF (FLD0863B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0863B).
           IF FLD0864B (1:)    NOT EQUAL XPC-FLD0864B
              DISPLAY 'FLD0864B ==> ' HEX-OF (FLD0864B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0864B).
           IF FLD0865B (1:)    NOT EQUAL XPC-FLD0865B
              DISPLAY 'FLD0865B ==> ' HEX-OF (FLD0865B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0865B).
           IF FLD0866B (1:)    NOT EQUAL XPC-FLD0866B
              DISPLAY 'FLD0866B ==> ' HEX-OF (FLD0866B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0866B).
           IF FLD0867B (1:)    NOT EQUAL XPC-FLD0867B
              DISPLAY 'FLD0867B ==> ' HEX-OF (FLD0867B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0867B).
           IF FLD0868B (1:)    NOT EQUAL XPC-FLD0868B
              DISPLAY 'FLD0868B ==> ' HEX-OF (FLD0868B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0868B).
           IF FLD0869B (1:)    NOT EQUAL XPC-FLD0869B
              DISPLAY 'FLD0869B ==> ' HEX-OF (FLD0869B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0869B).
           IF FLD0870B (1:)    NOT EQUAL XPC-FLD0870B
              DISPLAY 'FLD0870B ==> ' HEX-OF (FLD0870B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0870B).
           IF FLD0871B (1:)    NOT EQUAL XPC-FLD0871B
              DISPLAY 'FLD0871B ==> ' HEX-OF (FLD0871B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0871B).
           IF FLD0872B (1:)    NOT EQUAL XPC-FLD0872B
              DISPLAY 'FLD0872B ==> ' HEX-OF (FLD0872B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0872B).
           IF FLD0873B (1:)    NOT EQUAL XPC-FLD0873B
              DISPLAY 'FLD0873B ==> ' HEX-OF (FLD0873B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0873B).
           IF FLD0874B (1:)    NOT EQUAL XPC-FLD0874B
              DISPLAY 'FLD0874B ==> ' HEX-OF (FLD0874B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0874B).
           IF FLD0875B (1:)    NOT EQUAL XPC-FLD0875B
              DISPLAY 'FLD0875B ==> ' HEX-OF (FLD0875B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0875B).
           IF FLD0876B (1:)    NOT EQUAL XPC-FLD0876B
              DISPLAY 'FLD0876B ==> ' HEX-OF (FLD0876B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0876B).
           IF FLD0877B (1:)    NOT EQUAL XPC-FLD0877B
              DISPLAY 'FLD0877B ==> ' HEX-OF (FLD0877B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0877B).
           IF FLD0878B (1:)    NOT EQUAL XPC-FLD0878B
              DISPLAY 'FLD0878B ==> ' HEX-OF (FLD0878B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0878B).
           IF FLD0879B (1:)    NOT EQUAL XPC-FLD0879B
              DISPLAY 'FLD0879B ==> ' HEX-OF (FLD0879B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0879B).
           IF FLD0880B (1:)    NOT EQUAL XPC-FLD0880B
              DISPLAY 'FLD0880B ==> ' HEX-OF (FLD0880B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0880B).
           IF FLD0881B (1:)    NOT EQUAL XPC-FLD0881B
              DISPLAY 'FLD0881B ==> ' HEX-OF (FLD0881B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0881B).
           IF FLD0882B (1:)    NOT EQUAL XPC-FLD0882B
              DISPLAY 'FLD0882B ==> ' HEX-OF (FLD0882B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0882B).
           IF FLD0883B (1:)    NOT EQUAL XPC-FLD0883B
              DISPLAY 'FLD0883B ==> ' HEX-OF (FLD0883B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0883B).
           IF FLD0884B (1:)    NOT EQUAL XPC-FLD0884B
              DISPLAY 'FLD0884B ==> ' HEX-OF (FLD0884B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0884B).
           IF FLD0885B (1:)    NOT EQUAL XPC-FLD0885B
              DISPLAY 'FLD0885B ==> ' HEX-OF (FLD0885B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0885B).
           IF FLD0886B (1:)    NOT EQUAL XPC-FLD0886B
              DISPLAY 'FLD0886B ==> ' HEX-OF (FLD0886B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0886B).
           IF FLD0887B (1:)    NOT EQUAL XPC-FLD0887B
              DISPLAY 'FLD0887B ==> ' HEX-OF (FLD0887B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0887B).
           IF FLD0888B (1:)    NOT EQUAL XPC-FLD0888B
              DISPLAY 'FLD0888B ==> ' HEX-OF (FLD0888B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0888B).
           IF FLD0889B (1:)    NOT EQUAL XPC-FLD0889B
              DISPLAY 'FLD0889B ==> ' HEX-OF (FLD0889B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0889B).
           IF FLD0890B (1:)    NOT EQUAL XPC-FLD0890B
              DISPLAY 'FLD0890B ==> ' HEX-OF (FLD0890B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0890B).
           IF FLD0891B (1:)    NOT EQUAL XPC-FLD0891B
              DISPLAY 'FLD0891B ==> ' HEX-OF (FLD0891B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0891B).
           IF FLD0892B (1:)    NOT EQUAL XPC-FLD0892B
              DISPLAY 'FLD0892B ==> ' HEX-OF (FLD0892B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0892B).
           IF FLD0893B (1:)    NOT EQUAL XPC-FLD0893B
              DISPLAY 'FLD0893B ==> ' HEX-OF (FLD0893B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0893B).
           IF FLD0894B (1:)    NOT EQUAL XPC-FLD0894B
              DISPLAY 'FLD0894B ==> ' HEX-OF (FLD0894B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0894B).
           IF FLD0895B (1:)    NOT EQUAL XPC-FLD0895B
              DISPLAY 'FLD0895B ==> ' HEX-OF (FLD0895B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0895B).
           IF FLD0896B (1:)    NOT EQUAL XPC-FLD0896B
              DISPLAY 'FLD0896B ==> ' HEX-OF (FLD0896B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0896B).
           IF FLD0897B (1:)    NOT EQUAL XPC-FLD0897B
              DISPLAY 'FLD0897B ==> ' HEX-OF (FLD0897B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0897B).
           IF FLD0898B (1:)    NOT EQUAL XPC-FLD0898B
              DISPLAY 'FLD0898B ==> ' HEX-OF (FLD0898B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0898B).
           IF FLD0899B (1:)    NOT EQUAL XPC-FLD0899B
              DISPLAY 'FLD0899B ==> ' HEX-OF (FLD0899B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0899B).
           IF FLD0900B (1:)    NOT EQUAL XPC-FLD0900B
              DISPLAY 'FLD0900B ==> ' HEX-OF (FLD0900B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0900B).
           IF FLD0901B (1:)    NOT EQUAL XPC-FLD0901B
              DISPLAY 'FLD0901B ==> ' HEX-OF (FLD0901B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0901B).
           IF FLD0902B (1:)    NOT EQUAL XPC-FLD0902B
              DISPLAY 'FLD0902B ==> ' HEX-OF (FLD0902B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0902B).
           IF FLD0903B (1:)    NOT EQUAL XPC-FLD0903B
              DISPLAY 'FLD0903B ==> ' HEX-OF (FLD0903B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0903B).
           IF FLD0904B (1:)    NOT EQUAL XPC-FLD0904B
              DISPLAY 'FLD0904B ==> ' HEX-OF (FLD0904B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0904B).
           IF FLD0905B (1:)    NOT EQUAL XPC-FLD0905B
              DISPLAY 'FLD0905B ==> ' HEX-OF (FLD0905B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0905B).
           IF FLD0906B (1:)    NOT EQUAL XPC-FLD0906B
              DISPLAY 'FLD0906B ==> ' HEX-OF (FLD0906B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0906B).
           IF FLD0907B (1:)    NOT EQUAL XPC-FLD0907B
              DISPLAY 'FLD0907B ==> ' HEX-OF (FLD0907B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0907B).
           IF FLD0908B (1:)    NOT EQUAL XPC-FLD0908B
              DISPLAY 'FLD0908B ==> ' HEX-OF (FLD0908B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0908B).
           IF FLD0909B (1:)    NOT EQUAL XPC-FLD0909B
              DISPLAY 'FLD0909B ==> ' HEX-OF (FLD0909B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0909B).
           IF FLD0910B (1:)    NOT EQUAL XPC-FLD0910B
              DISPLAY 'FLD0910B ==> ' HEX-OF (FLD0910B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0910B).
           IF FLD0911B (1:)    NOT EQUAL XPC-FLD0911B
              DISPLAY 'FLD0911B ==> ' HEX-OF (FLD0911B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0911B).
           IF FLD0912B (1:)    NOT EQUAL XPC-FLD0912B
              DISPLAY 'FLD0912B ==> ' HEX-OF (FLD0912B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0912B).
           IF FLD0913B (1:)    NOT EQUAL XPC-FLD0913B
              DISPLAY 'FLD0913B ==> ' HEX-OF (FLD0913B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0913B).
           IF FLD0914B (1:)    NOT EQUAL XPC-FLD0914B
              DISPLAY 'FLD0914B ==> ' HEX-OF (FLD0914B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0914B).
           IF FLD0915B (1:)    NOT EQUAL XPC-FLD0915B
              DISPLAY 'FLD0915B ==> ' HEX-OF (FLD0915B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0915B).
           IF FLD0916B (1:)    NOT EQUAL XPC-FLD0916B
              DISPLAY 'FLD0916B ==> ' HEX-OF (FLD0916B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0916B).
           IF FLD0917B (1:)    NOT EQUAL XPC-FLD0917B
              DISPLAY 'FLD0917B ==> ' HEX-OF (FLD0917B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0917B).
           IF FLD0918B (1:)    NOT EQUAL XPC-FLD0918B
              DISPLAY 'FLD0918B ==> ' HEX-OF (FLD0918B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0918B).
           IF FLD0919B (1:)    NOT EQUAL XPC-FLD0919B
              DISPLAY 'FLD0919B ==> ' HEX-OF (FLD0919B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0919B).
           IF FLD0920B (1:)    NOT EQUAL XPC-FLD0920B
              DISPLAY 'FLD0920B ==> ' HEX-OF (FLD0920B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0920B).
           IF FLD0921B (1:)    NOT EQUAL XPC-FLD0921B
              DISPLAY 'FLD0921B ==> ' HEX-OF (FLD0921B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0921B).
           IF FLD0922B (1:)    NOT EQUAL XPC-FLD0922B
              DISPLAY 'FLD0922B ==> ' HEX-OF (FLD0922B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0922B).
           IF FLD0923B (1:)    NOT EQUAL XPC-FLD0923B
              DISPLAY 'FLD0923B ==> ' HEX-OF (FLD0923B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0923B).
           IF FLD0924B (1:)    NOT EQUAL XPC-FLD0924B
              DISPLAY 'FLD0924B ==> ' HEX-OF (FLD0924B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0924B).
           IF FLD0925B (1:)    NOT EQUAL XPC-FLD0925B
              DISPLAY 'FLD0925B ==> ' HEX-OF (FLD0925B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0925B).
           IF FLD0926B (1:)    NOT EQUAL XPC-FLD0926B
              DISPLAY 'FLD0926B ==> ' HEX-OF (FLD0926B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0926B).
           IF FLD0927B (1:)    NOT EQUAL XPC-FLD0927B
              DISPLAY 'FLD0927B ==> ' HEX-OF (FLD0927B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0927B).
           IF FLD0928B (1:)    NOT EQUAL XPC-FLD0928B
              DISPLAY 'FLD0928B ==> ' HEX-OF (FLD0928B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0928B).
           IF FLD0929B (1:)    NOT EQUAL XPC-FLD0929B
              DISPLAY 'FLD0929B ==> ' HEX-OF (FLD0929B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0929B).
           IF FLD0930B (1:)    NOT EQUAL XPC-FLD0930B
              DISPLAY 'FLD0930B ==> ' HEX-OF (FLD0930B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0930B).
           IF FLD0931B (1:)    NOT EQUAL XPC-FLD0931B
              DISPLAY 'FLD0931B ==> ' HEX-OF (FLD0931B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0931B).
           IF FLD0932B (1:)    NOT EQUAL XPC-FLD0932B
              DISPLAY 'FLD0932B ==> ' HEX-OF (FLD0932B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0932B).
           IF FLD0933B (1:)    NOT EQUAL XPC-FLD0933B
              DISPLAY 'FLD0933B ==> ' HEX-OF (FLD0933B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0933B).
           IF FLD0934B (1:)    NOT EQUAL XPC-FLD0934B
              DISPLAY 'FLD0934B ==> ' HEX-OF (FLD0934B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0934B).
           IF FLD0935B (1:)    NOT EQUAL XPC-FLD0935B
              DISPLAY 'FLD0935B ==> ' HEX-OF (FLD0935B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0935B).
           IF FLD0936B (1:)    NOT EQUAL XPC-FLD0936B
              DISPLAY 'FLD0936B ==> ' HEX-OF (FLD0936B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0936B).
           IF FLD0937B (1:)    NOT EQUAL XPC-FLD0937B
              DISPLAY 'FLD0937B ==> ' HEX-OF (FLD0937B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0937B).
           IF FLD0938B (1:)    NOT EQUAL XPC-FLD0938B
              DISPLAY 'FLD0938B ==> ' HEX-OF (FLD0938B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0938B).
           IF FLD0939B (1:)    NOT EQUAL XPC-FLD0939B
              DISPLAY 'FLD0939B ==> ' HEX-OF (FLD0939B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0939B).
           IF FLD0940B (1:)    NOT EQUAL XPC-FLD0940B
              DISPLAY 'FLD0940B ==> ' HEX-OF (FLD0940B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0940B).
           IF FLD0941B (1:)    NOT EQUAL XPC-FLD0941B
              DISPLAY 'FLD0941B ==> ' HEX-OF (FLD0941B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0941B).
           IF FLD0942B (1:)    NOT EQUAL XPC-FLD0942B
              DISPLAY 'FLD0942B ==> ' HEX-OF (FLD0942B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0942B).
           IF FLD0943B (1:)    NOT EQUAL XPC-FLD0943B
              DISPLAY 'FLD0943B ==> ' HEX-OF (FLD0943B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0943B).
           IF FLD0944B (1:)    NOT EQUAL XPC-FLD0944B
              DISPLAY 'FLD0944B ==> ' HEX-OF (FLD0944B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0944B).
           IF FLD0945B (1:)    NOT EQUAL XPC-FLD0945B
              DISPLAY 'FLD0945B ==> ' HEX-OF (FLD0945B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0945B).
           IF FLD0946B (1:)    NOT EQUAL XPC-FLD0946B
              DISPLAY 'FLD0946B ==> ' HEX-OF (FLD0946B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0946B).
           IF FLD0947B (1:)    NOT EQUAL XPC-FLD0947B
              DISPLAY 'FLD0947B ==> ' HEX-OF (FLD0947B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0947B).
           IF FLD0948B (1:)    NOT EQUAL XPC-FLD0948B
              DISPLAY 'FLD0948B ==> ' HEX-OF (FLD0948B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0948B).
           IF FLD0949B (1:)    NOT EQUAL XPC-FLD0949B
              DISPLAY 'FLD0949B ==> ' HEX-OF (FLD0949B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0949B).
           IF FLD0950B (1:)    NOT EQUAL XPC-FLD0950B
              DISPLAY 'FLD0950B ==> ' HEX-OF (FLD0950B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0950B).
           IF FLD0951B (1:)    NOT EQUAL XPC-FLD0951B
              DISPLAY 'FLD0951B ==> ' HEX-OF (FLD0951B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0951B).
           IF FLD0952B (1:)    NOT EQUAL XPC-FLD0952B
              DISPLAY 'FLD0952B ==> ' HEX-OF (FLD0952B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0952B).
           IF FLD0953B (1:)    NOT EQUAL XPC-FLD0953B
              DISPLAY 'FLD0953B ==> ' HEX-OF (FLD0953B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0953B).
           IF FLD0954B (1:)    NOT EQUAL XPC-FLD0954B
              DISPLAY 'FLD0954B ==> ' HEX-OF (FLD0954B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0954B).
           IF FLD0955B (1:)    NOT EQUAL XPC-FLD0955B
              DISPLAY 'FLD0955B ==> ' HEX-OF (FLD0955B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0955B).
           IF FLD0956B (1:)    NOT EQUAL XPC-FLD0956B
              DISPLAY 'FLD0956B ==> ' HEX-OF (FLD0956B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0956B).
           IF FLD0957B (1:)    NOT EQUAL XPC-FLD0957B
              DISPLAY 'FLD0957B ==> ' HEX-OF (FLD0957B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0957B).
           IF FLD0958B (1:)    NOT EQUAL XPC-FLD0958B
              DISPLAY 'FLD0958B ==> ' HEX-OF (FLD0958B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0958B).
           IF FLD0959B (1:)    NOT EQUAL XPC-FLD0959B
              DISPLAY 'FLD0959B ==> ' HEX-OF (FLD0959B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0959B).
           IF FLD0960B (1:)    NOT EQUAL XPC-FLD0960B
              DISPLAY 'FLD0960B ==> ' HEX-OF (FLD0960B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0960B).
           IF FLD0961B (1:)    NOT EQUAL XPC-FLD0961B
              DISPLAY 'FLD0961B ==> ' HEX-OF (FLD0961B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0961B).
           IF FLD0962B (1:)    NOT EQUAL XPC-FLD0962B
              DISPLAY 'FLD0962B ==> ' HEX-OF (FLD0962B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0962B).
           IF FLD0963B (1:)    NOT EQUAL XPC-FLD0963B
              DISPLAY 'FLD0963B ==> ' HEX-OF (FLD0963B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0963B).
           IF FLD0964B (1:)    NOT EQUAL XPC-FLD0964B
              DISPLAY 'FLD0964B ==> ' HEX-OF (FLD0964B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0964B).
           IF FLD0965B (1:)    NOT EQUAL XPC-FLD0965B
              DISPLAY 'FLD0965B ==> ' HEX-OF (FLD0965B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0965B).
           IF FLD0966B (1:)    NOT EQUAL XPC-FLD0966B
              DISPLAY 'FLD0966B ==> ' HEX-OF (FLD0966B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0966B).
           IF FLD0967B (1:)    NOT EQUAL XPC-FLD0967B
              DISPLAY 'FLD0967B ==> ' HEX-OF (FLD0967B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0967B).
           IF FLD0968B (1:)    NOT EQUAL XPC-FLD0968B
              DISPLAY 'FLD0968B ==> ' HEX-OF (FLD0968B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0968B).
           IF FLD0969B (1:)    NOT EQUAL XPC-FLD0969B
              DISPLAY 'FLD0969B ==> ' HEX-OF (FLD0969B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0969B).
           IF FLD0970B (1:)    NOT EQUAL XPC-FLD0970B
              DISPLAY 'FLD0970B ==> ' HEX-OF (FLD0970B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0970B).
           IF FLD0971B (1:)    NOT EQUAL XPC-FLD0971B
              DISPLAY 'FLD0971B ==> ' HEX-OF (FLD0971B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0971B).
           IF FLD0972B (1:)    NOT EQUAL XPC-FLD0972B
              DISPLAY 'FLD0972B ==> ' HEX-OF (FLD0972B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0972B).
           IF FLD0973B (1:)    NOT EQUAL XPC-FLD0973B
              DISPLAY 'FLD0973B ==> ' HEX-OF (FLD0973B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0973B).
           IF FLD0974B (1:)    NOT EQUAL XPC-FLD0974B
              DISPLAY 'FLD0974B ==> ' HEX-OF (FLD0974B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0974B).
           IF FLD0975B (1:)    NOT EQUAL XPC-FLD0975B
              DISPLAY 'FLD0975B ==> ' HEX-OF (FLD0975B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0975B).
           IF FLD0976B (1:)    NOT EQUAL XPC-FLD0976B
              DISPLAY 'FLD0976B ==> ' HEX-OF (FLD0976B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0976B).
           IF FLD0977B (1:)    NOT EQUAL XPC-FLD0977B
              DISPLAY 'FLD0977B ==> ' HEX-OF (FLD0977B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0977B).
           IF FLD0978B (1:)    NOT EQUAL XPC-FLD0978B
              DISPLAY 'FLD0978B ==> ' HEX-OF (FLD0978B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0978B).
           IF FLD0979B (1:)    NOT EQUAL XPC-FLD0979B
              DISPLAY 'FLD0979B ==> ' HEX-OF (FLD0979B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0979B).
           IF FLD0980B (1:)    NOT EQUAL XPC-FLD0980B
              DISPLAY 'FLD0980B ==> ' HEX-OF (FLD0980B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0980B).
           IF FLD0981B (1:)    NOT EQUAL XPC-FLD0981B
              DISPLAY 'FLD0981B ==> ' HEX-OF (FLD0981B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0981B).
           IF FLD0982B (1:)    NOT EQUAL XPC-FLD0982B
              DISPLAY 'FLD0982B ==> ' HEX-OF (FLD0982B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0982B).
           IF FLD0983B (1:)    NOT EQUAL XPC-FLD0983B
              DISPLAY 'FLD0983B ==> ' HEX-OF (FLD0983B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0983B).
           IF FLD0984B (1:)    NOT EQUAL XPC-FLD0984B
              DISPLAY 'FLD0984B ==> ' HEX-OF (FLD0984B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0984B).
           IF FLD0985B (1:)    NOT EQUAL XPC-FLD0985B
              DISPLAY 'FLD0985B ==> ' HEX-OF (FLD0985B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0985B).
           IF FLD0986B (1:)    NOT EQUAL XPC-FLD0986B
              DISPLAY 'FLD0986B ==> ' HEX-OF (FLD0986B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0986B).
           IF FLD0987B (1:)    NOT EQUAL XPC-FLD0987B
              DISPLAY 'FLD0987B ==> ' HEX-OF (FLD0987B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0987B).
           IF FLD0988B (1:)    NOT EQUAL XPC-FLD0988B
              DISPLAY 'FLD0988B ==> ' HEX-OF (FLD0988B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0988B).
           IF FLD0989B (1:)    NOT EQUAL XPC-FLD0989B
              DISPLAY 'FLD0989B ==> ' HEX-OF (FLD0989B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0989B).
           IF FLD0990B (1:)    NOT EQUAL XPC-FLD0990B
              DISPLAY 'FLD0990B ==> ' HEX-OF (FLD0990B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0990B).
           IF FLD0991B (1:)    NOT EQUAL XPC-FLD0991B
              DISPLAY 'FLD0991B ==> ' HEX-OF (FLD0991B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0991B).
           IF FLD0992B (1:)    NOT EQUAL XPC-FLD0992B
              DISPLAY 'FLD0992B ==> ' HEX-OF (FLD0992B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0992B).
           IF FLD0993B (1:)    NOT EQUAL XPC-FLD0993B
              DISPLAY 'FLD0993B ==> ' HEX-OF (FLD0993B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0993B).
           IF FLD0994B (1:)    NOT EQUAL XPC-FLD0994B
              DISPLAY 'FLD0994B ==> ' HEX-OF (FLD0994B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0994B).
           IF FLD0995B (1:)    NOT EQUAL XPC-FLD0995B
              DISPLAY 'FLD0995B ==> ' HEX-OF (FLD0995B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0995B).
           IF FLD0996B (1:)    NOT EQUAL XPC-FLD0996B
              DISPLAY 'FLD0996B ==> ' HEX-OF (FLD0996B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0996B).
           IF FLD0997B (1:)    NOT EQUAL XPC-FLD0997B
              DISPLAY 'FLD0997B ==> ' HEX-OF (FLD0997B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0997B).
           IF FLD0998B (1:)    NOT EQUAL XPC-FLD0998B
              DISPLAY 'FLD0998B ==> ' HEX-OF (FLD0998B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0998B).
           IF FLD0999B (1:)    NOT EQUAL XPC-FLD0999B
              DISPLAY 'FLD0999B ==> ' HEX-OF (FLD0999B)
              DISPLAY 'EXPECTED ==> ' HEX-OF (XPC-FLD0999B).