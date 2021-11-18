import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ButtonForMenu extends StatelessWidget {
  final String imageButton;
  final String textButton;

  const ButtonForMenu(
      {required this.imageButton, required this.textButton, Key? key})
      : super(key: key);

  Widget _makeThumbnail(VoidCallback changeRoute) => GestureDetector(
        onTap: changeRoute,
        child: Container(
          alignment: const FractionalOffset(0.0, 0.5),
          margin: EdgeInsets.only(
            left: 24.0.w,
          ),
          child: Image.asset(imageButton, width: 100.w, height: 100.h),
        ),
      );

  Widget _makeCard(VoidCallback changeRoute) => Container(
        height: 117.h,
        width: 257.w,
        margin: EdgeInsets.only(left: 72.0.w, right: 24.0.w),
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
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
        ),
      );

  Widget makeButton(VoidCallback changeRoute) => Container(
        margin: EdgeInsets.only(
            top: 30.0.h, bottom: 8.0.h, left: 10.w, right: 10.w),
        child: Stack(
          children: [_makeCard(changeRoute), _makeThumbnail(changeRoute)],
        ),
      );
}
