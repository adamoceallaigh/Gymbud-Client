import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';

class SessionDetails extends StatefulWidget {
  final User user;

  SessionDetails({Key key, @required this.user}) : super(key: key);
  @override
  _SessionDetailsState createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  final resources = [
    "Bicycle",
    "Assault Bike",
    "Trap Bar",
    "Barbells",
    "Plates",
    "Bands",
    "Suspension Trainers",
    "Skipping Rope",
    "Treadmill",
    "Slam Ball",
    "Kettle Bells"
  ];

  final activities = [
    "Swim",
    "Run",
    "Walk",
    "At Home Workout",
    "Gym",
    "Skip",
    "Hike",
    "Cycle"
  ];
  double _defaultIntensity = 20.0;
  // var pressed = false ; // This is the press variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SessionBody()
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Image.asset("Resources/Images/logoGymbud.png",
          height: 100.0, width: 100.0),
      backgroundColor: HexColor("FEFEFE"),
    );
  }

  Widget SessionBody(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Pick your fitness Level"),
        ),
        SliderTheme(
          data: SliderThemeData(),
          child: Slider(
            min: 0.0,
            max: 100.0,
            divisions: 5,
            label: GetLabel(_defaultIntensity),
            value: _defaultIntensity,
            onChanged: (val) => {
              setState((){
                _defaultIntensity = val;     
              })
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Pick your session intensity level"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Pick the resources you have"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Pick the activities you enjoy"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Pick your preferred session method"),
        ),
        RaisedButton(
          child: Text("Finish"),
          onPressed: null
        )
      ]
    );
  }

    String getLabel(double intensityLevel) {
      String returnLabel = "";
      switch (intensityLevel) {
        case 0.0:
        returnLabel = "";
        break
        case 20.0:
        returnLabel = "";
        break
        case 40.0:
        returnLabel = "";
        break
        case 60.0:
        returnLabel = "";
        break
        case 80.0:
        returnLabel = "";
        break
        case 100.0:
        returnLabel = "";
        break
        default:
        break
      }
            return returnLabel;
  }


}


// body: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(40.0),
//               child: Text(
//                 "Pick the resources you have",
//               ),
//             ),
//             GridView(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3
//               ),
//               children: resources.map((resource) {
//                 return GestureDetector(
//                   child: Card(
//                     margin: EdgeInsets.all(20.0),
//                     child: ResourceOption()
//                   ),
//                   onTap: () => {
//                     if (!widget.user.resources.contains(resource)){
//                       widget.user.resources.add(resource)
//                     } else {
//                       widget.user.resources.remove(resource)
//                     },
//                     setState(() => {})
//                   },
//                 );
//               }).toList(),
//               //   return Container(
//               //         decoration: BoxDecoration(
//               //             border: Border.all(color: HexColor('#C8C8C8'))
//               //         ),
//               //         child: FlatButton(
//               //           child: Column(
//               //               mainAxisAlignment: MainAxisAlignment.center,
//               //               children: [Text(resource)]
//               //           ),
//               //           color: widget.user.resources.contains(resource)
//               //               ? HexColor('#EB9661')
//               //               : Colors.transparent,
//               //           onPressed: () => {
//               //               if (!widget.user.resources.contains(resource)){
//               //                 widget.user.resources.add(resource)
//               //               } else {
//               //                 widget.user.resources.remove(resource)
//               //               },
//               //             setState(() => {})
//               //           },
//               //         ),
//               //       );
//               // }).toList(),
//               // shrinkWrap: true,
//             ),
//             //     return Container(
//             //           decoration: BoxDecoration(
//             //               border: Border.all(color: HexColor('#C8C8C8'))
//             //           ),
//             //           child: FlatButton(
//             //             child: Column(
//             //                 mainAxisAlignment: MainAxisAlignment.center,
//             //                 children: [Text(resources[resource])]),
//             //             color: widget.user.resources
//             //                     .contains(resources[resource])
//             //                 ? HexColor('#EB9661')
//             //                 : Colors.transparent,
//             //             onPressed: () => {
//             //               if (!widget.user.resources
//             //                   .contains(resources[resource]))
//             //                 {
//             //                   widget.user.resources
//             //                       .add(resources[resource])
//             //                 }
//             //               else
//             //                 {
//             //                   widget.user.resources
//             //                       .remove(resources[resource])
//             //                 },
//             //               setState(() => {})
//             //             },
//             //           ),
//             //         );
//             //   }),
//             // ),
//             // children: List.generate(
//             //     resources.length,
//             //     (resource) => Container(
//             //           decoration: BoxDecoration(
//             //               border: Border.all(color: HexColor('#C8C8C8'))
//             //           ),
//             //           child: FlatButton(
//             //             child: Column(
//             //                 mainAxisAlignment: MainAxisAlignment.center,
//             //                 children: [Text(resources[resource])]),
//             //             color: widget.user.resources
//             //                     .contains(resources[resource])
//             //                 ? HexColor('#EB9661')
//             //                 : Colors.transparent,
//             //             onPressed: () => {
//             //               if (!widget.user.resources
//             //                   .contains(resources[resource]))
//             //                 {
//             //                   widget.user.resources
//             //                       .add(resources[resource])
//             //                 }
//             //               else
//             //                 {
//             //                   widget.user.resources
//             //                       .remove(resources[resource])
//             //                 },
//             //               setState(() => {})
//             //             },
//             //           ),
//             //         ))
//             // ),
//             Container(
//               padding: EdgeInsets.all(40.0),
//               child: Text(
//                 "Pick the activities you enjoy",
//               ),
//             ),
//             // GridView.count(
//             //         crossAxisCount: 3,
//             //         scrollDirection: Axis.vertical,
//             //         primary: false,
//             //         children: List.generate(
//             //             activities.length,
//             //             (activity) => Container(
//             //               decoration: BoxDecoration(
//             //                       border: Border.all(color: HexColor('#C8C8C8'))
//             //                   ),
//             //               child: FlatButton(
//             //                     child: Column(
//             //                         mainAxisAlignment: MainAxisAlignment.center,
//             //                         children: [Text(activities[activity])]),
//             //                     color: widget.user.activitiesEnjoyed.contains(activities[activity])
//             //                         ? HexColor('#EB9661')
//             //                         : Colors.transparent,
//             //                     onPressed: () => {
//             //                       if (!widget.user.activitiesEnjoyed.contains(activities[activity])){
//             //                           widget.user.activitiesEnjoyed.add(activities[activity])
//             //                         }else{
//             //                           widget.user.activitiesEnjoyed.remove(activities[activity])
//             //                         },
//             //                       setState(() => {})
//             //                     },
//             //                   ),
//             //             )))