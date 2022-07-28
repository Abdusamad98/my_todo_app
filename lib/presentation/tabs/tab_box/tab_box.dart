import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/presentation/tabs/basket/basket_screen.dart';
import 'package:my_todo_app/presentation/tabs/done_list/done_list_screen.dart';
import 'package:my_todo_app/presentation/tabs/profile/profile_screen.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/todo_list_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  List<Widget> screens = [
    ToDoListScreen(),
    DoneListScreen(),
    BasketScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:screens[currentIndex],
      // IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        iconSize: 24,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        selectedLabelStyle:const TextStyle(color: Colors.green),
        items: [
          getItem(icon: Icons.task, labelText: tr("todos")),
          getItem(icon: Icons.done_all, labelText: tr("done")),
          getItem(icon: Icons.shopping_basket, labelText:tr("basket")),
          getItem(icon: Icons.perm_identity_rounded, labelText:tr("profile"))
        ],
      ),
    );
  }

  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.white,
        ));
  }
  void navigateToScreen() {
    switch (currentIndex) {
      case 0:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return ToDoListScreen();
              }));
        }
        break;
      case 1:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return DoneListScreen();
              }));
        }
        break;
      case 2:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return BasketScreen();
              }));
        }
        break;
      default:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return ProfileScreen();
              }));
        }
    }
  }
}
