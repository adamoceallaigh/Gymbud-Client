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
    return Container(
        child: Row(
      children: [
        Hero(
          tag: 'Activity ${widget.sessionId}',
          child: Expanded(
            child: Image.network(
                "https://images.unsplash.com/photo-1600881333165-1c06e53eeae2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8ODR8fGNvcmUlMjB3b3Jrb3V0fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
          ),
        ),
      ],
    ));
  }
}
