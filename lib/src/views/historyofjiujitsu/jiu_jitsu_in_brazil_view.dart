import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/admob/admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JiujitsuinBrazil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'O Jiu-jitsu no Brasil',
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: Color(0xff202848),
      bottomNavigationBar: Container(
        height: 60.h,
        child: AdWidget(
          key: UniqueKey(),
          ad: Admob.createBannerAd()..load(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                        'O mestre japonês, Mitsuo Maeda conhecido como Konde Koma, foi para o Brasil em missão diplomática, e em Belém, Pará, conheceu Gastão Gracie. A partir desse momento surgiu uma excelente amizade. Conde Koma por afinidade e favores concedidos por Gastão, ele começou a ensinar Jiu-jitsu para seu filho, Carlos Gracie, que mais tarde aprendendo a arte, ele ensinou aos irmãos, principalmente Hélio Gracie. Eles aprimoraram as técnicas conhecidas, tornando-as mais eficientes e disponível para todos os tipos de corpo. Este desenvolvimento foi com base na introdução de técnicas de alavanca nas técnicas tradicionais japonesas.',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                      ' Devido à sua saúde frágil, Hélio, o menor dos Gracies, não podia treinar o tradicional Jiu-Jitsu ensinado por seus irmãos, especialmente Carlos Gracie. Observador, Hélio passou a acompanhar, dos treze aos dezesseis anos, as aulas ministradas por Carlos. Ele aprendeu todas as técnicas e ensinamentos do irmão, mas, para compensar seu biótipo, Hélio melhorou a parte tradicional do solo, por meio do uso do alavanca, dando a ele a força extra que ele não tinha, criando assim o Jiu Jitsu brasileiro.',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                        ' Foi assim que nasceu o Gracie Jiu-jitsu, também conhecido como Jiu-jitsu. Brasileiro, a melhor e mais eficaz forma de autodefesa do mundo, já provadas, pelos resultados das constantes competições de vale tudo existente no mundo.',
                        style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
