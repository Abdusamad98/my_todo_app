import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/models/profile_model.dart';
import 'package:my_todo_app/presentation/tabs/profile/sub_screens/settings_screen.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

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

  void _init() async {
    imagePath = StorageRepository.getString("profile_image");
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const SettingsScreen();
                  }));
                },
                icon: const Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext con) {
                      return AlertDialog(
                        title: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                  "Are you sure you want to log out? Todo lar hammasi o'chadi!"),
                            ),
                            Icon(Icons.warning)
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () async {
                                await MyRepository.logUserOut();
                                SystemNavigator.pop();
                              },
                              child: Text("Ok")),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.logout)),
          ],
          title: const Text(
            "Profile  screen",
          ),
        ),
        body: FutureBuilder<ProfileModel>(
          future: MyRepository.getProfileModel(),
          builder: (BuildContext con, AsyncSnapshot<ProfileModel> data) {
            if (data.hasData) {
              var profileModel = data.data!;
              return Container(
                margin: EdgeInsets.all(24),
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
                                ? Image.asset(
                                    "assets/images/default_person.jpg")
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
                              onPressed: () async {
                                selectImageDialog(context);
                              },
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Username"),
                        Text(profileModel.firstName),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lastname"),
                        Text(profileModel.lastName),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Age"),
                        Text(profileModel.userAge.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email"),
                        Text(profileModel.userEmail),
                      ],
                    )
                  ],
                ),
              );
            } else if (data.hasError) {
              UtilityFunctions.getMyToast(message: "Error occurred");
              return Center(
                child: Text("Error occured"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
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
