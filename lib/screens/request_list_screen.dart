// lib/screens/request_list_screen.dart
import 'package:flutter/material.dart';
import 'add_request_screen.dart';
import 'edit_request_screen.dart';
import 'statistics_screen.dart';
import '../services/database_helper.dart';

class RequestListScreen extends StatefulWidget {
  @override
  _RequestListScreenState createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<Map<String, dynamic>> _requests = [];

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    final requests = await DatabaseHelper.instance.getRequests();
    setState(() {
      _requests = requests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Technoservice"),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatisticsScreen()),
              );
            },
          ),
        ],
      ),
      body: _requests.isEmpty
          ? const Center(child: Text("Список заявок пуст"))
          : ListView.builder(
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  child: ListTile(
                    title: Text("ID заявки: ${request['request_id']}"),
                    subtitle: Text(
                      "Описание: ${request['problem_description'] ?? 'Нет данных'}\n"
                      "Оборудование: ${request['equipment_serial'] ?? 'Нет данных'}\n"
                      "Статус: ${request['status_name'] ?? 'Нет данных'}",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditRequestScreen(
                              requestId: request['request_id']),
                        ),
                      ).then((value) {
                        if (value == true) {
                          _fetchRequests(); // Перезагрузить список заявок
                        }
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRequestScreen()),
          );
          if (result == true) {
            _fetchRequests(); // Перезагрузить список заявок
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
