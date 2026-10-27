import 'package:flutter/material.dart';

import '../models/department.dart';
import '../services/department_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class DepartmentDetailView extends StatefulWidget {
  final int id;
  const DepartmentDetailView({super.key, required this.id});

  @override
  State<DepartmentDetailView> createState() => _DepartmentDetailViewState();
}

class _DepartmentDetailViewState extends State<DepartmentDetailView> {
  final _service = DepartmentService();
  late Future<Department> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Departamento')),
      body: FutureBuilder<Department>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorDisplay(message: snapshot.error.toString());
          }
          final d = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(d.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              if (d.description != null) Text(d.description!),
              const SizedBox(height: 16),
              _row('Capital', d.cityCapitalName ?? '-'),
              _row('Municipios', '${d.municipalities ?? '-'}'),
              _row('Superficie (km²)', '${d.surface ?? '-'}'),
              _row('Población', '${d.population ?? '-'}'),
              _row('Prefijo tel.', d.phonePrefix ?? '-'),
              _row('Región ID', '${d.regionId ?? '-'}'),
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
