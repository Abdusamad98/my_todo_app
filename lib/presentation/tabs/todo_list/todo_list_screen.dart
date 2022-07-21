import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/global_widgets/my_custom_button.dart';
import 'package:my_todo_app/models/category_model.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/modal_top_view.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/select_urgent_level.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todos_item.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/styles.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<TodoModel> myTodos = [];
  List<CategoryModel> categories = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    myTodos = MyRepository.myTodos.where((element) => !element.isDone).toList();
    categories = MyRepository.categories;
    super.initState();
  }

  @override
  void dispose() {
   titleController.dispose();
   descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 100,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Scaffold(
                          body: Column(
                            children: [
                              ModalTopView(
                                  text: "Create new todo",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: titleController,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextField(
                                    controller: descriptionController,
                                    maxLength: 150,
                                    maxLines: 5,
                                    style: const TextStyle(fontSize: 19, color: Color(0xFF060F17)),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Description here',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(13),
                                      fillColor: const Color(0xFFD7D7D7).withOpacity(0.2),
                                    ),
                                  )
                              ),
                              SelectUrgentLevel(selectedStarsCount: 0, onChanged: (v){
                                print("BELGILANGANLARI:$v");
                              }),
                              Row(
                                children: [
                                  Expanded(
                                    child: MyCustomButton(
                                      buttonText: "Cancel",
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyCustomButton(
                                      buttonText: "Save",
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                );
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text("Todo List"),
      ),
      body: ListView(
        children: List.generate(myTodos.length, (index) {
          var toDo = myTodos[index];
          var category = getCategory(categories, toDo.categoryId);
          return TodosItem(
              toDo: toDo,
              category: category,
              isDone: false,
              onTap: () {
                setState(() {
                  myTodos.removeAt(index);
                  MyRepository.addTodoToDone(index);
                });
              });
        }),
      ),
    );
  }
}

CategoryModel getCategory(List<CategoryModel> categories, int categoryId) {
  return categories
      .where((element) => element.categoryId == categoryId)
      .toList()[0];
}
