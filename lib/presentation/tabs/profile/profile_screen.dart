import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/models/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String imagePath = "";
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    imagePath = StorageRepository.getString("profile_image");
    String password = StorageRepository.getString("password");
    ProfileModel profileModel = ProfileModel(
        imagePath: imagePath,
        password: password,
        lastName: "lastName",
        firstName: "firstName",
        userAge: 20,
        userEmail: "falonchi@gmail.com");
  }

  bool isValidEmail({required String email}) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  getFromGallery() async {
    imageFile = await _picker.pickImage(
      maxHeight: 500,
      maxWidth: 500,
      source: ImageSource.gallery,
    );
    if (imageFile != null) {
      await StorageRepository.putString(
        key: "profile_image",
        value: imageFile!.path,
      );
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
      await StorageRepository.putString(
          key: "profile_image", value: imageFile!.path);
      setState(() {
        imagePath = imageFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile  screen",
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: imagePath.isEmpty
                        ? Image.asset("assets/images/default_person.jpg")
                        : Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: TextButton(
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        selectImageDialog(context);
                      },
                    ))
              ],
            )
          ],
        ),
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
