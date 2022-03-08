import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

class ImageWidget extends ViewController<IProductController> {
  final String? urlImage;
  const ImageWidget({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          StreamBuilder<Uint8List?>(
            stream: controller.imageBytesField.stream,
            builder: (_, snap) {
              if (snap.hasData && snap.data != null) {
                return Image.memory(snap.data!);
              } else {
                return urlImage != null
                    ? Image.network(
                        urlImage!,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      )
                    : const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Escolha uma foto'),
                        ),
                      );
              }
            },
          ),
          Card(
            color: Colors.white.withOpacity(.6),
            child: IconButton(
              onPressed: controller.pickImage,
              icon: const Icon(Icons.camera_alt_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
