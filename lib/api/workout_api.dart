import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitness_tracker/models/workout.dart';

class WorkoutApi {
  static const String _baseUrl =
      'https://api.example.com/workouts'; // Replace with your API

  // Fetch all workouts
  Future<List<Workout>> getWorkouts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }

  
}
