import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/styles.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {Key? key, required this.buttonText, required this.onTap})
      : super(key: key);

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: MyTextStyle.interSemiBold600.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
