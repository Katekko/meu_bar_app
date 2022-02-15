import 'dart:async';

import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:get/get.dart' hide Rx;

class HomeController extends GetxController implements IHomeController {
  final _currentVersion = '1.0.0'.obs;

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
    // TODO: Adicionar o modo de pegar a versão atual do projeto
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}
