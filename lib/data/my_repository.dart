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

  static Future<void> addInitialValues() async {
    await StorageRepository.putBool("is_initial", true);
    await MyRepository.insertCachedCategory(
        cachedCategory: CachedCategory(
      categoryName: "Work",
      iconPath: Icons.work.codePoint,
      categoryColor: 0xFFFFFFFF,
    ));

    await MyRepository.insertCachedCategory(
        cachedCategory: CachedCategory(
      categoryName: "Sport",
      iconPath: Icons.sports_basketball.codePoint,
      categoryColor: 0xFF000000,
    ));
  }



  static Future<void> logUserOut() async {
    await StorageRepository.putBool("is_logged", false);
    await clearAllCachedTodos();
    await clearAllCachedCategories();
  }

// ------------- Shared preference side ---------------------------

  static getProfileImageUrl() =>
      StorageRepository.getString("profile_image").toString();

  static Future<ProfileModel> getProfileModel() async {
    await StorageRepository.getInstance();
    String imagePath = StorageRepository.getString("profile_image");
    String password = StorageRepository.getString("password");
    String lastName = StorageRepository.getString("lastname");
    String firstName = StorageRepository.getString("username");
    String userAge = StorageRepository.getString("age");
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

  static Future<List<CachedTodo>> getAllCachedTodosByDone(
      {required int isDone}) async {
    return await LocalDatabase.getTodoList(isDone);
  }

  static Future<int> updateCachedTodoIsDone(
      {required int isDone, required int id}) async {
    return await LocalDatabase.updateCachedTodoIsDone(id, isDone);
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
