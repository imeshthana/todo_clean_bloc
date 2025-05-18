// repos include what the Todo class can do

import 'package:todo_clean_bloc/domain/entities/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();

  addTodo(String text);

  updateTodo(Todo todo);

  deleteTodo(String id);
}
