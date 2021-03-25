// Imports

// Library Imports
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/Activity_Management/Components/Activity_Option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Config/configVariables.dart' as Constants;

class SelectFromOptionsWidget extends StatefulWidget {
  final List<GeneralOption> generalOptions;
  final String placeToChangeFrom;
  final String whatToChange;
  const SelectFromOptionsWidget(
      {Key key, this.generalOptions, this.placeToChangeFrom, this.whatToChange})
      : super(key: key);

  @override
  _SelectFromOptionsWidgetState createState() =>
      _SelectFromOptionsWidgetState();
}

class _SelectFromOptionsWidgetState extends State<SelectFromOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    // Getting instance of logged in user
    final logged_in_user = context.read(user_notifier_provider.state);

    // Creating instance of GeneralHelperMethodManager
    final generalHelperMethodManager = GeneralHelperMethodManager(
        context: context, logged_in_user: logged_in_user);

    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.generalOptions.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                widget.generalOptions
                    .forEach((gender) => gender.isSelected = false);
                widget.generalOptions[index].isSelected = true;
                generalHelperMethodManager.checkProvider(
                  widget.placeToChangeFrom,
                  widget.whatToChange,
                  widget.generalOptions[index].hiddenText,
                );
              });
            },
            child: GeneralOptionRadio(widget.generalOptions[index]),
          );
        },
      ),
    );
  }
}

class ActivitySliders extends StatefulWidget {
  final String place;
  final BuildContext context;

  ActivitySliders({this.context, this.place});

  @override
  _ActivitySlidersState createState() => _ActivitySlidersState();
}

class _ActivitySlidersState extends State<ActivitySliders> {
  @override
  Widget build(BuildContext context) {
    // Creating instance of GeneralHelperMethodManager
    final generalHelperMethodManager = GeneralHelperMethodManager(
        context: this.widget.context,
        logged_in_user: context.read(user_notifier_provider.state));

    return Container(
      margin: EdgeInsets.only(top: 20),
      height: widget.place == "User" ? 195 : 295,
      child: Column(
        children: [
          ActivityFitnessSlider(generalHelperMethodManager, widget.place),
          ActivityIntensitySlider(generalHelperMethodManager, widget.place),
          if (widget.place != "User")
            ActivityBudgetSlider(generalHelperMethodManager, widget.place),
        ],
      ),
    );
  }
}

class ActivityFitnessSlider extends StatefulWidget {
  final GeneralHelperMethodManager generalHelperMethodManager;
  final String place;
  ActivityFitnessSlider(this.generalHelperMethodManager, this.place);

  @override
  _ActivityFitnessSliderState createState() => _ActivityFitnessSliderState();
}

class _ActivityFitnessSliderState extends State<ActivityFitnessSlider> {
  @override
  Widget build(BuildContext context) {
    final whichProvider = widget.place == "User"
        ? context.read(user_notifier_provider.state).fitnessLevel
        : context.read(activity_notifier_provider.state).activityFitnessLevel;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Pick your fitness Level",
            style: GoogleFonts.meriendaOne(
              color: HexColor("#000000"),
              fontSize: 15,
            ),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            rangeTickMarkShape: RoundRangeSliderTickMarkShape(
              tickMarkRadius: 500,
            ),
          ),
          child: Slider(
            min: 0.0,
            max: 100.0,
            divisions: 5,
            activeColor: HexColor("#EB9661"),
            // inactiveColor: HexColor("#2E2B2B"),
            label: widget.generalHelperMethodManager.getLabel(
                    widget.generalHelperMethodManager
                        .getPercentLevel(whichProvider, "Fitness"),
                    "Fitness") ??
                widget.generalHelperMethodManager.getLabel(
                    Constants.ActivityVariableStore.defaultActivityLevel,
                    "Fitness"),
            value: widget.generalHelperMethodManager
                    .getPercentLevel(whichProvider, "Fitness") ??
                Constants.ActivityVariableStore.defaultActivityLevel,
            onChanged: (val) => {
              setState(() {
                widget.generalHelperMethodManager
                    .setActivityPreferencesFromSlider(
                  "Fitness",
                  widget.place,
                  widget.generalHelperMethodManager.getLabel(val, "Fitness"),
                );
              })
            },
          ),
        ),
      ],
    );
  }
}

class ActivityIntensitySlider extends StatefulWidget {
  final GeneralHelperMethodManager generalHelperMethodManager;
  final String place;
  ActivityIntensitySlider(this.generalHelperMethodManager, this.place);

  @override
  _ActivityIntensitySliderState createState() =>
      _ActivityIntensitySliderState();
}

class _ActivityIntensitySliderState extends State<ActivityIntensitySlider> {
  @override
  Widget build(BuildContext context) {
    final whichProvider = widget.place == "User"
        ? context.read(user_notifier_provider.state).preferredIntensity
        : context.read(activity_notifier_provider.state).activityIntensityLevel;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Pick your activity intensity level",
            style: GoogleFonts.meriendaOne(
              color: HexColor("#000000"),
              fontSize: 15,
            ),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(),
          child: Slider(
            min: 0.0,
            max: 100.0,
            divisions: 5,
            activeColor: HexColor("#EB9661"),
            label: widget.generalHelperMethodManager.getLabel(
                    widget.generalHelperMethodManager
                        .getPercentLevel(whichProvider, "Intensity"),
                    "Intensity") ??
                widget.generalHelperMethodManager.getLabel(
                    Constants.ActivityVariableStore.defaultIntensity,
                    "Intensity"),
            value: widget.generalHelperMethodManager
                    .getPercentLevel(whichProvider, "Intensity") ??
                Constants.ActivityVariableStore.defaultIntensity,
            onChanged: (val) => {
              setState(() {
                widget.generalHelperMethodManager
                    .setActivityPreferencesFromSlider(
                        "Intensity",
                        widget.place,
                        widget.generalHelperMethodManager
                            .getLabel(val, "Intensity"));
              })
            },
          ),
        ),
      ],
    );
  }
}

class ActivityBudgetSlider extends StatefulWidget {
  final GeneralHelperMethodManager generalHelperMethodManager;
  final String place;
  ActivityBudgetSlider(this.generalHelperMethodManager, this.place);

  @override
  _ActivityBudgetSliderState createState() => _ActivityBudgetSliderState();
}

class _ActivityBudgetSliderState extends State<ActivityBudgetSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Pick your Budget Level",
            style: GoogleFonts.meriendaOne(
              color: HexColor("#000000"),
              fontSize: 15,
            ),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            rangeTickMarkShape: RoundRangeSliderTickMarkShape(
              tickMarkRadius: 500,
            ),
          ),
          child: Slider(
            min: 0.0,
            max: 100.0,
            divisions: 5,
            activeColor: HexColor("#EB9661"),
            // inactiveColor: HexColor("#2E2B2B"),
            label: widget.generalHelperMethodManager.getLabel(
                    widget.generalHelperMethodManager.getPercentLevel(
                        context
                            .read(activity_notifier_provider.state)
                            .activityBudgetLevel,
                        "Budget"),
                    "Budget") ??
                widget.generalHelperMethodManager.getLabel(
                    Constants.ActivityVariableStore.defaultActivityLevel,
                    "Budget"),
            value: widget.generalHelperMethodManager.getPercentLevel(
                    context
                        .read(activity_notifier_provider.state)
                        .activityBudgetLevel,
                    "Budget") ??
                Constants.ActivityVariableStore.defaultActivityLevel,
            onChanged: (val) => {
              setState(() {
                widget.generalHelperMethodManager
                    .setActivityPreferencesFromSlider(
                        "Budget",
                        widget.place,
                        widget.generalHelperMethodManager
                            .getLabel(val, "Budget"));
              })
            },
          ),
        ),
      ],
    );
  }
}

class ActivityResourcesGrid extends StatefulWidget {
  final String place;
  final BuildContext context;

  ActivityResourcesGrid({this.context, this.place});

  @override
  _ActivityResourcesGridState createState() => _ActivityResourcesGridState();
}

class _ActivityResourcesGridState extends State<ActivityResourcesGrid> {
  @override
  Widget build(BuildContext context) {
    // Obtaining the logged in user
    final logged_in_user = context.read(user_notifier_provider.state);

    // Obtaining the activity we just set up
    final activity_notifier = context.read(activity_notifier_provider.state);
    if (activity_notifier.resources == null) activity_notifier.resources = [];
    if (logged_in_user.activities == null) logged_in_user.activities = [];

    final checkedActivityPlace = activity_notifier.activityType == null
        ? logged_in_user.preferredActivity
        : activity_notifier.activityType;

    checkInputs() {
      switch (checkedActivityPlace) {
        case "Home_Workout":
          return Constants.ActivityVariableStore.resources;
        case "Outdoor_Activities":
          return Constants.ActivityVariableStore.activities;
      }
    }

    checkPlace() {
      switch (widget.place) {
        case "User":
          return logged_in_user.activities;
        case "Activity":
          return activity_notifier.resources;
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            checkedActivityPlace == "Home_Workout"
                ? "Pick the resources you have"
                : "Pick the activities you want",
            style: GoogleFonts.meriendaOne(
              color: HexColor("#000000"),
              fontSize: 18,
              letterSpacing: -1.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: SizedBox(
            height: 200,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                crossAxisCount: 4,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                shrinkWrap: true,
                children: checkInputs().map((resource) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: checkPlace() != null &&
                                checkPlace().contains(resource)
                            ? Colors.transparent
                            : HexColor('#C8C8C8'),
                      ),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: checkPlace() != null &&
                                checkPlace().contains(resource)
                            ? HexColor('#EB9661')
                            : Colors.transparent,
                        primary: checkPlace() != null &&
                                checkPlace().contains(resource)
                            ? Colors.white
                            : HexColor('#EB9661'),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            resource,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.0,
                            ),
                          )
                        ],
                      ),
                      onPressed: () => {
                        setState(() => {
                              if (!checkPlace().contains(resource))
                                {checkPlace().add(resource)}
                              else
                                {checkPlace().remove(resource)},
                            })
                      },
                    ),
                  );
                }).toList()),
          ),
        ),
      ],
    );
  }
}
