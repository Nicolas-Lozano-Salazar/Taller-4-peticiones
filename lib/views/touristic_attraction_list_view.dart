import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/touristic_attraction.dart';
import '../services/touristic_attraction_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class TouristicAttractionListView extends StatefulWidget {
  const TouristicAttractionListView({super.key});

  @override
  State<TouristicAttractionListView> createState() => _TouristicAttractionListViewState();
}

class _TouristicAttractionListViewState extends State<TouristicAttractionListView> {
  final _service = TouristicAttractionService();
  late Future<List<TouristicAttraction>> _future;

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
      appBar: AppBar(title: const Text('Atractivos Turísticos')),
      body: FutureBuilder<List<TouristicAttraction>>(
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
                leading: a.images.isNotEmpty
                    ? Image.network(a.images.first, width: 56, height: 56, fit: BoxFit.cover)
                    : const Icon(Icons.place),
                title: Text(a.name),
                subtitle: Text(a.cityName ?? ''),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/touristic-attractions/${a.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
