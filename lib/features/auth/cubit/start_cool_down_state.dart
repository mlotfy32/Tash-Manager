part of 'start_cool_down_cubit.dart';

@immutable
sealed class StartCoolDownState {}

final class StartCoolDownInitial extends StartCoolDownState {}
class SignUpTimer extends StartCoolDownState {
  final int seconds;

  SignUpTimer(this.seconds);
}