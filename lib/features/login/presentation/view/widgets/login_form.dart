import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/validation/app_validator.dart';
import 'package:task/core/utiles/validation/field_type.dart';
import 'package:task/core/utiles/widgets/custom_text_form.dart';
import 'package:task/features/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/login/presentation/view/widgets/register_row.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.logInCubit, required this.visiblityCubit, required this.email, required this.pass});
final LoginCubit logInCubit;
final ObscureTextCubit visiblityCubit;
final TextEditingController email;
final TextEditingController pass;
  @override
  Widget build(BuildContext context) {
    return Form(
                key: logInCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.task_alt, size: 60.h, color: Colors.blue),
                    SizedBox(height: 10.h),
                    Text(
                      "Welcome Back",
                      style: AppFonts.f36ExtraBold191C1E().copyWith(
                        color: context.theme.primaryColor,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    const Text(
                      "Organize your momentum. Finish your day stronger.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 25.h),

                    CustomTextForm(
                      controller: email,
                      hint: "Email Address",
                      validator: (value) => AppValidator.validate(
                        value: value,
                        type: FieldType.email,
                      ),
                    ).withPadding(bottom: 15.h),
                    BlocBuilder<ObscureTextCubit, ObscureTextState>(
                      bloc: visiblityCubit,
                      builder: (context, state) {
                        return CustomTextForm(
                          isPass: visiblityCubit.obsecureText,
                          controller: pass,
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

                    const SizedBox(height: 10),

                    BlocBuilder<LoginCubit, LoginState>(
                      bloc: logInCubit,
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () => logInCubit.login(
                            email: email.text,
                            password: pass.text,
                          ),
                          child: Text(
                            'LogIn',
                            style: AppFonts.f20ExtraBold0F172A().copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  RegisterRow()
                  ],
                ),
              );
  }
}