import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/credits/credits_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------------------------------
    void _changecredits() async {
      await Navigator.of(context).push(MyTransitionElasticOut(
          route: CreditsView(), duration: Duration(milliseconds: 500)));
    }

//------------------------------------------------------------------------------
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 200.w,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff202848),
                    primary: Colors.white,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    side: BorderSide(color: Colors.white)),
                onPressed: _changecredits,
                child: Center(
                  child: Text(
                    'Créditos',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
