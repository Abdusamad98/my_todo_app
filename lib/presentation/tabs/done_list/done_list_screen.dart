import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/global_widgets/profile_image_appbar.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todos_item.dart';

class DoneListScreen extends StatefulWidget {
  const DoneListScreen({Key? key}) : super(key: key);

  @override
  State<DoneListScreen> createState() => _DoneListScreenState();
}

class _DoneListScreenState extends State<DoneListScreen> {
  List<CachedTodo> myTodos = [];
  List<CachedCategory> categories = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    myTodos = await MyRepository.getAllCachedTodosByDone(isDone: 1);
    categories = await MyRepository.getAllCachedCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const ProfileImageAppbar(),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        title: const Text("Done List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init();
        },
        child: ListView(
          children: List.generate(myTodos.length, (index) {
            var toDo = myTodos[index];
            return TodosItem(
                onDeleted: () {
                  MyRepository.updateCachedTodoIsDone(
                    isDone: 2,
                    id: myTodos[index].id!,
                  );
                  _init();
                },
                toDo: toDo,
                isDone: true,
                onTap: () {});
          }),
        ),
      ),
    );
  }
}
