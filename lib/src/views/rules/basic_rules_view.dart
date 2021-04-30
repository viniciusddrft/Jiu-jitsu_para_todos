import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/controllers/admob/admob_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Basicrules extends StatelessWidget {
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
        title: Column(
          children: [
            Text(
              'Regras Básicas',
              style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
            ),
          ],
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
                      'Visão geral',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Nesta categoria você ira entender o básico sobre as regras de campeonatos de jiu-jitsu para começar você deve entender que as lutas são divididas por peso, faixa e idade e com isso as regras também tem uma pequena mudança é essencial dizer que no jiu-jitsu não é permitido nenhum ataque “tradicional” como chutes, socos, joelhadas, cotoveladas e uma infinidade de outros ataques são proibidos, existe também nos campeonatos o famoso “absoluto” que é uma categoria sem peso, apenas por faixa e idade, lembrando que em qualquer luta a finalização da a vitoria direta e se o tempo acabar sem finalizações as lutas serão decididas pelos pontos vantagens e punições caso tudo esteja empatado é decisão do juiz.',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Pontuação',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'No jiu-jitsu a pontuação é dividida em 2 pontos, 3 pontos e 4 pontos existem também as vantagens e punições mas vamos falar delas depois.',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Movimentos que valem 2 pontos',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                        '''quedas → existem vários fatores para que uma queda seja considerada, ela deve ter inicio dentro da area de luta e é necessario a estabilização de 3 segundos , isso se aplica para qualquer tipo de queda.
                      ''',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        '''joelho na barriga → para ser considerado precisa de estabilizacão de 3 segundos.
                        ''',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        '''raspagem → uma raspagem basicamente é inverter a posição a partir de uma guarda imagine que você está fazendo guarda sendo assim você está em baixo e seu adversario em cima na raspagem você inverte a posição ficando por cima é importante que a posição começe de algum tipo de guarda, você pode paspar e ficarpor cima montado na guarda do adversario ou como preferir isso não interfere em nada você só precisa deixar seu adversario de costa no tatame e ficar por cima é preciso estabilizar 3 segundos para ganhar os pontos da raspagem.
                        ''',
                        style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Movimento que vale 3 ponto',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                        '''No jiu-jitsu só existe um movimento que vale 3 pontos.
                      ''',
                        style: TextStyle(fontSize: 16.sp)),
                    Text(
                        '''passagem de guarda → vale pra absolutamente qualquer tipo de guarda você precisa chegar na lateral, montada ou norte sul para ganhar os pontos é necessario estabilizar por 3 segundos.
                      ''',
                        style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Movimentos que valem 4 pontos',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                        '''montada → qualquer montada conta para guanhar os pontos precisa estabilizar 3 segundos.
                      ''',
                        style: TextStyle(fontSize: 15.sp)),
                    Text(
                        '''Pegada nas costas → você precisa chegar nas costas e conseguir por os ganchos é necessario estabilizar 3 segundos.
                        ''',
                        style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Vantagem e punições',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                        '''A vantagem pode ser decisiva ela você ganha uma vantagem toda vez que representar risco ao oponente como exemplo imagine que você quase finaliza o oponente ou quase da uma queda nela nesse caso você ganha vantagem mas lembrando que caso você consiga dar a queda você não ganhara vantagem e sim os 2 pontos da queda, pontos sempre terão um peso maior na decisão da luta do que as vantagens, as vantagens server de desempate caso a pontuação esteja igual.
                      ''',
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
