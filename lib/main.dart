// Imports 
import 'package:Client/pages/loading.dart';
import 'package:flutter/material.dart';

// Setting up routes and paths for the flutter app
void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
    }
));