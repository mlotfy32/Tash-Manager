import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/routes/router_named.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';

void logOut({required BuildContext context}) async {
  try {
    await Supabase.instance.client.auth.signOut();
    await SharedPref.instance.remove(PrefsKeys.userID);
    var s= SharedPref.instance.getString(PrefsKeys.userID);
    log('$s');
    context.go(RouterNamed.login);
  } on Exception catch (_) {
    Helper.flutterToast(message: 'Something went wrong');
  }
}
