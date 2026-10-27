import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const _items = [
    _DashboardItem(
      title: 'Departamentos',
      subtitle: 'Departamentos de Colombia',
      icon: Icons.map,
      route: '/departments',
    ),
    _DashboardItem(
      title: 'Presidentes',
      subtitle: 'Presidentes de Colombia',
      icon: Icons.person,
      route: '/presidents',
    ),
    _DashboardItem(
      title: 'Atractivos Turísticos',
      subtitle: 'Lugares turísticos',
      icon: Icons.place,
      route: '/touristic-attractions',
    ),
    _DashboardItem(
      title: 'Platos Típicos',
      subtitle: 'Gastronomía colombiana',
      icon: Icons.restaurant,
      route: '/typical-dishes',
    ),
    _DashboardItem(
      title: 'Aeropuertos',
      subtitle: 'Aeropuertos del país',
      icon: Icons.flight,
      route: '/airports',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => context.go(item.route),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 40, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 12),
                    Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(item.subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  const _DashboardItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}
