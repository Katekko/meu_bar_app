import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:get/get.dart';

class HomeController extends GetxController implements IHomeController {
  final _currentVersion = '1.0.0'.obs;
  @override
  Stream<String> get currentVersionStream => _currentVersion.stream;

  @override
  void onInit() {
    super.onInit();
    // TODO: Esperando versão 5 do getx para que o valor inicial
    // venha dentro da stream do get
    Future.delayed(const Duration(milliseconds: 300), _loadCurrentVersion);
  }

  @override
  void dispose() {
    _currentVersion.close();
    super.dispose();
  }

  void _loadCurrentVersion() {
    _currentVersion.value = '1.0.0';
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}
