abstract class IHomeController {
  void logout();

  Stream<String> get currentVersionStream;
}
