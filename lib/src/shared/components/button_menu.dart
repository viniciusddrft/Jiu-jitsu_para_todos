import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu(
      {super.key,
      required this.text,
      required this.imageButton,
      required this.onPressed});

  final String text, imageButton;
  final VoidCallback onPressed;

  static const _radius = BorderRadius.all(Radius.circular(8.0));
  static const _cardDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: _radius,
    boxShadow: <BoxShadow>[
      BoxShadow(color: Colors.black, blurRadius: 10.0, offset: Offset(0.0, 1.0))
    ],
  );
  static const _inkDecoration = BoxDecoration(
    gradient: LinearGradient(
        colors: [AppColors.background, Colors.indigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    borderRadius: _radius,
  );
  static final _buttonStyle = ElevatedButton.styleFrom(
    elevation: 7,
    padding: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(borderRadius: _radius),
  );
  static final _textStyle =
      GoogleFonts.ubuntu(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
          top: size.height * 0.04,
          bottom: size.height * 0.01,
          left: size.width * 0.01,
          right: size.width * 0.01),
      child: Stack(
        children: [
          Container(
            height: size.height * 0.13,
            width: size.width * 0.65,
            margin: EdgeInsets.only(left: size.width * 0.173),
            decoration: _cardDecoration,
            child: ElevatedButton(
              style: _buttonStyle,
              onPressed: onPressed,
              child: Ink(
                decoration: _inkDecoration,
                child: Center(
                  child: Text(
                    text,
                    style: _textStyle,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              alignment: const FractionalOffset(0.0, 0.5),
              margin: EdgeInsets.only(
                left: size.width * 0.055,
              ),
              child: Image.asset(imageButton,
                  width: size.height * 0.12, height: size.height * 0.12),
            ),
          )
        ],
      ),
    );
  }
}
