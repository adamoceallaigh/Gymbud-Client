import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class DatesNotifier extends ChangeNotifier {
  List<Activity> _value = [];
  List<Activity> get value => _value;
  void setDates(List<dynamic> activities) {
    List<Activity> logged_in_users_activities_dates = [];
    activities.forEach((activity) {
      activity.forEach((value) {
        logged_in_users_activities_dates.add(value);
      });
    });
    _value = logged_in_users_activities_dates;
    notifyListeners();
  }
}
