import 'package:flutter/material.dart';

import '../widgets/products/initial.widget.dart';

//TODO: Implement ProductsScreen
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductsScreen'),
        centerTitle: true,
      ),
      body: Center(child: InitialWidget()),
    );
  }
}
