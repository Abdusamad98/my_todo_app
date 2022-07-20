import 'package:flutter/material.dart';

class DoneListScreen extends StatelessWidget {
  const DoneListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Done List screen",
        ),
      ),
      body: Column(children: [
        Text("Under development")
      ],),
    );
  }
}
