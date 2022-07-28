import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/icons.dart';
import 'package:my_todo_app/utils/styles.dart';


class LanguageItem extends StatelessWidget {
  const LanguageItem({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: MyTextStyle.interSemiBold600.copyWith(
                fontSize: 16,
                color: MyColors.black
              ),
            ),
            Visibility(
              child: isActive
                  ? const Icon(Icons.check_box)
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
