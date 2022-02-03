import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import 'loading.interface.dart';

class CircularLoadingWidget extends ViewController<ILoadingController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: controller.isLoadingStream,
      builder: (_, loadingSnap) {
        if (loadingSnap.hasData && loadingSnap.data!) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Stack(
              children: <Widget>[
                ModalBarrier(
                  dismissible: false,
                  color: Colors.grey.withOpacity(.3),
                ),
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
