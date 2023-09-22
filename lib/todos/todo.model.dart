class TodoModel {
  final int todoId;
  final String todoTitle;
  final bool isCompleted;
  final int userId;

  TodoModel({
    required this.todoId,
    required this.todoTitle,
    required this.isCompleted,
    required this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      todoId: json['id'],
      todoTitle: json['title'],
      isCompleted: json['completed'],
      userId: json['userId'],
    );
  }

  static List<TodoModel> listFromJson(list) =>
      List<TodoModel>.from(list.map((x) => TodoModel.fromJson(x)));
}
