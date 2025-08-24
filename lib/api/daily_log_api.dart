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
