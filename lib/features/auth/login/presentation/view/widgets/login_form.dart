import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/validation/app_validator.dart';
import 'package:task/core/utiles/validation/field_type.dart';
import 'package:task/core/utiles/widgets/custom_text_form.dart';
import 'package:task/features/auth/cubit/start_cool_down_cubit.dart';
import 'package:task/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/auth/login/presentation/view/widgets/register_row.dart';
import 'package:task/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    this.logInCubit,
    this.suignUpCubit,
    required this.visiblityCubit,
    required this.email,
    required this.pass,
    required this.isLogin,
    this.name,
  });
  final LoginCubit? logInCubit;
  final SignUpCubit? suignUpCubit;
  final TextEditingController? name;
  final ObscureTextCubit visiblityCubit;
  final TextEditingController email;
  final TextEditingController pass;
  final bool isLogin;
  final counterCubit = sl<StartCoolDownCubit>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: !isLogin ? suignUpCubit!.formKey : logInCubit!.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 60.h, color: Colors.blue),
          SizedBox(height: 10.h),
          Text(
            isLogin ? "Welcome Back" : 'Create Account',
            style: AppFonts.f36ExtraBold191C1E().copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            isLogin
                ? "Organize your momentum. Finish your day stronger."
                : 'Join teams building the future with organized momentum.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),

          SizedBox(height: 25.h),

          isLogin
              ? const SizedBox.shrink()
              : CustomTextForm(
                  controller: name!,
                  hint: "Name",
                  validator: (value) => AppValidator.validate(
                    value: value,
                    type: FieldType.normal,
                  ),
                ).withPadding(bottom: 15.h),
          CustomTextForm(
            controller: email,
            hint: "Email Address",
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                AppValidator.validate(value: value, type: FieldType.email),
          ).withPadding(bottom: 15.h),
          BlocBuilder<ObscureTextCubit, ObscureTextState>(
            bloc: visiblityCubit,
            builder: (context, state) {
              return CustomTextForm(
                isPass: true,
                controller: pass,
                cubit: visiblityCubit,
                hint: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    visiblityCubit.obsecureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    visiblityCubit.changeObscureText();
                  },
                ),
                validator: (value) => AppValidator.validate(
                  value: value,
                  type: FieldType.password,
                ),
              );
            },
          ),

          SizedBox(height: 10.h),
          BlocBuilder<StartCoolDownCubit, StartCoolDownState>(
            bloc: counterCubit,
            builder: (context, state) {
              if (state is SignUpTimer &&
                      isLogin &&
                      counterCubit.widgetState == 'login' ||
                  state is SignUpTimer &&
                      !isLogin &&
                      counterCubit.widgetState == 'signup') {
                return SizedBox(
                  width: 80.w,
                  height: 80.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: counterCubit.remainingSeconds / 30,
                        strokeWidth: 5,
                      ),
                      Text(
                        "${counterCubit.remainingSeconds}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                if (isLogin) {
                  logInCubit!.emitInitial();
                } else {
                  suignUpCubit!.emitInitial();
                }
                return const SizedBox.shrink();
              }
            },
          ),

          isLogin
              ? BlocBuilder<LoginCubit, LoginState>(
                  bloc: logInCubit,
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: isLogin && counterCubit.widgetState == 'login'
                          ? null
                          : () {
                              logInCubit!.login(
                                loginCubit: logInCubit!,
                                email: email.text,
                                password: pass.text,
                                startCooldownCubit: counterCubit,
                              );
                            },
                      child: Text(
                        'LogIn',
                        style: AppFonts.f20ExtraBold0F172A().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              : BlocBuilder<SignUpCubit, SignUpState>(
                  bloc: suignUpCubit,
                  builder: (context, state) {
                    if (state is SignUpLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: isLogin && counterCubit.widgetState == 'signup'
                          ? null
                          : () {
                              suignUpCubit!.signUp(
                                signUp: suignUpCubit!,
                                email: email.text,
                                startCooldownCubit: counterCubit,
                                name: name!.text,
                                password: pass.text,
                              );
                            },
                      child: Text(
                        'SignUp',
                        style: AppFonts.f20ExtraBold0F172A().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
          RegisterRow(login: isLogin),
        ],
      ),
    );
  }
}
