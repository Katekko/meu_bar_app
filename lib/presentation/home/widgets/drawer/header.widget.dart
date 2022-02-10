import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Meu Bar'),
        ),
        IconButton(
          onPressed: Get.back,
          icon: const Padding(
            padding: EdgeInsets.only(top: 6),
            child: SizedBox(
              width: 10,
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        )
      ],
    );
  }
}
