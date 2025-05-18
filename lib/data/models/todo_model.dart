import '../../domain/models/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    String? id,
    required String text,
    bool isCompleted = false,
  }) : super(
          id: id,
          text: text,
          isCompleted: isCompleted,
        );

  factory TodoModel.fromJson(Map json) {
    return TodoModel(
      id: json['_id'],
      text: json['text'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map toJson() {
    return {
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromTodo(Todo todo) {
    return TodoModel(
      id: todo.id.toString(),
      text: todo.text,
      isCompleted: todo.isCompleted,
    );
  }
}
