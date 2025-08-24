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

  