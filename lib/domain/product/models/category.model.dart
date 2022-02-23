import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/presentation/shared/search/interfaces/searchable.interface.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CategoryModel extends Equatable implements ISearchable {
  final int id;
  final String name;
  final int icon;

  /// Identificador para o search
  final String _guid;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  }) : _guid = const Uuid().v1();

  @override
  String get desc => name;

  @override
  String get guid => _guid;

  factory CategoryModel.fromData(CategoryData data) {
    return CategoryModel(id: data.id, name: data.name, icon: data.icon);
  }

  CategoryData toData() => CategoryData(id: id, name: name, icon: icon);

  @override
  List<Object?> get props => [id, name, icon];
}
