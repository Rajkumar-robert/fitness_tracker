import 'package:flutter/material.dart';
import 'package:fitness_tracker/utils/chart_data.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _historyData = [];
  String _sortBy = 'date';
  bool _sortAscending = false;

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  void _loadHistoryData() {
    setState(() {
      _historyData = ChartData.getHistoryData();
      _sortHistoryData();
    });
  }

  void _sortHistoryData() {
    _historyData.sort((a, b) {
      int result = 0;
      switch (_sortBy) {
        case 'date':
          result = a['date'].compareTo(b['date']);
          break;
        case 'caloriesIn':
          result = a['caloriesIn'].compareTo(b['caloriesIn']);
          break;
        case 'caloriesBurnt':
          result = a['caloriesBurnt'].compareTo(b['caloriesBurnt']);
          break;
        case 'weight':
          result = a['weight'].compareTo(b['weight']);
          break;
        case 'steps':
          result = a['steps'].compareTo(b['steps']);
          break;
      }
      return _sortAscending ? result : -result;
    });
  }

  void _changeSortOrder(String sortBy) {
    setState(() {
      if (_sortBy == sortBy) {
        _sortAscending = !_sortAscending;
      } else {
        _sortBy = sortBy;
        _sortAscending = false;
      }
      _sortHistoryData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: _changeSortOrder,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'date', child: Text('Sort by Date')),
              const PopupMenuItem(
                value: 'caloriesIn',
                child: Text('Sort by Calories In'),
              ),
              const PopupMenuItem(
                value: 'caloriesBurnt',
                child: Text('Sort by Calories Burnt'),
              ),
              const PopupMenuItem(
                value: 'weight',
                child: Text('Sort by Weight'),
              ),
              const PopupMenuItem(value: 'steps', child: Text('Sort by Steps')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Stats Card
          _buildSummaryCard(),

          // Table Header
          _buildTableHeader(),

          // History Data Table
          Expanded(child: _buildHistoryTable()),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    if (_historyData.isEmpty) return const SizedBox.shrink();

    final totalDays = _historyData.length;
    final avgCaloriesIn =
        (_historyData
                    .map((e) => e['caloriesIn'] as int)
                    .reduce((a, b) => a + b) /
                totalDays)
            .round();
    final avgCaloriesBurnt =
        (_historyData
                    .map((e) => e['caloriesBurnt'] as int)
                    .reduce((a, b) => a + b) /
                totalDays)
            .round();
    final avgWeight =
        (_historyData
            .map((e) => e['weight'] as double)
            .reduce((a, b) => a + b) /
        totalDays);
    final totalSteps = _historyData
        .map((e) => e['steps'] as int)
        .reduce((a, b) => a + b);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary ($totalDays days)',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryStat(
                  'Avg Calories In',
                  '$avgCaloriesIn cal',
                  Icons.restaurant,
                  Colors.green,
                ),
              ),
              Expanded(
                child: _buildSummaryStat(
                  'Avg Calories Burnt',
                  '$avgCaloriesBurnt cal',
                  Icons.local_fire_department,
                  Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildSummaryStat(
                  'Avg Weight',
                  '${avgWeight.toStringAsFixed(1)} kg',
                  Icons.monitor_weight,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildSummaryStat(
                  'Total Steps',
                  '${(totalSteps / 1000).toStringAsFixed(0)}K',
                  Icons.directions_walk,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          _buildHeaderCell('Date', 'date', flex: 2),
          _buildHeaderCell('Cal In', 'caloriesIn', flex: 1),
          _buildHeaderCell('Cal Burnt', 'caloriesBurnt', flex: 1),
          _buildHeaderCell('Weight', 'weight', flex: 1),
          _buildHeaderCell('Steps', 'steps', flex: 1),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, String sortKey, {int flex = 1}) {
    final isSelected = _sortBy == sortKey;
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => _changeSortOrder(sortKey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.deepPurple : Colors.grey[700],
              ),
            ),
            if (isSelected)
              Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 12,
                color: Colors.deepPurple,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTable() {
    if (_historyData.isEmpty) {
      return const Center(
        child: Text(
          'No history data available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: _historyData.length,
          separatorBuilder: (context, index) =>
              Divider(height: 1, color: Colors.grey[200]),
          itemBuilder: (context, index) {
            final data = _historyData[index];
            return _buildTableRow(data, index);
          },
        ),
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> data, int index) {
    final netCalories = ChartData.getNetCalories(
      data['caloriesIn'],
      data['caloriesBurnt'],
    );
    final netCalorieColor = ChartData.getNetCalorieColor(netCalories);

    return InkWell(
      onTap: () => _showDetailDialog(data),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        color: index % 2 == 0 ? Colors.grey[50] : Colors.white,
        child: Row(
          children: [
            // Date
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ChartData.formatShortDate(data['date']),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _getDayOfWeek(data['date']),
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // Calories In
            Expanded(
              child: Text(
                '${data['caloriesIn']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Calories Burnt
            Expanded(
              child: Text(
                '${data['caloriesBurnt']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Weight
            Expanded(
              child: Text(
                '${data['weight']}kg',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Steps
            Expanded(
              child: Text(
                '${(data['steps'] / 1000).toStringAsFixed(1)}K',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  void _showDetailDialog(Map<String, dynamic> data) {
    final netCalories = ChartData.getNetCalories(
      data['caloriesIn'],
      data['caloriesBurnt'],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          ChartData.formatDate(data['date']),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              'Calories In',
              '${data['caloriesIn']} cal',
              Colors.green,
            ),
            _buildDetailRow(
              'Calories Burnt',
              '${data['caloriesBurnt']} cal',
              Colors.red,
            ),
            _buildDetailRow(
              'Net Calories',
              '$netCalories cal',
              ChartData.getNetCalorieColor(netCalories),
            ),
            const Divider(),
            _buildDetailRow('Weight', '${data['weight']} kg', Colors.blue),
            _buildDetailRow('Steps', '${data['steps']} steps', Colors.purple),
            _buildDetailRow(
              'Water Intake',
              '${data['waterIntake']} L',
              Colors.cyan,
            ),
            const Divider(),
            const Text(
              'Workout:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              data['workout'],
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
