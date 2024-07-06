import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Welcome'), backgroundColor: Colors.blue),
      body:
          const Center(child: Text('HomeView', style: TextStyle(fontSize: 30))),
    );
  }
}
