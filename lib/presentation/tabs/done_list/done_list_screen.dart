import 'package:flutter/material.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/models/category_model.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/todo_list_screen.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todos_item.dart';

class DoneListScreen extends StatefulWidget {
  const DoneListScreen({Key? key}) : super(key: key);

  @override
  State<DoneListScreen> createState() => _DoneListScreenState();
}

class _DoneListScreenState extends State<DoneListScreen> {
  List<TodoModel> myTodos = [];
  List<CategoryModel> categories = [];

  @override
  void initState() {
    myTodos = MyRepository.myTodos.where((element) => element.isDone).toList();
    categories = MyRepository.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        title: const Text("Todo List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            myTodos = MyRepository.myTodos
                .where((element) => element.isDone)
                .toList();
          });
        },
        child: ListView(
          children: List.generate(myTodos.length, (index) {
            var toDo = myTodos[index];
            var category = getCategory(categories, toDo.categoryId);
            return TodosItem(
                toDo: toDo, category: category, isDone: true, onTap: () {});
          }),
        ),
      ),
    );
  }
}
