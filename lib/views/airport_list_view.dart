import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/airport.dart';
import '../services/airport_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class AirportListView extends StatefulWidget {
  const AirportListView({super.key});

  @override
  State<AirportListView> createState() => _AirportListViewState();
}

class _AirportListViewState extends State<AirportListView> {
  final _service = AirportService();
  late Future<List<Airport>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getAll();
  }

  void _reload() {
    setState(() => _future = _service.getAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aeropuertos')),
      body: FutureBuilder<List<Airport>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorDisplay(message: snapshot.error.toString(), onRetry: _reload);
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) return const Center(child: Text('Sin resultados'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final a = items[index];
              return ListTile(
                title: Text(a.name),
                subtitle: Text('${a.cityName ?? ''} · ${a.iataCode ?? ''}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/airports/${a.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
