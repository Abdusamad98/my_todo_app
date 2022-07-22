import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/styles.dart';

class SelectDateItem extends StatelessWidget {
  const SelectDateItem({Key? key, required this.text, required this.onTap}) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: TextButton(
              child: Text(
                text,
                style:
                MyTextStyle.interSemiBold600.copyWith(
                  fontSize: 20,
                  color: MyColors.black,
                ),
              ),
              onPressed: onTap,
            )));
  }
}
