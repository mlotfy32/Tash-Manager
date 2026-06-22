import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';
import 'package:task/core/utiles/supabase/supabase_error_hundler.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final formKey = GlobalKey<FormState>();

  Future<void> login({required String email, required String password}) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        final SupabaseClient _client = Supabase.instance.client;
        final response = await _client.auth.signInWithPassword(
          email: email,
          password: password,
        );
        await SharedPref.instance.setString(
          PrefsKeys.userID,
          response.user!.id,
        );
        emit(LoginSuccess());
        print(response.user!.id);
      } on AuthApiException catch (e) {
        Helper.flutterToast(message: mapAuthError(e));
        emit(LoginFailure());
      } catch (e) {
        Helper.flutterToast(message: "login failed");
        emit(LoginFailure());
      }
    }
  }
}
