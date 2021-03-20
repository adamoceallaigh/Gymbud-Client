// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class ActivitiesNotifier extends StateNotifier<List<Activity>> {
  ActivitiesNotifier() : super([]);

  void addActivities(List<Activity> activities) => {state = activities};

  void createActivity(Activity activity) => {
        state = [...state, activity]
      };

  void readActivities() => state;

  void updateActivity(Activity updatedActivity) => {
        state = [
          for (final activity in state)
            if (activity.id == updatedActivity.id) updatedActivity else activity
        ]
      };

  void deleteActivity(Activity targetActivity) => {
        state = state
            .where((activity) => activity.id != targetActivity.id)
            .toList(),
      };
}

//  state = [
//           ...state,
//           activity,
//         ],
