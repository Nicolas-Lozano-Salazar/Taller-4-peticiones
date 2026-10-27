import 'package:flutter/material.dart';

import '../models/typical_dish.dart';
import '../services/typical_dish_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class TypicalDishDetailView extends StatefulWidget {
  final int id;
  const TypicalDishDetailView({super.key, required this.id});

  @override
  State<TypicalDishDetailView> createState() => _TypicalDishDetailViewState();
}

class _TypicalDishDetailViewState extends State<TypicalDishDetailView> {
  final _service = TypicalDishService();
  late Future<TypicalDish> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Plato Típico')),
      body: FutureBuilder<TypicalDish>(
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
              if (d.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(d.imageUrl!, height: 200, fit: BoxFit.cover),
                ),
              const SizedBox(height: 12),
              Text(d.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              if (d.description != null) Text(d.description!),
              const SizedBox(height: 16),
              _row('Ingredientes', d.ingredients ?? '-'),
              _row('Departamento', d.departmentName ?? '-'),
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
