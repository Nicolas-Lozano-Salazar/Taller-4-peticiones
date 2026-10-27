import 'package:flutter/material.dart';

import '../models/touristic_attraction.dart';
import '../services/touristic_attraction_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class TouristicAttractionDetailView extends StatefulWidget {
  final int id;
  const TouristicAttractionDetailView({super.key, required this.id});

  @override
  State<TouristicAttractionDetailView> createState() => _TouristicAttractionDetailViewState();
}

class _TouristicAttractionDetailViewState extends State<TouristicAttractionDetailView> {
  final _service = TouristicAttractionService();
  late Future<TouristicAttraction> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Atractivo')),
      body: FutureBuilder<TouristicAttraction>(
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
              if (a.images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(a.images.first, height: 200, fit: BoxFit.cover),
                ),
              const SizedBox(height: 12),
              Text(a.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              if (a.description != null) Text(a.description!),
              const SizedBox(height: 16),
              _row('Ciudad', a.cityName ?? '-'),
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
