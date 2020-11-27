import 'package:Client/pages/loading.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
    }
));