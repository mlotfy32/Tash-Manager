
import 'package:flutter/material.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';

class ObscureTextIcon extends StatelessWidget {
  const ObscureTextIcon({
    super.key,
    required this.obscureTextCubit,
  });

  final ObscureTextCubit obscureTextCubit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          obscureTextCubit.changeObscureText(),
      icon: Icon(
        obscureTextCubit.obsecureText
            ? Icons.remove_red_eye
            : Icons.visibility_off,
      ),
    );
  }
}
