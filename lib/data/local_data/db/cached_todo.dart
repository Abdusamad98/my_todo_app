const String todoTable = "cached_todos";

class CachedTodoFields {
  static final List<String> values = [
    /// Add all fields
    id, categoryId, dateTime, isDone, todoDescription, todoTitle, urgentLevel
  ];
  static const String id = "_id";
  static const String categoryId = "category_id";
  static const String dateTime = "date_time";
  static const String isDone = "is_done";
  static const String todoDescription = "todo_description";
  static const String todoTitle = "todo_title";
  static const String urgentLevel = "urgent_level";
}

class CachedTodo {
  final int? id;
  final int categoryId;
  final String dateTime;
  final int isDone;
  final String todoDescription;
  final String todoTitle;
  final int urgentLevel;

  CachedTodo({
    this.id,
    required this.dateTime,
    required this.todoTitle,
    required this.categoryId,
    required this.urgentLevel,
    required this.isDone,
    required this.todoDescription,
  });

  CachedTodo copyWith({
    int? id,
    int? categoryId,
    String? dateTime,
    int? isDone,
    String? todoTitle,
    String? todoDescription,
    int? urgentLevel,
  }) =>
      CachedTodo(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        dateTime: dateTime ?? this.dateTime,
        isDone: isDone ?? this.isDone,
        todoTitle: todoTitle ?? this.todoTitle,
        todoDescription: todoDescription ?? this.todoDescription,
        urgentLevel: urgentLevel ?? this.urgentLevel,
      );

  static CachedTodo fromJson(Map<String, Object?> json) => CachedTodo(
        id: json[CachedTodoFields.id] as int?,
        dateTime: json[CachedTodoFields.dateTime] as String,
        todoTitle: json[CachedTodoFields.todoTitle] as String,
        categoryId: json[CachedTodoFields.categoryId] as int,
        urgentLevel: json[CachedTodoFields.urgentLevel] as int,
        isDone: json[CachedTodoFields.isDone] as int,
        todoDescription: json[CachedTodoFields.todoDescription] as String,
      );

  Map<String, Object?> toJson() => {
        CachedTodoFields.id: id,
        CachedTodoFields.categoryId: categoryId,
        CachedTodoFields.todoDescription: todoDescription,
        CachedTodoFields.isDone: isDone,
        CachedTodoFields.todoTitle: todoTitle,
        CachedTodoFields.urgentLevel: urgentLevel,
        CachedTodoFields.dateTime: dateTime,
      };

  @override
  String toString() {
    return
      ''' 
  id:$id 
  categoryId:$categoryId
  title:$todoTitle
    ''';
  }
}
