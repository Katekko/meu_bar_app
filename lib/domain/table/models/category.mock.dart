import '../../../infrastructure/dal/services/data/category.data.dart';
import 'category.model.dart';

const categoryData1 = CategoryData(id: 1, name: 'Bebidas', icon: 0xff);
const categoryData2 = CategoryData(id: 2, name: 'Comidas', icon: 0xff);
const categoryData3 = CategoryData(id: 3, name: 'Outros', icon: 0xff);

final listCategoriesData = [categoryData1, categoryData2, categoryData3];

//-------------------------------------------------------------------------------//

final categoryModel1 = CategoryModel(id: 1, name: 'Bebidas', icon: 0xff);
final categoryModel2 = CategoryModel(id: 2, name: 'Comidas', icon: 0xff);
final categoryModel3 = CategoryModel(id: 3, name: 'Outros', icon: 0xff);

final listCategoriesModel = [categoryModel1, categoryModel2, categoryModel3];
