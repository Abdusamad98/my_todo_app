class TodoModel {
  TodoModel({
    required this.categoryId,
    required this.dateTime,
    required this.isDone,
    required this.todoDescription,
    required this.todoTitle,
  });

  final String todoTitle;
  final String todoDescription;
  final int categoryId;
  final bool isDone;
  final String dateTime;
}
