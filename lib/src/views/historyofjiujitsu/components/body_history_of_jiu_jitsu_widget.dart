import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/historyofjiujitsu/components/botton_options_history_widget.dart';
import 'package:jiu_jitsu_para_todos/src/views/historyofjiujitsu/jiu_jitsu_in_brazil_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/historyofjiujitsu/origin_of_jiu_jitsu_view.dart';

class BodyHistoryOfJiuJistu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BottonOptionsHistory(
              imagebotton: 'assets/images/iconsbutton/india.png',
              textbotton: 'Origem do Jiu-Jitsu',
              routebotton: OriginOfJiujitsu(),
            ),
            BottonOptionsHistory(
              imagebotton: 'assets/images/iconsbutton/brasil.png',
              textbotton: 'O Jiu-Jitsu no Brasil',
              routebotton: JiujitsuinBrazil(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
