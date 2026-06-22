import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/supabase/supabase_error_hundler.dart';
import 'package:task/features/auth/cubit/start_cool_down_cubit.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final formKey = GlobalKey<FormState>();

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required SignUpCubit signUp,
    required StartCoolDownCubit startCooldownCubit,
  }) async {
    if (formKey.currentState!.validate()) {
      safeEmit(SignUpLoading());
      try {
        final SupabaseClient _client = sl<SupabaseClient>();
        await _client.auth.signUp(
          email: email,
          password: password,
          data: {'username': name},
        );
        Helper.flutterToast(
          message: "Account created successfully. Please login.",
        );
        safeEmit(SignUpSuccess());
      } on AuthApiException catch (e) {
        startCooldownCubit.widgetState = 'signup';
        startCooldownCubit.startCooldown();
        Helper.flutterToast(message: mapAuthError(e));
        emit(SignUpFailure());
      } catch (e) {
        startCooldownCubit.widgetState = 'signup';
        startCooldownCubit.startCooldown();
        Helper.flutterToast(message: mapAuthError(e));
        safeEmit(SignUpFailure());
      }
    }
  }
void emitInitial(){
  safeEmit(SignUpInitial());
}
  void safeEmit(SignUpState state) {
    if (!isClosed) emit(state);
  }
}
