import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/global_widgets/profile_image_appbar.dart';
import 'package:my_todo_app/presentation/tabs/basket/widgets/basket_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todos_item.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<CachedTodo> deletedTodos = [];
  List<CachedCategory> categories = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    deletedTodos = await MyRepository.getAllCachedTodosByDone(isDone: 2);
    categories = await MyRepository.getAllCachedCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const ProfileImageAppbar(),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext con) {
                    return AlertDialog(
                      title: Text("Rostdan ham barini o'chirmoqchimisiz?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              MyRepository.clearAllCachedTodos();
                              _init();
                              Navigator.pop(context);
                            },
                            child: Text("Ok")),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.clear))
        ],
        title: const Text("Basket List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init();
        },
        child: ListView(
          children: List.generate(deletedTodos.length, (index) {
            var toDo = deletedTodos[index];
            return BasketItem(
              cachedTodo: deletedTodos[index],
              onDeleteTapped: () {
                showDialog(
                    context: context,
                    builder: (BuildContext con) {
                      return AlertDialog(
                        title: Text("Rostdan ham o'chirmoqchimisiz?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                MyRepository.deleteCachedTodById(
                                    id: deletedTodos[index].id!);
                                _init();
                                Navigator.pop(context);
                              },
                              child: Text("Ok")),
                        ],
                      );
                    });
              },
              onUpdateTapped: () {

              },
            );
          }),
        ),
      ),
    );
  }
}
