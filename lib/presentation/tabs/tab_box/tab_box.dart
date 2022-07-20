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
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
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
        selectedLabelStyle: TextStyle(color: Colors.green),
        items: [
          getItem(icon: Icons.task, labelText: "Todos"),
          getItem(icon: Icons.done_all, labelText: "Done"),
          getItem(icon: Icons.shopping_basket, labelText: "Basket"),
          getItem(icon: Icons.perm_identity_rounded, labelText: "Profile")
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
}
