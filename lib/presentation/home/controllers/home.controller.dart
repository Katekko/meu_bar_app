import 'dart:async';

import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class HomeController extends GetxController implements IHomeController {
  final _currentVersion = BehaviorSubject<String>();

  @override
  Stream<String> get currentVersionStream => _currentVersion.stream;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentVersion();
  }

  @override
  void dispose() {
    _currentVersion.close();
    super.dispose();
  }

  void _loadCurrentVersion() {
    _currentVersion.add('1.0.0');
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}
