import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  String imagePath = "";

  getFromGallery() async {
    imageFile = await _picker.pickImage(
      maxHeight: 500,
      maxWidth: 500,
      source: ImageSource.gallery,
    );
    if (imageFile != null) {
      setState(() {
        imagePath = imageFile!.path;
      });
    }
  }

  getFromCamera() async {
    imageFile = await _picker.pickImage(
      maxHeight: 500,
      maxWidth: 500,
      source: ImageSource.camera,
    );
    if (imageFile != null) {
      setState(() {
        imagePath = imageFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
        title: Text(
          "Todo List   screen",
        ),
      ),
      body: Column(
        children: [
          Text("Under development"),
          TextButton(
              onPressed: () {
                selectImageDialog(context);
              },
              child: Text("Select Image")),
          SizedBox(
            width: 300,
            height: 300,
            child: imagePath.isNotEmpty
                ? Image.file(File(imagePath))
                : Image.asset("assets/images/default_person.jpg"),
          )
        ],
      ),
    );
  }

  void selectImageDialog(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 150, //MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text("Gallery"),
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text("Camera"),
                    onTap: () {
                      getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
