import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/local_data/db/cached_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("todos.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $todoTable (
    ${CachedTodoFields.id} $idType,
    ${CachedTodoFields.categoryId} $intType,
    ${CachedTodoFields.dateTime} $textType,
    ${CachedTodoFields.isDone} $intType,
    ${CachedTodoFields.todoDescription} $textType,
    ${CachedTodoFields.todoTitle} $textType,
    ${CachedTodoFields.urgentLevel} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $categoryTable (
    ${CachedCategoryFields.id} $idType,
    ${CachedCategoryFields.categoryName} $textType,
    ${CachedCategoryFields.iconPath} $intType,
    ${CachedCategoryFields.categoryColor} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $userTable (
    ${CachedUsersFields.id} $idType,
    ${CachedUsersFields.userName} $textType,
    ${CachedUsersFields.age} $intType
    )
    ''');
  }

  LocalDatabase._init();

  //-------------------------------------------Cached Users Table------------------------------------

  static Future<CachedUser> insertCachedUser(CachedUser cachedUser) async {
    final db = await getInstance.database;
    final id = await db.insert(userTable, cachedUser.toJson());
    return cachedUser.copyWith(id: id);
  }

  static Future<CachedUser> getSingleUserById(int id) async {
    final db = await getInstance.database;
    final results = await db.query(
      userTable,
      columns: CachedUsersFields.values,
      where: '${CachedUsersFields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return CachedUser.fromJson(results.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<CachedUser>> getAllCachedUsers() async {
    final db = await getInstance.database;
    const orderBy = "${CachedUsersFields.userName} ASC";
    final result = await db.query(
      userTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedUser.fromJson(json)).toList();
  }

  static Future<int> deleteCachedUserById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(userTable, where: "${CachedUsersFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateCachedUser(CachedUser cachedUser) async {
    Map<String, dynamic> row = {
      CachedUsersFields.userName: cachedUser.userName,
      CachedUsersFields.age: cachedUser.age,
    };

    final db = await getInstance.database;
    return await db.update(
      userTable,
      row,
      where: '${CachedUsersFields.id} = ?',
      whereArgs: [cachedUser.id],
    );
  }

  static Future<int> deleteAllCachedUsers() async {
    final db = await getInstance.database;
    return await db.delete(userTable);
  }

  //-------------------------------------------Cached Categories Table------------------------------------

  static Future<CachedCategory> insertCachedCategory(
      CachedCategory cachedCategory) async {
    final db = await getInstance.database;
    final id = await db.insert(categoryTable, cachedCategory.toJson());
    return cachedCategory.copyWith(id: id);
  }

  static Future<CachedCategory> getSingleCategoryById(int id) async {
    final db = await getInstance.database;
    final results = await db.query(
      categoryTable,
      columns: CachedCategoryFields.values,
      where: '${CachedCategoryFields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return CachedCategory.fromJson(results.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<CachedCategory>> getAllCachedCategories() async {
    final db = await getInstance.database;
    final result = await db.query(
      categoryTable,
    );
    return result.map((json) => CachedCategory.fromJson(json)).toList();
  }

  static Future<int> deleteCachedCategoryById(int id) async {
    final db = await getInstance.database;
    var t = await db.delete(categoryTable,
        where: "${CachedCategoryFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateCachedCategory(
      {required int id, required CachedCategory cachedCategory}) async {
    Map<String, dynamic> row = {
      CachedCategoryFields.iconPath: cachedCategory.iconPath,
      CachedCategoryFields.categoryColor: cachedCategory.categoryColor,
      CachedCategoryFields.categoryName: cachedCategory.categoryName,
    };

    final db = await getInstance.database;
    return await db.update(
      categoryTable,
      row,
      where: '${CachedCategoryFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAllCachedCategories() async {
    final db = await getInstance.database;
    return await db.delete(categoryTable);
  }

  //-------------------------------------------Cached Todos Table------------------------------------

  static Future<CachedTodo> insertCachedTodo(CachedTodo cachedTodo) async {
    final db = await getInstance.database;
    final id = await db.insert(todoTable, cachedTodo.toJson());
    return cachedTodo.copyWith(id: id);
  }

  static Future<CachedTodo> getSingleTodoById(int id) async {
    final db = await getInstance.database;
    final results = await db.query(
      todoTable,
      columns: CachedTodoFields.values,
      where: '${CachedTodoFields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return CachedTodo.fromJson(results.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<CachedTodo>> getAllCachedTodos() async {
    final db = await getInstance.database;
    const orderBy = "${CachedTodoFields.todoTitle} ASC";
    final result = await db.query(
      todoTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedTodo.fromJson(json)).toList();
  }

  static Future<List<CachedTodo>> getTodoList(int isDone) async {
    final db = await getInstance.database;
    final result = await db.query(todoTable,
        where: "${CachedTodoFields.isDone}=?", whereArgs: [isDone]);
    return result.map((json) => CachedTodo.fromJson(json)).toList();
  }

  static Future<int> deleteAllCachedTodos() async {
    final db = await getInstance.database;
    return await db.delete(todoTable);
  }

  static Future<int> deleteCachedTodoById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(todoTable, where: "${CachedTodoFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateCachedTodo(
      {required int id, required CachedTodo cachedTodo}) async {
    Map<String, dynamic> row = {
      CachedTodoFields.isDone: cachedTodo.isDone,
      CachedTodoFields.todoTitle: cachedTodo.todoTitle,
      CachedTodoFields.todoDescription: cachedTodo.todoDescription,
      CachedTodoFields.categoryId: cachedTodo.categoryId,
      CachedTodoFields.urgentLevel: cachedTodo.urgentLevel,
      CachedTodoFields.dateTime: cachedTodo.dateTime,
    };

    final db = await getInstance.database;
    return db.update(
      todoTable,
      row,
      where: '${CachedTodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updateCachedTodoIsDone(int id, int isDone) async {
    Map<String, dynamic> row = {
      CachedTodoFields.isDone: isDone,
    };
    final db = await getInstance.database;
    return db.update(
      todoTable,
      row,
      where: '${CachedTodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await getInstance.database;
    db.close();
  }
}
