import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonOptionsRules extends StatefulWidget {
  final String imagebotton;
  final String textbotton;
  final routebotton;

  BottonOptionsRules(
      {@required this.imagebotton,
      @required this.textbotton,
      @required this.routebotton});

  @override
  _BottonOptionsRulesState createState() => _BottonOptionsRulesState();
}

class _BottonOptionsRulesState extends State<BottonOptionsRules> {
//------------------------------------------------------------------------------
  void _changeroute() async {
    await Navigator.of(context).push(MyTransitionElasticOut(
        route: widget.routebotton, duration: Duration(milliseconds: 500)));
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final thumbnail = GestureDetector(
      onTap: _changeroute,
      child: Container(
        alignment: FractionalOffset(0.0, 0.5),
        margin: EdgeInsets.only(
          left: 24.0.w,
        ),
        child: Image.asset(widget.imagebotton, width: 100.w, height: 100.h),
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
        onPressed: _changeroute,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff202848), Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: Text(
              widget.textbotton,
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
