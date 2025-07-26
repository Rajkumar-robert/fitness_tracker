class DailyLog {
  final String? id;
  final String userId;
  final DateTime date;
  final String? exercises;
  final int? duration;
  final int? caloriesIn;
  final int? caloriesBurnt;
  final int? steps;
  final double? weight;
  final double? waterIntake;
  final String? workoutOfTheDay;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyLog({
    this.id,
    required this.userId,
    required this.date,
    this.exercises,
    this.duration,
    this.caloriesIn,
    this.caloriesBurnt,
    this.steps,
    this.weight,
    this.waterIntake,
    this.workoutOfTheDay,
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
      'calories_in': caloriesIn,
      'calories_burnt': caloriesBurnt,
      'steps': steps,
      'weight': weight,
      'water_intake': waterIntake,
      'workout_of_the_day': workoutOfTheDay,
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
      caloriesIn: json['calories_in'],
      caloriesBurnt: json['calories_burnt'],
      steps: json['steps'],
      weight: json['weight']?.toDouble(),
      waterIntake: json['water_intake']?.toDouble(),
      workoutOfTheDay: json['workout_of_the_day'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
