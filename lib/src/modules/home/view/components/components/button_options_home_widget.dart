import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiu_jitsu_para_todos/src/shared/animated_page_route_builder/my_transition_elatic_out.dart';

class BottonOptionsHome extends StatefulWidget {
  final String imageButton;
  final String textButton;
  final Widget routeButton;
  final bool needToRebuildTheHome;
  final bool needAnimation;
  BottonOptionsHome(
      {required this.imageButton,
      required this.textButton,
      required this.routeButton,
      this.needToRebuildTheHome = false,
      this.needAnimation = true});

  @override
  _BottonOptionsHomeState createState() => _BottonOptionsHomeState();
}

//------------------------------------------------------------------------------
class _BottonOptionsHomeState extends State<BottonOptionsHome> {
  void _changeRoute() async {
    if (widget.needAnimation) {
      await Navigator.of(context).push(MyTransitionElasticOut(
          route: widget.routeButton, duration: Duration(milliseconds: 500)));
      if (widget.needToRebuildTheHome) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } else {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => widget.routeButton));
      if (widget.needToRebuildTheHome) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final thumbnail = GestureDetector(
      onTap: _changeRoute,
      child: Container(
        alignment: FractionalOffset(0.0, 0.5),
        margin: EdgeInsets.only(
          left: 24.0.w,
        ),
        child: Image.asset(widget.imageButton, width: 100.w, height: 100.h),
      ),
    );

    final card = Container(
      width: MediaQuery.of(context).size.width / 1.6,
      height: MediaQuery.of(context).size.height / 7,
      margin: EdgeInsets.only(left: 72.0.w, right: 24.0.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black, blurRadius: 10.0, offset: Offset(0.0, 10.0))
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 7,
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: _changeRoute,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff202848), Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: Text(
              widget.textButton,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
      ),
    );

    return Container(
      margin:
          EdgeInsets.only(top: 30.0.h, bottom: 8.0.h, left: 10.w, right: 10.w),
      child: Stack(
        children: [card, thumbnail],
      ),
    );
  }
}
