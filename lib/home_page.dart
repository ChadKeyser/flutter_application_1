import 'package:flutter/material.dart';
import 'app1_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Launcher'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, // restricts width for desktop, feels like mobile
          ),
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(24),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            children: [
              AppBlock(
                title: 'Calculator',
                icon: Icons.calculate,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const App1Page()),
                ),
              ),
              AppBlock(
                title: 'In Progress',
                icon: Icons.construction,
                onTap: () {}, // No navigation
              ),
              AppBlock(
                title: 'In Progress',
                icon: Icons.construction,
                onTap: () {}, // No navigation
              ),
              AppBlock(
                title: 'In Progress',
                icon: Icons.construction,
                onTap: () {}, // No navigation
              ),
            ],
          ),
        ),
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
