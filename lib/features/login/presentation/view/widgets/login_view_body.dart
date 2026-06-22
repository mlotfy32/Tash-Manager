import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/features/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/login/presentation/view/widgets/login_form.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late TextEditingController email;
  late TextEditingController pass;
  final logInCubit = sl.get<LoginCubit>();
  final visiblityCubit = sl.get<ObscureTextCubit>();
  @override
  void initState() {
    email = TextEditingController();
    pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    logInCubit.close();
    visiblityCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20.r,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: LoginForm(
                logInCubit: logInCubit,
                visiblityCubit: visiblityCubit,
                email: email,
                pass: pass,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
