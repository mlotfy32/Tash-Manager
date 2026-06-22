import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';
import 'package:task/core/utiles/supabase/supabase_error_hundler.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final SupabaseClient _client = Supabase.instance.client;
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      await SharedPref.instance.setString(PrefsKeys.userID, response.user!.id);
      emit(LoginSuccess());
      log(response.user!.id);
    } on AuthApiException catch (e) {
      emit(LoginFailure(errorMessage: mapAuthError(e)));
    } catch (e) {
      log("FB LOGIN ERROR: $e");
      emit(LoginFailure(errorMessage: "login failed"));
    }
  }
}
