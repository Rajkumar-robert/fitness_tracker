class Workout {
  final String? id;
  final String name;
  final String type; // e.g., 'Cardio', 'Strength Training'
  final int duration; // in minutes
  final int caloriesBurned;
  final DateTime date;

  Workout({
    this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.caloriesBurned,
    required this.date,
  });

  // Convert Workout object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'duration': duration,
      'calories_burned': caloriesBurned,
      'date': date.toIso8601String(),
    };
  }

  // Create Workout object from JSON
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      duration: json['duration'],
      caloriesBurned: json['calories_burned'],
      date: DateTime.parse(json['date']),
    );
  }
}
