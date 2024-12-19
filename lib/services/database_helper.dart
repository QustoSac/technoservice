// lib/services/database_helper.dart
import 'package:postgres/postgres.dart';
import 'dart:developer';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static PostgreSQLConnection? _connection;

  DatabaseHelper._privateConstructor();

  Future<PostgreSQLConnection> get connection async {
    if (_connection != null && !_connection!.isClosed) {
      return _connection!;
    }
    _connection = await _initDatabase();
    return _connection!;
  }

  Future<PostgreSQLConnection> _initDatabase() async {
    final connection = PostgreSQLConnection(
      'localhost',
      5432,
      'Technoservice',
      username: 'danila',
      password: 'kappa',
    );
    await connection.open();
    return connection;
  }

  Future<List<Map<String, dynamic>>> getRequests() async {
    final conn = await connection;
    final results = await conn.query('''
      SELECT
        request.id AS request_id,
        request.creation_date,
        request.problem_description,
        equipment.serial_number AS equipment_serial,
        status.name AS status_name
      FROM request
      LEFT JOIN equipment ON request.equipment_id = equipment.id
      LEFT JOIN status ON request.status_id = status.id;
    ''');

    log('Fetched requests: $results');

    return results.map((row) {
      return {
        'request_id': row[0],
        'creation_date': row[1],
        'problem_description': row[2],
        'equipment_serial': row[3],
        'status_name': row[4],
      };
    }).toList();
  }

  Future<int> countCompletedRequests() async {
    final conn = await connection;
    final result = await conn.query('''
      SELECT COUNT(*) AS completed_requests
      FROM request
      WHERE status_id = (SELECT id FROM status WHERE name = 'Выполнено');
    ''');
    return result.first[0] as int;
  }

  Future<int> countTotalRequests() async {
    final conn = await connection;
    final result =
        await conn.query('SELECT COUNT(*) AS total_requests FROM request');
    return result.first[0] as int;
  }

  Future<Map<String, int>> getFaultTypeStatistics() async {
    final conn = await connection;
    final results = await conn.query('''
    SELECT ft.description, COUNT(*) AS count
    FROM request r
    JOIN faulttype ft ON r.fault_type_id = ft.id
    GROUP BY ft.description;
  ''');

    return Map.fromIterable(
      results,
      key: (row) => row[0] as String,
      value: (row) => row[1] as int,
    );
  }

  Future<void> addRequest({
    required int equipmentId,
    required String problemDescription,
    required int clientId,
    required int statusId,
    required String creationDate,
  }) async {
    final conn = await connection;
    try {
      await conn.query('''
        INSERT INTO request (equipment_id, problem_description, client_id, status_id, creation_date)
        VALUES (@equipmentId, @problemDescription, @clientId, @statusId, @creationDate);
      ''', substitutionValues: {
        'equipmentId': equipmentId,
        'problemDescription': problemDescription,
        'clientId': clientId,
        'statusId': statusId,
        'creationDate': creationDate,
      });
      log('Request added successfully');
    } catch (e) {
      log('Error adding request: $e');
      rethrow;
    }
  }

  Future<void> updateRequest({
    required int requestId,
    required String description,
    required int statusId,
    required int clientId,
  }) async {
    final conn = await connection;
    try {
      await conn.query('''
        UPDATE request
        SET problem_description = @description,
            status_id = @statusId,
            client_id = @clientId
        WHERE id = @requestId
      ''', substitutionValues: {
        'description': description,
        'statusId': statusId,
        'clientId': clientId,
        'requestId': requestId,
      });
      log('Request updated successfully');
    } catch (e) {
      log('Error updating request: $e');
      rethrow;
    }
  }

  Future<void> deleteRequest(int requestId) async {
    final conn = await connection;
    await conn.query('DELETE FROM request WHERE id = @requestId',
        substitutionValues: {
          'requestId': requestId,
        });
  }

  Future<List<Map<String, dynamic>>> getClients() async {
    final conn = await connection;
    final results =
        await conn.query('SELECT id, firstname, secondname FROM client');
    return results.map((row) {
      return {
        'id': row[0] as int,
        'firstname': row[1] as String,
        'secondname': row[2] as String,
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getEquipments() async {
    final conn = await connection;
    final results = await conn.query('SELECT id, serial_number FROM equipment');
    return results.map((row) {
      return {
        'id': row[0],
        'serial_number': row[1],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getStatuses() async {
    final conn = await connection;
    final results = await conn.query('SELECT id, name FROM status');
    return results.map((row) {
      return {
        'id': row[0],
        'name': row[1],
      };
    }).toList();
  }
}
