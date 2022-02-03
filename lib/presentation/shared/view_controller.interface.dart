import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:flutter/material.dart';

abstract class ViewController<T> extends StatelessWidget {
  const ViewController({Key? key}) : super(key: key);

  T get controller => Inject.find<T>();

  @override
  Widget build(BuildContext context);
}
