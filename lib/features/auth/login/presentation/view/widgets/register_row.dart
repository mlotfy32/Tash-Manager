
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/routes/router_named.dart';

class RegisterRow extends StatelessWidget {
  const RegisterRow({super.key, required this.login});
final bool login;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
             login? "Don't have an account? ":"have an account? ",
              style: AppFonts.f16BoldWhite().copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,fontSize: 14.sp
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () =>login? context.go(RouterNamed.signUp) :context.go(RouterNamed.login),
          child: Text(
           login? "Register":'Login',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
