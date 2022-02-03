import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/infrastructure/dal/getx_connect.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/dal/getx_storage.dart';
import 'package:ekko/infrastructure/navigation/bindings/domains/auth.repository.binding.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'config.dart';
import 'domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'domain/core/abstractions/infrastructure/storage.interface.dart';
import 'domain/core/constants/storage.constants.dart';
import 'domain/core/utils/connect.util.dart';
import 'infrastructure/navigation/routes.dart';

import 'presentation/shared/loading/loading.controller.dart';

class Initializer {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await _initStorage();
      _initConnect();
      _initGlobalLoading();
      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initConnect() async {
    final getConnect = GetConnect();
    final url = ConfigEnvironments.getEnvironments()['url'];
    getConnect.baseUrl = url;
    getConnect.timeout = const Duration(seconds: 20);
    getConnect.httpClient.maxAuthRetries = 0;

    getConnect.httpClient.addRequestModifier<dynamic>(
      (request) async {
        final storage = Inject.find<IStorage>();
        final token = await storage.read<String>(
          StorageConstants.tokenAuthorization,
        );
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return request;
      },
    );

    getConnect.httpClient.addResponseModifier(
      (request, response) async {
        verifyResponse(statusText: response.statusText);
        if (response.statusCode == 401) {
          final authDomainBinding = AuthRepositoryBinding();
          await authDomainBinding.repository.logoutUser();
          Get.offAllNamed(Routes.login);
          SnackbarUtil.showWarning(
            'Faça login novamente para continuar utilizando o sistema',
          );
        }

        return response;
      },
    );

    Logger().i('Conectado em: $url');
    final connect = GetxConnect(connect: getConnect);
    Get.put<IHttpConnect>(connect);
  }

  static void _initGlobalLoading() {
    final loading = LoadingController();
    Get.put<ILoadingController>(loading);
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
    final storage = GetxStorage(storage: GetStorage());
    Get.put<IStorage>(storage);
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
