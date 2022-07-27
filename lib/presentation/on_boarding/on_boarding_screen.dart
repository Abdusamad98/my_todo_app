import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/presentation/login/login_screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPageIndex = 0;
  String buttonText = "Next";
  PageController controller = PageController(initialPage: 0);
  List<Widget> screens = [
    Container(
        color: Colors.pink,
        child: Center(
          child: Text("page 1"),
        )),
    Container(
        color: Colors.yellow,
        child: Center(
          child: Text("page 2"),
        )),
    Container(
        color: Colors.green,
        child: Center(
          child: Text("page 3"),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page View"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              GestureDetector(
                  onTap: () async {
                    await StorageRepository.putBool("is_initial", true);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext c) {
                      return LoginScreen();
                    }));
                  },
                  child: Text("Skip"))
            ],
          ),
          Expanded(
              child: PageView(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (pageIndex) {
              print(pageIndex);
            },
            controller: controller,
            children: screens,
          )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                color: currentPageIndex == 0 ? Colors.blueAccent : Colors.pink,
                width: currentPageIndex == 0 ? 20 : 10,
              ),
              const SizedBox(width: 5),
              Container(
                height: 10,
                color: currentPageIndex == 1 ? Colors.blueAccent : Colors.pink,
                width: currentPageIndex == 1 ? 20 : 10,
              ),
              const SizedBox(width: 5),
              Container(
                height: 10,
                color: currentPageIndex == 2 ? Colors.blueAccent : Colors.pink,
                width: currentPageIndex == 2 ? 20 : 10,
              )
            ],
          ),
          TextButton(
              onPressed: () async {
                if (currentPageIndex < 2) {
                  setState(() {
                    currentPageIndex++;
                    controller.jumpToPage(currentPageIndex);
                  });
                } else {
                  await MyRepository.addInitialValues();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext c) {
                    return LoginScreen();
                  }));
                }
                if (currentPageIndex == 2) {
                  setState(() {
                    buttonText = "Let's start";
                  });
                }
              },
              child: SizedBox(
                height: 55,
                child: Center(
                  child: Text(buttonText),
                ),
              ))
        ],
      ),
    );
  }
}
