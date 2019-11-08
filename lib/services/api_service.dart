import 'dart:convert';

// Import the client from the Http Packages
import 'package:http/http.dart' show Client;

//Import the Todo Model
import 'package:todo_flutter/models/todo.dart';

class ApiService {
  // Replace this with your computer's IP Address
  final String baseUrl = "http://192.168.0.105:8091/api";
  Client client = Client();

// Get All Todos
  Future<List<ToDo>> getToDos() async {
    final response = await client.get("$baseUrl/ToDos");
    if (response.statusCode == 200) {
      return fromJson(response.body);
    } else {
      return null;
    }
  }

// Update an existing Todo
  Future<bool> updateToDo(ToDo data) async {
    final response = await client.put(
      "$baseUrl/ToDos/${data.id}",
      headers: {"content-type": "application/json"},
      body: toJson(data),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

// Create a new Todo
  Future<bool> addToDo(ToDo data) async {
    final response = await client.post(
      "$baseUrl/ToDos",
      headers: {"content-type": "application/json"},
      body: toJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

// Delete a Todo
  Future<bool> deleteTodo(int todoId) async {
    final response = await client.delete(
      "$baseUrl/ToDos/$todoId",
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

// Get list of all Todo Statuses
  Future<List<String>> getStatuses() async {
    final response = await client.get("$baseUrl/Config");
    if (response.statusCode == 200) {
      var data = (jsonDecode(response.body) as List<dynamic>).cast<String>();
      return data;
    } else {
      return null;
    }
  }
}
