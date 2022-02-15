import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;

  /// Hexdecimal
  final int icon;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryModel.fromData(CategoryData data) {
    return CategoryModel(id: data.id, name: data.name, icon: data.icon);
  }

  CategoryData toData() => CategoryData(id: id, name: name, icon: icon);

  @override
  List<Object?> get props => [id, name, icon];
}
