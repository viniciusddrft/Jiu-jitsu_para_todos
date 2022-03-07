import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

abstract class ButtonForMenu extends StatefulWidget {
  final String imageButton;
  final String textButton;

  const ButtonForMenu(
      {required this.imageButton, required this.textButton, Key? key})
      : super(key: key);

  // changeRoute need context to be created and so it created in build method and parameter passed

  Widget _makeThumbnail(Size size, VoidCallback changeRoute) => GestureDetector(
        onTap: changeRoute,
        child: Container(
          alignment: const FractionalOffset(0.0, 0.5),
          margin: EdgeInsets.only(
            left: size.width * 0.055,
          ),
          child: Image.asset(imageButton,
              width: size.height * 0.12, height: size.height * 0.12),
        ),
      );

  Widget _makeCard(Size size, VoidCallback changeRoute) => Container(
        height: size.height * 0.15,
        width: size.width * 0.65,
        margin: EdgeInsets.only(left: size.width * 0.173),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0))
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
          onPressed: changeRoute,
          child: Ink(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [AppColors.background, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: Text(
                textButton,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      );

  Widget makeButton(BuildContext context, {required VoidCallback changeRoute}) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          top: _size.height * 0.04,
          bottom: _size.height * 0.01,
          left: _size.width * 0.01,
          right: _size.width * 0.01),
      child: Stack(
        children: [
          _makeCard(_size, changeRoute),
          _makeThumbnail(_size, changeRoute)
        ],
      ),
    );
  }
}
