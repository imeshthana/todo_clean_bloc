import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_clean_bloc/domain/usecases/todo_repo.dart';
import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepo {
  final http.Client client;
  final String baseUrl =
      'https://crudcrud.com/api/4edc952046be4ecf8d32ecae18e8ddf6/todo';

  TodoRepositoryImpl({required this.client});

  @override
  Future<List<Todo>> getTodos() async {
    try {
      final response = await client.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List jsonList = json.decode(response.body);
        return jsonList.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  @override
  Future addTodo(String text) async {
    try {
      final todo = TodoModel(text: text);
      final response = await client.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        return TodoModel.fromJson(responseJson);
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromTodo(todo);
      final response = await client.put(
        Uri.parse('$baseUrl/${todo.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(todoModel.toJson()),
      );

      if (response.statusCode == 200) {
        return todo;
      } else {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future deleteTodo(String id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete todo');
      }
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
