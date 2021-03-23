import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class DatesNotifier extends ChangeNotifier {
  List<Activity> _value = List<Activity>.empty();
  List<Activity> get value => _value;
  void setDates(List<dynamic> activities) {
    List<Activity>.from(activities).map((activity) => activity as Activity);
    _value = (activities).map((e) => e as Activity)?.toList();
    notifyListeners();
  }
}
