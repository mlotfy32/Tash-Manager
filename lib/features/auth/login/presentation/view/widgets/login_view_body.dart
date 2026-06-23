import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/core/utiles/routes/router_named.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/auth/login/presentation/view/widgets/login_form.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late TextEditingController email;
  late TextEditingController pass;
  late LoginCubit logInCubit;
  late ObscureTextCubit visiblityCubit;
  @override
  void initState() {
    email = TextEditingController();
    pass = TextEditingController();
    logInCubit = sl<LoginCubit>();
    visiblityCubit = sl<ObscureTextCubit>();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    // logInCubit.close();
    visiblityCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          bloc: logInCubit,
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go(RouterNamed.home);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
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
                  isLogin: true,
                  logInCubit: logInCubit,
                  visiblityCubit: visiblityCubit,
                  email: email,
                  pass: pass,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
