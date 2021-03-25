import 'package:Client/Helpers/Libs_Required.dart';

class ErrorNotifier extends ChangeNotifier {
  String message;

  void setString(String newMessage) {
    message = newMessage;
    notifyListeners();
  }
}
