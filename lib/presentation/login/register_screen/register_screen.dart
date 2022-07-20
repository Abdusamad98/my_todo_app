import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/presentation/login/login_screen/login_screen.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();

    usernameController.dispose();
    passwordController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginScreen();
            }));
          },
        ),
        title: const Text("Register screen"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onSubmitted: (v) {
                UtilityFunctions.fieldFocusChange(
                    context, focusNode1, focusNode2);
              },
              focusNode: focusNode1,
              controller: usernameController,
            ),
            TextField(
              onSubmitted: (v) {
                UtilityFunctions.fieldFocusChange(
                    context, focusNode2, focusNode3);
              },
              focusNode: focusNode2,
              controller: passwordController,
            ),
            TextField(
              onSubmitted: (v) {
                focusNode3.unfocus();
              },
              focusNode: focusNode3,
              controller: ageController,
            ),
            TextButton(
                onPressed: () async {
                  if (usernameController.text.trim().length > 3 &&
                      passwordController.text.trim().length > 6 &&
                      ageController.text.isNotEmpty) {
                    await StorageRepository.putString(
                        key: "username", value: usernameController.text);
                    await StorageRepository.putString(
                        key: "password", value: passwordController.text);
                    await StorageRepository.putString(
                        key: "age", value: ageController.text);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                  }));
                },
                child:const Text("Register User"))
          ],
        ),
      ),
    );
  }
}
