import 'package:flutter/material.dart';
import 'package:my_todo_app/models/category_model.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/styles.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.categoryModel,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  final CategoryModel categoryModel;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: 85,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: categoryModel.categoryColor),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      categoryModel.iconPath,
                      size: 35,
                      color: MyColors.white,
                    ),
                    Expanded(
                      child: Text(
                        categoryModel.categoryName,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyle.interMedium500.copyWith(
                          fontSize: 16,
                          color: MyColors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    color: MyColors.white.withOpacity(0.85),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  )),
            )
          ],
        ));
  }
}
