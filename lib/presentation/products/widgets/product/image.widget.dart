import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? urlImage;
  const ImageWidget({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          urlImage != null
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
                ),
          Card(
            color: Colors.white.withOpacity(.6),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
