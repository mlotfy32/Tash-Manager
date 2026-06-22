
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:task/core/utiles/app_fonts.dart';

class RegisterRow extends StatelessWidget {
  const RegisterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Don't have an account? ",
              style: AppFonts.f16BoldWhite().copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,fontSize: 14.sp
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Register",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
