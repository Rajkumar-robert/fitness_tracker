class DailyLog {
  final String? id;
  final String userId;
  final DateTime date;
  final String? exercises;
  final int? duration;
  final int? calories;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyLog({
    this.id,
    required this.userId,
    required this.date,
    this.exercises,
    this.duration,
    this.calories,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'exercises': exercises,
      'duration': duration,
      'calories': calories,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory DailyLog.fromJson(Map<String, dynamic> json) {
    return DailyLog(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['date']),
      exercises: json['exercises'],
      duration: json['duration'],
      calories: json['calories'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
