import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartData {
  // Sample data for the last 7 days of calorie intake
  // Target: 2300 calories per day
  static const int calorieTarget = 2300;

  static List<BarChartGroupData> getCalorieBarData() {
    // Sample data for last 7 days (calories achieved)
    final List<int> caloriesAchieved = [
      2150,
      2400,
      2100,
      2350,
      2250,
      2500,
      2200,
    ];
    final List<String> dayLabels = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return List.generate(7, (index) {
      final calories = caloriesAchieved[index];
      final isAboveTarget = calories >= calorieTarget;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: calories.toDouble(),
            color: isAboveTarget ? Colors.green : Colors.orange,
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: calorieTarget.toDouble(),
              color: Colors.grey.shade200,
            ),
          ),
        ],
      );
    });
  }

  static List<String> getCalorieDayLabels() {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  }

  static List<int> getCalorieValues() {
    return [2150, 2400, 2100, 2350, 2250, 2500, 2200];
  }

  // Sample data for weight tracking (last 7 days)
  // Weight range: 45kg - 47kg
  static List<FlSpot> getWeightLineData() {
    // Sample weight data for last 7 days
    final List<double> weights = [46.5, 46.3, 46.8, 46.2, 46.0, 46.4, 46.1];

    return List.generate(7, (index) {
      return FlSpot(index.toDouble(), weights[index]);
    });
  }

  static List<String> getWeightDayLabels() {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  }

  static List<double> getWeightValues() {
    return [46.5, 46.3, 46.8, 46.2, 46.0, 46.4, 46.1];
  }

  // Helper method to get the weight range for chart scaling
  static double getMinWeight() => 45.0;
  static double getMaxWeight() => 47.0;

  // Helper method to format weight for display
  static String formatWeight(double weight) {
    return '${weight.toStringAsFixed(1)}kg';
  }

  // Helper method to format calories for display
  static String formatCalories(int calories) {
    return '${calories}cal';
  }

  // Get color for calorie achievement
  static Color getCalorieColor(int calories) {
    if (calories >= calorieTarget) {
      return Colors.green;
    } else if (calories >= calorieTarget * 0.9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  // Calculate calorie achievement percentage
  static double getCalorieAchievementPercentage(int calories) {
    return (calories / calorieTarget) * 100;
  }

  // Get weekly summary data
  static Map<String, dynamic> getWeeklySummary() {
    final calorieValues = getCalorieValues();
    final weightValues = getWeightValues();

    final totalCalories = calorieValues.reduce((a, b) => a + b);
    final avgCalories = totalCalories / calorieValues.length;
    final targetCalories = calorieTarget * 7;

    final currentWeight = weightValues.last;
    final startWeight = weightValues.first;
    final weightChange = currentWeight - startWeight;

    final avgWeight =
        weightValues.reduce((a, b) => a + b) / weightValues.length;

    return {
      'totalCalories': totalCalories,
      'avgCalories': avgCalories.round(),
      'targetCalories': targetCalories,
      'calorieAchievementPercentage': (totalCalories / targetCalories) * 100,
      'currentWeight': currentWeight,
      'startWeight': startWeight,
      'weightChange': weightChange,
      'avgWeight': avgWeight,
      'daysAboveTarget': calorieValues.where((c) => c >= calorieTarget).length,
    };
  }

  // Sample data for additional metrics
  static List<Map<String, dynamic>> getAdditionalMetrics() {
    return [
      {
        'title': 'Steps',
        'value': '8,542',
        'target': '10,000',
        'percentage': 85.4,
        'icon': Icons.directions_walk,
        'color': Colors.blue,
      },
      {
        'title': 'Water',
        'value': '2.1L',
        'target': '2.5L',
        'percentage': 84.0,
        'icon': Icons.water_drop,
        'color': Colors.cyan,
      },
      {
        'title': 'Workouts',
        'value': '5',
        'target': '7',
        'percentage': 71.4,
        'icon': Icons.fitness_center,
        'color': Colors.purple,
      },
      {
        'title': 'Sleep',
        'value': '7.2h',
        'target': '8h',
        'percentage': 90.0,
        'icon': Icons.bedtime,
        'color': Colors.indigo,
      },
    ];
  }

  // Sample history data for fitness tracking
  static List<Map<String, dynamic>> getHistoryData() {
    return [
      {
        'date': DateTime(2025, 7, 26),
        'caloriesIn': 2200,
        'caloriesBurnt': 450,
        'workout': 'Morning Cardio + Strength Training',
        'weight': 46.1,
        'steps': 8500,
        'waterIntake': 2.3,
      },
      {
        'date': DateTime(2025, 7, 25),
        'caloriesIn': 2500,
        'caloriesBurnt': 380,
        'workout': 'Upper Body Workout',
        'weight': 46.4,
        'steps': 9200,
        'waterIntake': 2.1,
      },
      {
        'date': DateTime(2025, 7, 24),
        'caloriesIn': 2250,
        'caloriesBurnt': 520,
        'workout': 'HIIT Training',
        'weight': 46.0,
        'steps': 12300,
        'waterIntake': 2.8,
      },
      {
        'date': DateTime(2025, 7, 23),
        'caloriesIn': 2350,
        'caloriesBurnt': 300,
        'workout': 'Yoga & Stretching',
        'weight': 46.2,
        'steps': 6800,
        'waterIntake': 2.0,
      },
      {
        'date': DateTime(2025, 7, 22),
        'caloriesIn': 2100,
        'caloriesBurnt': 600,
        'workout': 'Full Body Circuit Training',
        'weight': 46.8,
        'steps': 11500,
        'waterIntake': 2.5,
      },
      {
        'date': DateTime(2025, 7, 21),
        'caloriesIn': 2400,
        'caloriesBurnt': 420,
        'workout': 'Swimming',
        'weight': 46.3,
        'steps': 4200,
        'waterIntake': 2.2,
      },
      {
        'date': DateTime(2025, 7, 20),
        'caloriesIn': 2150,
        'caloriesBurnt': 350,
        'workout': 'Lower Body Workout',
        'weight': 46.5,
        'steps': 8900,
        'waterIntake': 2.4,
      },
      {
        'date': DateTime(2025, 7, 19),
        'caloriesIn': 2450,
        'caloriesBurnt': 480,
        'workout': 'CrossFit Training',
        'weight': 46.7,
        'steps': 10200,
        'waterIntake': 2.6,
      },
      {
        'date': DateTime(2025, 7, 18),
        'caloriesIn': 2300,
        'caloriesBurnt': 290,
        'workout': 'Rest Day - Light Walking',
        'weight': 46.9,
        'steps': 5500,
        'waterIntake': 1.8,
      },
      {
        'date': DateTime(2025, 7, 17),
        'caloriesIn': 2180,
        'caloriesBurnt': 540,
        'workout': 'Running + Core Workout',
        'weight': 47.0,
        'steps': 13200,
        'waterIntake': 3.0,
      },
      {
        'date': DateTime(2025, 7, 16),
        'caloriesIn': 2320,
        'caloriesBurnt': 410,
        'workout': 'Pilates',
        'weight': 46.8,
        'steps': 7800,
        'waterIntake': 2.1,
      },
      {
        'date': DateTime(2025, 7, 15),
        'caloriesIn': 2280,
        'caloriesBurnt': 470,
        'workout': 'Bike Riding + Abs',
        'weight': 46.6,
        'steps': 9600,
        'waterIntake': 2.7,
      },
      {
        'date': DateTime(2025, 7, 14),
        'caloriesIn': 2400,
        'caloriesBurnt': 320,
        'workout': 'Functional Training',
        'weight': 46.4,
        'steps': 8100,
        'waterIntake': 2.3,
      },
      {
        'date': DateTime(2025, 7, 13),
        'caloriesIn': 2150,
        'caloriesBurnt': 560,
        'workout': 'Boot Camp',
        'weight': 46.2,
        'steps': 11800,
        'waterIntake': 2.9,
      },
      {
        'date': DateTime(2025, 7, 12),
        'caloriesIn': 2350,
        'caloriesBurnt': 380,
        'workout': 'Weight Training',
        'weight': 46.1,
        'steps': 8700,
        'waterIntake': 2.2,
      },
    ];
  }

  // Helper methods for history data
  static String formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static String formatShortDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static int getNetCalories(int caloriesIn, int caloriesBurnt) {
    return caloriesIn - caloriesBurnt;
  }

  static Color getNetCalorieColor(int netCalories) {
    if (netCalories > 2000) {
      return Colors.green;
    } else if (netCalories > 1500) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
