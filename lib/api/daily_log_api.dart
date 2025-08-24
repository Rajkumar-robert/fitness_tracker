import 'dart:convert';
import 'package:http/http.dart' as http;

class DailyLog {
  final String? id;
  final String userId;
  final DateTime date;
  final int steps;
  final int caloriesConsumed;
  final int caloriesBurned;
  final double waterIntake; // in liters
  final int sleepHours;

  DailyLog({
    this.id,
    required this.userId,
    required this.date,
    required this.steps,
    required this.caloriesConsumed,
    required this.caloriesBurned,
    required this.waterIntake,
    required this.sleepHours,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'steps': steps,
      'calories_consumed': caloriesConsumed,
      'calories_burned': caloriesBurned,
      'water_intake': waterIntake,
      'sleep_hours': sleepHours,
    };
  }

  factory DailyLog.fromJson(Map<String, dynamic> json) {
    return DailyLog(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['date']),
      steps: json['steps'],
      caloriesConsumed: json['calories_consumed'],
      caloriesBurned: json['calories_burned'],
      waterIntake: (json['water_intake'] as num).toDouble(),
      sleepHours: json['sleep_hours'],
    );
  }
}

class DailyLogApi {
  static const String _baseUrl =
      'https://api.example.com/daily_logs'; // Replace with your API

  // Fetch daily logs for a user
  Future<List<DailyLog>> getDailyLogs(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl?user_id=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => DailyLog.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load daily logs');
    }
  }

  // Add a new daily log
  Future<DailyLog> addDailyLog(DailyLog log) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(log.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return DailyLog.fromJson(data);
    } else {
      throw Exception('Failed to add daily log');
    }
  }

