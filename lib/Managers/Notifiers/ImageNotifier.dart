import 'package:Client/Helpers/Libs_Required.dart';

class ImageNotifier extends ChangeNotifier {
  String _value = "";
  String get value => _value;
  void setString(String urlPath) {
    _value = urlPath;
    notifyListeners();
  }
}
