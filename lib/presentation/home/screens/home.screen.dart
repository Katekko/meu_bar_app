import 'package:ekko/presentation/home/widgets/drawer/drawer.widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: const Center(child: Text('Home')),
    );
  }
}
