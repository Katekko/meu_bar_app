import 'package:flutter/material.dart';

import '../widgets/category/initial.widget.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CategoryScreen'),
        centerTitle: true,
      ),
      body: Center(child: InitialWidget()),
    );
  }
}
