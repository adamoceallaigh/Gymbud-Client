// Imports

// Library Imports
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// Page Imports

// Image Controller Class Definition to conduct user management operations
class ImageController {
  // Variable to hold the list of users throughout the methods
  List<Image> users = [];

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  ImageController(String url) {
    this.url_in_use = '$url/image/upload';
  }

  // Upload Image file to server
  Future<String> uploadImage(File _image) async {
    try {
      Response response = await dio.post(
        '${this.url_in_use}',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
        ),
        data: jsonEncode(
          {'uploadingImage': _image},
        ),
      );
      if (response.statusCode == 200) {
        var userJSON = response.data;
        // return Image.fromJSON(userJSON);
      }
      return null;
    } catch (e) {
      print('caught error $e');
    }
    return null;
  }

  Future<Image> createImage(Image user) async {}
}
