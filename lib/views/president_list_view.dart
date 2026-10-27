import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/president.dart';
import '../services/president_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PresidentListView extends StatefulWidget {
  const PresidentListView({super.key});

  @override
  State<PresidentListView> createState() => _PresidentListViewState();
}

class _PresidentListViewState extends State<PresidentListView> {
  final _service = PresidentService();
  late Future<List<President>> _future;

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
      appBar: AppBar(title: const Text('Presidentes')),
      body: FutureBuilder<List<President>>(
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
              final p = items[index];
              return ListTile(
                leading: p.image != null
                    ? CircleAvatar(backgroundImage: NetworkImage(p.image!))
                    : const CircleAvatar(child: Icon(Icons.person)),
                title: Text(p.fullName),
                subtitle: Text(p.politicalParty ?? ''),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/presidents/${p.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
