//Imports and Variable Declarations
// import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CalendarView.dart';
import 'HomeView.dart';
import 'MatchView.dart';
import 'ProfilePage.dart';

///Setting my Page up as a Stateful Widget
///so I can change the state of the list of users

class Home extends StatefulWidget {
  final User user;

  // We are going to instantiate a NewTripLocation with a required Trip instance
  // This is the way we are going to save the values across the pages
  Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _tabPages = [];
  Widget filterWidget;
  bool isDropped = false;
  GlobalKey filterKey;
  double widthOfFilterContainer, heightOfContainer, xPos, yPos;
  OverlayEntry _filterContainer;
  RangeValues _ageValues = RangeValues(5, 90);

  // Using Initiliazation method to set the state once with the list of users
  @override
  void initState() {
    super.initState();
    this._tabPages = [
      HomeView(),
      MatchView(user: widget.user),
      CalendarView(user: widget.user)
    ];
    filterKey = LabeledGlobalKey("filterDropdown");
  }

  // final _tabPages = [HomeView(), MatchView(), CalendarView()];

  void onTabTapped(int index) {
    setState(() => {_currentIndex = index});
  }

  List<Widget> getTopBarActions() {
    List<Widget> actionsList = new List<Widget>();
    actionsList = [
      GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(user: widget.user)),
          ),
        },
        // child: CircleAvatar(
        //   radius: 50.0,
        //   backgroundImage: widget.user.profileUrl != null
        //       ? new NetworkImage(widget.user.profileUrl)
        //       : null,
        //   backgroundColor: Colors.transparent,
        // ),
      ),
    ];
    return actionsList;
  }

  void fillDropDownData() {
    RenderBox renderBox = filterKey.currentContext.findRenderObject();
    widthOfFilterContainer = MediaQuery.of(context).size.width;
    heightOfContainer = renderBox.size.height;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPos = offset.dx;
    yPos = offset.dy;
    print(
      "Height : $heightOfContainer , Width: $widthOfFilterContainer , xPos: $xPos , yPos: $yPos , isDropped: $isDropped",
    );
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        width: widthOfFilterContainer,
        height: MediaQuery.of(context).size.height / 4,
        top: yPos + heightOfContainer + 10,
        child: Material(
          child: Container(
            alignment: null,
            color: Colors.white,
            height: 200,
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("Resources/Images/Male.svg"),
                          SvgPicture.asset("Resources/Images/Female.svg"),
                          SvgPicture.asset("Resources/Images/All_Gender.svg"),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("Resources/Images/GymWeights.svg"),
                          SvgPicture.asset("Resources/Images/Home_Workout.svg"),
                          SvgPicture.asset("Resources/Images/Outdoor_Act.svg"),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always),
                        child: RangeSlider(
                          values: _ageValues,
                          min: 0,
                          max: 100,
                          labels: RangeLabels('${_ageValues.start.round()}',
                              '${_ageValues.end.round()}'),
                          inactiveColor: Colors.grey,
                          activeColor: HexColor('#EB9661'),
                          onChanged: (RangeValues values) {
                            print(
                                'START: ${_ageValues.start.round()}, END: ${_ageValues.end.round()}');
                            setState(() {
                              widget.user.preferredAgeRange =
                                  '${_ageValues.start} - ${_ageValues.end}';
                              _ageValues = values;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBar() {
    if (_currentIndex == 1) {
      return AppBar(
        title: GestureDetector(
          key: filterKey,
          onTap: () => {
            setState(() {
              if (isDropped)
                _filterContainer.remove();
              else {
                fillDropDownData();
                _filterContainer = _createDropDown();
                Overlay.of(context).insert(_filterContainer);
              }
              isDropped = !isDropped;
            })
          },
          child: Container(
            margin: EdgeInsets.only(left: 4, right: 4),
            height: 40,
            decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              border: Border.all(
                width: 1.0,
                color: HexColor('#C4C4C4'),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FILTER BY",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#000000"),
                  ),
                ),
                SizedBox(width: 10),
                SvgPicture.asset("Resources/Images/arrowFilter.svg"),
              ],
            ),
          ),
        ),
        leading: Container(
          height: 120,
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'Resources/Images/logoGymbud.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        // actions: getTopBarActions(),
        backgroundColor: HexColor("FEFEFE"),
      );
    }
    return AppBar(
      leading: Container(
        height: 120,
        padding: const EdgeInsets.all(0),
        child: Expanded(
          child: Image.asset(
            'Resources/Images/logoGymbud.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      // actions: getTopBarActions(),
      backgroundColor: HexColor("FEFEFE"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      appBar: getAppBar(),
      endDrawer: Drawer(
        child: Text("Well"),
      ),
      body: _tabPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: HexColor("EB9661"),
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("Resources/Images/House_Icon.png"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("Resources/Images/Buds_Icon.png"),
            label: 'Buds',
          ),
          BottomNavigationBarItem(
              icon: Image.asset("Resources/Images/Calendar_Icon.png"),
              label: 'Calendar')
        ],
      ),
    );
  }
}
