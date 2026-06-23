import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';

class CustomTextForm extends StatefulWidget {
  CustomTextForm({
    super.key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.isPass, this.cubit,
  });
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  TextInputType? keyboardType;
  Widget? suffixIcon;
  bool? isPass;
final ObscureTextCubit? cubit;
  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
return TextFormField(
  controller: widget.controller,
  style: AppFonts.f16Redular717786().copyWith(fontSize: 12.sp),
  validator: widget.validator,
  keyboardType: widget.keyboardType,
  obscureText: widget.isPass != null &&widget. cubit!.obsecureText,

  decoration: InputDecoration(
    hintText: widget.hint,
    filled: true,
    fillColor: Theme.of(context).cardColor,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.5,
      ),
    ),

    suffixIcon: widget.suffixIcon,
    hintStyle: AppFonts.f16Redular717786().copyWith(fontSize: 12.sp),
  ),
);
  }
}
