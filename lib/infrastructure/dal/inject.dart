import 'package:get/get.dart';

class Inject {
  Inject._();

  static T find<T>() {
    return Get.find<T>();
  }

  static void lazyPut<T>(T Function() callback) {
    Get.lazyPut<T>(callback);
  }

  static void putForEver<T>(T object) {
    Get.put<T>(object);
  }
}
