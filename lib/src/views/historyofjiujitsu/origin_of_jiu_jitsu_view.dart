import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/admob/admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OriginOfJiujitsu extends StatelessWidget {
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
          'Origem do Jiu-jitsu',
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
                        'Apesar de sua popularidade crescente no Japão, a história do jiu-jitsu começou na Índia (daí o nome "berço das arte artes marciais "), há mais de dois mil anos.',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        ' A religião proibia monges monastérios indianos defender com armas. Mas em longas caminhadas, eles foram atacados por bandidos das tribos mongóis do norte da Ásia, e então necessidade de defesa corpo a corpo.',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        ' Os conhecedores dos pontos vitais do corpo desenvolveram uma espécie defesa especial para as características físicas de seu povo, baixo e magro. Este tipo de embrião de jiu-jitsu finalmente cruzou a linha fronteiras da China e seguir para o arquipélago japonês onde estava localizado desenvolvido, mas conhecido apenas por nobres e samurais. No Japão O Jiu-jitsu é literalmente conhecido como "Arte Suave".',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        ' O Jiu-jitsu foi a luta mais praticada no Japão por muito tempo, até o surgimento do judô como esporte em 1882, através do Mestre de Jiu-Jitsu, Jigoro Kano. Isso remove as técnicas traumáticas do jiu-jitsu mais perigoso e eficiente e cria o esporte como o conhecemos hoje.Mas havia vários estilos de jiu-jitsu e, de fato, todo competidor fazia seu próprio estilo.',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        ' O Jiu-Jitsu foi proibido no Japão por um tempo Como um crime contra sua pátria. Com a promoção da introdução da cultura ocidental no Japão Imperador Muto (1867-1912), artes marciais esquecido. Até mais tarde, quando o Ocidente começou apreciar e a "importar" esse tipo de luta.',
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
