// lib/screens/add_request_screen.dart
import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import 'dart:developer';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _problemDescriptionController = TextEditingController();
  int? _selectedClientId;
  int? _selectedEquipmentId;
  int? _selectedStatusId;
  String _selectedDate = '';
  List<DropdownMenuItem<int>> _clientItems = [];
  List<DropdownMenuItem<int>> _equipmentItems = [];
  List<DropdownMenuItem<int>> _statusItems = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().toIso8601String().split('T')[0];
    _loadClients();
    _loadEquipments();
    _loadStatuses();
  }

  @override
  void dispose() {
    _problemDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadClients() async {
    final clients = await DatabaseHelper.instance.getClients();
    setState(() {
      _clientItems = clients
          .map((client) => DropdownMenuItem<int>(
                value: client['id'],
                child: Text('${client['firstname']} ${client['secondname']}'),
              ))
          .toList();
    });
  }

  Future<void> _loadEquipments() async {
    final equipments = await DatabaseHelper.instance.getEquipments();
    setState(() {
      _equipmentItems = equipments
          .map((equipment) => DropdownMenuItem<int>(
                value: equipment['id'],
                child: Text(equipment['serial_number']),
              ))
          .toList();
    });
  }

  Future<void> _loadStatuses() async {
    final statuses = await DatabaseHelper.instance.getStatuses();
    setState(() {
      _statusItems = statuses
          .map((status) => DropdownMenuItem<int>(
                value: status['id'],
                child: Text(status['name']),
              ))
          .toList();
    });
  }

  Future<void> _addRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        log('Adding request with equipment: $_selectedEquipmentId, problemDescription: ${_problemDescriptionController.text}, clientId: $_selectedClientId, status: $_selectedStatusId, creationDate: $_selectedDate');
        await DatabaseHelper.instance.addRequest(
          equipmentId: _selectedEquipmentId!,
          problemDescription: _problemDescriptionController.text,
          clientId: _selectedClientId!,
          statusId: _selectedStatusId!,
          creationDate: _selectedDate,
        );
        Navigator.pop(context, true); // Возвращаем пользователя обратно
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Ошибка"),
            content: Text("Не удалось добавить заявку: $e"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить заявку"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: _selectedEquipmentId,
                decoration: const InputDecoration(
                  labelText: "Оборудование",
                  border: OutlineInputBorder(),
                ),
                items: _equipmentItems,
                onChanged: (value) {
                  setState(() {
                    _selectedEquipmentId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Выберите оборудование";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _problemDescriptionController,
                decoration: const InputDecoration(
                  labelText: "Описание проблемы",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Введите описание проблемы";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedClientId,
                decoration: const InputDecoration(
                  labelText: "Клиент",
                  border: OutlineInputBorder(),
                ),
                items: _clientItems,
                onChanged: (value) {
                  setState(() {
                    _selectedClientId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Выберите клиента";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedStatusId,
                decoration: const InputDecoration(
                  labelText: "Статус",
                  border: OutlineInputBorder(),
                ),
                items: _statusItems,
                onChanged: (value) {
                  setState(() {
                    _selectedStatusId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Выберите статус";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addRequest,
                child: const Text("Добавить заявку"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
