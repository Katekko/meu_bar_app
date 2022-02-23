import '../../../../domain/core/abstractions/domain/validators/field_validator.interface.dart';
import '../../../../domain/core/abstractions/domain/validators/validator.interface.dart';
import '../search.dart';

abstract class ISearchField<T extends ISearchable> extends IValidator {
  bool Function(T item, String searchText) filterCallback;

  ISearchField({
    required this.filterCallback,
    required List<IFieldValidator<T?>> validators,
  }) : super(validators: validators);

  Future<void> loadItems({bool useLoading = true});
  void addItems(List<T> items);
  void openDialog(void Function() callback);
  void selectItem(T item);

  T? get currentItem;
  Stream<List<T>> get itemsStream;
  Stream<T?> get currentItemStream;
  Stream<String?> get currentItemErrorStream;

  void dispose();
}
