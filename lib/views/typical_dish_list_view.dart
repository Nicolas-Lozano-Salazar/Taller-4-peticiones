import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/typical_dish.dart';
import '../services/typical_dish_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class TypicalDishListView extends StatefulWidget {
  const TypicalDishListView({super.key});

  @override
  State<TypicalDishListView> createState() => _TypicalDishListViewState();
}

class _TypicalDishListViewState extends State<TypicalDishListView> {
  final _service = TypicalDishService();
  late Future<List<TypicalDish>> _future;

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
      appBar: AppBar(title: const Text('Platos Típicos')),
      body: FutureBuilder<List<TypicalDish>>(
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
              final d = items[index];
              return ListTile(
                leading: d.imageUrl != null
                    ? Image.network(d.imageUrl!, width: 56, height: 56, fit: BoxFit.cover)
                    : const Icon(Icons.restaurant),
                title: Text(d.name),
                subtitle: Text(d.departmentName ?? ''),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/typical-dishes/${d.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
