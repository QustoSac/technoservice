// lib/screens/edit_request_screen.dart
import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import 'dart:developer';

class EditRequestScreen extends StatefulWidget {
  final int requestId;

  const EditRequestScreen({super.key, required this.requestId});

  @override
  State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _problemDescriptionController = TextEditingController();
  int? _selectedClientId;
  int? _selectedEquipmentId;
  int? _selectedStatusId;
  List<DropdownMenuItem<int>> _clientItems = [];
  List<DropdownMenuItem<int>> _equipmentItems = [];
  List<DropdownMenuItem<int>> _statusItems = [];

  @override
  void initState() {
    super.initState();
    _loadClients();
    _loadEquipments();
    _loadStatuses();
    _loadRequestDetails();
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

  Future<void> _loadRequestDetails() async {
    final conn = await DatabaseHelper.instance.connection;
    final result = await conn.query('''
    SELECT
      request.id AS request_id,
      request.creation_date,
      request.problem_description,
      equipment.serial_number AS equipment_serial,
      status.name AS status_name,
      client.id AS client_id,
      equipment.id AS equipment_id,
      status.id AS status_id
    FROM request
    LEFT JOIN equipment ON request.equipment_id = equipment.id
    LEFT JOIN status ON request.status_id = status.id
    LEFT JOIN client ON request.client_id = client.id
    WHERE request.id = @requestId
  ''', substitutionValues: {'requestId': widget.requestId});
  }

  Future<void> _updateRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        log('Updating request with requestId: ${widget.requestId}, problemDescription: ${_problemDescriptionController.text}, clientId: $_selectedClientId, statusId: $_selectedStatusId');
        await DatabaseHelper.instance.updateRequest(
          requestId: widget.requestId,
          description: _problemDescriptionController.text,
          statusId: _selectedStatusId!,
          clientId: _selectedClientId!,
        );
        Navigator.pop(context, true); // Возвращаем пользователя обратно
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Ошибка"),
            content: Text("Не удалось обновить заявку: $e"),
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
        title: const Text("Редактировать заявку"),
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
                onPressed: _updateRequest,
                child: const Text("Обновить заявку"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
