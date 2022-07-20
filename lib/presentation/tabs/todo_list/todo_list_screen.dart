import 'package:flutter/material.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.add))
        ],
        title: Text(
          "Todo List   screen",
        ),
      ),
      body: Column(children: [
        Text("Under development")
      ],),
    );
  }
}
