class Routes {
  static Future<String> get initialRoute async {
    try {
      // Comentado para sempre ficar no login por enquanto
      // final authDomainService = AuthRepositoryBinding().repository;
      // final authenticated = await authDomainService.isAuthenticated();
      // return !authenticated ? login : home;
      return home;
    } catch (err) {
      return login;
    }
  }

  static const categories = '/categories';
  static const createCategory = '/categories/create';
  static const editCategory = '/categories/edit';
  static const home = '/home';
  static const login = '/login';
  static const products = '/products';
  static const createProduct = '/products/create';
  static const editProduct = '/products/edit';
}
