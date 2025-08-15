import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitness_tracker/models/user.dart';

class UserApi {
  static const String _baseUrl =
      'https://api.example.com/users'; // Replace with your API base URL

  // Fetch a single user by ID
  Future<User> getUserById(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  
// Fetch all users
  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Create a new user
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to create user');
    }
  }

  // Update an existing user
  Future<User> updateUser(String userId, User user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to update user');
    }
  }

  // Delete a user by ID
  Future<void> deleteUser(String userId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$userId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}