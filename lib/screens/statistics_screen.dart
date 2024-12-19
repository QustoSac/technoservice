// lib/screens/statistics_screen.dart
import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _completedRequests = 0;
  int _totalRequests = 0;
  Map<String, int> _faultTypeStatistics = {};

  @override
  void initState() {
    super.initState();
    _fetchStatistics();
  }

  Future<void> _fetchStatistics() async {
    final completedCount =
        await DatabaseHelper.instance.countCompletedRequests();
    final totalCount = await DatabaseHelper.instance.countTotalRequests();
    final faultTypeStats =
        await DatabaseHelper.instance.getFaultTypeStatistics();

    setState(() {
      _completedRequests = completedCount;
      _totalRequests = totalCount;
      _faultTypeStatistics = faultTypeStats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Статистика")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Выполненные заявки: $_completedRequests",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              "Общее количество заявок: $_totalRequests",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              "Статистика по типам неисправностей:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._faultTypeStatistics.entries.map((entry) {
              return Text(
                "${entry.key}: ${entry.value}",
                style: const TextStyle(fontSize: 16),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
