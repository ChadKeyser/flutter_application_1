import 'package:flutter/material.dart';

class App1Page extends StatelessWidget {
  const App1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App 1')),
      body: const Center(child: Text('Welcome to App 1!')),
    );
  }
}
