import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Picker Kullanımı',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _myImage = File('');
  int isFileSelected = 0;
  ImagePicker picker = ImagePicker();

  pickImage(ImageSource source) async {
    XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width,
      preferredCameraDevice: CameraDevice.rear,
    );
    setState(() {
      if (image == null) {
        //TODO: Image not selected action.
        isFileSelected = 0;
      } else {
        //TODO: Image selected action.
        _myImage = File(image.path);
        isFileSelected = 1;
      }
    });
  }

  Widget showImage(File file) {
    if (isFileSelected == 0) {
      //TODO: Image not selected widget.
      return Center(child: Text("Resim Seçilmedi."));
    } else {
      //TODO: Image selected widget.
      return Container(
        height: MediaQuery.of(context).size.width * 9 / 16,
        width: MediaQuery.of(context).size.width,
        child: Image.file(file, fit: BoxFit.contain),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showImage(_myImage),
          ElevatedButton(onPressed: () => pickImage(ImageSource.camera), child: const Text("Kamera")),
          ElevatedButton(onPressed: () => pickImage(ImageSource.gallery), child: const Text("Galeri")),
        ],
      ),
    );
  }
}
