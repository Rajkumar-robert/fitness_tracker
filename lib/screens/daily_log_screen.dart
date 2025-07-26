import 'package:flutter/material.dart';
import 'package:fitness_tracker/widgets/custom_input.dart';
import 'package:fitness_tracker/models/daily_log.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _caloriesInController = TextEditingController();
  final TextEditingController _caloriesBurntController =
      TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waterIntakeController = TextEditingController();
  final TextEditingController _workoutController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();

  // Quick add buttons for water intake
  final List<double> _waterQuickAdd = [0.25, 0.5, 1.0, 1.5];
  double _totalWaterIntake = 0.0;

  // Quick add buttons for steps
  final List<int> _stepsQuickAdd = [1000, 2000, 5000, 10000];
  int _totalSteps = 0;

  String? _validateNumber(String? value, String fieldName) {
    if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  void _addWater(double amount) {
    setState(() {
      _totalWaterIntake += amount;
      _waterIntakeController.text = _totalWaterIntake.toStringAsFixed(1);
    });
  }

  void _addSteps(int steps) {
    setState(() {
      _totalSteps += steps;
      _stepsController.text = _totalSteps.toString();
    });
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveDailyLog() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Create daily log object
    final dailyLog = DailyLog(
      userId: 'current_user_id', // TODO: Get from authentication
      date: _selectedDate,
      caloriesIn: _caloriesInController.text.isNotEmpty
          ? int.tryParse(_caloriesInController.text)
          : null,
      caloriesBurnt: _caloriesBurntController.text.isNotEmpty
          ? int.tryParse(_caloriesBurntController.text)
          : null,
      steps: _stepsController.text.isNotEmpty
          ? int.tryParse(_stepsController.text)
          : null,
      weight: _weightController.text.isNotEmpty
          ? double.tryParse(_weightController.text)
          : null,
      waterIntake: _waterIntakeController.text.isNotEmpty
          ? double.tryParse(_waterIntakeController.text)
          : null,
      workoutOfTheDay: _workoutController.text.isNotEmpty
          ? _workoutController.text
          : null,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // TODO: Save to Supabase
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Daily log saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _clearForm() {
    _caloriesInController.clear();
    _caloriesBurntController.clear();
    _stepsController.clear();
    _weightController.clear();
    _waterIntakeController.clear();
    _workoutController.clear();
    _notesController.clear();
    setState(() {
      _totalWaterIntake = 0.0;
      _totalSteps = 0;
      _selectedDate = DateTime.now();
    });
  }

  @override
  void dispose() {
    _caloriesInController.dispose();
    _caloriesBurntController.dispose();
    _stepsController.dispose();
    _weightController.dispose();
    _waterIntakeController.dispose();
    _workoutController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Daily Log'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearForm,
            tooltip: 'Clear Form',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Selection Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Date'),
                  subtitle: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _selectDate,
                ),
              ),
              const SizedBox(height: 24),

              // Calories Section
              const Text(
                'Calories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      label: 'Calories In',
                      hint: '0',
                      controller: _caloriesInController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.restaurant,
                      validator: (value) =>
                          _validateNumber(value, 'Calories In'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomInput(
                      label: 'Calories Burnt',
                      hint: '0',
                      controller: _caloriesBurntController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.local_fire_department,
                      validator: (value) =>
                          _validateNumber(value, 'Calories Burnt'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Steps Section
              const Text(
                'Steps Count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              CustomInput(
                label: 'Steps Today',
                hint: '0',
                controller: _stepsController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.directions_walk,
                validator: (value) => _validateNumber(value, 'Steps'),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _stepsQuickAdd.map((steps) {
                  return ElevatedButton(
                    onPressed: () => _addSteps(steps),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade50,
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('+$steps'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Weight Section
              const Text(
                'Today\'s Weight',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              CustomInput(
                label: 'Weight',
                hint: '0.0 kg',
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                prefixIcon: Icons.monitor_weight,
                validator: (value) => _validateNumber(value, 'Weight'),
              ),
              const SizedBox(height: 24),

              // Water Intake Section
              const Text(
                'Water Intake',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              CustomInput(
                label: 'Water Intake',
                hint: '0.0 L',
                controller: _waterIntakeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                prefixIcon: Icons.water_drop,
                validator: (value) => _validateNumber(value, 'Water Intake'),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _waterQuickAdd.map((amount) {
                  return ElevatedButton(
                    onPressed: () => _addWater(amount),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('+${amount}L'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Workout Section
              const Text(
                'Workout of the Day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              CustomInput(
                label: 'Workout Description',
                hint: 'Describe your workout...',
                controller: _workoutController,
                prefixIcon: Icons.fitness_center,
              ),
              const SizedBox(height: 24),

              // Notes Section
              const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  hintText: 'Any additional notes about your day...',
                  prefixIcon: Icon(Icons.note_outlined),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveDailyLog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Save Daily Log',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
