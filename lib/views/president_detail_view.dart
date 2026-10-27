import 'package:flutter/material.dart';

import '../models/president.dart';
import '../services/president_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PresidentDetailView extends StatefulWidget {
  final int id;
  const PresidentDetailView({super.key, required this.id});

  @override
  State<PresidentDetailView> createState() => _PresidentDetailViewState();
}

class _PresidentDetailViewState extends State<PresidentDetailView> {
  final _service = PresidentService();
  late Future<President> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Presidente')),
      body: FutureBuilder<President>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorDisplay(message: snapshot.error.toString());
          }
          final p = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (p.image != null)
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(p.image!),
                  ),
                ),
              const SizedBox(height: 12),
              Text(p.fullName, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              _row('Partido', p.politicalParty ?? '-'),
              _row('Inicio periodo', p.startPeriodDate ?? '-'),
              _row('Fin periodo', p.endPeriodDate ?? '-'),
              _row('Ciudad', p.cityName ?? '-'),
              const SizedBox(height: 12),
              if (p.description != null) Text(p.description!),
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
