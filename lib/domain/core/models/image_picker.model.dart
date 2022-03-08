import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/presentation/image_picker.interface.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModel implements IImagePicker {
  @override
  Future<Uint8List?> pickCameraImage() async {
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(source: ImageSource.camera);
      final bytes = await photo?.readAsBytes();
      return bytes;
    } catch (err) {
      rethrow;
    }
  }
}
