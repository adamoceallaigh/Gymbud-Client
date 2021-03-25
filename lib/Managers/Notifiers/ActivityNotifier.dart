// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class ActivityNotifier extends StateNotifier<Activity> {
  ActivityNotifier() : super(Activity());

  void createActivity(Activity newActivity) {
    state = newActivity;
  }

  void readActivity() => state;

  void updateActivity(Activity updatedActivity) {
    state = updatedActivity;
  }

  void deleteActivity(Activity targetActivity) => {
        state = null,
      };
  void addVideoUrl(String videoUrl) {
    state.activityVideoUrl = videoUrl;
  }
}
