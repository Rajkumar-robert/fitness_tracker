class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  final String gender;
  final double height; // in cm
  final double weight; // in kg
  final String activityLevel;
  final String fitnessGoal;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.fitnessGoal,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert User object to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'activity_level': activityLevel,
      'fitness_goal': fitnessGoal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create User object from JSON (from database)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      height: json['height']?.toDouble() ?? 0.0,
      weight: json['weight']?.toDouble() ?? 0.0,
      activityLevel: json['activity_level'],
      fitnessGoal: json['fitness_goal'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? activityLevel,
    String? fitnessGoal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      activityLevel: activityLevel ?? this.activityLevel,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Get full name
  String get fullName => '$firstName $lastName';

  // Get initials
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  // Calculate BMI
  double get bmi => weight / ((height / 100) * (height / 100));

  // Get BMI category
  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) {
      return 'Underweight';
    } else if (bmiValue < 25) {
      return 'Normal';
    } else if (bmiValue < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  // Calculate daily calorie target based on user data (simplified calculation)
  int get dailyCalorieTarget {
    // Base metabolic rate calculation (simplified)
    double bmr;
    if (gender.toLowerCase() == 'male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    // Activity level multiplier
    double activityMultiplier;
    switch (activityLevel.toLowerCase()) {
      case 'sedentary':
        activityMultiplier = 1.2;
        break;
      case 'lightly active':
        activityMultiplier = 1.375;
        break;
      case 'moderately active':
        activityMultiplier = 1.55;
        break;
      case 'very active':
        activityMultiplier = 1.725;
        break;
      case 'extremely active':
        activityMultiplier = 1.9;
        break;
      default:
        activityMultiplier = 1.2;
    }

    // Adjust for fitness goal
    double goalAdjustment;
    switch (fitnessGoal.toLowerCase()) {
      case 'weight loss':
        goalAdjustment = 0.8; // 20% deficit
        break;
      case 'weight gain':
        goalAdjustment = 1.2; // 20% surplus
        break;
      case 'muscle building':
        goalAdjustment = 1.1; // 10% surplus
        break;
      default:
        goalAdjustment = 1.0; // maintenance
    }

    return (bmr * activityMultiplier * goalAdjustment).round();
  }

  // Validate user data
  bool get isValid {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        email.contains('@') &&
        age > 0 &&
        age < 120 &&
        height > 0 &&
        weight > 0 &&
        gender.isNotEmpty &&
        activityLevel.isNotEmpty &&
        fitnessGoal.isNotEmpty;
  }

  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, email: $email, age: $age, gender: $gender, height: ${height}cm, weight: ${weight}kg, activityLevel: $activityLevel, fitnessGoal: $fitnessGoal}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.age == age &&
        other.gender == gender &&
        other.height == height &&
        other.weight == weight &&
        other.activityLevel == activityLevel &&
        other.fitnessGoal == fitnessGoal;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        activityLevel.hashCode ^
        fitnessGoal.hashCode;
  }
}

// User registration data class for form handling
class UserRegistrationData {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String activityLevel;
  final String fitnessGoal;

  UserRegistrationData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.fitnessGoal,
  });

  // Convert to User object (without password fields)
  User toUser({String? id}) {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      activityLevel: activityLevel,
      fitnessGoal: fitnessGoal,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // Validate registration data
  List<String> validate() {
    final errors = <String>[];

    if (firstName.trim().isEmpty) {
      errors.add('First name is required');
    }

    if (lastName.trim().isEmpty) {
      errors.add('Last name is required');
    }

    if (email.trim().isEmpty) {
      errors.add('Email is required');
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      errors.add('Please enter a valid email address');
    }

    if (password.isEmpty) {
      errors.add('Password is required');
    } else if (password.length < 6) {
      errors.add('Password must be at least 6 characters long');
    }

    if (confirmPassword.isEmpty) {
      errors.add('Password confirmation is required');
    } else if (password != confirmPassword) {
      errors.add('Passwords do not match');
    }

    if (age <= 0 || age > 120) {
      errors.add('Please enter a valid age');
    }

    if (height <= 0 || height > 300) {
      errors.add('Please enter a valid height');
    }

    if (weight <= 0 || weight > 500) {
      errors.add('Please enter a valid weight');
    }

    if (gender.trim().isEmpty) {
      errors.add('Gender is required');
    }

    if (activityLevel.trim().isEmpty) {
      errors.add('Activity level is required');
    }

    if (fitnessGoal.trim().isEmpty) {
      errors.add('Fitness goal is required');
    }

    return errors;
  }

  bool get isValid => validate().isEmpty;
}
