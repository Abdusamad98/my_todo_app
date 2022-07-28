import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_todo_app/presentation/splash/splash_screen.dart';

void main() async{
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.pink, // status bar color
  //   statusBarBrightness: Brightness.dark,//status bar brigtness
  //   statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
  //   systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
  //   systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale('en', 'EN'),
        Locale('ru', 'RU'),
        Locale('uz', 'UZ'),
      ],
      saveLocale: true,
      fallbackLocale: Locale('uz', 'UZ'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
