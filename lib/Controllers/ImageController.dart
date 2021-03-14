// Imports

// Library Imports
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
    this.url_in_use = '$url/image/';
  }

  // Upload Image file to server
  Future<String> uploadImage(String imagePath) async {
    try {
      String filename = imagePath.split("/").last;
      final mimeTypeData =
          lookupMimeType(imagePath, headerBytes: [0xFF, 0xD8]).split("/");

      FormData formData = new FormData.fromMap({
        'uploadingImage': await MultipartFile.fromFile(
          imagePath,
          filename: filename,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
        "type": "image/png"
      });

      Response response = await dio.post(
        '${this.url_in_use}upload',
        data: formData,
        options: Options(
          headers: {"accept": "*/*", "Content-Type": "multipart/form-data"},
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["imagePath"] != null) {
          // this.url_in_use = this.url_in_use.split("/").first;
          return '${this.url_in_use}${response.data["imagePath"]}';
        }
      }
      return null;
    } catch (e) {
      print('caught error $e');
    }
    return null;
  }
}
