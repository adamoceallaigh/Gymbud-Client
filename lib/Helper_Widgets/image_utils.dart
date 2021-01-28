import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  // Active Image File
  File _imageFile;
  final _storage = FirebaseStorage.instance;
  ImagePicker _imgPicker = new ImagePicker();
  PickedFile _selectedImage;

  _pickImage(ImageSource source) async {
    // Check Permissions if Picking from Gallery
    if(source == ImageSource.gallery){
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if(permissionStatus.isGranted){
        //Select Image
        _selectedImage = await _imgPicker.getImage(source: source);
      } else{
        print("Grant Permissions and try again");
      }
    }

    _selectedImage = await _imgPicker.getImage(source: source);
    File _selected = File(_selectedImage.path);
    await _uploadFile(_selectedImage , _selected);
    
    setState((){
      _imageFile = _selected;
    });
  }

  _cropImage() async {
    File _croppedImage = await ImageCropper.cropImage(sourcePath: _imageFile.path);

    setState((){
      _imageFile = _croppedImage ?? _imageFile;
    });
  }

  _clear(){
    setState(() => _imageFile = null);
  }

  _uploadFile(PickedFile imageFile , File file) async {
    // Function to upload the photo to firebase storage
    if(imageFile != null){
      String filePath = 'images/';
      await _storage.ref().child(filePath).putFile(file);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset('Resources/Images/logoGymbud.png')),
            RaisedButton(
              child: Text('Upload Photo'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            RaisedButton(
              child: Text('Take Photo'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
          ]
        )
      ),
      body: ListView(
        children: <Widget>[
            (_imageFile != null)
              ? Image.file(_imageFile) : 
              Placeholder(fallbackHeight: 200.0 , fallbackWidth : double.infinity ) ,
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                )
              ]
            ),
          ],
      )
    );
  }
}



