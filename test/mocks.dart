import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/storage.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/image_picker.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class AuthServiceMock extends Mock implements IAuthService {}

class AuthRepositoryMock extends Mock implements IAuthRepository {}

class ProductsServiceMock extends Mock implements IProductsService {}

class CategoriesServiceMock extends Mock implements ICategoriesService {}

class ProductRepositoryMock extends Mock implements IProductRepository {}

class CategoryRepositoryMock extends Mock implements ICategoryRepository {}

class ImagePickerMock extends Mock implements IImagePicker {}

class LoadingControllerMock extends Mock implements ILoadingController {}

class ConnectMock extends Mock implements IHttpConnect {}

class StorageMock extends Mock implements IStorage {}

class FieldMock<T> extends Mock implements IField<T> {}

class FieldStreamMock<T> extends Mock implements IStreamField<T> {}

class CategoriesStreamMock extends Mock
    implements BehaviorSubject<List<CategoryModel>> {}
