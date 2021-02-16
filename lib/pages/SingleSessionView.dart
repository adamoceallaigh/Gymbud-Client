import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/pages/ProfilePage.dart';
import 'package:flutter/material.dart';

class SingleSessionView extends StatefulWidget {
  final sessionId;

  SingleSessionView({this.sessionId});
  @override
  _SingleSessionViewState createState() => _SingleSessionViewState();
}

class _SingleSessionViewState extends State<SingleSessionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 70,
          padding: const EdgeInsets.all(0),
          child: Row(children: [
            Expanded(
              flex: 6,
              child: Image.asset(
                'Resources/Images/logoGymbud.png',
                fit: BoxFit.fill,
              ),
            ),
          ]),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () => {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => ProfilePage(user: widget.user)),
        //       ),
        //     },
        //     child: CircleAvatar(
        //       radius: 50.0,
        //       backgroundImage: widget.user.profileUrl != null
        //           ? new NetworkImage(widget.user.profileUrl)
        //           : null,
        //       backgroundColor: Colors.transparent,
        //     ),
        //   ),
        // ],
        // leading: Image.asset("Resources/Images/logoGymbud.png",
        // height: 100.0, width: 100.0),
        backgroundColor: HexColor("FEFEFE"),
      ),
      body: getSingleSessionBody(),
    );
  }

  Widget getSingleSessionBody() {
    return SingleChildScrollView(
      child: Container(
          height: 830,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 450,
                child: Hero(
                  tag: 'Activity ${widget.sessionId}',
                  child: Image.network(
                    "https://images.unsplash.com/photo-1600881333165-1c06e53eeae2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8ODR8fGNvcmUlMjB3b3Jrb3V0fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
