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

  
