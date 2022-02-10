abstract class IHomeController {
  void navToCategories();
  void navToProducts();

  void logout();

  Stream<String> get currentVersionStream;
}
