import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class CheckInternetConnection {
  static final CheckInternetConnection _instance =
      CheckInternetConnection._internal();

  static CheckInternetConnection get instance => _instance;

  CheckInternetConnection._internal();

  Future<bool> checkInternet() async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      return true;
    } else {
      return false;
    }
  }
}
