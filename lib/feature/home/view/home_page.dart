import 'package:branc_epl/styles/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: frameBg,
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(child: Text('Home Page')),
    );
  }
}
