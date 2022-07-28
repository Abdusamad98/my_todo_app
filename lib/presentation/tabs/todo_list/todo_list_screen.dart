import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_todo_app/category_add_screen/category_add_screen.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/global_widgets/my_custom_button.dart';
import 'package:my_todo_app/global_widgets/profile_image_appbar.dart';
import 'package:my_todo_app/models/category_model.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/category_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/modal_top_view.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/select_date_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/select_urgent_level.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todos_item.dart';
import 'package:my_todo_app/utils/styles.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<CachedTodo> myTodos = [];
  List<CachedCategory> categories = [];
  int categorySelectedIndex = -1;
  int urgentLevel = 0;

//-----------------Date selecting------------------

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    myTodos = await MyRepository.getAllCachedTodosByDone(isDone: 0);
    categories = await MyRepository.getAllCachedCategories();
    setState(() {});
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
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return CategoryAddScreen(
                    onCategoryAddedListener: (value){
                      if(value){
                        _init();
                      }
                      print("CATEGORY ADDED:$value");
                    },
                  );
                }));
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return Dialog(
                //         insetPadding:
                //             const EdgeInsets.symmetric(horizontal: 24),
                //         child: Container(
                //           padding: const EdgeInsets.all(16),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(16)),
                //           height: 350,
                //           width: double.infinity,
                //           child: Column(
                //             children: [
                //               TextField(
                //
                //               ),
                //
                //               Container(
                //                 height: 100,
                //                 child: ListView(
                //                   children: List.generate(, (index) => null),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       );
                //     });
              },
              child: Text(
                "Add category",
                style: MyTextStyle.interMedium500.copyWith(color: Colors.white),
              )),
          IconButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 100,
                      child: StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return Scaffold(
                            resizeToAvoidBottomInset: false,
                            body: Container(
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  ModalTopView(
                                    text: "Create new todo",
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextField(
                                      controller: titleController,
                                      decoration: const InputDecoration(
                                          hintText: "To Do title here"),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextField(
                                        controller: descriptionController,
                                        maxLength: 150,
                                        maxLines: 5,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Color(0xFF060F17)),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: 'Description here',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(13),
                                          fillColor: const Color(0xFFD7D7D7)
                                              .withOpacity(0.2),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 85,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categories.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return CategoryItem(
                                          isSelected:
                                              categorySelectedIndex == index,
                                          categoryModel: categories[index],
                                          onTap: () {
                                            setState(() {
                                              categorySelectedIndex = index;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SelectUrgentLevel(
                                      selectedStarsCount: urgentLevel,
                                      onChanged: (v) {
                                        urgentLevel = v;
                                      }),
                                  SelectDateItem(
                                    //2022-07-28 21:50:32.557848
                                    text:
                                        DateFormat.yMMMd().format(selectedDate),
                                    onTap: () async {
                                      var t = await _selectDate(context);
                                      setState(() {
                                        selectedDate = t;
                                      });
                                    },
                                  ),
                                  SelectDateItem(
                                    text:
                                        "${selectedTime.hour}:${selectedTime.minute}",
                                    onTap: () async {
                                      var t = await _selectTime(context);
                                      setState(() {
                                        selectedTime = t;
                                      });
                                    },
                                  ),
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
                                          onTap: () async {
                                            String titleText =
                                                titleController.text;
                                            String descriptionText =
                                                descriptionController.text;
                                            if (titleText.length < 3) {
                                              UtilityFunctions.getMyToast(
                                                  message:
                                                      "Sarlavxani kiriting!");
                                            } else if (descriptionText.length <
                                                5) {
                                              UtilityFunctions.getMyToast(
                                                  message: "Izoh kiriting!");
                                            } else if (categorySelectedIndex <
                                                0) {
                                              UtilityFunctions.getMyToast(
                                                  message:
                                                      "Categoryani tanlang!");
                                            } else if (urgentLevel == 0) {
                                              UtilityFunctions.getMyToast(
                                                  message:
                                                      "Muhimlik darajasini tanlang!");
                                            } else {
                                              var dateTime = DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                selectedTime.hour,
                                                selectedTime.minute,
                                              );
                                              CachedTodo cachedTodo =
                                                  CachedTodo(
                                                dateTime: dateTime.toString(),
                                                todoTitle: titleText,
                                                categoryId: categories[
                                                        categorySelectedIndex]
                                                    .id!,
                                                urgentLevel: urgentLevel,
                                                isDone: 0,
                                                todoDescription:
                                                    descriptionText,
                                              );
                                              await MyRepository
                                                  .insertCachedTodo(
                                                      cachedTodo: cachedTodo);
                                              _init();
                                              setDefaults();
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                );
              },
              icon: const Icon(Icons.add))
        ],
        leading: const ProfileImageAppbar(),
        title: const Text("Todo List"),
      ),
      body: ListView(
        children: List.generate(myTodos.length, (index) {
          var toDo = myTodos[index];
          return TodosItem(
              toDo: toDo,
              isDone: false,
              onDeleted: () {
                MyRepository.updateCachedTodoIsDone(
                  isDone: 2,
                  id: myTodos[index].id!,
                );
                _init();
              },
              onTap: () {
                setState(() {
                  MyRepository.updateCachedTodoIsDone(
                    id: myTodos[index].id!,
                    isDone: 1,
                  );
                  myTodos.removeAt(index);
                });
              });
        }),
      ),
    );
  }

  void setDefaults() {
    urgentLevel = 0;
    descriptionController.clear();
    titleController.clear();
    categorySelectedIndex = -1;
  }
}

CategoryModel getCategory(List<CategoryModel> categories, int categoryId) {
  return categories
      .where((element) => element.categoryId == categoryId)
      .toList()[0];
}
