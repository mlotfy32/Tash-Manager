import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension SizeExtentions on BuildContext {
  double getWidth({required BuildContext context}) =>
      MediaQuery.sizeOf(context).width;
  double getHeight({required BuildContext context}) =>
      MediaQuery.sizeOf(context).height;
}

extension pray12hFormate on BuildContext {
  pray12hformate({required String text}) {
    if (text.contains(':')) {
      int frist = int.parse(text.split(':').first) > 12
          ? int.parse(text.split(':').first) - 12
          : int.parse(text.split(':').first);
      return '$frist:${text.split(':').last}';
    } else {
      return text;
    }
  }
}
extension ExtensionWidget on Widget {
  Widget get center => Align(alignment: Alignment.center, child: this);

  Widget withPadding({
    double all = 0.0,
    double vertical = 0.0,
    double horizontal = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    double start = 0.0,
    double end = 0.0,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: all + vertical + top,
        bottom: all + vertical + bottom,
        start: all + horizontal + start,
        end: all + horizontal + end,
      ),
      child: this,
    );
  }

  Widget get toEnd => Align(alignment: AlignmentDirectional.centerEnd, child: this);
  Widget get toStart => Align(alignment: AlignmentDirectional.centerStart, child: this);
  Widget get toBottom => Align(alignment: Alignment.bottomCenter, child: this);
  Widget get toBottomEnd => Align(alignment: AlignmentDirectional.bottomEnd, child: this);
  Widget get toBottomStart => Align(alignment: AlignmentDirectional.bottomStart, child: this);
  Widget get toTopEnd => Align(alignment: AlignmentDirectional.topEnd, child: this);
  Widget get toTopStart => Align(alignment: AlignmentDirectional.topStart, child: this);
  Widget get toTop => Align(alignment: Alignment.topCenter, child: this);
}
extension arabicDate on BuildContext {
  getArabicDate({required String date}) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      date = date.replaceAll(english[i], arabic[i]);
    }
    return date;
  }
}

extension Navigation on BuildContext {
  void navigateTo({required BuildContext context, required Widget child}) {
    Get.to(
      () => child,
      curve: Curves.easeInCirc,
      transition: Transition.zoom,
      duration: const Duration(microseconds: 500),
    );
  }

  void navigateBack({required BuildContext context}) {
    Get.back();
  }
}
