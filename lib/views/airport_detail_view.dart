import 'package:flutter/material.dart';

import '../models/airport.dart';
import '../services/airport_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class AirportDetailView extends StatefulWidget {
  final int id;
  const AirportDetailView({super.key, required this.id});

  @override
  State<AirportDetailView> createState() => _AirportDetailViewState();
}

class _AirportDetailViewState extends State<AirportDetailView> {
  final _service = AirportService();
  late Future<Airport> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Aeropuerto')),
      body: FutureBuilder<Airport>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorDisplay(message: snapshot.error.toString());
          }
          final a = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(a.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              _row('Código IATA', a.iataCode ?? '-'),
              _row('Código OACI', a.oaciCode ?? '-'),
              _row('Tipo', a.type ?? '-'),
              _row('Ciudad', a.cityName ?? '-'),
              _row('Departamento', a.departmentName ?? '-'),
              _row('Latitud', a.latitude ?? '-'),
              _row('Longitud', a.longitude ?? '-'),
            ],
          );
        },
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
