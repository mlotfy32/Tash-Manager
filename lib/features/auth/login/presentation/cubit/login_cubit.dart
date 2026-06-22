import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';
import 'package:task/core/utiles/supabase/supabase_error_hundler.dart';
import 'package:task/features/auth/cubit/start_cool_down_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final formKey = GlobalKey<FormState>();
  Future<void> login({
    required String email,
    required String password,
    required StartCoolDownCubit startCooldownCubit,
    required LoginCubit loginCubit,
  }) async {
    if (formKey.currentState!.validate()) {
      safeEmit(LoginLoading());
      try {
        final SupabaseClient _client = sl<SupabaseClient>();
        final response = await _client.auth.signInWithPassword(
          email: email,
          password: password,
        );
        await SharedPref.instance.setString(
          PrefsKeys.userID,
          response.user!.id,
        );
        safeEmit(LoginSuccess());

        print(response.user!.id);
      } on AuthApiException catch (e) {
        startCooldownCubit.widgetState='login';
        startCooldownCubit.startCooldown();
        Helper.flutterToast(message: mapAuthError(e));
        safeEmit(LoginFailure());
      } catch (e) {
        startCooldownCubit.widgetState='login';
        startCooldownCubit.startCooldown();
        Helper.flutterToast(message: mapAuthError(e));
        safeEmit(LoginFailure());
      }
    }
  }
void emitInitial(){
  safeEmit(LoginInitial());
}
  void safeEmit(LoginState state) {
    if (!isClosed) emit(state);
  }
}
