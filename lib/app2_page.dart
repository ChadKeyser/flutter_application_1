import 'package:flutter/material.dart';

class App2Page extends StatelessWidget {
  const App2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App 2')),
      body: const Center(child: Text('Welcome to App 2!')),
    );
  }
}
