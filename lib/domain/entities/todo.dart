// defines the todo object

class Todo {
  final String? id;
  final String text;
  final bool isCompleted;

  Todo({required this.id, required this.text, this.isCompleted = false});

  Todo toggleCompletion() {
    return Todo(id: id, text: text, isCompleted: !isCompleted);
  }
}
