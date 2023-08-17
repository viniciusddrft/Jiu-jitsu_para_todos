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
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 1.0))
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 7,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: onPressed,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.background, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    text,
                    style:
                        GoogleFonts.ubuntu(fontSize: 18, color: Colors.white),
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
