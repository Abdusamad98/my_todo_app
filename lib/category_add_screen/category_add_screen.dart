import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({Key? key, required this.onCategoryAddedListener})
      : super(key: key);

  final ValueChanged<bool> onCategoryAddedListener;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  List<IconData> icons = [];
  int iconCodePoint = 0;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    icons.add(
      Icons.add,
    );
    icons.add(
      Icons.abc,
    );
    icons.add(
      Icons.access_alarms,
    );
    icons.add(
      Icons.abc_rounded,
    );
    icons.add(
      Icons.ac_unit_rounded,
    );
    icons.add(
      Icons.sports_basketball,
    );
    icons.add(
      Icons.work,
    );
    icons.add(
      Icons.work,
    );
    icons.add(
      Icons.work,
    );
    icons.add(
      Icons.work,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add category"),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: textController,
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    icons.length,
                    (index) => GestureDetector(
                          onTap: () {
                            iconCodePoint = icons[index].codePoint;
                          },
                          child: Icon(
                            icons[index],
                            size: 35,
                            color: Colors.blueAccent,
                          ),
                        )),
              ),
            ),
            TextButton(
                onPressed: () async {
                  String categoryName = textController.text;
                  if (categoryName.isEmpty) {
                    UtilityFunctions.getMyToast(message: "Write category name");
                  } else if (iconCodePoint == 0) {
                    UtilityFunctions.getMyToast(
                        message: "Choose category icon");
                  } else {
                    var categ = CachedCategory(
                      categoryName: categoryName,
                      iconPath: iconCodePoint,
                      categoryColor: Colors.blueAccent.value,
                    );
                    var t = await MyRepository.insertCachedCategory(
                      cachedCategory: categ,
                    );
                    if (t.id != null) {
                      UtilityFunctions.getMyToast(
                          message: "Category added successfully");
                      widget.onCategoryAddedListener.call(true);
                    } else {
                      widget.onCategoryAddedListener.call(false);
                    }
                  }
                },
                child: Row(
                  children: [
                    Text("Add Category"),
                    SizedBox(
                      width: 14,
                    ),
                    Icon(
                      Icons.category,
                      size: 20,
                      color: Colors.red,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
