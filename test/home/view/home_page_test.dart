import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/home/view/home_page_view.dart';

void main() {
  testWidgets('Deve mostrar todos botões na tela', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePageView(),
      ),
    );
  });
}
