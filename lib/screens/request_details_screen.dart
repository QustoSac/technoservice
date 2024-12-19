import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  final int requestId;

  const RequestDetailsScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Детали заявки"),
      ),
      body: Center(
        child: Text("Здесь будет информация о заявке с ID: $requestId"),
      ),
    );
  }
}
