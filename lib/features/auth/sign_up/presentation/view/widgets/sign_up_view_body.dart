import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/features/auth/login/presentation/view/login_view.dart';
import 'package:task/features/auth/login/presentation/view/widgets/login_form.dart';
import 'package:task/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController name;
  late SignUpCubit signUpCubit;
  late ObscureTextCubit visiblityCubit;
  @override
  void initState() {
    email = TextEditingController();
    pass = TextEditingController();
    name = TextEditingController();
    signUpCubit = sl<SignUpCubit>();
    visiblityCubit = sl<ObscureTextCubit>();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    // signUpCubit.close();
    visiblityCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignUpCubit, SignUpState>(
          bloc: signUpCubit,
          listener: (context, state) {
            if (state is SignUpSuccess) {
              context.pushReplacement(LoginView());
            }
          },
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
                  isLogin: false,
                  suignUpCubit: signUpCubit,
                  visiblityCubit: visiblityCubit,
                  email: email,
                  pass: pass,name: name,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
