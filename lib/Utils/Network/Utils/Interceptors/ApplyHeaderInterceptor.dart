import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class ApplyHeaderInterceptor implements RequestInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    // final String? token = UserPreference.getValue(key: PrefKeys.tokenKey);

    var token = null;
    // UserPreference.getValue(key: PrefKeys.logInToken);
    // var token =
    //     await MySecureStorage(secureStorage: const FlutterSecureStorage())
    //         .getStringValue(StorageKeys.logInToken);
    // print("Tole : $token");
    // don't add token if null
    if (token == null) {
      return request;
    }
    // ignore: unnecessary_string_interpolations
    return applyHeader(request, 'x-access-token', '$token');
  }
}
