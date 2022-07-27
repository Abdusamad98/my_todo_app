import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/local_data/db/local_database.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/models/category_model.dart';
import 'package:my_todo_app/models/profile_model.dart';
import 'package:my_todo_app/models/todo_model.dart';

class MyRepository {
  static final MyRepository _instance = MyRepository._();

  factory MyRepository() {
    return _instance;
  }

  MyRepository._();

  static List<CategoryModel> categories = [
    CategoryModel(
      categoryName: "Work",
      categoryColor: Colors.green,
      categoryId: 1,
      iconPath: Icons.work,
    ),
    CategoryModel(
      categoryName: "Sport",
      categoryColor: Colors.blue,
      categoryId: 2,
      iconPath: Icons.sports_basketball,
    ),
    CategoryModel(
      categoryName: "Health",
      categoryColor: Colors.red,
      categoryId: 3,
      iconPath: Icons.favorite_outlined,
    ),
    CategoryModel(
      categoryName: "Food",
      categoryColor: Colors.yellow,
      categoryId: 4,
      iconPath: Icons.fastfood,
    ),
    CategoryModel(
      categoryName: "Coding",
      categoryColor: Colors.black,
      categoryId: 5,
      iconPath: Icons.code,
    )
  ];

  static List<TodoModel> myTodos = [
    TodoModel(
      categoryId: 5,
      dateTime: "2022-07-28 21:50:32.557848",
      isDone: false,
      todoDescription:
          "Learning SQL database requests, Yaxshilab o'rganishim kerak, darsga tayyorlanib borishim shart, Men ikkichi emasman!",
      todoTitle: "SQL",
      urgentLevel: 4,
    ),
    TodoModel(
      categoryId: 1,
      dateTime: "2022-07-26 21:50:32.557848",
      isDone: true,
      todoDescription: "Mettingda qatnashishim kerak",
      todoTitle: "Work",
      urgentLevel: 3,
    )
  ];

  static void addTodoToDone(TodoModel todoModel) {
    for (int i = 0; i < myTodos.length; i++) {
      if (myTodos[i] == todoModel) {
        myTodos[i].isDone = true;
      }
    }
  }

  static void addNewTodo({required TodoModel todoModel}) {
    myTodos.add(todoModel);
  }

// ------------- Shared preference side ---------------------------
  static Future<ProfileModel> getProfileModel() async {
    await StorageRepository.getInstance();
    String imagePath = StorageRepository.getString("profile_image");
    String password = StorageRepository.getString("password");
    String lastName = StorageRepository.getString("last_name");
    String firstName = StorageRepository.getString("first_name");
    String userAge = StorageRepository.getString("user_age");
    String userEmail = StorageRepository.getString("user_email");
    ProfileModel userData = ProfileModel(
      imagePath: imagePath,
      password: password,
      lastName: lastName,
      firstName: firstName,
      userAge: userAge.isNotEmpty ? int.parse(userAge) : 0,
      userEmail: userEmail,
    );
    return userData;
  }

// ------------------------------------Local DB side---------------------------------
//  -----------------------------------TO DO------------------------------------------

  static Future<CachedTodo> insertCachedTodo(
      {required CachedTodo cachedTodo}) async {
    return await LocalDatabase.insertCachedTodo(cachedTodo);
  }

  static Future<CachedTodo> getSingleTodoById({required int id}) async {
    return await LocalDatabase.getSingleTodoById(id);
  }

  static Future<List<CachedTodo>> getAllCachedTodos() async {
    return await LocalDatabase.getAllCachedTodos();
  }

  static Future<int> deleteCachedTodById({required int id}) async {
    return await LocalDatabase.deleteCachedTodoById(id);
  }

  static Future<int> updateCachedTodoById(
      {required int id, required CachedTodo cachedTodo}) async {
    return await LocalDatabase.updateCachedTodo(id: id, cachedTodo: cachedTodo);
  }

  static Future<int> clearAllCachedTodos() async {
    return await LocalDatabase.deleteAllCachedTodos();
  }

//  -----------------------------------Category------------------------------------------

  static Future<CachedCategory> insertCachedCategory(
      {required CachedCategory cachedCategory}) async {
    return await LocalDatabase.insertCachedCategory(cachedCategory);
  }

  static Future<CachedCategory> getSingleCategoryById({required int id}) async {
    return await LocalDatabase.getSingleCategoryById(id);
  }

  static Future<List<CachedCategory>> getAllCachedCategories() async {
    return await LocalDatabase.getAllCachedCategories();
  }

  static Future<int> deleteCachedCategoryById({required int id}) async {
    return await LocalDatabase.deleteCachedCategoryById(id);
  }

  static Future<int> updateCachedCategoryById(
      {required int id, required CachedCategory cachedCategory}) async {
    return await LocalDatabase.updateCachedCategory(
        id: id, cachedCategory: cachedCategory);
  }

  static Future<int> clearAllCachedCategories() async {
    return await LocalDatabase.deleteAllCachedCategories();
  }
}
