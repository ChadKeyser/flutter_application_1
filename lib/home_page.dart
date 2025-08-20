import 'package:flutter/material.dart';
import 'app1_page.dart';
import 'app2_page.dart';
import 'app3_page.dart';
import 'app4_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Launcher'),
        backgroundColor: Colors.green,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(24),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        children: [
          AppBlock(
            title: 'App 1',
            icon: Icons.apps,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const App1Page()),
            ),
          ),
          AppBlock(
            title: 'App 2',
            icon: Icons.star,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const App2Page()),
            ),
          ),
          AppBlock(
            title: 'App 3',
            icon: Icons.settings,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const App3Page()),
            ),
          ),
          AppBlock(
            title: 'App 4',
            icon: Icons.info,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const App4Page()),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AppBlock({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
