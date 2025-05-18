import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_bloc/domain/entities/todo.dart';
import 'package:todo_clean_bloc/domain/usecases/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;
  bool isLoading = false;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    isLoading = true;
    final todoList = await todoRepo.getTodos();
    emit(todoList);
    isLoading = false;
  }

  Future<void> addTodo(String text) async {
    await todoRepo.addTodo(text);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo.id.toString());
    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }
}
