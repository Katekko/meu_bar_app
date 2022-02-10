import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:equatable/equatable.dart';

class HomeController implements IHomeController, Equatable {
  @override
  // TODO: implement currentVersionStream
  Stream<String> get currentVersionStream => throw UnimplementedError();

  @override
  void navToCategories() {
    // TODO: implement navToCategories
  }

  @override
  void navToProducts() {
    // TODO: implement navToProducts
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => null;
}
