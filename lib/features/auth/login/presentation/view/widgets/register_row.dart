
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/features/auth/login/presentation/view/login_view.dart';
import 'package:task/features/auth/sign_up/presentation/view/sign_up_view.dart';

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
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,fontSize: 14.sp
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () =>login? context.pushReplacement(SignUpView()) :context.pushReplacement(LoginView()),
          child: Text(
           login? "Register":'Login',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
