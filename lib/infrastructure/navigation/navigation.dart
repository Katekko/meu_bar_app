import 'package:get/get.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.categories,
      page: () => CategoriesScreen(),
      binding: CategoriesControllerBinding(),
    ),
    GetPage(
      name: Routes.CATEGORY,
      page: () => CategoryScreen(),
      binding: CategoryControllerBinding(),
    ),    
  ];
}