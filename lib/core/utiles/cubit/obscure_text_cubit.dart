import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'obscure_text_state.dart';

class ObscureTextCubit extends Cubit<ObscureTextState> {
  ObscureTextCubit() : super(ObscureTextInitial());
  bool obsecureText = true;
  void changeObscureText(){
    obsecureText = !obsecureText;
    emit(ObscureText());
  }
}
