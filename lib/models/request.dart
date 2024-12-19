class Request {
  final int id;
  final DateTime creationDate;
  final String problemDescription;
  final int clientId;
  final String equipmentSerial;
  final String statusName;

  Request({
    required this.id,
    required this.creationDate,
    required this.problemDescription,
    required this.clientId,
    required this.equipmentSerial,
    required this.statusName,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      creationDate: DateTime.parse(json['creation_date']),
      problemDescription: json['problem_description'],
      clientId: json['client_id'],
      equipmentSerial: json['equipment_serial'],
      statusName: json['status_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creation_date': creationDate.toIso8601String(),
      'problem_description': problemDescription,
      'client_id': clientId,
      'equipment_serial': equipmentSerial,
      'status_name': statusName,
    };
  }
}
