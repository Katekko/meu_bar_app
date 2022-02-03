import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController implements ILoadingController {
  final _isLoading = false.obs;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  set isLoading(bool val) => _isLoading.value = val;

  @override
  void onClose() => _isLoading.close();
}
