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

  // Add a new workout
  Future<Workout> addWorkout(Workout workout) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(workout.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Workout.fromJson(data);
    } else {
      throw Exception('Failed to add workout');
    }
  }
}
