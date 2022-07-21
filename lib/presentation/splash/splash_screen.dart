import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/presentation/login/login_screen/login_screen.dart';
import 'package:my_todo_app/presentation/on_boarding/on_boarding_screen.dart';
import 'package:my_todo_app/presentation/tabs/tab_box/tab_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  bool isInitial = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await StorageRepository.getInstance();
    isLogged = StorageRepository.getBool("is_logged");
    isInitial = StorageRepository.getBool("is_initial");

    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext con) {
      return isLogged
          ? TabBox()
          : isInitial == true
              ? LoginScreen()
              : OnBoardingScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
