IDENTIFICATION DIVISION.
       PROGRAM-ID. PDTEST-MOVE2.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
       FUNCTION HEX-OF INTRINSIC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * DATA-AREA

       77 FLD0500A                       PIC S9(10)V9(08) COMP-3
           VALUE -4830218621.81680639.
       77 FLD0500C                       PIC  9(03)       COMP-6.

       77 FLD0501A                       PIC  9(09)V9(15) COMP-3
           VALUE  652910855.370784748430423.
       77 FLD0501C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0502A                       PIC  9(03)       COMP-6
           VALUE  079.
       77 FLD0502C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0503A                       PIC  9(10)V9(11) COMP-6
           VALUE  5662523582.77427925159.
       77 FLD0503C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0504A                       PIC S9(08)V9(02) COMP-3
           VALUE -28360864.01.
       77 FLD0504C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0505A                       PIC  9(04)V9(30) COMP-3
           VALUE  9110.332843503369248949752545740921.
       77 FLD0505C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0506A                       PIC  9(10)V9(11) COMP-3
           VALUE  5546838940.35467472960.
       77 FLD0506C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0507A                       PIC  9(08)V9(18) COMP-6
           VALUE  70736506.262277043521891073.
       77 FLD0507C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0508A                       PIC  9(09)V9(16) COMP-6
           VALUE  658855971.9467786957025623.
       77 FLD0508C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0509A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0509C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0510A                       PIC  9(04)       COMP-6
           VALUE  1295.
       77 FLD0510C                       PIC S9(03)       COMP-3.

       77 FLD0511A                       PIC  9(06)V9(25) COMP-6
           VALUE  815863.7850571600624860479911149.
       77 FLD0511C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0512A                       PIC  9(05)       COMP-6
           VALUE  13945.
       77 FLD0512C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0513A                       PIC  9(09)V9(15) COMP-3
           VALUE  653773832.246937192103075.
       77 FLD0513C                       PIC  9(08)V9(20) COMP-3.

       77 FLD0514A                       PIC  9(08)V9(18) COMP-3
           VALUE  70109343.593910689040882289.
       77 FLD0514C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0515A                       PIC  9(09)V9(16) COMP-6
           VALUE  658210435.7548693718271692.
       77 FLD0515C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0516A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.884403805479323734672902901365887373.
       77 FLD0516C                       PIC  9(01)       COMP-6.

       77 FLD0517A                       PIC  9(10)V9(07) COMP-6
           VALUE  4497620438.0577999.
       77 FLD0517C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0518A                       PIC  9(09)V9(16) COMP-3
           VALUE  664556684.1155496895510168.
       77 FLD0518C                       PIC S9(02)       COMP-3.

       77 FLD0519A                       PIC  9(09)V9(14) COMP-3
           VALUE  630097608.79846921088898.
       77 FLD0519C                       PIC  9(08)V9(17) COMP-3.

       77 FLD0520A                       PIC  9(04)V9(30) COMP-6
           VALUE  9052.329380117529744609328190563246.
       77 FLD0520C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0521A                       PIC  9(05)       COMP-6
           VALUE  13956.
       77 FLD0521C                       PIC S9(05)       COMP-3.

       77 FLD0522A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0522C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0523A                       PIC  9(08)V9(18) COMP-6
           VALUE  70807149.512639711019801325.
       77 FLD0523C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0524A                       PIC S9(06)V9(01) COMP-3
           VALUE +201515.3.
       77 FLD0524C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0525A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0525C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0526A                       PIC  9(07)V9(22) COMP-3
           VALUE  7812896.0072540409864672028561.
       77 FLD0526C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0527A                       PIC  9(10)V9(12) COMP-6
           VALUE  5853770318.384275972434.
       77 FLD0527C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0528A                       PIC  9(10)V9(08) COMP-6
           VALUE  4856797949.89136714.
       77 FLD0528C                       PIC S9(04)       COMP-3.

       77 FLD0529A                       PIC  9(10)V9(10) COMP-6
           VALUE  5298570971.4885653731.
       77 FLD0529C                       PIC S9(10)V9(07) COMP-3.

       77 FLD0530A                       PIC  9(05)V9(28) COMP-6
           VALUE  87536.5484141958027919372398173436.
       77 FLD0530C                       PIC S9(02)       COMP-3.

       77 FLD0531A                       PIC  9(09)V9(03) COMP-6
           VALUE  317487049.751.
       77 FLD0531C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0532A                       PIC  9(09)V9(15) COMP-3
           VALUE  653250626.044252880042506.
       77 FLD0532C                       PIC S9(01)       COMP-3.

       77 FLD0533A                       PIC  9(07)V9(02) COMP-6
           VALUE  2559928.55.
       77 FLD0533C                       PIC  9(03)       COMP-6.

       77 FLD0534A                       PIC  9(09)V9(06) COMP-6
           VALUE  408226706.354108.
       77 FLD0534C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0535A                       PIC  9(10)V9(11) COMP-6
           VALUE  5556101599.27967472981.
       77 FLD0535C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0536A                       PIC S9(08)V9(03) COMP-3
           VALUE -29061270.882.
       77 FLD0536C                       PIC S9(01)       COMP-3.

       77 FLD0537A                       PIC  9(08)V9(03) COMP-6
           VALUE  29943354.242.
       77 FLD0537C                       PIC  9(04)       COMP-6.

       77 FLD0538A                       PIC  9(03)V9(32) COMP-3
           VALUE  922.29859860523566439383102988358587.
       77 FLD0538C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0539A                       PIC  9(05)V9(27) COMP-6
           VALUE  85666.721070025741990860979058197.
       77 FLD0539C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0540A                       PIC S9(04)       COMP-3
           VALUE +1227.
       77 FLD0540C                       PIC  9(01)       COMP-6.

       77 FLD0541A                       PIC  9(09)V9(05) COMP-6
           VALUE  387240740.80744.
       77 FLD0541C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0542A                       PIC  9(06)V9(25) COMP-3
           VALUE  831706.5789473143677668076634290.
       77 FLD0542C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0543A                       PIC  9(06)V9(01) COMP-6
           VALUE  188772.9.
       77 FLD0543C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0544A                       PIC  9(10)V9(09) COMP-3
           VALUE  5241766194.366106468.
       77 FLD0544C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0545A                       PIC  9(09)V9(14) COMP-3
           VALUE  622229285.46684597161942.
       77 FLD0545C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0546A                       PIC  9(06)V9(25) COMP-3
           VALUE  820358.8689269564193651262939965.
       77 FLD0546C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0547A                       PIC  9(06)V9(25) COMP-3
           VALUE  821925.7242001770658035297856258.
       77 FLD0547C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0548A                       PIC  9(07)V9(23) COMP-6
           VALUE  7955385.78445739497091437897324.
       77 FLD0548C                       PIC  9(09)V9(17) COMP-6.

       77 FLD0549A                       PIC  9(07)V9(01) COMP-6
           VALUE  2367856.7.
       77 FLD0549C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0550A                       PIC  9(09)V9(15) COMP-6
           VALUE  656651700.520587522369453.
       77 FLD0550C                       PIC  9(02)       COMP-6.

       77 FLD0551A                       PIC  9(07)V9(02) COMP-6
           VALUE  2589973.73.
       77 FLD0551C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0552A                       PIC  9(10)V9(07) COMP-6
           VALUE  4579590761.6898545.
       77 FLD0552C                       PIC  9(05)       COMP-6.

       77 FLD0553A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0553C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0554A                       PIC  9(07)V9(02) COMP-6
           VALUE  2568219.15.
       77 FLD0554C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0555A                       PIC  9(09)V9(05) COMP-6
           VALUE  388184875.66560.
       77 FLD0555C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0556A                       PIC  9(04)V9(30) COMP-6
           VALUE  8983.209260005348140154524116951506.
       77 FLD0556C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0557A                       PIC  9(09)V9(15) COMP-3
           VALUE  650877011.601572519339242.
       77 FLD0557C                       PIC S9(05)       COMP-3.

       77 FLD0558A                       PIC  9(09)V9(13) COMP-6
           VALUE  595830550.3266489999703.
       77 FLD0558C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0559A                       PIC  9(10)V9(09) COMP-3
           VALUE  5242032248.235551916.
       77 FLD0559C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0560A                       PIC S9(09)V9(06) COMP-3
           VALUE +403640603.914505.
       77 FLD0560C                       PIC  9(09)V9(07) COMP-6.

       77 FLD0561A                       PIC  9(05)       COMP-6
           VALUE  14931.
       77 FLD0561C                       PIC  9(01)       COMP-6.

       77 FLD0562A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0562C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0563A                       PIC  9(10)V9(09) COMP-3
           VALUE  5040974749.501065943.
       77 FLD0563C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0564A                       PIC  9(09)V9(16) COMP-6
           VALUE  666123633.8391588462926051.
       77 FLD0564C                       PIC  9(03)V9(32) COMP-6.

       77 FLD0565A                       PIC  9(04)V9(30) COMP-6
           VALUE  8999.472704059103822515908177592791.
       77 FLD0565C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0566A                       PIC  9(10)V9(10) COMP-6
           VALUE  5451645287.6426646501.
       77 FLD0566C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0567A                       PIC S9(07)V9(02) COMP-3
           VALUE -2621767.34.
       77 FLD0567C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0568A                       PIC S9(08)V9(02) COMP-3
           VALUE -28119737.76.
       77 FLD0568C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0569A                       PIC  9(10)V9(10) COMP-3
           VALUE  5301098669.5201622875.
       77 FLD0569C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0570A                       PIC  9(05)       COMP-6
           VALUE  13775.
       77 FLD0570C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0571A                       PIC  9(10)V9(08) COMP-6
           VALUE  4995844884.12155025.
       77 FLD0571C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0572A                       PIC  9(06)V9(01) COMP-6
           VALUE  199648.9.
       77 FLD0572C                       PIC S9(06)       COMP-3.

       77 FLD0573A                       PIC  9(10)V9(11) COMP-6
           VALUE  5579051586.61930800079.
       77 FLD0573C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0574A                       PIC  9(10)V9(09) COMP-3
           VALUE  5021035726.447702352.
       77 FLD0574C                       PIC S9(01)       COMP-3.

       77 FLD0575A                       PIC  9(02)V9(34) COMP-3
           VALUE  96.0495649054037059499933093320578336.
       77 FLD0575C                       PIC S9(01)       COMP-3.

       77 FLD0576A                       PIC  9(09)V9(11) COMP-3
           VALUE  551289746.02273483895.
       77 FLD0576C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0577A                       PIC S9(10)V9(06) COMP-3
           VALUE +4245433083.607936.
       77 FLD0577C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0578A                       PIC S9(07)V9(02) COMP-3
           VALUE +2444375.29.
       77 FLD0578C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0579A                       PIC  9(09)V9(17) COMP-6
           VALUE  688719854.55414208576740975.
       77 FLD0579C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0580A                       PIC S9(08)V9(04) COMP-3
           VALUE +33455460.0291.
       77 FLD0580C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0581A                       PIC S9(08)V9(02) COMP-3
           VALUE -28271118.43.
       77 FLD0581C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0582A                       PIC  9(02)V9(34) COMP-3
           VALUE  95.0957041455027018983514608407858759.
       77 FLD0582C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0583A                       PIC  9(04)V9(30) COMP-3
           VALUE  9004.015213488590907431330379040446.
       77 FLD0583C                       PIC S9(01)       COMP-3.

       77 FLD0584A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0584C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0585A                       PIC S9(10)V9(06) COMP-3
           VALUE +4326355872.600766.
       77 FLD0585C                       PIC  9(03)V9(32) COMP-6.

       77 FLD0586A                       PIC  9(05)V9(27) COMP-6
           VALUE  85722.001340062370378092282408033.
       77 FLD0586C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0587A                       PIC S9(09)V9(05) COMP-3
           VALUE -381433349.51035.
       77 FLD0587C                       PIC S9(04)       COMP-3.

       77 FLD0588A                       PIC  9(10)V9(09) COMP-6
           VALUE  5181115773.570048599.
       77 FLD0588C                       PIC  9(04)V9(30) COMP-3.

       77 FLD0589A                       PIC S9(09)V9(06) COMP-3
           VALUE +401102073.275349.
       77 FLD0589C                       PIC S9(04)       COMP-3.

       77 FLD0590A                       PIC  9(08)V9(18) COMP-3
           VALUE  70309799.830174168899787900.
       77 FLD0590C                       PIC S9(06)V9(01) COMP-3.

       77 FLD0591A                       PIC  9(09)V9(12) COMP-6
           VALUE  576933255.371857245386.
       77 FLD0591C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0592A                       PIC  9(09)V9(15) COMP-3
           VALUE  644514829.253344467829833.
       77 FLD0592C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0593A                       PIC  9(08)V9(19) COMP-3
           VALUE  72063942.4137167527995018190.
       77 FLD0593C                       PIC S9(02)       COMP-3.

       77 FLD0594A                       PIC S9(08)V9(02) COMP-3
           VALUE -27405154.91.
       77 FLD0594C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0595A                       PIC  9(08)V9(18) COMP-3
           VALUE  70489201.749069052560514592.
       77 FLD0595C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0596A                       PIC  9(04)V9(30) COMP-6
           VALUE  9050.358418523600789740157779306173.
       77 FLD0596C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0597A                       PIC S9(10)V9(07) COMP-3
           VALUE -4611492066.1642122.
       77 FLD0597C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0598A                       PIC  9(10)V9(12) COMP-6
           VALUE  5888650589.753158248740.
       77 FLD0598C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0599A                       PIC  9(05)V9(27) COMP-6
           VALUE  85689.140306102984379066356268594.
       77 FLD0599C                       PIC  9(01)       COMP-6.

       77 FLD0600A                       PIC S9(09)V9(06) COMP-3
           VALUE +401694362.049109.
       77 FLD0600C                       PIC  9(06)V9(24) COMP-3.

       77 FLD0601A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.763793413809590537866256454435642808.
       77 FLD0601C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0602A                       PIC  9(09)V9(17) COMP-6
           VALUE  685435627.00727922454291274.
       77 FLD0602C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0603A                       PIC  9(09)V9(16) COMP-6
           VALUE  679265807.5584466770280300.
       77 FLD0603C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0604A                       PIC  9(08)V9(19) COMP-6
           VALUE  72862711.3591577502127449861.
       77 FLD0604C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0605A                       PIC  9(04)       COMP-6
           VALUE  1194.
       77 FLD0605C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0606A                       PIC  9(07)V9(23) COMP-6
           VALUE  7955557.56926823565144957228767.
       77 FLD0606C                       PIC S9(08)V9(04) COMP-3.

       77 FLD0607A                       PIC  9(10)V9(08) COMP-6
           VALUE  4950511846.00309279.
       77 FLD0607C                       PIC  9(05)       COMP-6.

       77 FLD0608A                       PIC  9(09)V9(03) COMP-6
           VALUE  328182518.441.
       77 FLD0608C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0609A                       PIC  9(08)V9(04) COMP-6
           VALUE  33948712.4475.
       77 FLD0609C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0610A                       PIC  9(06)V9(24) COMP-6
           VALUE  807988.537497822956190418608457.
       77 FLD0610C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0611A                       PIC  9(07)V9(22) COMP-3
           VALUE  7747853.4043620861382350994972.
       77 FLD0611C                       PIC  9(01)       COMP-6.

       77 FLD0612A                       PIC  9(10)V9(11) COMP-3
           VALUE  5644161799.14422944108.
       77 FLD0612C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0613A                       PIC  9(05)       COMP-6
           VALUE  15551.
       77 FLD0613C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0614A                       PIC  9(10)V9(09) COMP-3
           VALUE  5201647014.630440546.
       77 FLD0614C                       PIC  9(09)V9(13) COMP-6.

       77 FLD0615A                       PIC S9(03)       COMP-3
           VALUE +101.
       77 FLD0615C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0616A                       PIC  9(07)V9(22) COMP-3
           VALUE  7639230.3574527464782306651613.
       77 FLD0616C                       PIC  9(02)       COMP-6.

       77 FLD0617A                       PIC S9(01)       COMP-3
           VALUE -0.
       77 FLD0617C                       PIC  9(01)       COMP-6.

       77 FLD0618A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.817148549708982763206677191192284226.
       77 FLD0618C                       PIC  9(03)       COMP-6.

       77 FLD0619A                       PIC  9(06)V9(24) COMP-3
           VALUE  801850.998363624500875346257089.
       77 FLD0619C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0620A                       PIC  9(08)V9(19) COMP-6
           VALUE  71717267.3810957062023874186.
       77 FLD0620C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0621A                       PIC  9(04)V9(30) COMP-3
           VALUE  9035.013690395441443570234696380794.
       77 FLD0621C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0622A                       PIC  9(09)V9(13) COMP-3
           VALUE  592420192.5737704321761.
       77 FLD0622C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0623A                       PIC S9(03)       COMP-3
           VALUE +104.
       77 FLD0623C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0624A                       PIC S9(06)       COMP-3
           VALUE -162056.
       77 FLD0624C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0625A                       PIC  9(04)       COMP-6
           VALUE  1296.
       77 FLD0625C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0626A                       PIC  9(04)V9(29) COMP-3
           VALUE  8839.60373056715265072114107169909.
       77 FLD0626C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0627A                       PIC  9(04)       COMP-6
           VALUE  1093.
       77 FLD0627C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0628A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.943034041886028573387079632084351032.
       77 FLD0628C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0629A                       PIC  9(03)V9(32) COMP-6
           VALUE  925.54391942612090904418664649710990.
       77 FLD0629C                       PIC  9(05)V9(28) COMP-3.

       77 FLD0630A                       PIC S9(09)V9(06) COMP-3
           VALUE +400669561.119235.
       77 FLD0630C                       PIC  9(09)V9(12) COMP-6.

       77 FLD0631A                       PIC  9(09)V9(15) COMP-3
           VALUE  644864894.904831453814608.
       77 FLD0631C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0632A                       PIC  9(08)V9(18) COMP-6
           VALUE  69998401.036213298009869276.
       77 FLD0632C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0633A                       PIC  9(08)V9(19) COMP-3
           VALUE  72186800.0789349095747127194.
       77 FLD0633C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0634A                       PIC S9(10)V9(06) COMP-3
           VALUE +4236607402.255205.
       77 FLD0634C                       PIC  9(07)V9(23) COMP-3.

       77 FLD0635A                       PIC S9(06)V9(01) COMP-3
           VALUE -190863.2.
       77 FLD0635C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0636A                       PIC S9(07)V9(01) COMP-3
           VALUE +2326055.8.
       77 FLD0636C                       PIC  9(05)       COMP-6.

       77 FLD0637A                       PIC  9(08)V9(19) COMP-3
           VALUE  73470187.3111827330475875896.
       77 FLD0637C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0638A                       PIC  9(07)V9(22) COMP-6
           VALUE  7752451.2041246673721417437263.
       77 FLD0638C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0639A                       PIC S9(09)V9(03) COMP-3
           VALUE +320313574.327.
       77 FLD0639C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0640A                       PIC  9(04)V9(29) COMP-3
           VALUE  8818.61493829378950692898797569796.
       77 FLD0640C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0641A                       PIC  9(07)V9(22) COMP-6
           VALUE  7672056.2697199168322725881807.
       77 FLD0641C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0642A                       PIC  9(08)V9(18) COMP-6
           VALUE  70806494.663622721041917884.
       77 FLD0642C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0643A                       PIC  9(07)V9(01) COMP-6
           VALUE  2194714.9.
       77 FLD0643C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0644A                       PIC  9(02)       COMP-6
           VALUE  07.
       77 FLD0644C                       PIC  9(03)V9(32) COMP-6.

       77 FLD0645A                       PIC  9(03)V9(31) COMP-3
           VALUE  913.1000502995376688630813077907077.
       77 FLD0645C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0646A                       PIC  9(07)V9(21) COMP-3
           VALUE  7520596.805608434909373727350.
       77 FLD0646C                       PIC  9(09)V9(13) COMP-6.

       77 FLD0647A                       PIC S9(02)       COMP-3
           VALUE -07.
       77 FLD0647C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0648A                       PIC S9(04)       COMP-3
           VALUE +1149.
       77 FLD0648C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0649A                       PIC  9(07)V9(23) COMP-3
           VALUE  7912687.10466688007798552462190.
       77 FLD0649C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0650A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.878734262172308433491707546636462211.
       77 FLD0650C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0651A                       PIC  9(08)V9(18) COMP-6
           VALUE  69993795.648145529231243244.
       77 FLD0651C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0652A                       PIC  9(05)V9(01) COMP-6
           VALUE  16676.6.
       77 FLD0652C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0653A                       PIC  9(09)V9(14) COMP-3
           VALUE  620233215.83922497168828.
       77 FLD0653C                       PIC  9(06)       COMP-6.

       77 FLD0654A                       PIC  9(09)V9(15) COMP-6
           VALUE  639337130.284049814932245.
       77 FLD0654C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0655A                       PIC  9(06)V9(25) COMP-6
           VALUE  818013.3890362937254536745967925.
       77 FLD0655C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0656A                       PIC S9(06)V9(01) COMP-3
           VALUE +200859.7.
       77 FLD0656C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0657A                       PIC  9(03)V9(32) COMP-6
           VALUE  936.17194619070143168926279031438753.
       77 FLD0657C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0658A                       PIC  9(08)V9(18) COMP-3
           VALUE  70069365.832955088357891781.
       77 FLD0658C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0659A                       PIC  9(04)V9(30) COMP-3
           VALUE  9044.337793801533464943531726021319.
       77 FLD0659C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0660A                       PIC  9(10)V9(09) COMP-3
           VALUE  5240012407.843260833.
       77 FLD0660C                       PIC S9(05)       COMP-3.

       77 FLD0661A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.5581569624071600621562083688331767.
       77 FLD0661C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0662A                       PIC S9(07)V9(01) COMP-3
           VALUE +2131985.0.
       77 FLD0662C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0663A                       PIC  9(05)       COMP-6
           VALUE  15788.
       77 FLD0663C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0664A                       PIC S9(05)       COMP-3
           VALUE +14371.
       77 FLD0664C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0665A                       PIC  9(07)V9(02) COMP-6
           VALUE  2455875.37.
       77 FLD0665C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0666A                       PIC  9(05)V9(27) COMP-3
           VALUE  86015.549175288641414738322055200.
       77 FLD0666C                       PIC  9(02)       COMP-6.

       77 FLD0667A                       PIC  9(02)V9(33) COMP-3
           VALUE  94.482499794694274619644147605868056.
       77 FLD0667C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0668A                       PIC  9(03)V9(32) COMP-6
           VALUE  935.15331845029669999291854765033349.
       77 FLD0668C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0669A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.937328225295053441001869032334070652.
       77 FLD0669C                       PIC  9(10)V9(05) COMP-6.

       77 FLD0670A                       PIC  9(07)V9(02) COMP-6
           VALUE  2567113.54.
       77 FLD0670C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0671A                       PIC  9(09)V9(03) COMP-6
           VALUE  326622169.718.
       77 FLD0671C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0672A                       PIC  9(10)V9(07) COMP-6
           VALUE  4564917934.3294549.
       77 FLD0672C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0673A                       PIC  9(10)V9(06) COMP-6
           VALUE  4285002333.462958.
       77 FLD0673C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0674A                       PIC  9(10)V9(10) COMP-6
           VALUE  5491650640.0821929467.
       77 FLD0674C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0675A                       PIC  9(05)V9(27) COMP-6
           VALUE  84609.285471017914304070473008323.
       77 FLD0675C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0676A                       PIC  9(03)       COMP-6
           VALUE  096.
       77 FLD0676C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0677A                       PIC S9(07)V9(01) COMP-3
           VALUE +2248183.1.
       77 FLD0677C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0678A                       PIC S9(03)       COMP-3
           VALUE -092.
       77 FLD0678C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0679A                       PIC S9(03)       COMP-3
           VALUE -080.
       77 FLD0679C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0680A                       PIC S9(08)V9(02) COMP-3
           VALUE -28119381.66.
       77 FLD0680C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0681A                       PIC  9(08)V9(17) COMP-3
           VALUE  68244115.95644890304868113.
       77 FLD0681C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0682A                       PIC S9(10)V9(08) COMP-3
           VALUE -4949729784.45772315.
       77 FLD0682C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0683A                       PIC  9(05)V9(28) COMP-6
           VALUE  86894.3068817851549390240961656672.
       77 FLD0683C                       PIC  9(10)V9(12) COMP-3.

       77 FLD0684A                       PIC  9(10)V9(13) COMP-6
           VALUE  6059233373.6406744915115.
       77 FLD0684C                       PIC  9(09)V9(07) COMP-6.

       77 FLD0685A                       PIC S9(07)V9(02) COMP-3
           VALUE -2545714.99.
       77 FLD0685C                       PIC  9(07)V9(23) COMP-3.

       77 FLD0686A                       PIC  9(09)V9(14) COMP-3
           VALUE  621044693.11257093355749.
       77 FLD0686C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0687A                       PIC S9(09)V9(05) COMP-3
           VALUE -394005874.76898.
       77 FLD0687C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0688A                       PIC  9(03)V9(32) COMP-3
           VALUE  932.26844955554755145499257196206599.
       77 FLD0688C                       PIC  9(04)       COMP-6.

       77 FLD0689A                       PIC  9(10)V9(07) COMP-6
           VALUE  4559306991.4341932.
       77 FLD0689C                       PIC S9(08)V9(04) COMP-3.

       77 FLD0690A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.793660005922469879990899244148749858.
       77 FLD0690C                       PIC S9(08)V9(02) COMP-3.

       77 FLD0691A                       PIC  9(09)V9(07) COMP-6
           VALUE  439500550.5938089.
       77 FLD0691C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0692A                       PIC  9(09)V9(04) COMP-6
           VALUE  358382577.7464.
       77 FLD0692C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0693A                       PIC S9(07)V9(01) COMP-3
           VALUE +2127399.6.
       77 FLD0693C                       PIC S9(01)       COMP-3.

       77 FLD0694A                       PIC  9(09)V9(05) COMP-6
           VALUE  378019656.01658.
       77 FLD0694C                       PIC  9(01)       COMP-6.

       77 FLD0695A                       PIC S9(09)V9(04) COMP-3
           VALUE -354304867.1111.
       77 FLD0695C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0696A                       PIC  9(04)V9(30) COMP-6
           VALUE  9067.945209731629319094281527213752.
       77 FLD0696C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0697A                       PIC S9(09)V9(06) COMP-3
           VALUE +414586353.841170.
       77 FLD0697C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0698A                       PIC  9(08)V9(18) COMP-3
           VALUE  69447533.832122987362822641.
       77 FLD0698C                       PIC S9(03)       COMP-3.

       77 FLD0699A                       PIC  9(09)V9(13) COMP-6
           VALUE  597064952.5204202445749.
       77 FLD0699C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0700A                       PIC  9(06)V9(25) COMP-3
           VALUE  820234.3139012789885455845251271.
       77 FLD0700C                       PIC S9(01)       COMP-3.

       77 FLD0701A                       PIC  9(06)V9(24) COMP-6
           VALUE  809485.363390515577641792788199.
       77 FLD0701C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0702A                       PIC  9(04)V9(30) COMP-3
           VALUE  9021.848589518318695112952809722628.
       77 FLD0702C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0703A                       PIC S9(04)       COMP-3
           VALUE +1126.
       77 FLD0703C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0704A                       PIC  9(10)V9(07) COMP-6
           VALUE  4696322933.5995404.
       77 FLD0704C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0705A                       PIC  9(10)V9(10) COMP-6
           VALUE  5381864238.0664638569.
       77 FLD0705C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0706A                       PIC  9(07)V9(22) COMP-3
           VALUE  7815442.4104873465584120140192.
       77 FLD0706C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0707A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0707C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0708A                       PIC  9(02)V9(34) COMP-3
           VALUE  95.1225570140109555339336111501324921.
       77 FLD0708C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0709A                       PIC S9(04)       COMP-3
           VALUE +1124.
       77 FLD0709C                       PIC  9(09)V9(05) COMP-6.

       77 FLD0710A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.946833086486408515014545628218911588.
       77 FLD0710C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0711A                       PIC  9(09)V9(16) COMP-6
           VALUE  677754067.1912668512888444.
       77 FLD0711C                       PIC  9(02)       COMP-6.

       77 FLD0712A                       PIC  9(09)V9(14) COMP-3
           VALUE  610433230.32745544498567.
       77 FLD0712C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0713A                       PIC S9(08)V9(03) COMP-3
           VALUE -29280564.557.
       77 FLD0713C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0714A                       PIC  9(10)V9(07) COMP-6
           VALUE  4593980567.3719869.
       77 FLD0714C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0715A                       PIC  9(09)V9(06) COMP-6
           VALUE  406643755.503527.
       77 FLD0715C                       PIC  9(10)V9(10) COMP-6.

       77 FLD0716A                       PIC S9(08)V9(03) COMP-3
           VALUE -29497495.128.
       77 FLD0716C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0717A                       PIC  9(05)V9(28) COMP-6
           VALUE  86936.9843469434133709228262887336.
       77 FLD0717C                       PIC  9(07)V9(21) COMP-6.

       77 FLD0718A                       PIC  9(06)       COMP-6
           VALUE  158746.
       77 FLD0718C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0719A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0719C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0720A                       PIC  9(03)       COMP-6
           VALUE  087.
       77 FLD0720C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0721A                       PIC S9(09)V9(03) COMP-3
           VALUE +332294869.962.
       77 FLD0721C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0722A                       PIC S9(05)V9(01) COMP-3
           VALUE -17094.9.
       77 FLD0722C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0723A                       PIC  9(05)V9(28) COMP-3
           VALUE  87349.0901765646254872876852459739.
       77 FLD0723C                       PIC  9(02)       COMP-6.

       77 FLD0724A                       PIC  9(09)V9(03) COMP-6
           VALUE  317474559.928.
       77 FLD0724C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0725A                       PIC  9(03)V9(31) COMP-6
           VALUE  915.1169879467740964074096154945436.
       77 FLD0725C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0726A                       PIC  9(05)       COMP-6
           VALUE  14771.
       77 FLD0726C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0727A                       PIC  9(10)V9(10) COMP-3
           VALUE  5412169008.2113094177.
       77 FLD0727C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0728A                       PIC  9(09)V9(07) COMP-6
           VALUE  439411444.5456123.
       77 FLD0728C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0729A                       PIC  9(02)V9(33) COMP-6
           VALUE  94.514768998125520127473464526701718.
       77 FLD0729C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0730A                       PIC  9(06)V9(25) COMP-3
           VALUE  822685.8594490329412707296796725.
       77 FLD0730C                       PIC  9(09)V9(14) COMP-3.

       77 FLD0731A                       PIC  9(10)V9(12) COMP-3
           VALUE  5808279049.356201984011.
       77 FLD0731C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0732A                       PIC  9(03)V9(31) COMP-6
           VALUE  915.5080332184045710519626481982413.
       77 FLD0732C                       PIC S9(04)       COMP-3.

       77 FLD0733A                       PIC  9(09)V9(03) COMP-6
           VALUE  328019305.824.
       77 FLD0733C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0734A                       PIC S9(06)       COMP-3
           VALUE -164821.
       77 FLD0734C                       PIC  9(02)       COMP-6.

       77 FLD0735A                       PIC S9(06)V9(01) COMP-3
           VALUE -190229.8.
       77 FLD0735C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0736A                       PIC  9(10)V9(09) COMP-3
           VALUE  5128678158.202983894.
       77 FLD0736C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0737A                       PIC S9(07)V9(02) COMP-3
           VALUE -2601084.10.
       77 FLD0737C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0738A                       PIC  9(10)V9(09) COMP-6
           VALUE  5071467647.954436275.
       77 FLD0738C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0739A                       PIC S9(09)V9(03) COMP-3
           VALUE +324797211.447.
       77 FLD0739C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0740A                       PIC S9(08)V9(03) COMP-3
           VALUE +30394739.303.
       77 FLD0740C                       PIC  9(05)V9(28) COMP-3.

       77 FLD0741A                       PIC S9(09)V9(03) COMP-3
           VALUE +322386723.831.
       77 FLD0741C                       PIC S9(09)V9(03) COMP-3.

       77 FLD0742A                       PIC  9(09)V9(06) COMP-6
           VALUE  419367234.713135.
       77 FLD0742C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0743A                       PIC  9(05)V9(27) COMP-6
           VALUE  85864.867305029812794003873932524.
       77 FLD0743C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0744A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0744C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0745A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.759709501186564217789509712019935250.
       77 FLD0745C                       PIC  9(05)       COMP-6.

       77 FLD0746A                       PIC  9(10)V9(10) COMP-3
           VALUE  5435731573.3552813430.
       77 FLD0746C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0747A                       PIC  9(10)V9(11) COMP-6
           VALUE  5681676571.07930934579.
       77 FLD0747C                       PIC  9(03)V9(31) COMP-6.

       77 FLD0748A                       PIC  9(03)       COMP-6
           VALUE  086.
       77 FLD0748C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0749A                       PIC S9(10)V9(07) COMP-3
           VALUE -4609096560.3942379.
       77 FLD0749C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0750A                       PIC  9(07)V9(22) COMP-6
           VALUE  7666736.3171436386792834127845.
       77 FLD0750C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0751A                       PIC  9(02)       COMP-6
           VALUE  06.
       77 FLD0751C                       PIC S9(05)       COMP-3.

       77 FLD0752A                       PIC  9(02)       COMP-6
           VALUE  07.
       77 FLD0752C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0753A                       PIC  9(08)V9(19) COMP-3
           VALUE  73379118.3872512742247806727.
       77 FLD0753C                       PIC S9(01)       COMP-3.

       77 FLD0754A                       PIC S9(09)V9(03) COMP-3
           VALUE +322061792.108.
       77 FLD0754C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0755A                       PIC  9(06)V9(25) COMP-6
           VALUE  835592.8333445592492978448717622.
       77 FLD0755C                       PIC  9(10)V9(10) COMP-3.

       77 FLD0756A                       PIC  9(09)V9(04) COMP-6
           VALUE  366295057.8421.
       77 FLD0756C                       PIC S9(05)       COMP-3.

       77 FLD0757A                       PIC  9(08)V9(19) COMP-3
           VALUE  71466976.1113856494283425035.
       77 FLD0757C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0758A                       PIC  9(07)V9(01) COMP-6
           VALUE  2293699.9.
       77 FLD0758C                       PIC S9(06)       COMP-3.

       77 FLD0759A                       PIC  9(03)V9(32) COMP-3
           VALUE  931.38963166127219928114300273591652.
       77 FLD0759C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0760A                       PIC  9(06)V9(01) COMP-6
           VALUE  188511.3.
       77 FLD0760C                       PIC  9(04)V9(30) COMP-3.

       77 FLD0761A                       PIC  9(09)V9(17) COMP-3
           VALUE  690006529.44346418937726639.
       77 FLD0761C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0762A                       PIC  9(09)V9(16) COMP-3
           VALUE  671435372.9957326377686399.
       77 FLD0762C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0763A                       PIC  9(08)V9(19) COMP-3
           VALUE  71468145.3175585401638159055.
       77 FLD0763C                       PIC  9(06)V9(24) COMP-6.

       77 FLD0764A                       PIC  9(10)V9(11) COMP-3
           VALUE  5535007698.50315821329.
       77 FLD0764C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0765A                       PIC  9(04)V9(29) COMP-6
           VALUE  8855.80582773889624093044403707608.
       77 FLD0765C                       PIC S9(04)       COMP-3.

       77 FLD0766A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0766C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0767A                       PIC S9(10)V9(08) COMP-3
           VALUE -4848285740.27346248.
       77 FLD0767C                       PIC S9(01)       COMP-3.

       77 FLD0768A                       PIC  9(09)V9(17) COMP-3
           VALUE  684230789.92735519854306858.
       77 FLD0768C                       PIC S9(02)       COMP-3.

       77 FLD0769A                       PIC  9(07)V9(02) COMP-6
           VALUE  2565731.27.
       77 FLD0769C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0770A                       PIC  9(09)V9(12) COMP-3
           VALUE  574214303.174467532997.
       77 FLD0770C                       PIC  9(10)V9(13) COMP-6.

       77 FLD0771A                       PIC  9(08)V9(18) COMP-6
           VALUE  69721614.519732855175249142.
       77 FLD0771C                       PIC  9(09)V9(17) COMP-3.

       77 FLD0772A                       PIC  9(10)V9(08) COMP-6
           VALUE  4868623585.10471993.
       77 FLD0772C                       PIC  9(10)V9(05) COMP-6.

       77 FLD0773A                       PIC S9(07)V9(01) COMP-3
           VALUE +2339835.9.
       77 FLD0773C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0774A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0774C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0775A                       PIC  9(09)V9(06) COMP-6
           VALUE  418947899.183504.
       77 FLD0775C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0776A                       PIC  9(09)V9(06) COMP-6
           VALUE  418950765.017868.
       77 FLD0776C                       PIC  9(05)V9(27) COMP-6.

       77 FLD0777A                       PIC S9(08)V9(03) COMP-3
           VALUE +31438250.184.
       77 FLD0777C                       PIC  9(10)V9(11) COMP-3.

       77 FLD0778A                       PIC S9(06)V9(01) COMP-3
           VALUE -192739.4.
       77 FLD0778C                       PIC  9(03)V9(31) COMP-6.

       77 FLD0779A                       PIC  9(04)V9(30) COMP-3
           VALUE  9029.333248069044692840634525055065.
       77 FLD0779C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0780A                       PIC  9(09)V9(03) COMP-6
           VALUE  318241207.749.
       77 FLD0780C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0781A                       PIC  9(10)V9(08) COMP-6
           VALUE  4967153543.73054196.
       77 FLD0781C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0782A                       PIC  9(05)       COMP-6
           VALUE  13793.
       77 FLD0782C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0783A                       PIC  9(04)V9(29) COMP-3
           VALUE  8813.39219378433402773964644438819.
       77 FLD0783C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0784A                       PIC  9(09)V9(15) COMP-3
           VALUE  641964802.793786426526878.
       77 FLD0784C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0785A                       PIC  9(08)V9(17) COMP-3
           VALUE  68097654.34600172362422654.
       77 FLD0785C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0786A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.820249933224565186407062356011010706.
       77 FLD0786C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0787A                       PIC  9(10)V9(11) COMP-6
           VALUE  5592847098.07636559730.
       77 FLD0787C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0788A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.6557531637097668841818176588276401.
       77 FLD0788C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0789A                       PIC S9(05)V9(01) COMP-3
           VALUE -17101.7.
       77 FLD0789C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0790A                       PIC  9(07)V9(02) COMP-6
           VALUE  2384369.54.
       77 FLD0790C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0791A                       PIC  9(03)       COMP-6
           VALUE  088.
       77 FLD0791C                       PIC  9(08)V9(20) COMP-6.

       77 FLD0792A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.5230059106088935649836457741912454.
       77 FLD0792C                       PIC  9(09)V9(05) COMP-6.

       77 FLD0793A                       PIC  9(06)V9(01) COMP-6
           VALUE  199221.9.
       77 FLD0793C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0794A                       PIC S9(08)V9(04) COMP-3
           VALUE +33437009.5807.
       77 FLD0794C                       PIC S9(01)       COMP-3.

       77 FLD0795A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0795C                       PIC S9(08)V9(04) COMP-3.

       77 FLD0796A                       PIC  9(07)V9(21) COMP-6
           VALUE  7565685.006144580171394409262.
       77 FLD0796C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0797A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0797C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0798A                       PIC S9(09)V9(03) COMP-3
           VALUE +332243375.906.
       77 FLD0798C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0799A                       PIC  9(09)V9(17) COMP-3
           VALUE  690866271.33683375934225523.
       77 FLD0799C                       PIC  9(09)V9(11) COMP-3.

       77 FLD0800A                       PIC  9(08)V9(18) COMP-3
           VALUE  70036112.416705975647346349.
       77 FLD0800C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0801A                       PIC S9(09)V9(07) COMP-3
           VALUE +443093279.8052367.
       77 FLD0801C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0802A                       PIC S9(07)V9(02) COMP-3
           VALUE +2449505.23.
       77 FLD0802C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0803A                       PIC S9(05)V9(01) COMP-3
           VALUE -17467.0.
       77 FLD0803C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0804A                       PIC  9(07)V9(02) COMP-6
           VALUE  2599541.84.
       77 FLD0804C                       PIC  9(01)       COMP-6.

       77 FLD0805A                       PIC  9(07)V9(01) COMP-6
           VALUE  2358341.0.
       77 FLD0805C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0806A                       PIC  9(10)V9(11) COMP-3
           VALUE  5703927562.80738821850.
       77 FLD0806C                       PIC  9(09)V9(07) COMP-6.

       77 FLD0807A                       PIC  9(09)V9(17) COMP-6
           VALUE  689326682.16034242991696601.
       77 FLD0807C                       PIC S9(03)       COMP-3.

       77 FLD0808A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0808C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0809A                       PIC  9(05)V9(28) COMP-6
           VALUE  86873.4196996681751201663246320094.
       77 FLD0809C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0810A                       PIC S9(04)       COMP-3
           VALUE +1129.
       77 FLD0810C                       PIC S9(07)V9(01) COMP-3.

       77 FLD0811A                       PIC  9(09)V9(15) COMP-6
           VALUE  648943185.643321429623142.
       77 FLD0811C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0812A                       PIC S9(08)V9(03) COMP-3
           VALUE -29270905.795.
       77 FLD0812C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0813A                       PIC  9(10)V9(08) COMP-6
           VALUE  4881724662.84412076.
       77 FLD0813C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0814A                       PIC S9(02)       COMP-3
           VALUE -07.
       77 FLD0814C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0815A                       PIC  9(06)V9(25) COMP-6
           VALUE  838676.0467962863785373883729334.
       77 FLD0815C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0816A                       PIC  9(08)V9(18) COMP-6
           VALUE  70774184.783492177786001775.
       77 FLD0816C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0817A                       PIC  9(10)V9(09) COMP-6
           VALUE  5163345142.860672476.
       77 FLD0817C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0818A                       PIC  9(08)V9(03) COMP-6
           VALUE  30586164.664.
       77 FLD0818C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0819A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.844708607145921108738662042014766484.
       77 FLD0819C                       PIC S9(03)       COMP-3.

       77 FLD0820A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0820C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0821A                       PIC  9(09)V9(11) COMP-3
           VALUE  550576956.44832715942.
       77 FLD0821C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0822A                       PIC S9(05)       COMP-3
           VALUE +14037.
       77 FLD0822C                       PIC  9(04)       COMP-6.

       77 FLD0823A                       PIC  9(08)V9(20) COMP-6
           VALUE  73880168.20028298070610617287.
       77 FLD0823C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0824A                       PIC  9(10)V9(10) COMP-6
           VALUE  5351534260.3280557920.
       77 FLD0824C                       PIC  9(09)V9(14) COMP-6.

       77 FLD0825A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0825C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0826A                       PIC S9(06)V9(01) COMP-3
           VALUE -190786.5.
       77 FLD0826C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0827A                       PIC  9(07)V9(22) COMP-6
           VALUE  7763847.1978375678261841130733.
       77 FLD0827C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0828A                       PIC S9(10)V9(07) COMP-3
           VALUE -4530916009.2405642.
       77 FLD0828C                       PIC S9(05)       COMP-3.

       77 FLD0829A                       PIC  9(09)V9(17) COMP-3
           VALUE  691486534.21926165041355716.
       77 FLD0829C                       PIC  9(07)V9(23) COMP-6.

       77 FLD0830A                       PIC  9(04)V9(30) COMP-6
           VALUE  8965.722935126121395654763546190224.
       77 FLD0830C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0831A                       PIC  9(04)V9(30) COMP-6
           VALUE  8956.555580996397036841472072410397.
       77 FLD0831C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0832A                       PIC  9(04)       COMP-6
           VALUE  1185.
       77 FLD0832C                       PIC  9(09)V9(06) COMP-6.

       77 FLD0833A                       PIC  9(06)V9(24) COMP-3
           VALUE  804859.798300300854911881742737.
       77 FLD0833C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0834A                       PIC  9(09)V9(04) COMP-6
           VALUE  349209744.2881.
       77 FLD0834C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0835A                       PIC  9(08)V9(19) COMP-3
           VALUE  71178359.2779248075466114187.
       77 FLD0835C                       PIC  9(07)V9(22) COMP-6.

       77 FLD0836A                       PIC  9(09)V9(07) COMP-6
           VALUE  446141389.3412962.
       77 FLD0836C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0837A                       PIC  9(04)V9(30) COMP-6
           VALUE  8982.008694278872384941792006429750.
       77 FLD0837C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0838A                       PIC  9(10)V9(12) COMP-6
           VALUE  5873188106.793812979233.
       77 FLD0838C                       PIC  9(07)V9(22) COMP-3.

       77 FLD0839A                       PIC  9(08)V9(19) COMP-3
           VALUE  71324671.8649382605015318858.
       77 FLD0839C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0840A                       PIC S9(03)       COMP-3
           VALUE -094.
       77 FLD0840C                       PIC  9(04)       COMP-6.

       77 FLD0841A                       PIC  9(08)V9(18) COMP-3
           VALUE  70179428.042996372383299785.
       77 FLD0841C                       PIC  9(06)V9(24) COMP-3.

       77 FLD0842A                       PIC  9(09)V9(16) COMP-3
           VALUE  661649948.5739699704112126.
       77 FLD0842C                       PIC  9(02)V9(33) COMP-6.

       77 FLD0843A                       PIC  9(06)V9(25) COMP-6
           VALUE  818928.0761087860405211813485948.
       77 FLD0843C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0844A                       PIC  9(07)V9(22) COMP-6
           VALUE  7754458.9142564990247308287507.
       77 FLD0844C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0845A                       PIC  9(10)V9(12) COMP-3
           VALUE  5903835745.060688200425.
       77 FLD0845C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0846A                       PIC  9(08)V9(03) COMP-6
           VALUE  29802576.878.
       77 FLD0846C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0847A                       PIC  9(05)V9(26) COMP-3
           VALUE  84041.42690564196938041163775778.
       77 FLD0847C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0848A                       PIC  9(07)V9(23) COMP-3
           VALUE  7949747.62786875510656159349309.
       77 FLD0848C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0849A                       PIC  9(09)V9(13) COMP-6
           VALUE  595598045.8961575019216.
       77 FLD0849C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0850A                       PIC  9(09)V9(06) COMP-6
           VALUE  418716850.605351.
       77 FLD0850C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0851A                       PIC S9(03)       COMP-3
           VALUE -082.
       77 FLD0851C                       PIC  9(07)V9(01) COMP-6.

       77 FLD0852A                       PIC  9(10)V9(11) COMP-3
           VALUE  5643399909.75319838462.
       77 FLD0852C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0853A                       PIC  9(06)V9(24) COMP-3
           VALUE  801200.590406665469345171004533.
       77 FLD0853C                       PIC S9(01)       COMP-3.

       77 FLD0854A                       PIC  9(01)V9(35) COMP-3
           VALUE  9.72377885073923198255840816273121163.
       77 FLD0854C                       PIC  9(01)       COMP-6.

       77 FLD0855A                       PIC  9(08)V9(19) COMP-6
           VALUE  73562901.0042854747375429269.
       77 FLD0855C                       PIC  9(05)V9(01) COMP-6.

       77 FLD0856A                       PIC  9(09)V9(04) COMP-6
           VALUE  356144099.6704.
       77 FLD0856C                       PIC S9(05)       COMP-3.

       77 FLD0857A                       PIC  9(03)V9(31) COMP-6
           VALUE  915.3286634102202334872799838194623.
       77 FLD0857C                       PIC S9(02)       COMP-3.

       77 FLD0858A                       PIC  9(10)V9(11) COMP-6
           VALUE  5560594458.08950059131.
       77 FLD0858C                       PIC  9(08)V9(03) COMP-6.

       77 FLD0859A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0859C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0860A                       PIC  9(07)V9(02) COMP-6
           VALUE  2576407.94.
       77 FLD0860C                       PIC  9(08)V9(04) COMP-6.

       77 FLD0861A                       PIC S9(10)V9(07) COMP-3
           VALUE -4605509961.3842453.
       77 FLD0861C                       PIC  9(04)       COMP-6.

       77 FLD0862A                       PIC  9(07)V9(22) COMP-6
           VALUE  7652464.2157409383802502134130.
       77 FLD0862C                       PIC  9(09)V9(12) COMP-6.

       77 FLD0863A                       PIC  9(05)V9(27) COMP-3
           VALUE  85070.091557533766835064170663827.
       77 FLD0863C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0864A                       PIC  9(10)V9(11) COMP-3
           VALUE  5711242885.34377577697.
       77 FLD0864C                       PIC  9(04)V9(29) COMP-6.

       77 FLD0865A                       PIC  9(06)V9(24) COMP-6
           VALUE  807409.725415061507725056344497.
       77 FLD0865C                       PIC S9(03)       COMP-3.

       77 FLD0866A                       PIC  9(09)V9(05) COMP-6
           VALUE  376060050.51851.
       77 FLD0866C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0867A                       PIC S9(05)       COMP-3
           VALUE +14084.
       77 FLD0867C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0868A                       PIC  9(07)V9(22) COMP-3
           VALUE  7648419.8420910554094831468319.
       77 FLD0868C                       PIC  9(10)V9(12) COMP-3.

       77 FLD0869A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0869C                       PIC  9(08)V9(17) COMP-3.

       77 FLD0870A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0870C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0871A                       PIC  9(09)V9(14) COMP-6
           VALUE  609764683.38536315982878.
       77 FLD0871C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0872A                       PIC  9(04)V9(29) COMP-3
           VALUE  8816.31176263962479389135751262074.
       77 FLD0872C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0873A                       PIC  9(07)V9(21) COMP-6
           VALUE  7561255.223942077163812314211.
       77 FLD0873C                       PIC  9(05)       COMP-6.

       77 FLD0874A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0874C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0875A                       PIC S9(06)V9(01) COMP-3
           VALUE +204126.0.
       77 FLD0875C                       PIC  9(02)       COMP-6.

       77 FLD0876A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0876C                       PIC  9(07)V9(23) COMP-3.

       77 FLD0877A                       PIC  9(08)V9(18) COMP-6
           VALUE  69924605.886404200827399790.
       77 FLD0877C                       PIC  9(09)V9(15) COMP-3.

       77 FLD0878A                       PIC  9(07)V9(22) COMP-3
           VALUE  7831260.9220719830993573395971.
       77 FLD0878C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0879A                       PIC  9(07)V9(02) COMP-6
           VALUE  2371533.81.
       77 FLD0879C                       PIC  9(05)V9(27) COMP-3.

       77 FLD0880A                       PIC S9(10)V9(06) COMP-3
           VALUE +4237732309.742536.
       77 FLD0880C                       PIC  9(05)V9(26) COMP-6.

       77 FLD0881A                       PIC  9(10)V9(11) COMP-6
           VALUE  5571129514.90407404264.
       77 FLD0881C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0882A                       PIC  9(10)V9(12) COMP-6
           VALUE  5888713345.878072713546.
       77 FLD0882C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0883A                       PIC  9(09)V9(16) COMP-3
           VALUE  672192258.1526228457349247.
       77 FLD0883C                       PIC  9(07)V9(21) COMP-6.

       77 FLD0884A                       PIC  9(10)V9(08) COMP-6
           VALUE  4954020911.85092596.
       77 FLD0884C                       PIC  9(07)V9(21) COMP-3.

       77 FLD0885A                       PIC S9(05)       COMP-3
           VALUE +13360.
       77 FLD0885C                       PIC S9(05)       COMP-3.

       77 FLD0886A                       PIC S9(09)V9(05) COMP-3
           VALUE -374529584.88504.
       77 FLD0886C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0887A                       PIC S9(07)V9(01) COMP-3
           VALUE +2114795.5.
       77 FLD0887C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0888A                       PIC  9(08)V9(19) COMP-6
           VALUE  73580519.1914812417586233550.
       77 FLD0888C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0889A                       PIC S9(05)       COMP-3
           VALUE -15225.
       77 FLD0889C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0890A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0890C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0891A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.7956124985634538404610793804749846.
       77 FLD0891C                       PIC  9(08)V9(19) COMP-6.

       77 FLD0892A                       PIC  9(10)V9(09) COMP-6
           VALUE  5079027644.377075434.
       77 FLD0892C                       PIC  9(03)       COMP-6.

       77 FLD0893A                       PIC  9(10)V9(12) COMP-3
           VALUE  5900775083.003402254888.
       77 FLD0893C                       PIC  9(02)       COMP-6.

       77 FLD0894A                       PIC  9(06)V9(25) COMP-6
           VALUE  819872.1409522375935807758651208.
       77 FLD0894C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0895A                       PIC  9(10)V9(09) COMP-6
           VALUE  5099949658.575000377.
       77 FLD0895C                       PIC  9(08)V9(02) COMP-6.

       77 FLD0896A                       PIC  9(10)V9(07) COMP-6
           VALUE  4576511370.6787369.
       77 FLD0896C                       PIC S9(01)       COMP-3.

       77 FLD0897A                       PIC  9(01)V9(36) COMP-6
           VALUE  9.997543976245016894566219889384228736.
       77 FLD0897C                       PIC S9(09)V9(07) COMP-3.

       77 FLD0898A                       PIC  9(09)V9(05) COMP-6
           VALUE  378033726.09171.
       77 FLD0898C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0899A                       PIC  9(08)V9(20) COMP-6
           VALUE  74918436.40783237834313013081.
       77 FLD0899C                       PIC  9(09)V9(07) COMP-6.

       77 FLD0900A                       PIC  9(03)V9(32) COMP-6
           VALUE  929.41329164379282712360463847289793.
       77 FLD0900C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0901A                       PIC  9(10)V9(07) COMP-6
           VALUE  4563598931.5070740.
       77 FLD0901C                       PIC  9(01)V9(36) COMP-6.

       77 FLD0902A                       PIC  9(05)V9(28) COMP-3
           VALUE  87405.6741908566081633580324705690.
       77 FLD0902C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0903A                       PIC  9(08)V9(02) COMP-6
           VALUE  28616952.10.
       77 FLD0903C                       PIC S9(02)       COMP-3.

       77 FLD0904A                       PIC S9(04)       COMP-3
           VALUE +1137.
       77 FLD0904C                       PIC S9(01)       COMP-3.

       77 FLD0905A                       PIC  9(09)V9(04) COMP-6
           VALUE  357938124.4724.
       77 FLD0905C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0906A                       PIC  9(09)V9(16) COMP-6
           VALUE  669388906.6218295935684068.
       77 FLD0906C                       PIC  9(01)       COMP-6.

       77 FLD0907A                       PIC S9(09)V9(05) COMP-3
           VALUE -390800584.69506.
       77 FLD0907C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0908A                       PIC S9(10)V9(06) COMP-3
           VALUE +4306350776.286586.
       77 FLD0908C                       PIC  9(03)V9(31) COMP-3.

       77 FLD0909A                       PIC  9(08)V9(03) COMP-6
           VALUE  30663800.453.
       77 FLD0909C                       PIC  9(01)       COMP-6.

       77 FLD0910A                       PIC S9(06)V9(01) COMP-3
           VALUE -193158.9.
       77 FLD0910C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0911A                       PIC S9(10)V9(07) COMP-3
           VALUE -4611964452.0728980.
       77 FLD0911C                       PIC  9(08)V9(20) COMP-3.

       77 FLD0912A                       PIC  9(10)V9(09) COMP-3
           VALUE  5000191930.396378214.
       77 FLD0912C                       PIC  9(01)       COMP-6.

       77 FLD0913A                       PIC S9(04)       COMP-3
           VALUE +1246.
       77 FLD0913C                       PIC  9(03)       COMP-6.

       77 FLD0914A                       PIC  9(03)V9(31) COMP-6
           VALUE  917.2012666333545505281676923914346.
       77 FLD0914C                       PIC  9(01)V9(36) COMP-3.

       77 FLD0915A                       PIC  9(08)V9(20) COMP-6
           VALUE  74750906.49492384109464637731.
       77 FLD0915C                       PIC S9(04)       COMP-3.

       77 FLD0916A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0916C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0917A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0917C                       PIC  9(04)       COMP-6.

       77 FLD0918A                       PIC  9(04)       COMP-6
           VALUE  1059.
       77 FLD0918C                       PIC  9(10)V9(11) COMP-6.

       77 FLD0919A                       PIC S9(02)       COMP-3
           VALUE -06.
       77 FLD0919C                       PIC S9(01)       COMP-3.

       77 FLD0920A                       PIC S9(05)V9(01) COMP-3
           VALUE -17474.9.
       77 FLD0920C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0921A                       PIC  9(10)V9(10) COMP-6
           VALUE  5463494999.0456427304.
       77 FLD0921C                       PIC S9(01)       COMP-3.

       77 FLD0922A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0922C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0923A                       PIC  9(06)       COMP-6
           VALUE  159582.
       77 FLD0923C                       PIC S9(04)       COMP-3.

       77 FLD0924A                       PIC  9(10)V9(11) COMP-6
           VALUE  5650505738.70210182114.
       77 FLD0924C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0925A                       PIC S9(04)       COMP-3
           VALUE +1236.
       77 FLD0925C                       PIC S9(01)       COMP-3.

       77 FLD0926A                       PIC  9(08)V9(18) COMP-6
           VALUE  69535643.175280814620720093.
       77 FLD0926C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0927A                       PIC  9(06)V9(24) COMP-3
           VALUE  800954.558131814597921049880824.
       77 FLD0927C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0928A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0928C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0929A                       PIC  9(05)V9(28) COMP-3
           VALUE  87174.0739403786824013309342262800.
       77 FLD0929C                       PIC  9(08)V9(19) COMP-3.

       77 FLD0930A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.911281003002671008417223674769047647.
       77 FLD0930C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0931A                       PIC  9(09)V9(12) COMP-3
           VALUE  573747057.720371378408.
       77 FLD0931C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0932A                       PIC  9(10)V9(09) COMP-6
           VALUE  5079506475.355934913.
       77 FLD0932C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0933A                       PIC  9(07)V9(22) COMP-6
           VALUE  7776883.1704294028028812135744.
       77 FLD0933C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0934A                       PIC  9(05)V9(01) COMP-6
           VALUE  16899.6.
       77 FLD0934C                       PIC  9(07)V9(02) COMP-6.

       77 FLD0935A                       PIC  9(05)V9(01) COMP-6
           VALUE  16691.2.
       77 FLD0935C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0936A                       PIC  9(08)V9(03) COMP-6
           VALUE  29560937.131.
       77 FLD0936C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0937A                       PIC  9(02)V9(33) COMP-3
           VALUE  94.462893191714936147462822191300801.
       77 FLD0937C                       PIC  9(01)       COMP-6.

       77 FLD0938A                       PIC  9(09)V9(12) COMP-6
           VALUE  578242437.999430092254.
       77 FLD0938C                       PIC  9(08)V9(18) COMP-6.

       77 FLD0939A                       PIC  9(10)V9(13) COMP-6
           VALUE  6084884727.3780637401330.
       77 FLD0939C                       PIC S9(01)       COMP-3.

       77 FLD0940A                       PIC  9(09)V9(12) COMP-6
           VALUE  577997061.609985873786.
       77 FLD0940C                       PIC  9(10)V9(08) COMP-6.

       77 FLD0941A                       PIC  9(09)V9(16) COMP-3
           VALUE  670449367.9367865555107641.
       77 FLD0941C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0942A                       PIC  9(10)V9(10) COMP-3
           VALUE  5309347867.8071082121.
       77 FLD0942C                       PIC  9(03)V9(32) COMP-3.

       77 FLD0943A                       PIC S9(09)V9(03) COMP-3
           VALUE +323766798.919.
       77 FLD0943C                       PIC S9(06)V9(01) COMP-3.

       77 FLD0944A                       PIC  9(02)V9(34) COMP-6
           VALUE  95.7363239628727824559462078468641266.
       77 FLD0944C                       PIC S9(07)V9(02) COMP-3.

       77 FLD0945A                       PIC  9(10)V9(10) COMP-3
           VALUE  5427766423.1255295934.
       77 FLD0945C                       PIC S9(10)V9(06) COMP-3.

       77 FLD0946A                       PIC S9(07)V9(02) COMP-3
           VALUE -2603132.30.
       77 FLD0946C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0947A                       PIC  9(05)V9(27) COMP-6
           VALUE  85846.989065825540787812997223227.
       77 FLD0947C                       PIC  9(09)V9(16) COMP-3.

       77 FLD0948A                       PIC  9(04)       COMP-6
           VALUE  1058.
       77 FLD0948C                       PIC  9(07)V9(21) COMP-6.

       77 FLD0949A                       PIC S9(10)V9(06) COMP-3
           VALUE +4307044196.647341.
       77 FLD0949C                       PIC  9(10)V9(07) COMP-6.

       77 FLD0950A                       PIC  9(09)V9(14) COMP-3
           VALUE  614898523.03850200954116.
       77 FLD0950C                       PIC  9(04)V9(30) COMP-6.

       77 FLD0951A                       PIC S9(08)V9(03) COMP-3
           VALUE +31116955.475.
       77 FLD0951C                       PIC  9(08)V9(20) COMP-6.

       77 FLD0952A                       PIC  9(09)V9(03) COMP-6
           VALUE  315844571.317.
       77 FLD0952C                       PIC  9(02)       COMP-6.

       77 FLD0953A                       PIC  9(06)       COMP-6
           VALUE  166635.
       77 FLD0953C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0954A                       PIC  9(10)V9(11) COMP-6
           VALUE  5577123049.60128579800.
       77 FLD0954C                       PIC  9(02)V9(34) COMP-3.

       77 FLD0955A                       PIC S9(08)V9(02) COMP-3
           VALUE -27357789.23.
       77 FLD0955C                       PIC  9(06)V9(25) COMP-3.

       77 FLD0956A                       PIC S9(08)V9(02) COMP-3
           VALUE -27355040.84.
       77 FLD0956C                       PIC  9(08)V9(18) COMP-3.

       77 FLD0957A                       PIC  9(09)V9(15) COMP-6
           VALUE  637627083.330792543414133.
       77 FLD0957C                       PIC S9(04)       COMP-3.

       77 FLD0958A                       PIC S9(08)V9(03) COMP-3
           VALUE -29370744.150.
       77 FLD0958C                       PIC  9(10)V9(06) COMP-6.

       77 FLD0959A                       PIC  9(06)V9(25) COMP-6
           VALUE  827211.6833605048791255853757320.
       77 FLD0959C                       PIC S9(01)       COMP-3.

       77 FLD0960A                       PIC  9(10)V9(11) COMP-6
           VALUE  5559976801.18206716315.
       77 FLD0960C                       PIC S9(01)       COMP-3.

       77 FLD0961A                       PIC  9(08)V9(19) COMP-6
           VALUE  72708740.7191407630868695832.
       77 FLD0961C                       PIC S9(04)       COMP-3.

       77 FLD0962A                       PIC  9(02)V9(34) COMP-6
           VALUE  96.8081984946274620718043024680810049.
       77 FLD0962C                       PIC  9(08)V9(17) COMP-3.

       77 FLD0963A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.803573230667260718362854277074802666.
       77 FLD0963C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0964A                       PIC  9(09)V9(15) COMP-6
           VALUE  639504907.969730918004813.
       77 FLD0964C                       PIC  9(09)V9(13) COMP-6.

       77 FLD0965A                       PIC  9(05)       COMP-6
           VALUE  13581.
       77 FLD0965C                       PIC  9(01)       COMP-6.

       77 FLD0966A                       PIC  9(06)V9(01) COMP-6
           VALUE  189200.6.
       77 FLD0966C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0967A                       PIC  9(02)       COMP-6
           VALUE  06.
       77 FLD0967C                       PIC  9(09)V9(04) COMP-6.

       77 FLD0968A                       PIC  9(09)V9(15) COMP-6
           VALUE  649996663.320669743058033.
       77 FLD0968C                       PIC S9(04)       COMP-3.

       77 FLD0969A                       PIC S9(05)       COMP-3
           VALUE -15366.
       77 FLD0969C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0970A                       PIC  9(09)V9(14) COMP-3
           VALUE  631417540.20798013247173.
       77 FLD0970C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0971A                       PIC  9(07)V9(01) COMP-6
           VALUE  2161446.9.
       77 FLD0971C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0972A                       PIC  9(09)V9(15) COMP-6
           VALUE  647710182.878484586055378.
       77 FLD0972C                       PIC  9(05)       COMP-6.

       77 FLD0973A                       PIC  9(05)       COMP-6
           VALUE  13817.
       77 FLD0973C                       PIC  9(06)V9(25) COMP-6.

       77 FLD0974A                       PIC  9(04)       COMP-6
           VALUE  1180.
       77 FLD0974C                       PIC S9(03)       COMP-3.

       77 FLD0975A                       PIC S9(02)       COMP-3
           VALUE -06.
       77 FLD0975C                       PIC  9(09)V9(03) COMP-6.

       77 FLD0976A                       PIC S9(07)V9(01) COMP-3
           VALUE +2206144.7.
       77 FLD0976C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0977A                       PIC  9(09)V9(03) COMP-6
           VALUE  327431372.704.
       77 FLD0977C                       PIC S9(09)V9(05) COMP-3.

       77 FLD0978A                       PIC  9(09)V9(16) COMP-6
           VALUE  675062190.8116747338368668.
       77 FLD0978C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0979A                       PIC  9(03)V9(32) COMP-6
           VALUE  925.33169671466619643496187563869170.
       77 FLD0979C                       PIC  9(09)V9(05) COMP-6.

       77 FLD0980A                       PIC  9(03)V9(32) COMP-6
           VALUE  935.82234581280043794748735308530740.
       77 FLD0980C                       PIC  9(09)V9(15) COMP-6.

       77 FLD0981A                       PIC  9(06)V9(01) COMP-6
           VALUE  195132.7.
       77 FLD0981C                       PIC S9(09)V9(04) COMP-3.

       77 FLD0982A                       PIC  9(06)V9(25) COMP-6
           VALUE  816610.1728260642955703474399342.
       77 FLD0982C                       PIC S9(08)V9(03) COMP-3.

       77 FLD0983A                       PIC  9(10)V9(09) COMP-3
           VALUE  5114754992.436914005.
       77 FLD0983C                       PIC  9(02)V9(34) COMP-6.

       77 FLD0984A                       PIC  9(09)V9(15) COMP-3
           VALUE  632949921.330981046807551.
       77 FLD0984C                       PIC  9(10)V9(09) COMP-6.

       77 FLD0985A                       PIC  9(10)V9(06) COMP-6
           VALUE  4296662473.303992.
       77 FLD0985C                       PIC  9(05)V9(28) COMP-3.

       77 FLD0986A                       PIC  9(05)       COMP-6
           VALUE  14588.
       77 FLD0986C                       PIC  9(01)       COMP-6.

       77 FLD0987A                       PIC  9(01)V9(36) COMP-3
           VALUE  9.834402345123109956404050535638816654.
       77 FLD0987C                       PIC  9(06)V9(26) COMP-3.

       77 FLD0988A                       PIC  9(01)       COMP-6
           VALUE  0.
       77 FLD0988C                       PIC S9(05)V9(01) COMP-3.

       77 FLD0989A                       PIC S9(04)       COMP-3
           VALUE +1235.
       77 FLD0989C                       PIC  9(09)V9(13) COMP-3.

       77 FLD0990A                       PIC  9(07)V9(22) COMP-3
           VALUE  7806084.0781040319313888176111.
       77 FLD0990C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0991A                       PIC  9(06)V9(24) COMP-6
           VALUE  807774.663029880435338725419569.
       77 FLD0991C                       PIC S9(09)V9(06) COMP-3.

       77 FLD0992A                       PIC  9(07)V9(22) COMP-6
           VALUE  7784108.2583169551867285917978.
       77 FLD0992C                       PIC  9(04)V9(29) COMP-3.

       77 FLD0993A                       PIC  9(08)V9(20) COMP-6
           VALUE  74534466.64416291111976420324.
       77 FLD0993C                       PIC S9(04)       COMP-3.

       77 FLD0994A                       PIC  9(06)V9(24) COMP-6
           VALUE  815107.307501011568717785849003.
       77 FLD0994C                       PIC S9(10)V9(08) COMP-3.

       77 FLD0995A                       PIC S9(01)       COMP-3
           VALUE +0.
       77 FLD0995C                       PIC  9(06)V9(01) COMP-6.

       77 FLD0996A                       PIC  9(09)V9(14) COMP-6
           VALUE  619241405.61761309431432.
       77 FLD0996C                       PIC  9(09)V9(16) COMP-6.

       77 FLD0997A                       PIC  9(10)V9(09) COMP-3
           VALUE  5006446394.611311356.
       77 FLD0997C                       PIC  9(10)V9(09) COMP-3.

       77 FLD0998A                       PIC  9(09)V9(13) COMP-6
           VALUE  598229443.4201559374386.
       77 FLD0998C                       PIC S9(01)       COMP-3.

       77 FLD0999A                       PIC S9(03)       COMP-3
           VALUE -081.
       77 FLD0999C                       PIC S9(01)       COMP-3.

      * RESULTS-AREA
       78 XPC-FLD0500C
          VALUE X'0621'.
       78 XPC-FLD0501C
          VALUE X'065291085537078474843042'.
       78 XPC-FLD0502C
          VALUE X'000000790000000000000000000000'.
       78 XPC-FLD0503C
          VALUE X'358277427925159000000000000000000F'.
       78 XPC-FLD0504C
          VALUE X'0028360864010000000F'.
       78 XPC-FLD0505C
          VALUE X'000000091103328435033F'.
       78 XPC-FLD0506C
          VALUE X'068389403C'.
       78 XPC-FLD0507C
          VALUE X'0070736506262277043F'.
       78 XPC-FLD0508C
          VALUE X'06588559719467786C'.
       78 XPC-FLD0509C
          VALUE X'000000000000000000'.
       78 XPC-FLD0510C
          VALUE X'295C'.
       78 XPC-FLD0511C
          VALUE X'00000815863785057160'.
       78 XPC-FLD0512C
          VALUE X'5000000000000000000000000000000000000F'.
       78 XPC-FLD0513C
          VALUE X'05377383224693719210307500000F'.
       78 XPC-FLD0514C
          VALUE X'00701093435939'.
       78 XPC-FLD0515C
          VALUE X'43575486937182716920000000000000000F'.
       78 XPC-FLD0516C
          VALUE X'09'.
       78 XPC-FLD0517C
          VALUE X'0449762043805779990C'.
       78 XPC-FLD0518C
          VALUE X'084C'.
       78 XPC-FLD0519C
          VALUE X'3009760879846921088898000F'.
       78 XPC-FLD0520C
          VALUE X'00000905232938011752974F'.
       78 XPC-FLD0521C
          VALUE X'13956C'.
       78 XPC-FLD0522C
          VALUE X'0000000000000C'.
       78 XPC-FLD0523C
          VALUE X'07080714951C'.
       78 XPC-FLD0524C
          VALUE X'0000201515300000000F'.
       78 XPC-FLD0525C
          VALUE X'0000000000000000000000000000000000'.
       78 XPC-FLD0526C
          VALUE X'0781289600'.
       78 XPC-FLD0527C
          VALUE X'5853770318384275972F'.
       78 XPC-FLD0528C
          VALUE X'07949C'.
       78 XPC-FLD0529C
          VALUE X'52985709714885653C'.
       78 XPC-FLD0530C
          VALUE X'036C'.
       78 XPC-FLD0531C
          VALUE X'074870497C'.
       78 XPC-FLD0532C
          VALUE X'6C'.
       78 XPC-FLD0533C
          VALUE X'0928'.
       78 XPC-FLD0534C
          VALUE X'0408226706354108000F'.
       78 XPC-FLD0535C
          VALUE X'001599279674729810000000000000000F'.
       78 XPC-FLD0536C
          VALUE X'0D'.
       78 XPC-FLD0537C
          VALUE X'3354'.
       78 XPC-FLD0538C
          VALUE X'0092229859860523566439383102988358'.
       78 XPC-FLD0539C
          VALUE X'085666721070025741990860979058197F'.
       78 XPC-FLD0540C
          VALUE X'07'.
       78 XPC-FLD0541C
          VALUE X'072407408074400000000000000000'.
       78 XPC-FLD0542C
          VALUE X'000083170657894731436F'.
       78 XPC-FLD0543C
          VALUE X'0018877290'.
       78 XPC-FLD0544C
          VALUE X'4176619436'.
       78 XPC-FLD0545C
          VALUE X'222292854668459716194200000F'.
       78 XPC-FLD0546C
          VALUE X'00082035886892695641936F'.
       78 XPC-FLD0547C
          VALUE X'0008219257242C'.
       78 XPC-FLD0548C
          VALUE X'00795538578445739497091437'.
       78 XPC-FLD0549C
          VALUE X'0002367856700000'.
       78 XPC-FLD0550C
          VALUE X'00'.
       78 XPC-FLD0551C
          VALUE X'0002589973730000000000000F'.
       78 XPC-FLD0552C
          VALUE X'090761'.
       78 XPC-FLD0553C
          VALUE X'0000000000000C'.
       78 XPC-FLD0554C
          VALUE X'21915000000000000000000000000000000F'.
       78 XPC-FLD0555C
          VALUE X'0388184875665600000F'.
       78 XPC-FLD0556C
          VALUE X'0000000898320926000534'.
       78 XPC-FLD0557C
          VALUE X'77011C'.
       78 XPC-FLD0558C
          VALUE X'08305503'.
       78 XPC-FLD0559C
          VALUE X'020322482355519160000000000000'.
       78 XPC-FLD0560C
          VALUE X'4036406039145050'.
       78 XPC-FLD0561C
          VALUE X'01'.
       78 XPC-FLD0562C
          VALUE X'000000000000000000000000000000000000'.
       78 XPC-FLD0563C
          VALUE X'40974749501C'.
       78 XPC-FLD0564C
          VALUE X'063383915884629260510000000000000000'.
       78 XPC-FLD0565C
          VALUE X'00089994'.
       78 XPC-FLD0566C
          VALUE X'451645287642'.
       78 XPC-FLD0567C
          VALUE X'0176734000000000000000000000000000'.
       78 XPC-FLD0568C
          VALUE X'002811973776000000000000'.
       78 XPC-FLD0569C
          VALUE X'301098669520162C'.
       78 XPC-FLD0570C
          VALUE X'000137750000000000000000000F'.
       78 XPC-FLD0571C
          VALUE X'09958448841215502500000000'.
       78 XPC-FLD0572C
          VALUE X'0199648C'.
       78 XPC-FLD0573C
          VALUE X'6619308000790000000000000000000000000F'.
       78 XPC-FLD0574C
          VALUE X'6C'.
       78 XPC-FLD0575C
          VALUE X'6C'.
       78 XPC-FLD0576C
          VALUE X'05512897460227348389'.
       78 XPC-FLD0577C
          VALUE X'836079360000000000000000000000000000'.
       78 XPC-FLD0578C
          VALUE X'443752'.
       78 XPC-FLD0579C
          VALUE X'0688719854554142085F'.
       78 XPC-FLD0580C
          VALUE X'0600291000000000000000000000000000000F'.
       78 XPC-FLD0581C
          VALUE X'028271118430000000000000'.
       78 XPC-FLD0582C
          VALUE X'000000009509570414550270'.
       78 XPC-FLD0583C
          VALUE X'4C'.
       78 XPC-FLD0584C
          VALUE X'000000000000000000000000000000000000'.
       78 XPC-FLD0585C
          VALUE X'087260076600000000000000000000000000'.
       78 XPC-FLD0586C
          VALUE X'000857220013400623703780922824'.
       78 XPC-FLD0587C
          VALUE X'03349D'.
       78 XPC-FLD0588C
          VALUE X'05773570048599000000000000000000000F'.
       78 XPC-FLD0589C
          VALUE X'02073C'.
       78 XPC-FLD0590C
          VALUE X'3097998C'.
       78 XPC-FLD0591C
          VALUE X'0576933255371857245F'.
       78 XPC-FLD0592C
          VALUE X'44514829253C'.
       78 XPC-FLD0593C
          VALUE X'042C'.
       78 XPC-FLD0594C
          VALUE X'74051549100000000000000000000F'.
       78 XPC-FLD0595C
          VALUE X'4892017490690525605145920000000F'.
       78 XPC-FLD0596C
          VALUE X'000009050358418523600789'.
       78 XPC-FLD0597C
          VALUE X'04920661642122000000000000000000'.
       78 XPC-FLD0598C
          VALUE X'888650589753158C'.
       78 XPC-FLD0599C
          VALUE X'09'.
       78 XPC-FLD0600C
          VALUE X'0694362049109000000000000000000F'.
       78 XPC-FLD0601C
          VALUE X'000000009763'.
       78 XPC-FLD0602C
          VALUE X'0543562700'.
       78 XPC-FLD0603C
          VALUE X'0658075C'.
       78 XPC-FLD0604C
          VALUE X'0007286271135915775021'.
       78 XPC-FLD0605C
          VALUE X'0000001194000000'.
       78 XPC-FLD0606C
          VALUE X'0079555575692C'.
       78 XPC-FLD0607C
          VALUE X'011846'.
       78 XPC-FLD0608C
          VALUE X'184410000000000000000000000000000000'.
       78 XPC-FLD0609C
          VALUE X'000339487124475000'.
       78 XPC-FLD0610C
          VALUE X'0080798853'.
       78 XPC-FLD0611C
          VALUE X'03'.
       78 XPC-FLD0612C
          VALUE X'041617991442294410800000000000'.
       78 XPC-FLD0613C
          VALUE X'000155510C'.
       78 XPC-FLD0614C
          VALUE X'2016470146304405460000'.
       78 XPC-FLD0615C
          VALUE X'000001010C'.
       78 XPC-FLD0616C
          VALUE X'30'.
       78 XPC-FLD0617C
          VALUE X'00'.
       78 XPC-FLD0618C
          VALUE X'0009'.
       78 XPC-FLD0619C
          VALUE X'000008018509983636245F'.
       78 XPC-FLD0620C
          VALUE X'071717267381095706202387'.
       78 XPC-FLD0621C
          VALUE X'000090350136903954414435702F'.
       78 XPC-FLD0622C
          VALUE X'5924201925737C'.
       78 XPC-FLD0623C
          VALUE X'0000000104000000000000000F'.
       78 XPC-FLD0624C
          VALUE X'0000162056000000'.
       78 XPC-FLD0625C
          VALUE X'00012960000000000000000000000F'.
       78 XPC-FLD0626C
          VALUE X'000000883960373C'.
       78 XPC-FLD0627C
          VALUE X'000010930C'.
       78 XPC-FLD0628C
          VALUE X'000000009943'.
       78 XPC-FLD0629C
          VALUE X'009255439194261209090441866464971F'.
       78 XPC-FLD0630C
          VALUE X'0400669561119235000000'.
       78 XPC-FLD0631C
          VALUE X'648949'.
       78 XPC-FLD0632C
          VALUE X'00069998401036213298'.
       78 XPC-FLD0633C
          VALUE X'0072186800078C'.
       78 XPC-FLD0634C
          VALUE X'0660740225520500000000000000000F'.
       78 XPC-FLD0635C
          VALUE X'0000019086320000000000'.
       78 XPC-FLD0636C
          VALUE X'026055'.
       78 XPC-FLD0637C
          VALUE X'000734701873111827330F'.
       78 XPC-FLD0638C
          VALUE X'7524512041246673721417437263000F'.
       78 XPC-FLD0639C
          VALUE X'04327000000000000000000000000000000000'.
       78 XPC-FLD0640C
          VALUE X'81861493829378950692898797569796000F'.
       78 XPC-FLD0641C
          VALUE X'0076720562697199168322725881'.
       78 XPC-FLD0642C
          VALUE X'00708064946636227210419F'.
       78 XPC-FLD0643C
          VALUE X'0219471490'.
       78 XPC-FLD0644C
          VALUE X'000700000000000000000000000000000000'.
       78 XPC-FLD0645C
          VALUE X'0000091310'.
       78 XPC-FLD0646C
          VALUE X'0075205968056084349093'.
       78 XPC-FLD0647C
          VALUE X'00000000070000000000000000'.
       78 XPC-FLD0648C
          VALUE X'0000001149000000000000000F'.
       78 XPC-FLD0649C
          VALUE X'0007912687104666880F'.
       78 XPC-FLD0650C
          VALUE X'0000000098787342621723084F'.
       78 XPC-FLD0651C
          VALUE X'006999379564814C'.
       78 XPC-FLD0652C
          VALUE X'000166766C'.
       78 XPC-FLD0653C
          VALUE X'233215'.
       78 XPC-FLD0654C
          VALUE X'3933713028'.
       78 XPC-FLD0655C
          VALUE X'00008180133890362937254F'.
       78 XPC-FLD0656C
          VALUE X'0000200859700000000000000F'.
       78 XPC-FLD0657C
          VALUE X'000000936171946190701431689F'.
       78 XPC-FLD0658C
          VALUE X'000700693658329550883F'.
       78 XPC-FLD0659C
          VALUE X'0000090443377938015334649435'.
       78 XPC-FLD0660C
          VALUE X'12407C'.
       78 XPC-FLD0661C
          VALUE X'000000009655815696240F'.
       78 XPC-FLD0662C
          VALUE X'00021319850000000000000000'.
       78 XPC-FLD0663C
          VALUE X'0578800000000000000000000000000000'.
       78 XPC-FLD0664C
          VALUE X'00000143710000000C'.
       78 XPC-FLD0665C
          VALUE X'0024558753700000000000000F'.
       78 XPC-FLD0666C
          VALUE X'15'.
       78 XPC-FLD0667C
          VALUE X'0000000094482499794694274F'.
       78 XPC-FLD0668C
          VALUE X'0000000935153318450F'.
       78 XPC-FLD0669C
          VALUE X'0000000000993732'.
       78 XPC-FLD0670C
          VALUE X'0135400000000000000000000000000000000F'.
       78 XPC-FLD0671C
          VALUE X'06221697'.
       78 XPC-FLD0672C
          VALUE X'564917934329454900000000'.
       78 XPC-FLD0673C
          VALUE X'0500233346'.
       78 XPC-FLD0674C
          VALUE X'06506400821929467000000000000000'.
       78 XPC-FLD0675C
          VALUE X'00000084609285471017'.
       78 XPC-FLD0676C
          VALUE X'0960000000000000000000000000000000000F'.
       78 XPC-FLD0677C
          VALUE X'818310000000000000000000000000000F'.
       78 XPC-FLD0678C
          VALUE X'00092000000000000000000000000000'.
       78 XPC-FLD0679C
          VALUE X'000000000800000000'.
       78 XPC-FLD0680C
          VALUE X'002811938166000000000F'.
       78 XPC-FLD0681C
          VALUE X'2441159564489030486811300000000F'.
       78 XPC-FLD0682C
          VALUE X'7297844577231500000000000000000F'.
       78 XPC-FLD0683C
          VALUE X'00000086894306881785154F'.
       78 XPC-FLD0684C
          VALUE X'0592333736406744'.
       78 XPC-FLD0685C
          VALUE X'0254571499000000000000000000000F'.
       78 XPC-FLD0686C
          VALUE X'06210446931125709335574F'.
       78 XPC-FLD0687C
          VALUE X'039400587476898000'.
       78 XPC-FLD0688C
          VALUE X'0932'.
       78 XPC-FLD0689C
          VALUE X'0593069914341C'.
       78 XPC-FLD0690C
          VALUE X'00000000979C'.
       78 XPC-FLD0691C
          VALUE X'00439500550593808C'.
       78 XPC-FLD0692C
          VALUE X'358382577746400000000000'.
       78 XPC-FLD0693C
          VALUE X'9C'.
       78 XPC-FLD0694C
          VALUE X'06'.
       78 XPC-FLD0695C
          VALUE X'354304867111100000000000'.
       78 XPC-FLD0696C
          VALUE X'000009067945'.
       78 XPC-FLD0697C
          VALUE X'00414586353841170000'.
       78 XPC-FLD0698C
          VALUE X'533C'.
       78 XPC-FLD0699C
          VALUE X'59706495252042024457490F'.
       78 XPC-FLD0700C
          VALUE X'4C'.
       78 XPC-FLD0701C
          VALUE X'0853633905155776417927881990000000000F'.
       78 XPC-FLD0702C
          VALUE X'00090218'.
       78 XPC-FLD0703C
          VALUE X'000011260000'.
       78 XPC-FLD0704C
          VALUE X'69632293359954040000000F'.
       78 XPC-FLD0705C
          VALUE X'053818642380664638'.
       78 XPC-FLD0706C
          VALUE X'0154424C'.
       78 XPC-FLD0707C
          VALUE X'0000000000000000000F'.
       78 XPC-FLD0708C
          VALUE X'000000951225'.
       78 XPC-FLD0709C
          VALUE X'00000112400000'.
       78 XPC-FLD0710C
          VALUE X'0000000009946C'.
       78 XPC-FLD0711C
          VALUE X'67'.
       78 XPC-FLD0712C
          VALUE X'0061043323032745544C'.
       78 XPC-FLD0713C
          VALUE X'92805645'.
       78 XPC-FLD0714C
          VALUE X'05939805673719'.
       78 XPC-FLD0715C
          VALUE X'04066437555035270000'.
       78 XPC-FLD0716C
          VALUE X'04951280000000000000000000000000000F'.
       78 XPC-FLD0717C
          VALUE X'0086936984346943413370922826'.
       78 XPC-FLD0718C
          VALUE X'0000158746000000'.
       78 XPC-FLD0719C
          VALUE X'0000000000'.
       78 XPC-FLD0720C
          VALUE X'000000087000000C'.
       78 XPC-FLD0721C
          VALUE X'22948699'.
       78 XPC-FLD0722C
          VALUE X'00017094900000000000000000000F'.
       78 XPC-FLD0723C
          VALUE X'49'.
       78 XPC-FLD0724C
          VALUE X'00317474559928000000'.
       78 XPC-FLD0725C
          VALUE X'00000009151169879C'.
       78 XPC-FLD0726C
          VALUE X'000014771000000C'.
       78 XPC-FLD0727C
          VALUE X'04121690082113094177000000'.
       78 XPC-FLD0728C
          VALUE X'043941144454561C'.
       78 XPC-FLD0729C
          VALUE X'000009451476899812552012747346'.
       78 XPC-FLD0730C
          VALUE X'00082268585944903294127F'.
       78 XPC-FLD0731C
          VALUE X'08082790493562019840110F'.
       78 XPC-FLD0732C
          VALUE X'00915C'.
       78 XPC-FLD0733C
          VALUE X'328019305824000000000000'.
       78 XPC-FLD0734C
          VALUE X'21'.
       78 XPC-FLD0735C
          VALUE X'0000190229800000000000000F'.
       78 XPC-FLD0736C
          VALUE X'867815820298389400000000000000'.
       78 XPC-FLD0737C
          VALUE X'260108410D'.
       78 XPC-FLD0738C
          VALUE X'479544362750000000000000000000000000'.
       78 XPC-FLD0739C
          VALUE X'0032479721144700000C'.
       78 XPC-FLD0740C
          VALUE X'947393030000000000000000000000000F'.
       78 XPC-FLD0741C
          VALUE X'0322386723831C'.
       78 XPC-FLD0742C
          VALUE X'19367234713C'.
       78 XPC-FLD0743C
          VALUE X'00858648'.
       78 XPC-FLD0744C
          VALUE X'0000000000'.
       78 XPC-FLD0745C
          VALUE X'000009'.
       78 XPC-FLD0746C
          VALUE X'5435731573355281343F'.
       78 XPC-FLD0747C
          VALUE X'5710793093457900000000000000000000'.
       78 XPC-FLD0748C
          VALUE X'0000860C'.
       78 XPC-FLD0749C
          VALUE X'0965603942379000000000000000000F'.
       78 XPC-FLD0750C
          VALUE X'076667363171'.
       78 XPC-FLD0751C
          VALUE X'00006C'.
       78 XPC-FLD0752C
          VALUE X'00700000000000000000000000000000000F'.
       78 XPC-FLD0753C
          VALUE X'8C'.
       78 XPC-FLD0754C
          VALUE X'0206179210'.
       78 XPC-FLD0755C
          VALUE X'000008355928333445592F'.
       78 XPC-FLD0756C
          VALUE X'95057C'.
       78 XPC-FLD0757C
          VALUE X'146697611C'.
       78 XPC-FLD0758C
          VALUE X'0293699C'.
       78 XPC-FLD0759C
          VALUE X'00000931389631661272199281143F'.
       78 XPC-FLD0760C
          VALUE X'08511300000000000000000000000000000F'.
       78 XPC-FLD0761C
          VALUE X'069000652944346418937726'.
       78 XPC-FLD0762C
          VALUE X'0143537299'.
       78 XPC-FLD0763C
          VALUE X'468145317558540163815905500000'.
       78 XPC-FLD0764C
          VALUE X'553500769850315821'.
       78 XPC-FLD0765C
          VALUE X'08855C'.
       78 XPC-FLD0766C
          VALUE X'00000000'.
       78 XPC-FLD0767C
          VALUE X'0D'.
       78 XPC-FLD0768C
          VALUE X'089C'.
       78 XPC-FLD0769C
          VALUE X'00025657312700'.
       78 XPC-FLD0770C
          VALUE X'005742143031744675329970'.
       78 XPC-FLD0771C
          VALUE X'006972161451973285517524914F'.
       78 XPC-FLD0772C
          VALUE X'0486862358510471'.
       78 XPC-FLD0773C
          VALUE X'83590000000000000000000000000000000F'.
       78 XPC-FLD0774C
          VALUE X'000000000C'.
       78 XPC-FLD0775C
          VALUE X'89918350400000000000000000000000000F'.
       78 XPC-FLD0776C
          VALUE X'50765017868000000000000000000000'.
       78 XPC-FLD0777C
          VALUE X'003143825018400000000F'.
       78 XPC-FLD0778C
          VALUE X'7394000000000000000000000000000000'.
       78 XPC-FLD0779C
          VALUE X'0000000902933324806C'.
       78 XPC-FLD0780C
          VALUE X'2412077490000000000000000000000F'.
       78 XPC-FLD0781C
          VALUE X'067153543730'.
       78 XPC-FLD0782C
          VALUE X'930000000000000000000000000000000000'.
       78 XPC-FLD0783C
          VALUE X'00000008813392193C'.
       78 XPC-FLD0784C
          VALUE X'9648027937864265268780000000000F'.
       78 XPC-FLD0785C
          VALUE X'068097654346'.
       78 XPC-FLD0786C
          VALUE X'000009820249933224565186407062356F'.
       78 XPC-FLD0787C
          VALUE X'08470980'.
       78 XPC-FLD0788C
          VALUE X'000000956557531637097668841818'.
       78 XPC-FLD0789C
          VALUE X'0000171017000000000000000F'.
       78 XPC-FLD0790C
          VALUE X'02384369540C'.
       78 XPC-FLD0791C
          VALUE X'0000008800000000000000000000'.
       78 XPC-FLD0792C
          VALUE X'00000009552300'.
       78 XPC-FLD0793C
          VALUE X'0000019922190000000000'.
       78 XPC-FLD0794C
          VALUE X'9C'.
       78 XPC-FLD0795C
          VALUE X'0000000000000C'.
       78 XPC-FLD0796C
          VALUE X'0075656850061445801713944092'.
       78 XPC-FLD0797C
          VALUE X'00000000000000'.
       78 XPC-FLD0798C
          VALUE X'3322433759060000000000000F'.
       78 XPC-FLD0799C
          VALUE X'069086627133683375934F'.
       78 XPC-FLD0800C
          VALUE X'7003611241'.
       78 XPC-FLD0801C
          VALUE X'9805236700000000000000000000000000000F'.
       78 XPC-FLD0802C
          VALUE X'950523000000000000000000000000000F'.
       78 XPC-FLD0803C
          VALUE X'0000001746700000000000'.
       78 XPC-FLD0804C
          VALUE X'01'.
       78 XPC-FLD0805C
          VALUE X'000235834100000000'.
       78 XPC-FLD0806C
          VALUE X'7039275628073882'.
       78 XPC-FLD0807C
          VALUE X'682C'.
       78 XPC-FLD0808C
          VALUE X'000000000000000000'.
       78 XPC-FLD0809C
          VALUE X'00000868734196996C'.
       78 XPC-FLD0810C
          VALUE X'000011290C'.
       78 XPC-FLD0811C
          VALUE X'5643321429623142000000000000000000000F'.
       78 XPC-FLD0812C
          VALUE X'2927090579'.
       78 XPC-FLD0813C
          VALUE X'81724662844C'.
       78 XPC-FLD0814C
          VALUE X'00000007000000000000000000000F'.
       78 XPC-FLD0815C
          VALUE X'0760467962863785373883729334000000000F'.
       78 XPC-FLD0816C
          VALUE X'0418478349217778600177500000000000'.
       78 XPC-FLD0817C
          VALUE X'05163345142860672476'.
       78 XPC-FLD0818C
          VALUE X'0305861646640000000000000000'.
       78 XPC-FLD0819C
          VALUE X'009C'.
       78 XPC-FLD0820C
          VALUE X'000000000000000000000000000000000000'.
       78 XPC-FLD0821C
          VALUE X'055057695644832C'.
       78 XPC-FLD0822C
          VALUE X'4037'.
       78 XPC-FLD0823C
          VALUE X'073880168200282C'.
       78 XPC-FLD0824C
          VALUE X'035153426032805579200000'.
       78 XPC-FLD0825C
          VALUE X'0000000C'.
       78 XPC-FLD0826C
          VALUE X'0000019078650000000D'.
       78 XPC-FLD0827C
          VALUE X'000077638471978375'.
       78 XPC-FLD0828C
          VALUE X'16009D'.
       78 XPC-FLD0829C
          VALUE X'148653421926165041355716000000'.
       78 XPC-FLD0830C
          VALUE X'0000000896572293512612'.
       78 XPC-FLD0831C
          VALUE X'0000089565555809963970368F'.
       78 XPC-FLD0832C
          VALUE X'0000001185000000'.
       78 XPC-FLD0833C
          VALUE X'0008048597983003008549118F'.
       78 XPC-FLD0834C
          VALUE X'492097442881000000000000000F'.
       78 XPC-FLD0835C
          VALUE X'011783592779248075466114187000'.
       78 XPC-FLD0836C
          VALUE X'04461413893412962000000F'.
       78 XPC-FLD0837C
          VALUE X'00008982008C'.
       78 XPC-FLD0838C
          VALUE X'31881067938129792330000000000F'.
       78 XPC-FLD0839C
          VALUE X'03246718'.
       78 XPC-FLD0840C
          VALUE X'0094'.
       78 XPC-FLD0841C
          VALUE X'0179428042996372383299785000000F'.
       78 XPC-FLD0842C
          VALUE X'048573969970411212600000000000000000'.
       78 XPC-FLD0843C
          VALUE X'00818928076C'.
       78 XPC-FLD0844C
          VALUE X'000077544589142564'.
       78 XPC-FLD0845C
          VALUE X'0903835745060688200425000F'.
       78 XPC-FLD0846C
          VALUE X'000298025768780000'.
       78 XPC-FLD0847C
          VALUE X'000084041426'.
       78 XPC-FLD0848C
          VALUE X'079497476278687551065615934F'.
       78 XPC-FLD0849C
          VALUE X'05598045896157501921600000000F'.
       78 XPC-FLD0850C
          VALUE X'0418716850605351000000000F'.
       78 XPC-FLD0851C
          VALUE X'00000820'.
       78 XPC-FLD0852C
          VALUE X'4339990975'.
       78 XPC-FLD0853C
          VALUE X'0C'.
       78 XPC-FLD0854C
          VALUE X'09'.
       78 XPC-FLD0855C
          VALUE X'629010'.
       78 XPC-FLD0856C
          VALUE X'44099C'.
       78 XPC-FLD0857C
          VALUE X'015C'.
       78 XPC-FLD0858C
          VALUE X'060594458089'.
       78 XPC-FLD0859C
          VALUE X'0000000000000000000000000000000000000F'.
       78 XPC-FLD0860C
          VALUE X'025764079400'.
       78 XPC-FLD0861C
          VALUE X'9961'.
       78 XPC-FLD0862C
          VALUE X'0007652464215740938380'.
       78 XPC-FLD0863C
          VALUE X'00000085070091557533'.
       78 XPC-FLD0864C
          VALUE X'0288534377577697000000000000000000'.
       78 XPC-FLD0865C
          VALUE X'409C'.
       78 XPC-FLD0866C
          VALUE X'0050518510000000000000000000000000'.
       78 XPC-FLD0867C
          VALUE X'0000140840000000000000000000'.
       78 XPC-FLD0868C
          VALUE X'00007648419842091055409F'.
       78 XPC-FLD0869C
          VALUE X'0000000000000000000000000F'.
       78 XPC-FLD0870C
          VALUE X'000000000000000000000000'.
       78 XPC-FLD0871C
          VALUE X'0609764683385363159F'.
       78 XPC-FLD0872C
          VALUE X'000000088163117626'.
       78 XPC-FLD0873C
          VALUE X'061255'.
       78 XPC-FLD0874C
          VALUE X'00000000'.
       78 XPC-FLD0875C
          VALUE X'26'.
       78 XPC-FLD0876C
          VALUE X'0000000000000000000000000000000F'.
       78 XPC-FLD0877C
          VALUE X'0069924605886404200827399F'.
       78 XPC-FLD0878C
          VALUE X'126092207198309935733959710000000F'.
       78 XPC-FLD0879C
          VALUE X'071533810000000000000000000000000F'.
       78 XPC-FLD0880C
          VALUE X'03230974253600000000000000000000'.
       78 XPC-FLD0881C
          VALUE X'5711295149040C'.
       78 XPC-FLD0882C
          VALUE X'08887133458780727135460000'.
       78 XPC-FLD0883C
          VALUE X'2192258152622845734924700000'.
       78 XPC-FLD0884C
          VALUE X'04020911850925960000000000000F'.
       78 XPC-FLD0885C
          VALUE X'13360C'.
       78 XPC-FLD0886C
          VALUE X'037452958488504D'.
       78 XPC-FLD0887C
          VALUE X'01147955000000000000000000000000'.
       78 XPC-FLD0888C
          VALUE X'0358051919'.
       78 XPC-FLD0889C
          VALUE X'0250000000000000000000000000000000000F'.
       78 XPC-FLD0890C
          VALUE X'000000000000000000000000000F'.
       78 XPC-FLD0891C
          VALUE X'0000000957956124985634538404'.
       78 XPC-FLD0892C
          VALUE X'0644'.
       78 XPC-FLD0893C
          VALUE X'83'.
       78 XPC-FLD0894C
          VALUE X'000819872140952237593580'.
       78 XPC-FLD0895C
          VALUE X'9994965857'.
       78 XPC-FLD0896C
          VALUE X'0C'.
       78 XPC-FLD0897C
          VALUE X'00000000099975439C'.
       78 XPC-FLD0898C
          VALUE X'00337260'.
       78 XPC-FLD0899C
          VALUE X'0749184364078323'.
       78 XPC-FLD0900C
          VALUE X'00009294'.
       78 XPC-FLD0901C
          VALUE X'01507074000000000000000000000000000000'.
       78 XPC-FLD0902C
          VALUE X'0000087405674190856F'.
       78 XPC-FLD0903C
          VALUE X'052C'.
       78 XPC-FLD0904C
          VALUE X'7C'.
       78 XPC-FLD0905C
          VALUE X'03579381244724'.
       78 XPC-FLD0906C
          VALUE X'06'.
       78 XPC-FLD0907C
          VALUE X'0039080058469506000000'.
       78 XPC-FLD0908C
          VALUE X'07762865860000000000000000000000000F'.
       78 XPC-FLD0909C
          VALUE X'00'.
       78 XPC-FLD0910C
          VALUE X'3158900000000000000000000000000000'.
       78 XPC-FLD0911C
          VALUE X'01196445207289800000000000000F'.
       78 XPC-FLD0912C
          VALUE X'00'.
       78 XPC-FLD0913C
          VALUE X'0246'.
       78 XPC-FLD0914C
          VALUE X'7201266633354550528167692391434600000F'.
       78 XPC-FLD0915C
          VALUE X'00906C'.
       78 XPC-FLD0916C
          VALUE X'0000000000000000'.
       78 XPC-FLD0917C
          VALUE X'0000'.
       78 XPC-FLD0918C
          VALUE X'0000000105900000000000'.
       78 XPC-FLD0919C
          VALUE X'6D'.
       78 XPC-FLD0920C
          VALUE X'00000174749000000000000000'.
       78 XPC-FLD0921C
          VALUE X'9C'.
       78 XPC-FLD0922C
          VALUE X'0000000C'.
       78 XPC-FLD0923C
          VALUE X'09582C'.
       78 XPC-FLD0924C
          VALUE X'5057387021018211400000000000000F'.
       78 XPC-FLD0925C
          VALUE X'6C'.
       78 XPC-FLD0926C
          VALUE X'953564317C'.
       78 XPC-FLD0927C
          VALUE X'0000800954558131814F'.
       78 XPC-FLD0928C
          VALUE X'0000000000'.
       78 XPC-FLD0929C
          VALUE X'000871740739403786824013309F'.
       78 XPC-FLD0930C
          VALUE X'00000000099112810030026F'.
       78 XPC-FLD0931C
          VALUE X'374705772C'.
       78 XPC-FLD0932C
          VALUE X'05079506475355934913'.
       78 XPC-FLD0933C
          VALUE X'007776883170'.
       78 XPC-FLD0934C
          VALUE X'0001689960'.
       78 XPC-FLD0935C
          VALUE X'000001669120000000'.
       78 XPC-FLD0936C
          VALUE X'0371310000000000000000000000000000000F'.
       78 XPC-FLD0937C
          VALUE X'04'.
       78 XPC-FLD0938C
          VALUE X'78242437999430092254000000'.
       78 XPC-FLD0939C
          VALUE X'7C'.
       78 XPC-FLD0940C
          VALUE X'057799706160998587'.
       78 XPC-FLD0941C
          VALUE X'06704493679367'.
       78 XPC-FLD0942C
          VALUE X'86780710821210000000000000000000000F'.
       78 XPC-FLD0943C
          VALUE X'7667989C'.
       78 XPC-FLD0944C
          VALUE X'000009573C'.
       78 XPC-FLD0945C
          VALUE X'05427766423125529C'.
       78 XPC-FLD0946C
          VALUE X'0323000000000000000000000000000000000F'.
       78 XPC-FLD0947C
          VALUE X'0000858469890658255407878F'.
       78 XPC-FLD0948C
          VALUE X'0001058000000000000000000000'.
       78 XPC-FLD0949C
          VALUE X'043070441966473410'.
       78 XPC-FLD0950C
          VALUE X'8523038502009541160000000000000000'.
       78 XPC-FLD0951C
          VALUE X'3111695547500000000000000000'.
       78 XPC-FLD0952C
          VALUE X'71'.
       78 XPC-FLD0953C
          VALUE X'00000166635000000000'.
       78 XPC-FLD0954C
          VALUE X'0496012857980000000000000000000000000F'.
       78 XPC-FLD0955C
          VALUE X'3577892300000000000000000000000F'.
       78 XPC-FLD0956C
          VALUE X'027355040840000000000000000F'.
       78 XPC-FLD0957C
          VALUE X'07083C'.
       78 XPC-FLD0958C
          VALUE X'0029370744150000'.
       78 XPC-FLD0959C
          VALUE X'1C'.
       78 XPC-FLD0960C
          VALUE X'1C'.
       78 XPC-FLD0961C
          VALUE X'08740C'.
       78 XPC-FLD0962C
          VALUE X'0000009680819849462746207F'.
       78 XPC-FLD0963C
          VALUE X'00000000098035732306672607'.
       78 XPC-FLD0964C
          VALUE X'6395049079697309180048'.
       78 XPC-FLD0965C
          VALUE X'01'.
       78 XPC-FLD0966C
          VALUE X'01892006'.
       78 XPC-FLD0967C
          VALUE X'00000000060000'.
       78 XPC-FLD0968C
          VALUE X'06663C'.
       78 XPC-FLD0969C
          VALUE X'00000153660000000000000F'.
       78 XPC-FLD0970C
          VALUE X'402079801324717300000000000000000000'.
       78 XPC-FLD0971C
          VALUE X'002161446900000C'.
       78 XPC-FLD0972C
          VALUE X'010182'.
       78 XPC-FLD0973C
          VALUE X'00138170000000000000000000000000'.
       78 XPC-FLD0974C
          VALUE X'180C'.
       78 XPC-FLD0975C
          VALUE X'000000006000'.
       78 XPC-FLD0976C
          VALUE X'00002206144700000000'.
       78 XPC-FLD0977C
          VALUE X'032743137270400C'.
       78 XPC-FLD0978C
          VALUE X'675062190811674C'.
       78 XPC-FLD0979C
          VALUE X'00000092533169'.
       78 XPC-FLD0980C
          VALUE X'000000935822345812800437'.
       78 XPC-FLD0981C
          VALUE X'0001951327000C'.
       78 XPC-FLD0982C
          VALUE X'00816610172C'.
       78 XPC-FLD0983C
          VALUE X'924369140050000000000000000000000000'.
       78 XPC-FLD0984C
          VALUE X'00632949921330981046'.
       78 XPC-FLD0985C
          VALUE X'624733039920000000000000000000000F'.
       78 XPC-FLD0986C
          VALUE X'08'.
       78 XPC-FLD0987C
          VALUE X'000000983440234512310995640405053F'.
       78 XPC-FLD0988C
          VALUE X'0000000C'.
       78 XPC-FLD0989C
          VALUE X'00000012350000000000000F'.
       78 XPC-FLD0990C
          VALUE X'08060840'.
       78 XPC-FLD0991C
          VALUE X'000807774663029C'.
       78 XPC-FLD0992C
          VALUE X'410825831695518672859179780000000F'.
       78 XPC-FLD0993C
          VALUE X'04466C'.
       78 XPC-FLD0994C
          VALUE X'0000081510730750101C'.
       78 XPC-FLD0995C
          VALUE X'00000000'.
       78 XPC-FLD0996C
          VALUE X'06192414056176130943143200'.
       78 XPC-FLD0997C
          VALUE X'5006446394611311356F'.
       78 XPC-FLD0998C
          VALUE X'3C'.
       78 XPC-FLD0999C
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

           MOVE FLD0500A        TO FLD0500C.
           MOVE FLD0501A        TO FLD0501C.
           MOVE FLD0502A        TO FLD0502C.
           MOVE FLD0503A        TO FLD0503C.
           MOVE FLD0504A        TO FLD0504C.
           MOVE FLD0505A        TO FLD0505C.
           MOVE FLD0506A        TO FLD0506C.
           MOVE FLD0507A        TO FLD0507C.
           MOVE FLD0508A        TO FLD0508C.
           MOVE FLD0509A        TO FLD0509C.
           MOVE FLD0510A        TO FLD0510C.
           MOVE FLD0511A        TO FLD0511C.
           MOVE FLD0512A        TO FLD0512C.
           MOVE FLD0513A        TO FLD0513C.
           MOVE FLD0514A        TO FLD0514C.
           MOVE FLD0515A        TO FLD0515C.
           MOVE FLD0516A        TO FLD0516C.
           MOVE FLD0517A        TO FLD0517C.
           MOVE FLD0518A        TO FLD0518C.
           MOVE FLD0519A        TO FLD0519C.
           MOVE FLD0520A        TO FLD0520C.
           MOVE FLD0521A        TO FLD0521C.
           MOVE FLD0522A        TO FLD0522C.
           MOVE FLD0523A        TO FLD0523C.
           MOVE FLD0524A        TO FLD0524C.
           MOVE FLD0525A        TO FLD0525C.
           MOVE FLD0526A        TO FLD0526C.
           MOVE FLD0527A        TO FLD0527C.
           MOVE FLD0528A        TO FLD0528C.
           MOVE FLD0529A        TO FLD0529C.
           MOVE FLD0530A        TO FLD0530C.
           MOVE FLD0531A        TO FLD0531C.
           MOVE FLD0532A        TO FLD0532C.
           MOVE FLD0533A        TO FLD0533C.
           MOVE FLD0534A        TO FLD0534C.
           MOVE FLD0535A        TO FLD0535C.
           MOVE FLD0536A        TO FLD0536C.
           MOVE FLD0537A        TO FLD0537C.
           MOVE FLD0538A        TO FLD0538C.
           MOVE FLD0539A        TO FLD0539C.
           MOVE FLD0540A        TO FLD0540C.
           MOVE FLD0541A        TO FLD0541C.
           MOVE FLD0542A        TO FLD0542C.
           MOVE FLD0543A        TO FLD0543C.
           MOVE FLD0544A        TO FLD0544C.
           MOVE FLD0545A        TO FLD0545C.
           MOVE FLD0546A        TO FLD0546C.
           MOVE FLD0547A        TO FLD0547C.
           MOVE FLD0548A        TO FLD0548C.
           MOVE FLD0549A        TO FLD0549C.
           MOVE FLD0550A        TO FLD0550C.
           MOVE FLD0551A        TO FLD0551C.
           MOVE FLD0552A        TO FLD0552C.
           MOVE FLD0553A        TO FLD0553C.
           MOVE FLD0554A        TO FLD0554C.
           MOVE FLD0555A        TO FLD0555C.
           MOVE FLD0556A        TO FLD0556C.
           MOVE FLD0557A        TO FLD0557C.
           MOVE FLD0558A        TO FLD0558C.
           MOVE FLD0559A        TO FLD0559C.
           MOVE FLD0560A        TO FLD0560C.
           MOVE FLD0561A        TO FLD0561C.
           MOVE FLD0562A        TO FLD0562C.
           MOVE FLD0563A        TO FLD0563C.
           MOVE FLD0564A        TO FLD0564C.
           MOVE FLD0565A        TO FLD0565C.
           MOVE FLD0566A        TO FLD0566C.
           MOVE FLD0567A        TO FLD0567C.
           MOVE FLD0568A        TO FLD0568C.
           MOVE FLD0569A        TO FLD0569C.
           MOVE FLD0570A        TO FLD0570C.
           MOVE FLD0571A        TO FLD0571C.
           MOVE FLD0572A        TO FLD0572C.
           MOVE FLD0573A        TO FLD0573C.
           MOVE FLD0574A        TO FLD0574C.
           MOVE FLD0575A        TO FLD0575C.
           MOVE FLD0576A        TO FLD0576C.
           MOVE FLD0577A        TO FLD0577C.
           MOVE FLD0578A        TO FLD0578C.
           MOVE FLD0579A        TO FLD0579C.
           MOVE FLD0580A        TO FLD0580C.
           MOVE FLD0581A        TO FLD0581C.
           MOVE FLD0582A        TO FLD0582C.
           MOVE FLD0583A        TO FLD0583C.
           MOVE FLD0584A        TO FLD0584C.
           MOVE FLD0585A        TO FLD0585C.
           MOVE FLD0586A        TO FLD0586C.
           MOVE FLD0587A        TO FLD0587C.
           MOVE FLD0588A        TO FLD0588C.
           MOVE FLD0589A        TO FLD0589C.
           MOVE FLD0590A        TO FLD0590C.
           MOVE FLD0591A        TO FLD0591C.
           MOVE FLD0592A        TO FLD0592C.
           MOVE FLD0593A        TO FLD0593C.
           MOVE FLD0594A        TO FLD0594C.
           MOVE FLD0595A        TO FLD0595C.
           MOVE FLD0596A        TO FLD0596C.
           MOVE FLD0597A        TO FLD0597C.
           MOVE FLD0598A        TO FLD0598C.
           MOVE FLD0599A        TO FLD0599C.
           MOVE FLD0600A        TO FLD0600C.
           MOVE FLD0601A        TO FLD0601C.
           MOVE FLD0602A        TO FLD0602C.
           MOVE FLD0603A        TO FLD0603C.
           MOVE FLD0604A        TO FLD0604C.
           MOVE FLD0605A        TO FLD0605C.
           MOVE FLD0606A        TO FLD0606C.
           MOVE FLD0607A        TO FLD0607C.
           MOVE FLD0608A        TO FLD0608C.
           MOVE FLD0609A        TO FLD0609C.
           MOVE FLD0610A        TO FLD0610C.
           MOVE FLD0611A        TO FLD0611C.
           MOVE FLD0612A        TO FLD0612C.
           MOVE FLD0613A        TO FLD0613C.
           MOVE FLD0614A        TO FLD0614C.
           MOVE FLD0615A        TO FLD0615C.
           MOVE FLD0616A        TO FLD0616C.
           MOVE FLD0617A        TO FLD0617C.
           MOVE FLD0618A        TO FLD0618C.
           MOVE FLD0619A        TO FLD0619C.
           MOVE FLD0620A        TO FLD0620C.
           MOVE FLD0621A        TO FLD0621C.
           MOVE FLD0622A        TO FLD0622C.
           MOVE FLD0623A        TO FLD0623C.
           MOVE FLD0624A        TO FLD0624C.
           MOVE FLD0625A        TO FLD0625C.
           MOVE FLD0626A        TO FLD0626C.
           MOVE FLD0627A        TO FLD0627C.
           MOVE FLD0628A        TO FLD0628C.
           MOVE FLD0629A        TO FLD0629C.
           MOVE FLD0630A        TO FLD0630C.
           MOVE FLD0631A        TO FLD0631C.
           MOVE FLD0632A        TO FLD0632C.
           MOVE FLD0633A        TO FLD0633C.
           MOVE FLD0634A        TO FLD0634C.
           MOVE FLD0635A        TO FLD0635C.
           MOVE FLD0636A        TO FLD0636C.
           MOVE FLD0637A        TO FLD0637C.
           MOVE FLD0638A        TO FLD0638C.
           MOVE FLD0639A        TO FLD0639C.
           MOVE FLD0640A        TO FLD0640C.
           MOVE FLD0641A        TO FLD0641C.
           MOVE FLD0642A        TO FLD0642C.
           MOVE FLD0643A        TO FLD0643C.
           MOVE FLD0644A        TO FLD0644C.
           MOVE FLD0645A        TO FLD0645C.
           MOVE FLD0646A        TO FLD0646C.
           MOVE FLD0647A        TO FLD0647C.
           MOVE FLD0648A        TO FLD0648C.
           MOVE FLD0649A        TO FLD0649C.
           MOVE FLD0650A        TO FLD0650C.
           MOVE FLD0651A        TO FLD0651C.
           MOVE FLD0652A        TO FLD0652C.
           MOVE FLD0653A        TO FLD0653C.
           MOVE FLD0654A        TO FLD0654C.
           MOVE FLD0655A        TO FLD0655C.
           MOVE FLD0656A        TO FLD0656C.
           MOVE FLD0657A        TO FLD0657C.
           MOVE FLD0658A        TO FLD0658C.
           MOVE FLD0659A        TO FLD0659C.
           MOVE FLD0660A        TO FLD0660C.
           MOVE FLD0661A        TO FLD0661C.
           MOVE FLD0662A        TO FLD0662C.
           MOVE FLD0663A        TO FLD0663C.
           MOVE FLD0664A        TO FLD0664C.
           MOVE FLD0665A        TO FLD0665C.
           MOVE FLD0666A        TO FLD0666C.
           MOVE FLD0667A        TO FLD0667C.
           MOVE FLD0668A        TO FLD0668C.
           MOVE FLD0669A        TO FLD0669C.
           MOVE FLD0670A        TO FLD0670C.
           MOVE FLD0671A        TO FLD0671C.
           MOVE FLD0672A        TO FLD0672C.
           MOVE FLD0673A        TO FLD0673C.
           MOVE FLD0674A        TO FLD0674C.
           MOVE FLD0675A        TO FLD0675C.
           MOVE FLD0676A        TO FLD0676C.
           MOVE FLD0677A        TO FLD0677C.
           MOVE FLD0678A        TO FLD0678C.
           MOVE FLD0679A        TO FLD0679C.
           MOVE FLD0680A        TO FLD0680C.
           MOVE FLD0681A        TO FLD0681C.
           MOVE FLD0682A        TO FLD0682C.
           MOVE FLD0683A        TO FLD0683C.
           MOVE FLD0684A        TO FLD0684C.
           MOVE FLD0685A        TO FLD0685C.
           MOVE FLD0686A        TO FLD0686C.
           MOVE FLD0687A        TO FLD0687C.
           MOVE FLD0688A        TO FLD0688C.
           MOVE FLD0689A        TO FLD0689C.
           MOVE FLD0690A        TO FLD0690C.
           MOVE FLD0691A        TO FLD0691C.
           MOVE FLD0692A        TO FLD0692C.
           MOVE FLD0693A        TO FLD0693C.
           MOVE FLD0694A        TO FLD0694C.
           MOVE FLD0695A        TO FLD0695C.
           MOVE FLD0696A        TO FLD0696C.
           MOVE FLD0697A        TO FLD0697C.
           MOVE FLD0698A        TO FLD0698C.
           MOVE FLD0699A        TO FLD0699C.
           MOVE FLD0700A        TO FLD0700C.
           MOVE FLD0701A        TO FLD0701C.
           MOVE FLD0702A        TO FLD0702C.
           MOVE FLD0703A        TO FLD0703C.
           MOVE FLD0704A        TO FLD0704C.
           MOVE FLD0705A        TO FLD0705C.
           MOVE FLD0706A        TO FLD0706C.
           MOVE FLD0707A        TO FLD0707C.
           MOVE FLD0708A        TO FLD0708C.
           MOVE FLD0709A        TO FLD0709C.
           MOVE FLD0710A        TO FLD0710C.
           MOVE FLD0711A        TO FLD0711C.
           MOVE FLD0712A        TO FLD0712C.
           MOVE FLD0713A        TO FLD0713C.
           MOVE FLD0714A        TO FLD0714C.
           MOVE FLD0715A        TO FLD0715C.
           MOVE FLD0716A        TO FLD0716C.
           MOVE FLD0717A        TO FLD0717C.
           MOVE FLD0718A        TO FLD0718C.
           MOVE FLD0719A        TO FLD0719C.
           MOVE FLD0720A        TO FLD0720C.
           MOVE FLD0721A        TO FLD0721C.
           MOVE FLD0722A        TO FLD0722C.
           MOVE FLD0723A        TO FLD0723C.
           MOVE FLD0724A        TO FLD0724C.
           MOVE FLD0725A        TO FLD0725C.
           MOVE FLD0726A        TO FLD0726C.
           MOVE FLD0727A        TO FLD0727C.
           MOVE FLD0728A        TO FLD0728C.
           MOVE FLD0729A        TO FLD0729C.
           MOVE FLD0730A        TO FLD0730C.
           MOVE FLD0731A        TO FLD0731C.
           MOVE FLD0732A        TO FLD0732C.
           MOVE FLD0733A        TO FLD0733C.
           MOVE FLD0734A        TO FLD0734C.
           MOVE FLD0735A        TO FLD0735C.
           MOVE FLD0736A        TO FLD0736C.
           MOVE FLD0737A        TO FLD0737C.
           MOVE FLD0738A        TO FLD0738C.
           MOVE FLD0739A        TO FLD0739C.
           MOVE FLD0740A        TO FLD0740C.
           MOVE FLD0741A        TO FLD0741C.
           MOVE FLD0742A        TO FLD0742C.
           MOVE FLD0743A        TO FLD0743C.
           MOVE FLD0744A        TO FLD0744C.
           MOVE FLD0745A        TO FLD0745C.
           MOVE FLD0746A        TO FLD0746C.
           MOVE FLD0747A        TO FLD0747C.
           MOVE FLD0748A        TO FLD0748C.
           MOVE FLD0749A        TO FLD0749C.
           MOVE FLD0750A        TO FLD0750C.
           MOVE FLD0751A        TO FLD0751C.
           MOVE FLD0752A        TO FLD0752C.
           MOVE FLD0753A        TO FLD0753C.
           MOVE FLD0754A        TO FLD0754C.
           MOVE FLD0755A        TO FLD0755C.
           MOVE FLD0756A        TO FLD0756C.
           MOVE FLD0757A        TO FLD0757C.
           MOVE FLD0758A        TO FLD0758C.
           MOVE FLD0759A        TO FLD0759C.
           MOVE FLD0760A        TO FLD0760C.
           MOVE FLD0761A        TO FLD0761C.
           MOVE FLD0762A        TO FLD0762C.
           MOVE FLD0763A        TO FLD0763C.
           MOVE FLD0764A        TO FLD0764C.
           MOVE FLD0765A        TO FLD0765C.
           MOVE FLD0766A        TO FLD0766C.
           MOVE FLD0767A        TO FLD0767C.
           MOVE FLD0768A        TO FLD0768C.
           MOVE FLD0769A        TO FLD0769C.
           MOVE FLD0770A        TO FLD0770C.
           MOVE FLD0771A        TO FLD0771C.
           MOVE FLD0772A        TO FLD0772C.
           MOVE FLD0773A        TO FLD0773C.
           MOVE FLD0774A        TO FLD0774C.
           MOVE FLD0775A        TO FLD0775C.
           MOVE FLD0776A        TO FLD0776C.
           MOVE FLD0777A        TO FLD0777C.
           MOVE FLD0778A        TO FLD0778C.
           MOVE FLD0779A        TO FLD0779C.
           MOVE FLD0780A        TO FLD0780C.
           MOVE FLD0781A        TO FLD0781C.
           MOVE FLD0782A        TO FLD0782C.
           MOVE FLD0783A        TO FLD0783C.
           MOVE FLD0784A        TO FLD0784C.
           MOVE FLD0785A        TO FLD0785C.
           MOVE FLD0786A        TO FLD0786C.
           MOVE FLD0787A        TO FLD0787C.
           MOVE FLD0788A        TO FLD0788C.
           MOVE FLD0789A        TO FLD0789C.
           MOVE FLD0790A        TO FLD0790C.
           MOVE FLD0791A        TO FLD0791C.
           MOVE FLD0792A        TO FLD0792C.
           MOVE FLD0793A        TO FLD0793C.
           MOVE FLD0794A        TO FLD0794C.
           MOVE FLD0795A        TO FLD0795C.
           MOVE FLD0796A        TO FLD0796C.
           MOVE FLD0797A        TO FLD0797C.
           MOVE FLD0798A        TO FLD0798C.
           MOVE FLD0799A        TO FLD0799C.
           MOVE FLD0800A        TO FLD0800C.
           MOVE FLD0801A        TO FLD0801C.
           MOVE FLD0802A        TO FLD0802C.
           MOVE FLD0803A        TO FLD0803C.
           MOVE FLD0804A        TO FLD0804C.
           MOVE FLD0805A        TO FLD0805C.
           MOVE FLD0806A        TO FLD0806C.
           MOVE FLD0807A        TO FLD0807C.
           MOVE FLD0808A        TO FLD0808C.
           MOVE FLD0809A        TO FLD0809C.
           MOVE FLD0810A        TO FLD0810C.
           MOVE FLD0811A        TO FLD0811C.
           MOVE FLD0812A        TO FLD0812C.
           MOVE FLD0813A        TO FLD0813C.
           MOVE FLD0814A        TO FLD0814C.
           MOVE FLD0815A        TO FLD0815C.
           MOVE FLD0816A        TO FLD0816C.
           MOVE FLD0817A        TO FLD0817C.
           MOVE FLD0818A        TO FLD0818C.
           MOVE FLD0819A        TO FLD0819C.
           MOVE FLD0820A        TO FLD0820C.
           MOVE FLD0821A        TO FLD0821C.
           MOVE FLD0822A        TO FLD0822C.
           MOVE FLD0823A        TO FLD0823C.
           MOVE FLD0824A        TO FLD0824C.
           MOVE FLD0825A        TO FLD0825C.
           MOVE FLD0826A        TO FLD0826C.
           MOVE FLD0827A        TO FLD0827C.
           MOVE FLD0828A        TO FLD0828C.
           MOVE FLD0829A        TO FLD0829C.
           MOVE FLD0830A        TO FLD0830C.
           MOVE FLD0831A        TO FLD0831C.
           MOVE FLD0832A        TO FLD0832C.
           MOVE FLD0833A        TO FLD0833C.
           MOVE FLD0834A        TO FLD0834C.
           MOVE FLD0835A        TO FLD0835C.
           MOVE FLD0836A        TO FLD0836C.
           MOVE FLD0837A        TO FLD0837C.
           MOVE FLD0838A        TO FLD0838C.
           MOVE FLD0839A        TO FLD0839C.
           MOVE FLD0840A        TO FLD0840C.
           MOVE FLD0841A        TO FLD0841C.
           MOVE FLD0842A        TO FLD0842C.
           MOVE FLD0843A        TO FLD0843C.
           MOVE FLD0844A        TO FLD0844C.
           MOVE FLD0845A        TO FLD0845C.
           MOVE FLD0846A        TO FLD0846C.
           MOVE FLD0847A        TO FLD0847C.
           MOVE FLD0848A        TO FLD0848C.
           MOVE FLD0849A        TO FLD0849C.
           MOVE FLD0850A        TO FLD0850C.
           MOVE FLD0851A        TO FLD0851C.
           MOVE FLD0852A        TO FLD0852C.
           MOVE FLD0853A        TO FLD0853C.
           MOVE FLD0854A        TO FLD0854C.
           MOVE FLD0855A        TO FLD0855C.
           MOVE FLD0856A        TO FLD0856C.
           MOVE FLD0857A        TO FLD0857C.
           MOVE FLD0858A        TO FLD0858C.
           MOVE FLD0859A        TO FLD0859C.
           MOVE FLD0860A        TO FLD0860C.
           MOVE FLD0861A        TO FLD0861C.
           MOVE FLD0862A        TO FLD0862C.
           MOVE FLD0863A        TO FLD0863C.
           MOVE FLD0864A        TO FLD0864C.
           MOVE FLD0865A        TO FLD0865C.
           MOVE FLD0866A        TO FLD0866C.
           MOVE FLD0867A        TO FLD0867C.
           MOVE FLD0868A        TO FLD0868C.
           MOVE FLD0869A        TO FLD0869C.
           MOVE FLD0870A        TO FLD0870C.
           MOVE FLD0871A        TO FLD0871C.
           MOVE FLD0872A        TO FLD0872C.
           MOVE FLD0873A        TO FLD0873C.
           MOVE FLD0874A        TO FLD0874C.
           MOVE FLD0875A        TO FLD0875C.
           MOVE FLD0876A        TO FLD0876C.
           MOVE FLD0877A        TO FLD0877C.
           MOVE FLD0878A        TO FLD0878C.
           MOVE FLD0879A        TO FLD0879C.
           MOVE FLD0880A        TO FLD0880C.
           MOVE FLD0881A        TO FLD0881C.
           MOVE FLD0882A        TO FLD0882C.
           MOVE FLD0883A        TO FLD0883C.
           MOVE FLD0884A        TO FLD0884C.
           MOVE FLD0885A        TO FLD0885C.
           MOVE FLD0886A        TO FLD0886C.
           MOVE FLD0887A        TO FLD0887C.
           MOVE FLD0888A        TO FLD0888C.
           MOVE FLD0889A        TO FLD0889C.
           MOVE FLD0890A        TO FLD0890C.
           MOVE FLD0891A        TO FLD0891C.
           MOVE FLD0892A        TO FLD0892C.
           MOVE FLD0893A        TO FLD0893C.
           MOVE FLD0894A        TO FLD0894C.
           MOVE FLD0895A        TO FLD0895C.
           MOVE FLD0896A        TO FLD0896C.
           MOVE FLD0897A        TO FLD0897C.
           MOVE FLD0898A        TO FLD0898C.
           MOVE FLD0899A        TO FLD0899C.
           MOVE FLD0900A        TO FLD0900C.
           MOVE FLD0901A        TO FLD0901C.
           MOVE FLD0902A        TO FLD0902C.
           MOVE FLD0903A        TO FLD0903C.
           MOVE FLD0904A        TO FLD0904C.
           MOVE FLD0905A        TO FLD0905C.
           MOVE FLD0906A        TO FLD0906C.
           MOVE FLD0907A        TO FLD0907C.
           MOVE FLD0908A        TO FLD0908C.
           MOVE FLD0909A        TO FLD0909C.
           MOVE FLD0910A        TO FLD0910C.
           MOVE FLD0911A        TO FLD0911C.
           MOVE FLD0912A        TO FLD0912C.
           MOVE FLD0913A        TO FLD0913C.
           MOVE FLD0914A        TO FLD0914C.
           MOVE FLD0915A        TO FLD0915C.
           MOVE FLD0916A        TO FLD0916C.
           MOVE FLD0917A        TO FLD0917C.
           MOVE FLD0918A        TO FLD0918C.
           MOVE FLD0919A        TO FLD0919C.
           MOVE FLD0920A        TO FLD0920C.
           MOVE FLD0921A        TO FLD0921C.
           MOVE FLD0922A        TO FLD0922C.
           MOVE FLD0923A        TO FLD0923C.
           MOVE FLD0924A        TO FLD0924C.
           MOVE FLD0925A        TO FLD0925C.
           MOVE FLD0926A        TO FLD0926C.
           MOVE FLD0927A        TO FLD0927C.
           MOVE FLD0928A        TO FLD0928C.
           MOVE FLD0929A        TO FLD0929C.
           MOVE FLD0930A        TO FLD0930C.
           MOVE FLD0931A        TO FLD0931C.
           MOVE FLD0932A        TO FLD0932C.
           MOVE FLD0933A        TO FLD0933C.
           MOVE FLD0934A        TO FLD0934C.
           MOVE FLD0935A        TO FLD0935C.
           MOVE FLD0936A        TO FLD0936C.
           MOVE FLD0937A        TO FLD0937C.
           MOVE FLD0938A        TO FLD0938C.
           MOVE FLD0939A        TO FLD0939C.
           MOVE FLD0940A        TO FLD0940C.
           MOVE FLD0941A        TO FLD0941C.
           MOVE FLD0942A        TO FLD0942C.
           MOVE FLD0943A        TO FLD0943C.
           MOVE FLD0944A        TO FLD0944C.
           MOVE FLD0945A        TO FLD0945C.
           MOVE FLD0946A        TO FLD0946C.
           MOVE FLD0947A        TO FLD0947C.
           MOVE FLD0948A        TO FLD0948C.
           MOVE FLD0949A        TO FLD0949C.
           MOVE FLD0950A        TO FLD0950C.
           MOVE FLD0951A        TO FLD0951C.
           MOVE FLD0952A        TO FLD0952C.
           MOVE FLD0953A        TO FLD0953C.
           MOVE FLD0954A        TO FLD0954C.
           MOVE FLD0955A        TO FLD0955C.
           MOVE FLD0956A        TO FLD0956C.
           MOVE FLD0957A        TO FLD0957C.
           MOVE FLD0958A        TO FLD0958C.
           MOVE FLD0959A        TO FLD0959C.
           MOVE FLD0960A        TO FLD0960C.
           MOVE FLD0961A        TO FLD0961C.
           MOVE FLD0962A        TO FLD0962C.
           MOVE FLD0963A        TO FLD0963C.
           MOVE FLD0964A        TO FLD0964C.
           MOVE FLD0965A        TO FLD0965C.
           MOVE FLD0966A        TO FLD0966C.
           MOVE FLD0967A        TO FLD0967C.
           MOVE FLD0968A        TO FLD0968C.
           MOVE FLD0969A        TO FLD0969C.
           MOVE FLD0970A        TO FLD0970C.
           MOVE FLD0971A        TO FLD0971C.
           MOVE FLD0972A        TO FLD0972C.
           MOVE FLD0973A        TO FLD0973C.
           MOVE FLD0974A        TO FLD0974C.
           MOVE FLD0975A        TO FLD0975C.
           MOVE FLD0976A        TO FLD0976C.
           MOVE FLD0977A        TO FLD0977C.
           MOVE FLD0978A        TO FLD0978C.
           MOVE FLD0979A        TO FLD0979C.
           MOVE FLD0980A        TO FLD0980C.
           MOVE FLD0981A        TO FLD0981C.
           MOVE FLD0982A        TO FLD0982C.
           MOVE FLD0983A        TO FLD0983C.
           MOVE FLD0984A        TO FLD0984C.
           MOVE FLD0985A        TO FLD0985C.
           MOVE FLD0986A        TO FLD0986C.
           MOVE FLD0987A        TO FLD0987C.
           MOVE FLD0988A        TO FLD0988C.
           MOVE FLD0989A        TO FLD0989C.
           MOVE FLD0990A        TO FLD0990C.
           MOVE FLD0991A        TO FLD0991C.
           MOVE FLD0992A        TO FLD0992C.
           MOVE FLD0993A        TO FLD0993C.
           MOVE FLD0994A        TO FLD0994C.
           MOVE FLD0995A        TO FLD0995C.
           MOVE FLD0996A        TO FLD0996C.
           MOVE FLD0997A        TO FLD0997C.
           MOVE FLD0998A        TO FLD0998C.
           MOVE FLD0999A        TO FLD0999C.

       4000-COMPARE.

           IF FLD0500C (1:)    NOT EQUAL XPC-FLD0500C
              DISPLAY 'FLD0500C ==> ' HEX-OF (FLD0500C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0500C).
           IF FLD0501C (1:)    NOT EQUAL XPC-FLD0501C
              DISPLAY 'FLD0501C ==> ' HEX-OF (FLD0501C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0501C).
           IF FLD0502C (1:)    NOT EQUAL XPC-FLD0502C
              DISPLAY 'FLD0502C ==> ' HEX-OF (FLD0502C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0502C).
           IF FLD0503C (1:)    NOT EQUAL XPC-FLD0503C
              DISPLAY 'FLD0503C ==> ' HEX-OF (FLD0503C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0503C).
           IF FLD0504C (1:)    NOT EQUAL XPC-FLD0504C
              DISPLAY 'FLD0504C ==> ' HEX-OF (FLD0504C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0504C).
           IF FLD0505C (1:)    NOT EQUAL XPC-FLD0505C
              DISPLAY 'FLD0505C ==> ' HEX-OF (FLD0505C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0505C).
           IF FLD0506C (1:)    NOT EQUAL XPC-FLD0506C
              DISPLAY 'FLD0506C ==> ' HEX-OF (FLD0506C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0506C).
           IF FLD0507C (1:)    NOT EQUAL XPC-FLD0507C
              DISPLAY 'FLD0507C ==> ' HEX-OF (FLD0507C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0507C).
           IF FLD0508C (1:)    NOT EQUAL XPC-FLD0508C
              DISPLAY 'FLD0508C ==> ' HEX-OF (FLD0508C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0508C).
           IF FLD0509C (1:)    NOT EQUAL XPC-FLD0509C
              DISPLAY 'FLD0509C ==> ' HEX-OF (FLD0509C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0509C).
           IF FLD0510C (1:)    NOT EQUAL XPC-FLD0510C
              DISPLAY 'FLD0510C ==> ' HEX-OF (FLD0510C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0510C).
           IF FLD0511C (1:)    NOT EQUAL XPC-FLD0511C
              DISPLAY 'FLD0511C ==> ' HEX-OF (FLD0511C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0511C).
           IF FLD0512C (1:)    NOT EQUAL XPC-FLD0512C
              DISPLAY 'FLD0512C ==> ' HEX-OF (FLD0512C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0512C).
           IF FLD0513C (1:)    NOT EQUAL XPC-FLD0513C
              DISPLAY 'FLD0513C ==> ' HEX-OF (FLD0513C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0513C).
           IF FLD0514C (1:)    NOT EQUAL XPC-FLD0514C
              DISPLAY 'FLD0514C ==> ' HEX-OF (FLD0514C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0514C).
           IF FLD0515C (1:)    NOT EQUAL XPC-FLD0515C
              DISPLAY 'FLD0515C ==> ' HEX-OF (FLD0515C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0515C).
           IF FLD0516C (1:)    NOT EQUAL XPC-FLD0516C
              DISPLAY 'FLD0516C ==> ' HEX-OF (FLD0516C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0516C).
           IF FLD0517C (1:)    NOT EQUAL XPC-FLD0517C
              DISPLAY 'FLD0517C ==> ' HEX-OF (FLD0517C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0517C).
           IF FLD0518C (1:)    NOT EQUAL XPC-FLD0518C
              DISPLAY 'FLD0518C ==> ' HEX-OF (FLD0518C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0518C).
           IF FLD0519C (1:)    NOT EQUAL XPC-FLD0519C
              DISPLAY 'FLD0519C ==> ' HEX-OF (FLD0519C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0519C).
           IF FLD0520C (1:)    NOT EQUAL XPC-FLD0520C
              DISPLAY 'FLD0520C ==> ' HEX-OF (FLD0520C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0520C).
           IF FLD0521C (1:)    NOT EQUAL XPC-FLD0521C
              DISPLAY 'FLD0521C ==> ' HEX-OF (FLD0521C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0521C).
           IF FLD0522C (1:)    NOT EQUAL XPC-FLD0522C
              DISPLAY 'FLD0522C ==> ' HEX-OF (FLD0522C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0522C).
           IF FLD0523C (1:)    NOT EQUAL XPC-FLD0523C
              DISPLAY 'FLD0523C ==> ' HEX-OF (FLD0523C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0523C).
           IF FLD0524C (1:)    NOT EQUAL XPC-FLD0524C
              DISPLAY 'FLD0524C ==> ' HEX-OF (FLD0524C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0524C).
           IF FLD0525C (1:)    NOT EQUAL XPC-FLD0525C
              DISPLAY 'FLD0525C ==> ' HEX-OF (FLD0525C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0525C).
           IF FLD0526C (1:)    NOT EQUAL XPC-FLD0526C
              DISPLAY 'FLD0526C ==> ' HEX-OF (FLD0526C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0526C).
           IF FLD0527C (1:)    NOT EQUAL XPC-FLD0527C
              DISPLAY 'FLD0527C ==> ' HEX-OF (FLD0527C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0527C).
           IF FLD0528C (1:)    NOT EQUAL XPC-FLD0528C
              DISPLAY 'FLD0528C ==> ' HEX-OF (FLD0528C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0528C).
           IF FLD0529C (1:)    NOT EQUAL XPC-FLD0529C
              DISPLAY 'FLD0529C ==> ' HEX-OF (FLD0529C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0529C).
           IF FLD0530C (1:)    NOT EQUAL XPC-FLD0530C
              DISPLAY 'FLD0530C ==> ' HEX-OF (FLD0530C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0530C).
           IF FLD0531C (1:)    NOT EQUAL XPC-FLD0531C
              DISPLAY 'FLD0531C ==> ' HEX-OF (FLD0531C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0531C).
           IF FLD0532C (1:)    NOT EQUAL XPC-FLD0532C
              DISPLAY 'FLD0532C ==> ' HEX-OF (FLD0532C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0532C).
           IF FLD0533C (1:)    NOT EQUAL XPC-FLD0533C
              DISPLAY 'FLD0533C ==> ' HEX-OF (FLD0533C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0533C).
           IF FLD0534C (1:)    NOT EQUAL XPC-FLD0534C
              DISPLAY 'FLD0534C ==> ' HEX-OF (FLD0534C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0534C).
           IF FLD0535C (1:)    NOT EQUAL XPC-FLD0535C
              DISPLAY 'FLD0535C ==> ' HEX-OF (FLD0535C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0535C).
           IF FLD0536C (1:)    NOT EQUAL XPC-FLD0536C
              DISPLAY 'FLD0536C ==> ' HEX-OF (FLD0536C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0536C).
           IF FLD0537C (1:)    NOT EQUAL XPC-FLD0537C
              DISPLAY 'FLD0537C ==> ' HEX-OF (FLD0537C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0537C).
           IF FLD0538C (1:)    NOT EQUAL XPC-FLD0538C
              DISPLAY 'FLD0538C ==> ' HEX-OF (FLD0538C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0538C).
           IF FLD0539C (1:)    NOT EQUAL XPC-FLD0539C
              DISPLAY 'FLD0539C ==> ' HEX-OF (FLD0539C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0539C).
           IF FLD0540C (1:)    NOT EQUAL XPC-FLD0540C
              DISPLAY 'FLD0540C ==> ' HEX-OF (FLD0540C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0540C).
           IF FLD0541C (1:)    NOT EQUAL XPC-FLD0541C
              DISPLAY 'FLD0541C ==> ' HEX-OF (FLD0541C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0541C).
           IF FLD0542C (1:)    NOT EQUAL XPC-FLD0542C
              DISPLAY 'FLD0542C ==> ' HEX-OF (FLD0542C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0542C).
           IF FLD0543C (1:)    NOT EQUAL XPC-FLD0543C
              DISPLAY 'FLD0543C ==> ' HEX-OF (FLD0543C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0543C).
           IF FLD0544C (1:)    NOT EQUAL XPC-FLD0544C
              DISPLAY 'FLD0544C ==> ' HEX-OF (FLD0544C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0544C).
           IF FLD0545C (1:)    NOT EQUAL XPC-FLD0545C
              DISPLAY 'FLD0545C ==> ' HEX-OF (FLD0545C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0545C).
           IF FLD0546C (1:)    NOT EQUAL XPC-FLD0546C
              DISPLAY 'FLD0546C ==> ' HEX-OF (FLD0546C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0546C).
           IF FLD0547C (1:)    NOT EQUAL XPC-FLD0547C
              DISPLAY 'FLD0547C ==> ' HEX-OF (FLD0547C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0547C).
           IF FLD0548C (1:)    NOT EQUAL XPC-FLD0548C
              DISPLAY 'FLD0548C ==> ' HEX-OF (FLD0548C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0548C).
           IF FLD0549C (1:)    NOT EQUAL XPC-FLD0549C
              DISPLAY 'FLD0549C ==> ' HEX-OF (FLD0549C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0549C).
           IF FLD0550C (1:)    NOT EQUAL XPC-FLD0550C
              DISPLAY 'FLD0550C ==> ' HEX-OF (FLD0550C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0550C).
           IF FLD0551C (1:)    NOT EQUAL XPC-FLD0551C
              DISPLAY 'FLD0551C ==> ' HEX-OF (FLD0551C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0551C).
           IF FLD0552C (1:)    NOT EQUAL XPC-FLD0552C
              DISPLAY 'FLD0552C ==> ' HEX-OF (FLD0552C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0552C).
           IF FLD0553C (1:)    NOT EQUAL XPC-FLD0553C
              DISPLAY 'FLD0553C ==> ' HEX-OF (FLD0553C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0553C).
           IF FLD0554C (1:)    NOT EQUAL XPC-FLD0554C
              DISPLAY 'FLD0554C ==> ' HEX-OF (FLD0554C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0554C).
           IF FLD0555C (1:)    NOT EQUAL XPC-FLD0555C
              DISPLAY 'FLD0555C ==> ' HEX-OF (FLD0555C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0555C).
           IF FLD0556C (1:)    NOT EQUAL XPC-FLD0556C
              DISPLAY 'FLD0556C ==> ' HEX-OF (FLD0556C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0556C).
           IF FLD0557C (1:)    NOT EQUAL XPC-FLD0557C
              DISPLAY 'FLD0557C ==> ' HEX-OF (FLD0557C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0557C).
           IF FLD0558C (1:)    NOT EQUAL XPC-FLD0558C
              DISPLAY 'FLD0558C ==> ' HEX-OF (FLD0558C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0558C).
           IF FLD0559C (1:)    NOT EQUAL XPC-FLD0559C
              DISPLAY 'FLD0559C ==> ' HEX-OF (FLD0559C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0559C).
           IF FLD0560C (1:)    NOT EQUAL XPC-FLD0560C
              DISPLAY 'FLD0560C ==> ' HEX-OF (FLD0560C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0560C).
           IF FLD0561C (1:)    NOT EQUAL XPC-FLD0561C
              DISPLAY 'FLD0561C ==> ' HEX-OF (FLD0561C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0561C).
           IF FLD0562C (1:)    NOT EQUAL XPC-FLD0562C
              DISPLAY 'FLD0562C ==> ' HEX-OF (FLD0562C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0562C).
           IF FLD0563C (1:)    NOT EQUAL XPC-FLD0563C
              DISPLAY 'FLD0563C ==> ' HEX-OF (FLD0563C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0563C).
           IF FLD0564C (1:)    NOT EQUAL XPC-FLD0564C
              DISPLAY 'FLD0564C ==> ' HEX-OF (FLD0564C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0564C).
           IF FLD0565C (1:)    NOT EQUAL XPC-FLD0565C
              DISPLAY 'FLD0565C ==> ' HEX-OF (FLD0565C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0565C).
           IF FLD0566C (1:)    NOT EQUAL XPC-FLD0566C
              DISPLAY 'FLD0566C ==> ' HEX-OF (FLD0566C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0566C).
           IF FLD0567C (1:)    NOT EQUAL XPC-FLD0567C
              DISPLAY 'FLD0567C ==> ' HEX-OF (FLD0567C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0567C).
           IF FLD0568C (1:)    NOT EQUAL XPC-FLD0568C
              DISPLAY 'FLD0568C ==> ' HEX-OF (FLD0568C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0568C).
           IF FLD0569C (1:)    NOT EQUAL XPC-FLD0569C
              DISPLAY 'FLD0569C ==> ' HEX-OF (FLD0569C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0569C).
           IF FLD0570C (1:)    NOT EQUAL XPC-FLD0570C
              DISPLAY 'FLD0570C ==> ' HEX-OF (FLD0570C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0570C).
           IF FLD0571C (1:)    NOT EQUAL XPC-FLD0571C
              DISPLAY 'FLD0571C ==> ' HEX-OF (FLD0571C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0571C).
           IF FLD0572C (1:)    NOT EQUAL XPC-FLD0572C
              DISPLAY 'FLD0572C ==> ' HEX-OF (FLD0572C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0572C).
           IF FLD0573C (1:)    NOT EQUAL XPC-FLD0573C
              DISPLAY 'FLD0573C ==> ' HEX-OF (FLD0573C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0573C).
           IF FLD0574C (1:)    NOT EQUAL XPC-FLD0574C
              DISPLAY 'FLD0574C ==> ' HEX-OF (FLD0574C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0574C).
           IF FLD0575C (1:)    NOT EQUAL XPC-FLD0575C
              DISPLAY 'FLD0575C ==> ' HEX-OF (FLD0575C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0575C).
           IF FLD0576C (1:)    NOT EQUAL XPC-FLD0576C
              DISPLAY 'FLD0576C ==> ' HEX-OF (FLD0576C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0576C).
           IF FLD0577C (1:)    NOT EQUAL XPC-FLD0577C
              DISPLAY 'FLD0577C ==> ' HEX-OF (FLD0577C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0577C).
           IF FLD0578C (1:)    NOT EQUAL XPC-FLD0578C
              DISPLAY 'FLD0578C ==> ' HEX-OF (FLD0578C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0578C).
           IF FLD0579C (1:)    NOT EQUAL XPC-FLD0579C
              DISPLAY 'FLD0579C ==> ' HEX-OF (FLD0579C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0579C).
           IF FLD0580C (1:)    NOT EQUAL XPC-FLD0580C
              DISPLAY 'FLD0580C ==> ' HEX-OF (FLD0580C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0580C).
           IF FLD0581C (1:)    NOT EQUAL XPC-FLD0581C
              DISPLAY 'FLD0581C ==> ' HEX-OF (FLD0581C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0581C).
           IF FLD0582C (1:)    NOT EQUAL XPC-FLD0582C
              DISPLAY 'FLD0582C ==> ' HEX-OF (FLD0582C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0582C).
           IF FLD0583C (1:)    NOT EQUAL XPC-FLD0583C
              DISPLAY 'FLD0583C ==> ' HEX-OF (FLD0583C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0583C).
           IF FLD0584C (1:)    NOT EQUAL XPC-FLD0584C
              DISPLAY 'FLD0584C ==> ' HEX-OF (FLD0584C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0584C).
           IF FLD0585C (1:)    NOT EQUAL XPC-FLD0585C
              DISPLAY 'FLD0585C ==> ' HEX-OF (FLD0585C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0585C).
           IF FLD0586C (1:)    NOT EQUAL XPC-FLD0586C
              DISPLAY 'FLD0586C ==> ' HEX-OF (FLD0586C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0586C).
           IF FLD0587C (1:)    NOT EQUAL XPC-FLD0587C
              DISPLAY 'FLD0587C ==> ' HEX-OF (FLD0587C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0587C).
           IF FLD0588C (1:)    NOT EQUAL XPC-FLD0588C
              DISPLAY 'FLD0588C ==> ' HEX-OF (FLD0588C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0588C).
           IF FLD0589C (1:)    NOT EQUAL XPC-FLD0589C
              DISPLAY 'FLD0589C ==> ' HEX-OF (FLD0589C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0589C).
           IF FLD0590C (1:)    NOT EQUAL XPC-FLD0590C
              DISPLAY 'FLD0590C ==> ' HEX-OF (FLD0590C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0590C).
           IF FLD0591C (1:)    NOT EQUAL XPC-FLD0591C
              DISPLAY 'FLD0591C ==> ' HEX-OF (FLD0591C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0591C).
           IF FLD0592C (1:)    NOT EQUAL XPC-FLD0592C
              DISPLAY 'FLD0592C ==> ' HEX-OF (FLD0592C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0592C).
           IF FLD0593C (1:)    NOT EQUAL XPC-FLD0593C
              DISPLAY 'FLD0593C ==> ' HEX-OF (FLD0593C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0593C).
           IF FLD0594C (1:)    NOT EQUAL XPC-FLD0594C
              DISPLAY 'FLD0594C ==> ' HEX-OF (FLD0594C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0594C).
           IF FLD0595C (1:)    NOT EQUAL XPC-FLD0595C
              DISPLAY 'FLD0595C ==> ' HEX-OF (FLD0595C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0595C).
           IF FLD0596C (1:)    NOT EQUAL XPC-FLD0596C
              DISPLAY 'FLD0596C ==> ' HEX-OF (FLD0596C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0596C).
           IF FLD0597C (1:)    NOT EQUAL XPC-FLD0597C
              DISPLAY 'FLD0597C ==> ' HEX-OF (FLD0597C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0597C).
           IF FLD0598C (1:)    NOT EQUAL XPC-FLD0598C
              DISPLAY 'FLD0598C ==> ' HEX-OF (FLD0598C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0598C).
           IF FLD0599C (1:)    NOT EQUAL XPC-FLD0599C
              DISPLAY 'FLD0599C ==> ' HEX-OF (FLD0599C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0599C).
           IF FLD0600C (1:)    NOT EQUAL XPC-FLD0600C
              DISPLAY 'FLD0600C ==> ' HEX-OF (FLD0600C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0600C).
           IF FLD0601C (1:)    NOT EQUAL XPC-FLD0601C
              DISPLAY 'FLD0601C ==> ' HEX-OF (FLD0601C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0601C).
           IF FLD0602C (1:)    NOT EQUAL XPC-FLD0602C
              DISPLAY 'FLD0602C ==> ' HEX-OF (FLD0602C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0602C).
           IF FLD0603C (1:)    NOT EQUAL XPC-FLD0603C
              DISPLAY 'FLD0603C ==> ' HEX-OF (FLD0603C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0603C).
           IF FLD0604C (1:)    NOT EQUAL XPC-FLD0604C
              DISPLAY 'FLD0604C ==> ' HEX-OF (FLD0604C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0604C).
           IF FLD0605C (1:)    NOT EQUAL XPC-FLD0605C
              DISPLAY 'FLD0605C ==> ' HEX-OF (FLD0605C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0605C).
           IF FLD0606C (1:)    NOT EQUAL XPC-FLD0606C
              DISPLAY 'FLD0606C ==> ' HEX-OF (FLD0606C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0606C).
           IF FLD0607C (1:)    NOT EQUAL XPC-FLD0607C
              DISPLAY 'FLD0607C ==> ' HEX-OF (FLD0607C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0607C).
           IF FLD0608C (1:)    NOT EQUAL XPC-FLD0608C
              DISPLAY 'FLD0608C ==> ' HEX-OF (FLD0608C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0608C).
           IF FLD0609C (1:)    NOT EQUAL XPC-FLD0609C
              DISPLAY 'FLD0609C ==> ' HEX-OF (FLD0609C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0609C).
           IF FLD0610C (1:)    NOT EQUAL XPC-FLD0610C
              DISPLAY 'FLD0610C ==> ' HEX-OF (FLD0610C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0610C).
           IF FLD0611C (1:)    NOT EQUAL XPC-FLD0611C
              DISPLAY 'FLD0611C ==> ' HEX-OF (FLD0611C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0611C).
           IF FLD0612C (1:)    NOT EQUAL XPC-FLD0612C
              DISPLAY 'FLD0612C ==> ' HEX-OF (FLD0612C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0612C).
           IF FLD0613C (1:)    NOT EQUAL XPC-FLD0613C
              DISPLAY 'FLD0613C ==> ' HEX-OF (FLD0613C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0613C).
           IF FLD0614C (1:)    NOT EQUAL XPC-FLD0614C
              DISPLAY 'FLD0614C ==> ' HEX-OF (FLD0614C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0614C).
           IF FLD0615C (1:)    NOT EQUAL XPC-FLD0615C
              DISPLAY 'FLD0615C ==> ' HEX-OF (FLD0615C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0615C).
           IF FLD0616C (1:)    NOT EQUAL XPC-FLD0616C
              DISPLAY 'FLD0616C ==> ' HEX-OF (FLD0616C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0616C).
           IF FLD0617C (1:)    NOT EQUAL XPC-FLD0617C
              DISPLAY 'FLD0617C ==> ' HEX-OF (FLD0617C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0617C).
           IF FLD0618C (1:)    NOT EQUAL XPC-FLD0618C
              DISPLAY 'FLD0618C ==> ' HEX-OF (FLD0618C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0618C).
           IF FLD0619C (1:)    NOT EQUAL XPC-FLD0619C
              DISPLAY 'FLD0619C ==> ' HEX-OF (FLD0619C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0619C).
           IF FLD0620C (1:)    NOT EQUAL XPC-FLD0620C
              DISPLAY 'FLD0620C ==> ' HEX-OF (FLD0620C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0620C).
           IF FLD0621C (1:)    NOT EQUAL XPC-FLD0621C
              DISPLAY 'FLD0621C ==> ' HEX-OF (FLD0621C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0621C).
           IF FLD0622C (1:)    NOT EQUAL XPC-FLD0622C
              DISPLAY 'FLD0622C ==> ' HEX-OF (FLD0622C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0622C).
           IF FLD0623C (1:)    NOT EQUAL XPC-FLD0623C
              DISPLAY 'FLD0623C ==> ' HEX-OF (FLD0623C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0623C).
           IF FLD0624C (1:)    NOT EQUAL XPC-FLD0624C
              DISPLAY 'FLD0624C ==> ' HEX-OF (FLD0624C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0624C).
           IF FLD0625C (1:)    NOT EQUAL XPC-FLD0625C
              DISPLAY 'FLD0625C ==> ' HEX-OF (FLD0625C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0625C).
           IF FLD0626C (1:)    NOT EQUAL XPC-FLD0626C
              DISPLAY 'FLD0626C ==> ' HEX-OF (FLD0626C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0626C).
           IF FLD0627C (1:)    NOT EQUAL XPC-FLD0627C
              DISPLAY 'FLD0627C ==> ' HEX-OF (FLD0627C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0627C).
           IF FLD0628C (1:)    NOT EQUAL XPC-FLD0628C
              DISPLAY 'FLD0628C ==> ' HEX-OF (FLD0628C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0628C).
           IF FLD0629C (1:)    NOT EQUAL XPC-FLD0629C
              DISPLAY 'FLD0629C ==> ' HEX-OF (FLD0629C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0629C).
           IF FLD0630C (1:)    NOT EQUAL XPC-FLD0630C
              DISPLAY 'FLD0630C ==> ' HEX-OF (FLD0630C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0630C).
           IF FLD0631C (1:)    NOT EQUAL XPC-FLD0631C
              DISPLAY 'FLD0631C ==> ' HEX-OF (FLD0631C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0631C).
           IF FLD0632C (1:)    NOT EQUAL XPC-FLD0632C
              DISPLAY 'FLD0632C ==> ' HEX-OF (FLD0632C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0632C).
           IF FLD0633C (1:)    NOT EQUAL XPC-FLD0633C
              DISPLAY 'FLD0633C ==> ' HEX-OF (FLD0633C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0633C).
           IF FLD0634C (1:)    NOT EQUAL XPC-FLD0634C
              DISPLAY 'FLD0634C ==> ' HEX-OF (FLD0634C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0634C).
           IF FLD0635C (1:)    NOT EQUAL XPC-FLD0635C
              DISPLAY 'FLD0635C ==> ' HEX-OF (FLD0635C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0635C).
           IF FLD0636C (1:)    NOT EQUAL XPC-FLD0636C
              DISPLAY 'FLD0636C ==> ' HEX-OF (FLD0636C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0636C).
           IF FLD0637C (1:)    NOT EQUAL XPC-FLD0637C
              DISPLAY 'FLD0637C ==> ' HEX-OF (FLD0637C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0637C).
           IF FLD0638C (1:)    NOT EQUAL XPC-FLD0638C
              DISPLAY 'FLD0638C ==> ' HEX-OF (FLD0638C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0638C).
           IF FLD0639C (1:)    NOT EQUAL XPC-FLD0639C
              DISPLAY 'FLD0639C ==> ' HEX-OF (FLD0639C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0639C).
           IF FLD0640C (1:)    NOT EQUAL XPC-FLD0640C
              DISPLAY 'FLD0640C ==> ' HEX-OF (FLD0640C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0640C).
           IF FLD0641C (1:)    NOT EQUAL XPC-FLD0641C
              DISPLAY 'FLD0641C ==> ' HEX-OF (FLD0641C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0641C).
           IF FLD0642C (1:)    NOT EQUAL XPC-FLD0642C
              DISPLAY 'FLD0642C ==> ' HEX-OF (FLD0642C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0642C).
           IF FLD0643C (1:)    NOT EQUAL XPC-FLD0643C
              DISPLAY 'FLD0643C ==> ' HEX-OF (FLD0643C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0643C).
           IF FLD0644C (1:)    NOT EQUAL XPC-FLD0644C
              DISPLAY 'FLD0644C ==> ' HEX-OF (FLD0644C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0644C).
           IF FLD0645C (1:)    NOT EQUAL XPC-FLD0645C
              DISPLAY 'FLD0645C ==> ' HEX-OF (FLD0645C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0645C).
           IF FLD0646C (1:)    NOT EQUAL XPC-FLD0646C
              DISPLAY 'FLD0646C ==> ' HEX-OF (FLD0646C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0646C).
           IF FLD0647C (1:)    NOT EQUAL XPC-FLD0647C
              DISPLAY 'FLD0647C ==> ' HEX-OF (FLD0647C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0647C).
           IF FLD0648C (1:)    NOT EQUAL XPC-FLD0648C
              DISPLAY 'FLD0648C ==> ' HEX-OF (FLD0648C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0648C).
           IF FLD0649C (1:)    NOT EQUAL XPC-FLD0649C
              DISPLAY 'FLD0649C ==> ' HEX-OF (FLD0649C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0649C).
           IF FLD0650C (1:)    NOT EQUAL XPC-FLD0650C
              DISPLAY 'FLD0650C ==> ' HEX-OF (FLD0650C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0650C).
           IF FLD0651C (1:)    NOT EQUAL XPC-FLD0651C
              DISPLAY 'FLD0651C ==> ' HEX-OF (FLD0651C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0651C).
           IF FLD0652C (1:)    NOT EQUAL XPC-FLD0652C
              DISPLAY 'FLD0652C ==> ' HEX-OF (FLD0652C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0652C).
           IF FLD0653C (1:)    NOT EQUAL XPC-FLD0653C
              DISPLAY 'FLD0653C ==> ' HEX-OF (FLD0653C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0653C).
           IF FLD0654C (1:)    NOT EQUAL XPC-FLD0654C
              DISPLAY 'FLD0654C ==> ' HEX-OF (FLD0654C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0654C).
           IF FLD0655C (1:)    NOT EQUAL XPC-FLD0655C
              DISPLAY 'FLD0655C ==> ' HEX-OF (FLD0655C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0655C).
           IF FLD0656C (1:)    NOT EQUAL XPC-FLD0656C
              DISPLAY 'FLD0656C ==> ' HEX-OF (FLD0656C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0656C).
           IF FLD0657C (1:)    NOT EQUAL XPC-FLD0657C
              DISPLAY 'FLD0657C ==> ' HEX-OF (FLD0657C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0657C).
           IF FLD0658C (1:)    NOT EQUAL XPC-FLD0658C
              DISPLAY 'FLD0658C ==> ' HEX-OF (FLD0658C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0658C).
           IF FLD0659C (1:)    NOT EQUAL XPC-FLD0659C
              DISPLAY 'FLD0659C ==> ' HEX-OF (FLD0659C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0659C).
           IF FLD0660C (1:)    NOT EQUAL XPC-FLD0660C
              DISPLAY 'FLD0660C ==> ' HEX-OF (FLD0660C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0660C).
           IF FLD0661C (1:)    NOT EQUAL XPC-FLD0661C
              DISPLAY 'FLD0661C ==> ' HEX-OF (FLD0661C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0661C).
           IF FLD0662C (1:)    NOT EQUAL XPC-FLD0662C
              DISPLAY 'FLD0662C ==> ' HEX-OF (FLD0662C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0662C).
           IF FLD0663C (1:)    NOT EQUAL XPC-FLD0663C
              DISPLAY 'FLD0663C ==> ' HEX-OF (FLD0663C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0663C).
           IF FLD0664C (1:)    NOT EQUAL XPC-FLD0664C
              DISPLAY 'FLD0664C ==> ' HEX-OF (FLD0664C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0664C).
           IF FLD0665C (1:)    NOT EQUAL XPC-FLD0665C
              DISPLAY 'FLD0665C ==> ' HEX-OF (FLD0665C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0665C).
           IF FLD0666C (1:)    NOT EQUAL XPC-FLD0666C
              DISPLAY 'FLD0666C ==> ' HEX-OF (FLD0666C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0666C).
           IF FLD0667C (1:)    NOT EQUAL XPC-FLD0667C
              DISPLAY 'FLD0667C ==> ' HEX-OF (FLD0667C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0667C).
           IF FLD0668C (1:)    NOT EQUAL XPC-FLD0668C
              DISPLAY 'FLD0668C ==> ' HEX-OF (FLD0668C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0668C).
           IF FLD0669C (1:)    NOT EQUAL XPC-FLD0669C
              DISPLAY 'FLD0669C ==> ' HEX-OF (FLD0669C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0669C).
           IF FLD0670C (1:)    NOT EQUAL XPC-FLD0670C
              DISPLAY 'FLD0670C ==> ' HEX-OF (FLD0670C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0670C).
           IF FLD0671C (1:)    NOT EQUAL XPC-FLD0671C
              DISPLAY 'FLD0671C ==> ' HEX-OF (FLD0671C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0671C).
           IF FLD0672C (1:)    NOT EQUAL XPC-FLD0672C
              DISPLAY 'FLD0672C ==> ' HEX-OF (FLD0672C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0672C).
           IF FLD0673C (1:)    NOT EQUAL XPC-FLD0673C
              DISPLAY 'FLD0673C ==> ' HEX-OF (FLD0673C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0673C).
           IF FLD0674C (1:)    NOT EQUAL XPC-FLD0674C
              DISPLAY 'FLD0674C ==> ' HEX-OF (FLD0674C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0674C).
           IF FLD0675C (1:)    NOT EQUAL XPC-FLD0675C
              DISPLAY 'FLD0675C ==> ' HEX-OF (FLD0675C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0675C).
           IF FLD0676C (1:)    NOT EQUAL XPC-FLD0676C
              DISPLAY 'FLD0676C ==> ' HEX-OF (FLD0676C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0676C).
           IF FLD0677C (1:)    NOT EQUAL XPC-FLD0677C
              DISPLAY 'FLD0677C ==> ' HEX-OF (FLD0677C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0677C).
           IF FLD0678C (1:)    NOT EQUAL XPC-FLD0678C
              DISPLAY 'FLD0678C ==> ' HEX-OF (FLD0678C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0678C).
           IF FLD0679C (1:)    NOT EQUAL XPC-FLD0679C
              DISPLAY 'FLD0679C ==> ' HEX-OF (FLD0679C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0679C).
           IF FLD0680C (1:)    NOT EQUAL XPC-FLD0680C
              DISPLAY 'FLD0680C ==> ' HEX-OF (FLD0680C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0680C).
           IF FLD0681C (1:)    NOT EQUAL XPC-FLD0681C
              DISPLAY 'FLD0681C ==> ' HEX-OF (FLD0681C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0681C).
           IF FLD0682C (1:)    NOT EQUAL XPC-FLD0682C
              DISPLAY 'FLD0682C ==> ' HEX-OF (FLD0682C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0682C).
           IF FLD0683C (1:)    NOT EQUAL XPC-FLD0683C
              DISPLAY 'FLD0683C ==> ' HEX-OF (FLD0683C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0683C).
           IF FLD0684C (1:)    NOT EQUAL XPC-FLD0684C
              DISPLAY 'FLD0684C ==> ' HEX-OF (FLD0684C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0684C).
           IF FLD0685C (1:)    NOT EQUAL XPC-FLD0685C
              DISPLAY 'FLD0685C ==> ' HEX-OF (FLD0685C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0685C).
           IF FLD0686C (1:)    NOT EQUAL XPC-FLD0686C
              DISPLAY 'FLD0686C ==> ' HEX-OF (FLD0686C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0686C).
           IF FLD0687C (1:)    NOT EQUAL XPC-FLD0687C
              DISPLAY 'FLD0687C ==> ' HEX-OF (FLD0687C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0687C).
           IF FLD0688C (1:)    NOT EQUAL XPC-FLD0688C
              DISPLAY 'FLD0688C ==> ' HEX-OF (FLD0688C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0688C).
           IF FLD0689C (1:)    NOT EQUAL XPC-FLD0689C
              DISPLAY 'FLD0689C ==> ' HEX-OF (FLD0689C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0689C).
           IF FLD0690C (1:)    NOT EQUAL XPC-FLD0690C
              DISPLAY 'FLD0690C ==> ' HEX-OF (FLD0690C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0690C).
           IF FLD0691C (1:)    NOT EQUAL XPC-FLD0691C
              DISPLAY 'FLD0691C ==> ' HEX-OF (FLD0691C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0691C).
           IF FLD0692C (1:)    NOT EQUAL XPC-FLD0692C
              DISPLAY 'FLD0692C ==> ' HEX-OF (FLD0692C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0692C).
           IF FLD0693C (1:)    NOT EQUAL XPC-FLD0693C
              DISPLAY 'FLD0693C ==> ' HEX-OF (FLD0693C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0693C).
           IF FLD0694C (1:)    NOT EQUAL XPC-FLD0694C
              DISPLAY 'FLD0694C ==> ' HEX-OF (FLD0694C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0694C).
           IF FLD0695C (1:)    NOT EQUAL XPC-FLD0695C
              DISPLAY 'FLD0695C ==> ' HEX-OF (FLD0695C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0695C).
           IF FLD0696C (1:)    NOT EQUAL XPC-FLD0696C
              DISPLAY 'FLD0696C ==> ' HEX-OF (FLD0696C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0696C).
           IF FLD0697C (1:)    NOT EQUAL XPC-FLD0697C
              DISPLAY 'FLD0697C ==> ' HEX-OF (FLD0697C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0697C).
           IF FLD0698C (1:)    NOT EQUAL XPC-FLD0698C
              DISPLAY 'FLD0698C ==> ' HEX-OF (FLD0698C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0698C).
           IF FLD0699C (1:)    NOT EQUAL XPC-FLD0699C
              DISPLAY 'FLD0699C ==> ' HEX-OF (FLD0699C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0699C).
           IF FLD0700C (1:)    NOT EQUAL XPC-FLD0700C
              DISPLAY 'FLD0700C ==> ' HEX-OF (FLD0700C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0700C).
           IF FLD0701C (1:)    NOT EQUAL XPC-FLD0701C
              DISPLAY 'FLD0701C ==> ' HEX-OF (FLD0701C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0701C).
           IF FLD0702C (1:)    NOT EQUAL XPC-FLD0702C
              DISPLAY 'FLD0702C ==> ' HEX-OF (FLD0702C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0702C).
           IF FLD0703C (1:)    NOT EQUAL XPC-FLD0703C
              DISPLAY 'FLD0703C ==> ' HEX-OF (FLD0703C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0703C).
           IF FLD0704C (1:)    NOT EQUAL XPC-FLD0704C
              DISPLAY 'FLD0704C ==> ' HEX-OF (FLD0704C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0704C).
           IF FLD0705C (1:)    NOT EQUAL XPC-FLD0705C
              DISPLAY 'FLD0705C ==> ' HEX-OF (FLD0705C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0705C).
           IF FLD0706C (1:)    NOT EQUAL XPC-FLD0706C
              DISPLAY 'FLD0706C ==> ' HEX-OF (FLD0706C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0706C).
           IF FLD0707C (1:)    NOT EQUAL XPC-FLD0707C
              DISPLAY 'FLD0707C ==> ' HEX-OF (FLD0707C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0707C).
           IF FLD0708C (1:)    NOT EQUAL XPC-FLD0708C
              DISPLAY 'FLD0708C ==> ' HEX-OF (FLD0708C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0708C).
           IF FLD0709C (1:)    NOT EQUAL XPC-FLD0709C
              DISPLAY 'FLD0709C ==> ' HEX-OF (FLD0709C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0709C).
           IF FLD0710C (1:)    NOT EQUAL XPC-FLD0710C
              DISPLAY 'FLD0710C ==> ' HEX-OF (FLD0710C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0710C).
           IF FLD0711C (1:)    NOT EQUAL XPC-FLD0711C
              DISPLAY 'FLD0711C ==> ' HEX-OF (FLD0711C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0711C).
           IF FLD0712C (1:)    NOT EQUAL XPC-FLD0712C
              DISPLAY 'FLD0712C ==> ' HEX-OF (FLD0712C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0712C).
           IF FLD0713C (1:)    NOT EQUAL XPC-FLD0713C
              DISPLAY 'FLD0713C ==> ' HEX-OF (FLD0713C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0713C).
           IF FLD0714C (1:)    NOT EQUAL XPC-FLD0714C
              DISPLAY 'FLD0714C ==> ' HEX-OF (FLD0714C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0714C).
           IF FLD0715C (1:)    NOT EQUAL XPC-FLD0715C
              DISPLAY 'FLD0715C ==> ' HEX-OF (FLD0715C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0715C).
           IF FLD0716C (1:)    NOT EQUAL XPC-FLD0716C
              DISPLAY 'FLD0716C ==> ' HEX-OF (FLD0716C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0716C).
           IF FLD0717C (1:)    NOT EQUAL XPC-FLD0717C
              DISPLAY 'FLD0717C ==> ' HEX-OF (FLD0717C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0717C).
           IF FLD0718C (1:)    NOT EQUAL XPC-FLD0718C
              DISPLAY 'FLD0718C ==> ' HEX-OF (FLD0718C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0718C).
           IF FLD0719C (1:)    NOT EQUAL XPC-FLD0719C
              DISPLAY 'FLD0719C ==> ' HEX-OF (FLD0719C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0719C).
           IF FLD0720C (1:)    NOT EQUAL XPC-FLD0720C
              DISPLAY 'FLD0720C ==> ' HEX-OF (FLD0720C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0720C).
           IF FLD0721C (1:)    NOT EQUAL XPC-FLD0721C
              DISPLAY 'FLD0721C ==> ' HEX-OF (FLD0721C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0721C).
           IF FLD0722C (1:)    NOT EQUAL XPC-FLD0722C
              DISPLAY 'FLD0722C ==> ' HEX-OF (FLD0722C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0722C).
           IF FLD0723C (1:)    NOT EQUAL XPC-FLD0723C
              DISPLAY 'FLD0723C ==> ' HEX-OF (FLD0723C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0723C).
           IF FLD0724C (1:)    NOT EQUAL XPC-FLD0724C
              DISPLAY 'FLD0724C ==> ' HEX-OF (FLD0724C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0724C).
           IF FLD0725C (1:)    NOT EQUAL XPC-FLD0725C
              DISPLAY 'FLD0725C ==> ' HEX-OF (FLD0725C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0725C).
           IF FLD0726C (1:)    NOT EQUAL XPC-FLD0726C
              DISPLAY 'FLD0726C ==> ' HEX-OF (FLD0726C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0726C).
           IF FLD0727C (1:)    NOT EQUAL XPC-FLD0727C
              DISPLAY 'FLD0727C ==> ' HEX-OF (FLD0727C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0727C).
           IF FLD0728C (1:)    NOT EQUAL XPC-FLD0728C
              DISPLAY 'FLD0728C ==> ' HEX-OF (FLD0728C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0728C).
           IF FLD0729C (1:)    NOT EQUAL XPC-FLD0729C
              DISPLAY 'FLD0729C ==> ' HEX-OF (FLD0729C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0729C).
           IF FLD0730C (1:)    NOT EQUAL XPC-FLD0730C
              DISPLAY 'FLD0730C ==> ' HEX-OF (FLD0730C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0730C).
           IF FLD0731C (1:)    NOT EQUAL XPC-FLD0731C
              DISPLAY 'FLD0731C ==> ' HEX-OF (FLD0731C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0731C).
           IF FLD0732C (1:)    NOT EQUAL XPC-FLD0732C
              DISPLAY 'FLD0732C ==> ' HEX-OF (FLD0732C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0732C).
           IF FLD0733C (1:)    NOT EQUAL XPC-FLD0733C
              DISPLAY 'FLD0733C ==> ' HEX-OF (FLD0733C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0733C).
           IF FLD0734C (1:)    NOT EQUAL XPC-FLD0734C
              DISPLAY 'FLD0734C ==> ' HEX-OF (FLD0734C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0734C).
           IF FLD0735C (1:)    NOT EQUAL XPC-FLD0735C
              DISPLAY 'FLD0735C ==> ' HEX-OF (FLD0735C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0735C).
           IF FLD0736C (1:)    NOT EQUAL XPC-FLD0736C
              DISPLAY 'FLD0736C ==> ' HEX-OF (FLD0736C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0736C).
           IF FLD0737C (1:)    NOT EQUAL XPC-FLD0737C
              DISPLAY 'FLD0737C ==> ' HEX-OF (FLD0737C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0737C).
           IF FLD0738C (1:)    NOT EQUAL XPC-FLD0738C
              DISPLAY 'FLD0738C ==> ' HEX-OF (FLD0738C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0738C).
           IF FLD0739C (1:)    NOT EQUAL XPC-FLD0739C
              DISPLAY 'FLD0739C ==> ' HEX-OF (FLD0739C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0739C).
           IF FLD0740C (1:)    NOT EQUAL XPC-FLD0740C
              DISPLAY 'FLD0740C ==> ' HEX-OF (FLD0740C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0740C).
           IF FLD0741C (1:)    NOT EQUAL XPC-FLD0741C
              DISPLAY 'FLD0741C ==> ' HEX-OF (FLD0741C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0741C).
           IF FLD0742C (1:)    NOT EQUAL XPC-FLD0742C
              DISPLAY 'FLD0742C ==> ' HEX-OF (FLD0742C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0742C).
           IF FLD0743C (1:)    NOT EQUAL XPC-FLD0743C
              DISPLAY 'FLD0743C ==> ' HEX-OF (FLD0743C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0743C).
           IF FLD0744C (1:)    NOT EQUAL XPC-FLD0744C
              DISPLAY 'FLD0744C ==> ' HEX-OF (FLD0744C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0744C).
           IF FLD0745C (1:)    NOT EQUAL XPC-FLD0745C
              DISPLAY 'FLD0745C ==> ' HEX-OF (FLD0745C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0745C).
           IF FLD0746C (1:)    NOT EQUAL XPC-FLD0746C
              DISPLAY 'FLD0746C ==> ' HEX-OF (FLD0746C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0746C).
           IF FLD0747C (1:)    NOT EQUAL XPC-FLD0747C
              DISPLAY 'FLD0747C ==> ' HEX-OF (FLD0747C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0747C).
           IF FLD0748C (1:)    NOT EQUAL XPC-FLD0748C
              DISPLAY 'FLD0748C ==> ' HEX-OF (FLD0748C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0748C).
           IF FLD0749C (1:)    NOT EQUAL XPC-FLD0749C
              DISPLAY 'FLD0749C ==> ' HEX-OF (FLD0749C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0749C).
           IF FLD0750C (1:)    NOT EQUAL XPC-FLD0750C
              DISPLAY 'FLD0750C ==> ' HEX-OF (FLD0750C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0750C).
           IF FLD0751C (1:)    NOT EQUAL XPC-FLD0751C
              DISPLAY 'FLD0751C ==> ' HEX-OF (FLD0751C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0751C).
           IF FLD0752C (1:)    NOT EQUAL XPC-FLD0752C
              DISPLAY 'FLD0752C ==> ' HEX-OF (FLD0752C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0752C).
           IF FLD0753C (1:)    NOT EQUAL XPC-FLD0753C
              DISPLAY 'FLD0753C ==> ' HEX-OF (FLD0753C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0753C).
           IF FLD0754C (1:)    NOT EQUAL XPC-FLD0754C
              DISPLAY 'FLD0754C ==> ' HEX-OF (FLD0754C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0754C).
           IF FLD0755C (1:)    NOT EQUAL XPC-FLD0755C
              DISPLAY 'FLD0755C ==> ' HEX-OF (FLD0755C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0755C).
           IF FLD0756C (1:)    NOT EQUAL XPC-FLD0756C
              DISPLAY 'FLD0756C ==> ' HEX-OF (FLD0756C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0756C).
           IF FLD0757C (1:)    NOT EQUAL XPC-FLD0757C
              DISPLAY 'FLD0757C ==> ' HEX-OF (FLD0757C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0757C).
           IF FLD0758C (1:)    NOT EQUAL XPC-FLD0758C
              DISPLAY 'FLD0758C ==> ' HEX-OF (FLD0758C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0758C).
           IF FLD0759C (1:)    NOT EQUAL XPC-FLD0759C
              DISPLAY 'FLD0759C ==> ' HEX-OF (FLD0759C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0759C).
           IF FLD0760C (1:)    NOT EQUAL XPC-FLD0760C
              DISPLAY 'FLD0760C ==> ' HEX-OF (FLD0760C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0760C).
           IF FLD0761C (1:)    NOT EQUAL XPC-FLD0761C
              DISPLAY 'FLD0761C ==> ' HEX-OF (FLD0761C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0761C).
           IF FLD0762C (1:)    NOT EQUAL XPC-FLD0762C
              DISPLAY 'FLD0762C ==> ' HEX-OF (FLD0762C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0762C).
           IF FLD0763C (1:)    NOT EQUAL XPC-FLD0763C
              DISPLAY 'FLD0763C ==> ' HEX-OF (FLD0763C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0763C).
           IF FLD0764C (1:)    NOT EQUAL XPC-FLD0764C
              DISPLAY 'FLD0764C ==> ' HEX-OF (FLD0764C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0764C).
           IF FLD0765C (1:)    NOT EQUAL XPC-FLD0765C
              DISPLAY 'FLD0765C ==> ' HEX-OF (FLD0765C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0765C).
           IF FLD0766C (1:)    NOT EQUAL XPC-FLD0766C
              DISPLAY 'FLD0766C ==> ' HEX-OF (FLD0766C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0766C).
           IF FLD0767C (1:)    NOT EQUAL XPC-FLD0767C
              DISPLAY 'FLD0767C ==> ' HEX-OF (FLD0767C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0767C).
           IF FLD0768C (1:)    NOT EQUAL XPC-FLD0768C
              DISPLAY 'FLD0768C ==> ' HEX-OF (FLD0768C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0768C).
           IF FLD0769C (1:)    NOT EQUAL XPC-FLD0769C
              DISPLAY 'FLD0769C ==> ' HEX-OF (FLD0769C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0769C).
           IF FLD0770C (1:)    NOT EQUAL XPC-FLD0770C
              DISPLAY 'FLD0770C ==> ' HEX-OF (FLD0770C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0770C).
           IF FLD0771C (1:)    NOT EQUAL XPC-FLD0771C
              DISPLAY 'FLD0771C ==> ' HEX-OF (FLD0771C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0771C).
           IF FLD0772C (1:)    NOT EQUAL XPC-FLD0772C
              DISPLAY 'FLD0772C ==> ' HEX-OF (FLD0772C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0772C).
           IF FLD0773C (1:)    NOT EQUAL XPC-FLD0773C
              DISPLAY 'FLD0773C ==> ' HEX-OF (FLD0773C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0773C).
           IF FLD0774C (1:)    NOT EQUAL XPC-FLD0774C
              DISPLAY 'FLD0774C ==> ' HEX-OF (FLD0774C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0774C).
           IF FLD0775C (1:)    NOT EQUAL XPC-FLD0775C
              DISPLAY 'FLD0775C ==> ' HEX-OF (FLD0775C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0775C).
           IF FLD0776C (1:)    NOT EQUAL XPC-FLD0776C
              DISPLAY 'FLD0776C ==> ' HEX-OF (FLD0776C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0776C).
           IF FLD0777C (1:)    NOT EQUAL XPC-FLD0777C
              DISPLAY 'FLD0777C ==> ' HEX-OF (FLD0777C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0777C).
           IF FLD0778C (1:)    NOT EQUAL XPC-FLD0778C
              DISPLAY 'FLD0778C ==> ' HEX-OF (FLD0778C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0778C).
           IF FLD0779C (1:)    NOT EQUAL XPC-FLD0779C
              DISPLAY 'FLD0779C ==> ' HEX-OF (FLD0779C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0779C).
           IF FLD0780C (1:)    NOT EQUAL XPC-FLD0780C
              DISPLAY 'FLD0780C ==> ' HEX-OF (FLD0780C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0780C).
           IF FLD0781C (1:)    NOT EQUAL XPC-FLD0781C
              DISPLAY 'FLD0781C ==> ' HEX-OF (FLD0781C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0781C).
           IF FLD0782C (1:)    NOT EQUAL XPC-FLD0782C
              DISPLAY 'FLD0782C ==> ' HEX-OF (FLD0782C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0782C).
           IF FLD0783C (1:)    NOT EQUAL XPC-FLD0783C
              DISPLAY 'FLD0783C ==> ' HEX-OF (FLD0783C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0783C).
           IF FLD0784C (1:)    NOT EQUAL XPC-FLD0784C
              DISPLAY 'FLD0784C ==> ' HEX-OF (FLD0784C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0784C).
           IF FLD0785C (1:)    NOT EQUAL XPC-FLD0785C
              DISPLAY 'FLD0785C ==> ' HEX-OF (FLD0785C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0785C).
           IF FLD0786C (1:)    NOT EQUAL XPC-FLD0786C
              DISPLAY 'FLD0786C ==> ' HEX-OF (FLD0786C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0786C).
           IF FLD0787C (1:)    NOT EQUAL XPC-FLD0787C
              DISPLAY 'FLD0787C ==> ' HEX-OF (FLD0787C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0787C).
           IF FLD0788C (1:)    NOT EQUAL XPC-FLD0788C
              DISPLAY 'FLD0788C ==> ' HEX-OF (FLD0788C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0788C).
           IF FLD0789C (1:)    NOT EQUAL XPC-FLD0789C
              DISPLAY 'FLD0789C ==> ' HEX-OF (FLD0789C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0789C).
           IF FLD0790C (1:)    NOT EQUAL XPC-FLD0790C
              DISPLAY 'FLD0790C ==> ' HEX-OF (FLD0790C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0790C).
           IF FLD0791C (1:)    NOT EQUAL XPC-FLD0791C
              DISPLAY 'FLD0791C ==> ' HEX-OF (FLD0791C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0791C).
           IF FLD0792C (1:)    NOT EQUAL XPC-FLD0792C
              DISPLAY 'FLD0792C ==> ' HEX-OF (FLD0792C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0792C).
           IF FLD0793C (1:)    NOT EQUAL XPC-FLD0793C
              DISPLAY 'FLD0793C ==> ' HEX-OF (FLD0793C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0793C).
           IF FLD0794C (1:)    NOT EQUAL XPC-FLD0794C
              DISPLAY 'FLD0794C ==> ' HEX-OF (FLD0794C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0794C).
           IF FLD0795C (1:)    NOT EQUAL XPC-FLD0795C
              DISPLAY 'FLD0795C ==> ' HEX-OF (FLD0795C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0795C).
           IF FLD0796C (1:)    NOT EQUAL XPC-FLD0796C
              DISPLAY 'FLD0796C ==> ' HEX-OF (FLD0796C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0796C).
           IF FLD0797C (1:)    NOT EQUAL XPC-FLD0797C
              DISPLAY 'FLD0797C ==> ' HEX-OF (FLD0797C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0797C).
           IF FLD0798C (1:)    NOT EQUAL XPC-FLD0798C
              DISPLAY 'FLD0798C ==> ' HEX-OF (FLD0798C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0798C).
           IF FLD0799C (1:)    NOT EQUAL XPC-FLD0799C
              DISPLAY 'FLD0799C ==> ' HEX-OF (FLD0799C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0799C).
           IF FLD0800C (1:)    NOT EQUAL XPC-FLD0800C
              DISPLAY 'FLD0800C ==> ' HEX-OF (FLD0800C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0800C).
           IF FLD0801C (1:)    NOT EQUAL XPC-FLD0801C
              DISPLAY 'FLD0801C ==> ' HEX-OF (FLD0801C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0801C).
           IF FLD0802C (1:)    NOT EQUAL XPC-FLD0802C
              DISPLAY 'FLD0802C ==> ' HEX-OF (FLD0802C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0802C).
           IF FLD0803C (1:)    NOT EQUAL XPC-FLD0803C
              DISPLAY 'FLD0803C ==> ' HEX-OF (FLD0803C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0803C).
           IF FLD0804C (1:)    NOT EQUAL XPC-FLD0804C
              DISPLAY 'FLD0804C ==> ' HEX-OF (FLD0804C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0804C).
           IF FLD0805C (1:)    NOT EQUAL XPC-FLD0805C
              DISPLAY 'FLD0805C ==> ' HEX-OF (FLD0805C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0805C).
           IF FLD0806C (1:)    NOT EQUAL XPC-FLD0806C
              DISPLAY 'FLD0806C ==> ' HEX-OF (FLD0806C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0806C).
           IF FLD0807C (1:)    NOT EQUAL XPC-FLD0807C
              DISPLAY 'FLD0807C ==> ' HEX-OF (FLD0807C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0807C).
           IF FLD0808C (1:)    NOT EQUAL XPC-FLD0808C
              DISPLAY 'FLD0808C ==> ' HEX-OF (FLD0808C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0808C).
           IF FLD0809C (1:)    NOT EQUAL XPC-FLD0809C
              DISPLAY 'FLD0809C ==> ' HEX-OF (FLD0809C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0809C).
           IF FLD0810C (1:)    NOT EQUAL XPC-FLD0810C
              DISPLAY 'FLD0810C ==> ' HEX-OF (FLD0810C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0810C).
           IF FLD0811C (1:)    NOT EQUAL XPC-FLD0811C
              DISPLAY 'FLD0811C ==> ' HEX-OF (FLD0811C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0811C).
           IF FLD0812C (1:)    NOT EQUAL XPC-FLD0812C
              DISPLAY 'FLD0812C ==> ' HEX-OF (FLD0812C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0812C).
           IF FLD0813C (1:)    NOT EQUAL XPC-FLD0813C
              DISPLAY 'FLD0813C ==> ' HEX-OF (FLD0813C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0813C).
           IF FLD0814C (1:)    NOT EQUAL XPC-FLD0814C
              DISPLAY 'FLD0814C ==> ' HEX-OF (FLD0814C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0814C).
           IF FLD0815C (1:)    NOT EQUAL XPC-FLD0815C
              DISPLAY 'FLD0815C ==> ' HEX-OF (FLD0815C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0815C).
           IF FLD0816C (1:)    NOT EQUAL XPC-FLD0816C
              DISPLAY 'FLD0816C ==> ' HEX-OF (FLD0816C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0816C).
           IF FLD0817C (1:)    NOT EQUAL XPC-FLD0817C
              DISPLAY 'FLD0817C ==> ' HEX-OF (FLD0817C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0817C).
           IF FLD0818C (1:)    NOT EQUAL XPC-FLD0818C
              DISPLAY 'FLD0818C ==> ' HEX-OF (FLD0818C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0818C).
           IF FLD0819C (1:)    NOT EQUAL XPC-FLD0819C
              DISPLAY 'FLD0819C ==> ' HEX-OF (FLD0819C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0819C).
           IF FLD0820C (1:)    NOT EQUAL XPC-FLD0820C
              DISPLAY 'FLD0820C ==> ' HEX-OF (FLD0820C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0820C).
           IF FLD0821C (1:)    NOT EQUAL XPC-FLD0821C
              DISPLAY 'FLD0821C ==> ' HEX-OF (FLD0821C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0821C).
           IF FLD0822C (1:)    NOT EQUAL XPC-FLD0822C
              DISPLAY 'FLD0822C ==> ' HEX-OF (FLD0822C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0822C).
           IF FLD0823C (1:)    NOT EQUAL XPC-FLD0823C
              DISPLAY 'FLD0823C ==> ' HEX-OF (FLD0823C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0823C).
           IF FLD0824C (1:)    NOT EQUAL XPC-FLD0824C
              DISPLAY 'FLD0824C ==> ' HEX-OF (FLD0824C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0824C).
           IF FLD0825C (1:)    NOT EQUAL XPC-FLD0825C
              DISPLAY 'FLD0825C ==> ' HEX-OF (FLD0825C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0825C).
           IF FLD0826C (1:)    NOT EQUAL XPC-FLD0826C
              DISPLAY 'FLD0826C ==> ' HEX-OF (FLD0826C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0826C).
           IF FLD0827C (1:)    NOT EQUAL XPC-FLD0827C
              DISPLAY 'FLD0827C ==> ' HEX-OF (FLD0827C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0827C).
           IF FLD0828C (1:)    NOT EQUAL XPC-FLD0828C
              DISPLAY 'FLD0828C ==> ' HEX-OF (FLD0828C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0828C).
           IF FLD0829C (1:)    NOT EQUAL XPC-FLD0829C
              DISPLAY 'FLD0829C ==> ' HEX-OF (FLD0829C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0829C).
           IF FLD0830C (1:)    NOT EQUAL XPC-FLD0830C
              DISPLAY 'FLD0830C ==> ' HEX-OF (FLD0830C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0830C).
           IF FLD0831C (1:)    NOT EQUAL XPC-FLD0831C
              DISPLAY 'FLD0831C ==> ' HEX-OF (FLD0831C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0831C).
           IF FLD0832C (1:)    NOT EQUAL XPC-FLD0832C
              DISPLAY 'FLD0832C ==> ' HEX-OF (FLD0832C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0832C).
           IF FLD0833C (1:)    NOT EQUAL XPC-FLD0833C
              DISPLAY 'FLD0833C ==> ' HEX-OF (FLD0833C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0833C).
           IF FLD0834C (1:)    NOT EQUAL XPC-FLD0834C
              DISPLAY 'FLD0834C ==> ' HEX-OF (FLD0834C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0834C).
           IF FLD0835C (1:)    NOT EQUAL XPC-FLD0835C
              DISPLAY 'FLD0835C ==> ' HEX-OF (FLD0835C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0835C).
           IF FLD0836C (1:)    NOT EQUAL XPC-FLD0836C
              DISPLAY 'FLD0836C ==> ' HEX-OF (FLD0836C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0836C).
           IF FLD0837C (1:)    NOT EQUAL XPC-FLD0837C
              DISPLAY 'FLD0837C ==> ' HEX-OF (FLD0837C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0837C).
           IF FLD0838C (1:)    NOT EQUAL XPC-FLD0838C
              DISPLAY 'FLD0838C ==> ' HEX-OF (FLD0838C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0838C).
           IF FLD0839C (1:)    NOT EQUAL XPC-FLD0839C
              DISPLAY 'FLD0839C ==> ' HEX-OF (FLD0839C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0839C).
           IF FLD0840C (1:)    NOT EQUAL XPC-FLD0840C
              DISPLAY 'FLD0840C ==> ' HEX-OF (FLD0840C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0840C).
           IF FLD0841C (1:)    NOT EQUAL XPC-FLD0841C
              DISPLAY 'FLD0841C ==> ' HEX-OF (FLD0841C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0841C).
           IF FLD0842C (1:)    NOT EQUAL XPC-FLD0842C
              DISPLAY 'FLD0842C ==> ' HEX-OF (FLD0842C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0842C).
           IF FLD0843C (1:)    NOT EQUAL XPC-FLD0843C
              DISPLAY 'FLD0843C ==> ' HEX-OF (FLD0843C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0843C).
           IF FLD0844C (1:)    NOT EQUAL XPC-FLD0844C
              DISPLAY 'FLD0844C ==> ' HEX-OF (FLD0844C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0844C).
           IF FLD0845C (1:)    NOT EQUAL XPC-FLD0845C
              DISPLAY 'FLD0845C ==> ' HEX-OF (FLD0845C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0845C).
           IF FLD0846C (1:)    NOT EQUAL XPC-FLD0846C
              DISPLAY 'FLD0846C ==> ' HEX-OF (FLD0846C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0846C).
           IF FLD0847C (1:)    NOT EQUAL XPC-FLD0847C
              DISPLAY 'FLD0847C ==> ' HEX-OF (FLD0847C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0847C).
           IF FLD0848C (1:)    NOT EQUAL XPC-FLD0848C
              DISPLAY 'FLD0848C ==> ' HEX-OF (FLD0848C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0848C).
           IF FLD0849C (1:)    NOT EQUAL XPC-FLD0849C
              DISPLAY 'FLD0849C ==> ' HEX-OF (FLD0849C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0849C).
           IF FLD0850C (1:)    NOT EQUAL XPC-FLD0850C
              DISPLAY 'FLD0850C ==> ' HEX-OF (FLD0850C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0850C).
           IF FLD0851C (1:)    NOT EQUAL XPC-FLD0851C
              DISPLAY 'FLD0851C ==> ' HEX-OF (FLD0851C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0851C).
           IF FLD0852C (1:)    NOT EQUAL XPC-FLD0852C
              DISPLAY 'FLD0852C ==> ' HEX-OF (FLD0852C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0852C).
           IF FLD0853C (1:)    NOT EQUAL XPC-FLD0853C
              DISPLAY 'FLD0853C ==> ' HEX-OF (FLD0853C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0853C).
           IF FLD0854C (1:)    NOT EQUAL XPC-FLD0854C
              DISPLAY 'FLD0854C ==> ' HEX-OF (FLD0854C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0854C).
           IF FLD0855C (1:)    NOT EQUAL XPC-FLD0855C
              DISPLAY 'FLD0855C ==> ' HEX-OF (FLD0855C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0855C).
           IF FLD0856C (1:)    NOT EQUAL XPC-FLD0856C
              DISPLAY 'FLD0856C ==> ' HEX-OF (FLD0856C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0856C).
           IF FLD0857C (1:)    NOT EQUAL XPC-FLD0857C
              DISPLAY 'FLD0857C ==> ' HEX-OF (FLD0857C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0857C).
           IF FLD0858C (1:)    NOT EQUAL XPC-FLD0858C
              DISPLAY 'FLD0858C ==> ' HEX-OF (FLD0858C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0858C).
           IF FLD0859C (1:)    NOT EQUAL XPC-FLD0859C
              DISPLAY 'FLD0859C ==> ' HEX-OF (FLD0859C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0859C).
           IF FLD0860C (1:)    NOT EQUAL XPC-FLD0860C
              DISPLAY 'FLD0860C ==> ' HEX-OF (FLD0860C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0860C).
           IF FLD0861C (1:)    NOT EQUAL XPC-FLD0861C
              DISPLAY 'FLD0861C ==> ' HEX-OF (FLD0861C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0861C).
           IF FLD0862C (1:)    NOT EQUAL XPC-FLD0862C
              DISPLAY 'FLD0862C ==> ' HEX-OF (FLD0862C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0862C).
           IF FLD0863C (1:)    NOT EQUAL XPC-FLD0863C
              DISPLAY 'FLD0863C ==> ' HEX-OF (FLD0863C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0863C).
           IF FLD0864C (1:)    NOT EQUAL XPC-FLD0864C
              DISPLAY 'FLD0864C ==> ' HEX-OF (FLD0864C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0864C).
           IF FLD0865C (1:)    NOT EQUAL XPC-FLD0865C
              DISPLAY 'FLD0865C ==> ' HEX-OF (FLD0865C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0865C).
           IF FLD0866C (1:)    NOT EQUAL XPC-FLD0866C
              DISPLAY 'FLD0866C ==> ' HEX-OF (FLD0866C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0866C).
           IF FLD0867C (1:)    NOT EQUAL XPC-FLD0867C
              DISPLAY 'FLD0867C ==> ' HEX-OF (FLD0867C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0867C).
           IF FLD0868C (1:)    NOT EQUAL XPC-FLD0868C
              DISPLAY 'FLD0868C ==> ' HEX-OF (FLD0868C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0868C).
           IF FLD0869C (1:)    NOT EQUAL XPC-FLD0869C
              DISPLAY 'FLD0869C ==> ' HEX-OF (FLD0869C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0869C).
           IF FLD0870C (1:)    NOT EQUAL XPC-FLD0870C
              DISPLAY 'FLD0870C ==> ' HEX-OF (FLD0870C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0870C).
           IF FLD0871C (1:)    NOT EQUAL XPC-FLD0871C
              DISPLAY 'FLD0871C ==> ' HEX-OF (FLD0871C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0871C).
           IF FLD0872C (1:)    NOT EQUAL XPC-FLD0872C
              DISPLAY 'FLD0872C ==> ' HEX-OF (FLD0872C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0872C).
           IF FLD0873C (1:)    NOT EQUAL XPC-FLD0873C
              DISPLAY 'FLD0873C ==> ' HEX-OF (FLD0873C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0873C).
           IF FLD0874C (1:)    NOT EQUAL XPC-FLD0874C
              DISPLAY 'FLD0874C ==> ' HEX-OF (FLD0874C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0874C).
           IF FLD0875C (1:)    NOT EQUAL XPC-FLD0875C
              DISPLAY 'FLD0875C ==> ' HEX-OF (FLD0875C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0875C).
           IF FLD0876C (1:)    NOT EQUAL XPC-FLD0876C
              DISPLAY 'FLD0876C ==> ' HEX-OF (FLD0876C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0876C).
           IF FLD0877C (1:)    NOT EQUAL XPC-FLD0877C
              DISPLAY 'FLD0877C ==> ' HEX-OF (FLD0877C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0877C).
           IF FLD0878C (1:)    NOT EQUAL XPC-FLD0878C
              DISPLAY 'FLD0878C ==> ' HEX-OF (FLD0878C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0878C).
           IF FLD0879C (1:)    NOT EQUAL XPC-FLD0879C
              DISPLAY 'FLD0879C ==> ' HEX-OF (FLD0879C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0879C).
           IF FLD0880C (1:)    NOT EQUAL XPC-FLD0880C
              DISPLAY 'FLD0880C ==> ' HEX-OF (FLD0880C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0880C).
           IF FLD0881C (1:)    NOT EQUAL XPC-FLD0881C
              DISPLAY 'FLD0881C ==> ' HEX-OF (FLD0881C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0881C).
           IF FLD0882C (1:)    NOT EQUAL XPC-FLD0882C
              DISPLAY 'FLD0882C ==> ' HEX-OF (FLD0882C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0882C).
           IF FLD0883C (1:)    NOT EQUAL XPC-FLD0883C
              DISPLAY 'FLD0883C ==> ' HEX-OF (FLD0883C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0883C).
           IF FLD0884C (1:)    NOT EQUAL XPC-FLD0884C
              DISPLAY 'FLD0884C ==> ' HEX-OF (FLD0884C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0884C).
           IF FLD0885C (1:)    NOT EQUAL XPC-FLD0885C
              DISPLAY 'FLD0885C ==> ' HEX-OF (FLD0885C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0885C).
           IF FLD0886C (1:)    NOT EQUAL XPC-FLD0886C
              DISPLAY 'FLD0886C ==> ' HEX-OF (FLD0886C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0886C).
           IF FLD0887C (1:)    NOT EQUAL XPC-FLD0887C
              DISPLAY 'FLD0887C ==> ' HEX-OF (FLD0887C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0887C).
           IF FLD0888C (1:)    NOT EQUAL XPC-FLD0888C
              DISPLAY 'FLD0888C ==> ' HEX-OF (FLD0888C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0888C).
           IF FLD0889C (1:)    NOT EQUAL XPC-FLD0889C
              DISPLAY 'FLD0889C ==> ' HEX-OF (FLD0889C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0889C).
           IF FLD0890C (1:)    NOT EQUAL XPC-FLD0890C
              DISPLAY 'FLD0890C ==> ' HEX-OF (FLD0890C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0890C).
           IF FLD0891C (1:)    NOT EQUAL XPC-FLD0891C
              DISPLAY 'FLD0891C ==> ' HEX-OF (FLD0891C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0891C).
           IF FLD0892C (1:)    NOT EQUAL XPC-FLD0892C
              DISPLAY 'FLD0892C ==> ' HEX-OF (FLD0892C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0892C).
           IF FLD0893C (1:)    NOT EQUAL XPC-FLD0893C
              DISPLAY 'FLD0893C ==> ' HEX-OF (FLD0893C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0893C).
           IF FLD0894C (1:)    NOT EQUAL XPC-FLD0894C
              DISPLAY 'FLD0894C ==> ' HEX-OF (FLD0894C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0894C).
           IF FLD0895C (1:)    NOT EQUAL XPC-FLD0895C
              DISPLAY 'FLD0895C ==> ' HEX-OF (FLD0895C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0895C).
           IF FLD0896C (1:)    NOT EQUAL XPC-FLD0896C
              DISPLAY 'FLD0896C ==> ' HEX-OF (FLD0896C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0896C).
           IF FLD0897C (1:)    NOT EQUAL XPC-FLD0897C
              DISPLAY 'FLD0897C ==> ' HEX-OF (FLD0897C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0897C).
           IF FLD0898C (1:)    NOT EQUAL XPC-FLD0898C
              DISPLAY 'FLD0898C ==> ' HEX-OF (FLD0898C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0898C).
           IF FLD0899C (1:)    NOT EQUAL XPC-FLD0899C
              DISPLAY 'FLD0899C ==> ' HEX-OF (FLD0899C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0899C).
           IF FLD0900C (1:)    NOT EQUAL XPC-FLD0900C
              DISPLAY 'FLD0900C ==> ' HEX-OF (FLD0900C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0900C).
           IF FLD0901C (1:)    NOT EQUAL XPC-FLD0901C
              DISPLAY 'FLD0901C ==> ' HEX-OF (FLD0901C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0901C).
           IF FLD0902C (1:)    NOT EQUAL XPC-FLD0902C
              DISPLAY 'FLD0902C ==> ' HEX-OF (FLD0902C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0902C).
           IF FLD0903C (1:)    NOT EQUAL XPC-FLD0903C
              DISPLAY 'FLD0903C ==> ' HEX-OF (FLD0903C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0903C).
           IF FLD0904C (1:)    NOT EQUAL XPC-FLD0904C
              DISPLAY 'FLD0904C ==> ' HEX-OF (FLD0904C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0904C).
           IF FLD0905C (1:)    NOT EQUAL XPC-FLD0905C
              DISPLAY 'FLD0905C ==> ' HEX-OF (FLD0905C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0905C).
           IF FLD0906C (1:)    NOT EQUAL XPC-FLD0906C
              DISPLAY 'FLD0906C ==> ' HEX-OF (FLD0906C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0906C).
           IF FLD0907C (1:)    NOT EQUAL XPC-FLD0907C
              DISPLAY 'FLD0907C ==> ' HEX-OF (FLD0907C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0907C).
           IF FLD0908C (1:)    NOT EQUAL XPC-FLD0908C
              DISPLAY 'FLD0908C ==> ' HEX-OF (FLD0908C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0908C).
           IF FLD0909C (1:)    NOT EQUAL XPC-FLD0909C
              DISPLAY 'FLD0909C ==> ' HEX-OF (FLD0909C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0909C).
           IF FLD0910C (1:)    NOT EQUAL XPC-FLD0910C
              DISPLAY 'FLD0910C ==> ' HEX-OF (FLD0910C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0910C).
           IF FLD0911C (1:)    NOT EQUAL XPC-FLD0911C
              DISPLAY 'FLD0911C ==> ' HEX-OF (FLD0911C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0911C).
           IF FLD0912C (1:)    NOT EQUAL XPC-FLD0912C
              DISPLAY 'FLD0912C ==> ' HEX-OF (FLD0912C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0912C).
           IF FLD0913C (1:)    NOT EQUAL XPC-FLD0913C
              DISPLAY 'FLD0913C ==> ' HEX-OF (FLD0913C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0913C).
           IF FLD0914C (1:)    NOT EQUAL XPC-FLD0914C
              DISPLAY 'FLD0914C ==> ' HEX-OF (FLD0914C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0914C).
           IF FLD0915C (1:)    NOT EQUAL XPC-FLD0915C
              DISPLAY 'FLD0915C ==> ' HEX-OF (FLD0915C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0915C).
           IF FLD0916C (1:)    NOT EQUAL XPC-FLD0916C
              DISPLAY 'FLD0916C ==> ' HEX-OF (FLD0916C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0916C).
           IF FLD0917C (1:)    NOT EQUAL XPC-FLD0917C
              DISPLAY 'FLD0917C ==> ' HEX-OF (FLD0917C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0917C).
           IF FLD0918C (1:)    NOT EQUAL XPC-FLD0918C
              DISPLAY 'FLD0918C ==> ' HEX-OF (FLD0918C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0918C).
           IF FLD0919C (1:)    NOT EQUAL XPC-FLD0919C
              DISPLAY 'FLD0919C ==> ' HEX-OF (FLD0919C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0919C).
           IF FLD0920C (1:)    NOT EQUAL XPC-FLD0920C
              DISPLAY 'FLD0920C ==> ' HEX-OF (FLD0920C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0920C).
           IF FLD0921C (1:)    NOT EQUAL XPC-FLD0921C
              DISPLAY 'FLD0921C ==> ' HEX-OF (FLD0921C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0921C).
           IF FLD0922C (1:)    NOT EQUAL XPC-FLD0922C
              DISPLAY 'FLD0922C ==> ' HEX-OF (FLD0922C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0922C).
           IF FLD0923C (1:)    NOT EQUAL XPC-FLD0923C
              DISPLAY 'FLD0923C ==> ' HEX-OF (FLD0923C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0923C).
           IF FLD0924C (1:)    NOT EQUAL XPC-FLD0924C
              DISPLAY 'FLD0924C ==> ' HEX-OF (FLD0924C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0924C).
           IF FLD0925C (1:)    NOT EQUAL XPC-FLD0925C
              DISPLAY 'FLD0925C ==> ' HEX-OF (FLD0925C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0925C).
           IF FLD0926C (1:)    NOT EQUAL XPC-FLD0926C
              DISPLAY 'FLD0926C ==> ' HEX-OF (FLD0926C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0926C).
           IF FLD0927C (1:)    NOT EQUAL XPC-FLD0927C
              DISPLAY 'FLD0927C ==> ' HEX-OF (FLD0927C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0927C).
           IF FLD0928C (1:)    NOT EQUAL XPC-FLD0928C
              DISPLAY 'FLD0928C ==> ' HEX-OF (FLD0928C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0928C).
           IF FLD0929C (1:)    NOT EQUAL XPC-FLD0929C
              DISPLAY 'FLD0929C ==> ' HEX-OF (FLD0929C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0929C).
           IF FLD0930C (1:)    NOT EQUAL XPC-FLD0930C
              DISPLAY 'FLD0930C ==> ' HEX-OF (FLD0930C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0930C).
           IF FLD0931C (1:)    NOT EQUAL XPC-FLD0931C
              DISPLAY 'FLD0931C ==> ' HEX-OF (FLD0931C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0931C).
           IF FLD0932C (1:)    NOT EQUAL XPC-FLD0932C
              DISPLAY 'FLD0932C ==> ' HEX-OF (FLD0932C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0932C).
           IF FLD0933C (1:)    NOT EQUAL XPC-FLD0933C
              DISPLAY 'FLD0933C ==> ' HEX-OF (FLD0933C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0933C).
           IF FLD0934C (1:)    NOT EQUAL XPC-FLD0934C
              DISPLAY 'FLD0934C ==> ' HEX-OF (FLD0934C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0934C).
           IF FLD0935C (1:)    NOT EQUAL XPC-FLD0935C
              DISPLAY 'FLD0935C ==> ' HEX-OF (FLD0935C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0935C).
           IF FLD0936C (1:)    NOT EQUAL XPC-FLD0936C
              DISPLAY 'FLD0936C ==> ' HEX-OF (FLD0936C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0936C).
           IF FLD0937C (1:)    NOT EQUAL XPC-FLD0937C
              DISPLAY 'FLD0937C ==> ' HEX-OF (FLD0937C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0937C).
           IF FLD0938C (1:)    NOT EQUAL XPC-FLD0938C
              DISPLAY 'FLD0938C ==> ' HEX-OF (FLD0938C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0938C).
           IF FLD0939C (1:)    NOT EQUAL XPC-FLD0939C
              DISPLAY 'FLD0939C ==> ' HEX-OF (FLD0939C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0939C).
           IF FLD0940C (1:)    NOT EQUAL XPC-FLD0940C
              DISPLAY 'FLD0940C ==> ' HEX-OF (FLD0940C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0940C).
           IF FLD0941C (1:)    NOT EQUAL XPC-FLD0941C
              DISPLAY 'FLD0941C ==> ' HEX-OF (FLD0941C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0941C).
           IF FLD0942C (1:)    NOT EQUAL XPC-FLD0942C
              DISPLAY 'FLD0942C ==> ' HEX-OF (FLD0942C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0942C).
           IF FLD0943C (1:)    NOT EQUAL XPC-FLD0943C
              DISPLAY 'FLD0943C ==> ' HEX-OF (FLD0943C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0943C).
           IF FLD0944C (1:)    NOT EQUAL XPC-FLD0944C
              DISPLAY 'FLD0944C ==> ' HEX-OF (FLD0944C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0944C).
           IF FLD0945C (1:)    NOT EQUAL XPC-FLD0945C
              DISPLAY 'FLD0945C ==> ' HEX-OF (FLD0945C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0945C).
           IF FLD0946C (1:)    NOT EQUAL XPC-FLD0946C
              DISPLAY 'FLD0946C ==> ' HEX-OF (FLD0946C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0946C).
           IF FLD0947C (1:)    NOT EQUAL XPC-FLD0947C
              DISPLAY 'FLD0947C ==> ' HEX-OF (FLD0947C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0947C).
           IF FLD0948C (1:)    NOT EQUAL XPC-FLD0948C
              DISPLAY 'FLD0948C ==> ' HEX-OF (FLD0948C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0948C).
           IF FLD0949C (1:)    NOT EQUAL XPC-FLD0949C
              DISPLAY 'FLD0949C ==> ' HEX-OF (FLD0949C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0949C).
           IF FLD0950C (1:)    NOT EQUAL XPC-FLD0950C
              DISPLAY 'FLD0950C ==> ' HEX-OF (FLD0950C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0950C).
           IF FLD0951C (1:)    NOT EQUAL XPC-FLD0951C
              DISPLAY 'FLD0951C ==> ' HEX-OF (FLD0951C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0951C).
           IF FLD0952C (1:)    NOT EQUAL XPC-FLD0952C
              DISPLAY 'FLD0952C ==> ' HEX-OF (FLD0952C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0952C).
           IF FLD0953C (1:)    NOT EQUAL XPC-FLD0953C
              DISPLAY 'FLD0953C ==> ' HEX-OF (FLD0953C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0953C).
           IF FLD0954C (1:)    NOT EQUAL XPC-FLD0954C
              DISPLAY 'FLD0954C ==> ' HEX-OF (FLD0954C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0954C).
           IF FLD0955C (1:)    NOT EQUAL XPC-FLD0955C
              DISPLAY 'FLD0955C ==> ' HEX-OF (FLD0955C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0955C).
           IF FLD0956C (1:)    NOT EQUAL XPC-FLD0956C
              DISPLAY 'FLD0956C ==> ' HEX-OF (FLD0956C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0956C).
           IF FLD0957C (1:)    NOT EQUAL XPC-FLD0957C
              DISPLAY 'FLD0957C ==> ' HEX-OF (FLD0957C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0957C).
           IF FLD0958C (1:)    NOT EQUAL XPC-FLD0958C
              DISPLAY 'FLD0958C ==> ' HEX-OF (FLD0958C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0958C).
           IF FLD0959C (1:)    NOT EQUAL XPC-FLD0959C
              DISPLAY 'FLD0959C ==> ' HEX-OF (FLD0959C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0959C).
           IF FLD0960C (1:)    NOT EQUAL XPC-FLD0960C
              DISPLAY 'FLD0960C ==> ' HEX-OF (FLD0960C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0960C).
           IF FLD0961C (1:)    NOT EQUAL XPC-FLD0961C
              DISPLAY 'FLD0961C ==> ' HEX-OF (FLD0961C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0961C).
           IF FLD0962C (1:)    NOT EQUAL XPC-FLD0962C
              DISPLAY 'FLD0962C ==> ' HEX-OF (FLD0962C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0962C).
           IF FLD0963C (1:)    NOT EQUAL XPC-FLD0963C
              DISPLAY 'FLD0963C ==> ' HEX-OF (FLD0963C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0963C).
           IF FLD0964C (1:)    NOT EQUAL XPC-FLD0964C
              DISPLAY 'FLD0964C ==> ' HEX-OF (FLD0964C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0964C).
           IF FLD0965C (1:)    NOT EQUAL XPC-FLD0965C
              DISPLAY 'FLD0965C ==> ' HEX-OF (FLD0965C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0965C).
           IF FLD0966C (1:)    NOT EQUAL XPC-FLD0966C
              DISPLAY 'FLD0966C ==> ' HEX-OF (FLD0966C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0966C).
           IF FLD0967C (1:)    NOT EQUAL XPC-FLD0967C
              DISPLAY 'FLD0967C ==> ' HEX-OF (FLD0967C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0967C).
           IF FLD0968C (1:)    NOT EQUAL XPC-FLD0968C
              DISPLAY 'FLD0968C ==> ' HEX-OF (FLD0968C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0968C).
           IF FLD0969C (1:)    NOT EQUAL XPC-FLD0969C
              DISPLAY 'FLD0969C ==> ' HEX-OF (FLD0969C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0969C).
           IF FLD0970C (1:)    NOT EQUAL XPC-FLD0970C
              DISPLAY 'FLD0970C ==> ' HEX-OF (FLD0970C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0970C).
           IF FLD0971C (1:)    NOT EQUAL XPC-FLD0971C
              DISPLAY 'FLD0971C ==> ' HEX-OF (FLD0971C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0971C).
           IF FLD0972C (1:)    NOT EQUAL XPC-FLD0972C
              DISPLAY 'FLD0972C ==> ' HEX-OF (FLD0972C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0972C).
           IF FLD0973C (1:)    NOT EQUAL XPC-FLD0973C
              DISPLAY 'FLD0973C ==> ' HEX-OF (FLD0973C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0973C).
           IF FLD0974C (1:)    NOT EQUAL XPC-FLD0974C
              DISPLAY 'FLD0974C ==> ' HEX-OF (FLD0974C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0974C).
           IF FLD0975C (1:)    NOT EQUAL XPC-FLD0975C
              DISPLAY 'FLD0975C ==> ' HEX-OF (FLD0975C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0975C).
           IF FLD0976C (1:)    NOT EQUAL XPC-FLD0976C
              DISPLAY 'FLD0976C ==> ' HEX-OF (FLD0976C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0976C).
           IF FLD0977C (1:)    NOT EQUAL XPC-FLD0977C
              DISPLAY 'FLD0977C ==> ' HEX-OF (FLD0977C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0977C).
           IF FLD0978C (1:)    NOT EQUAL XPC-FLD0978C
              DISPLAY 'FLD0978C ==> ' HEX-OF (FLD0978C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0978C).
           IF FLD0979C (1:)    NOT EQUAL XPC-FLD0979C
              DISPLAY 'FLD0979C ==> ' HEX-OF (FLD0979C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0979C).
           IF FLD0980C (1:)    NOT EQUAL XPC-FLD0980C
              DISPLAY 'FLD0980C ==> ' HEX-OF (FLD0980C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0980C).
           IF FLD0981C (1:)    NOT EQUAL XPC-FLD0981C
              DISPLAY 'FLD0981C ==> ' HEX-OF (FLD0981C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0981C).
           IF FLD0982C (1:)    NOT EQUAL XPC-FLD0982C
              DISPLAY 'FLD0982C ==> ' HEX-OF (FLD0982C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0982C).
           IF FLD0983C (1:)    NOT EQUAL XPC-FLD0983C
              DISPLAY 'FLD0983C ==> ' HEX-OF (FLD0983C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0983C).
           IF FLD0984C (1:)    NOT EQUAL XPC-FLD0984C
              DISPLAY 'FLD0984C ==> ' HEX-OF (FLD0984C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0984C).
           IF FLD0985C (1:)    NOT EQUAL XPC-FLD0985C
              DISPLAY 'FLD0985C ==> ' HEX-OF (FLD0985C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0985C).
           IF FLD0986C (1:)    NOT EQUAL XPC-FLD0986C
              DISPLAY 'FLD0986C ==> ' HEX-OF (FLD0986C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0986C).
           IF FLD0987C (1:)    NOT EQUAL XPC-FLD0987C
              DISPLAY 'FLD0987C ==> ' HEX-OF (FLD0987C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0987C).
           IF FLD0988C (1:)    NOT EQUAL XPC-FLD0988C
              DISPLAY 'FLD0988C ==> ' HEX-OF (FLD0988C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0988C).
           IF FLD0989C (1:)    NOT EQUAL XPC-FLD0989C
              DISPLAY 'FLD0989C ==> ' HEX-OF (FLD0989C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0989C).
           IF FLD0990C (1:)    NOT EQUAL XPC-FLD0990C
              DISPLAY 'FLD0990C ==> ' HEX-OF (FLD0990C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0990C).
           IF FLD0991C (1:)    NOT EQUAL XPC-FLD0991C
              DISPLAY 'FLD0991C ==> ' HEX-OF (FLD0991C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0991C).
           IF FLD0992C (1:)    NOT EQUAL XPC-FLD0992C
              DISPLAY 'FLD0992C ==> ' HEX-OF (FLD0992C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0992C).
           IF FLD0993C (1:)    NOT EQUAL XPC-FLD0993C
              DISPLAY 'FLD0993C ==> ' HEX-OF (FLD0993C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0993C).
           IF FLD0994C (1:)    NOT EQUAL XPC-FLD0994C
              DISPLAY 'FLD0994C ==> ' HEX-OF (FLD0994C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0994C).
           IF FLD0995C (1:)    NOT EQUAL XPC-FLD0995C
              DISPLAY 'FLD0995C ==> ' HEX-OF (FLD0995C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0995C).
           IF FLD0996C (1:)    NOT EQUAL XPC-FLD0996C
              DISPLAY 'FLD0996C ==> ' HEX-OF (FLD0996C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0996C).
           IF FLD0997C (1:)    NOT EQUAL XPC-FLD0997C
              DISPLAY 'FLD0997C ==> ' HEX-OF (FLD0997C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0997C).
           IF FLD0998C (1:)    NOT EQUAL XPC-FLD0998C
              DISPLAY 'FLD0998C ==> ' HEX-OF (FLD0998C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0998C).
           IF FLD0999C (1:)    NOT EQUAL XPC-FLD0999C
              DISPLAY 'FLD0999C ==> ' HEX-OF (FLD0999C)
                x'0a' 'EXPECTED ==> ' HEX-OF (XPC-FLD0999C).