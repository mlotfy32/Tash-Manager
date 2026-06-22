import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_cool_down_state.dart';

class StartCoolDownCubit extends Cubit<StartCoolDownState> {
  StartCoolDownCubit() : super(StartCoolDownInitial());
  Timer? _timer;
  int remainingSeconds = 0;
  bool get canSignUp => remainingSeconds == 0;
  String widgetState = '';
  void startCooldown() {
    remainingSeconds = 30;

    safeEmit(SignUpTimer(remainingSeconds));

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;

      safeEmit(SignUpTimer(remainingSeconds));

      if (remainingSeconds <= 0) {
        timer.cancel();
        widgetState = '';
        safeEmit(StartCoolDownInitial());
      }
    });
  }

  void safeEmit(StartCoolDownState state) {
    if (!isClosed) emit(state);
  }
}
