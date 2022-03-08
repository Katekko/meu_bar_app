import 'dart:typed_data';

abstract class IImagePicker {
  Future<Uint8List?> pickCameraImage();
}
