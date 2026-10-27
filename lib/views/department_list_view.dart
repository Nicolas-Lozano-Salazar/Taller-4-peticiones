import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/department.dart';
import '../services/department_service.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class DepartmentListView extends StatefulWidget {
  const DepartmentListView({super.key});

  @override
  State<DepartmentListView> createState() => _DepartmentListViewState();
}

class _DepartmentListViewState extends State<DepartmentListView> {
  final _service = DepartmentService();
  late Future<List<Department>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getAll();
  }

  void _reload() {
    setState(() {
      _future = _service.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Departamentos')),
      body: FutureBuilder<List<Department>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorDisplay(message: snapshot.error.toString(), onRetry: _reload);
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Sin resultados'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final d = items[index];
              return ListTile(
                title: Text(d.name),
                subtitle: Text(d.cityCapitalName ?? ''),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/departments/${d.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
