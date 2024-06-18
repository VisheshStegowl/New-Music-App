import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Models/RadioModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class RadioController extends BaseController {
  late AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  late HomeChopperService _homeChopperService;

  RadioController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  Rxn<RadioModel> radioModel = Rxn<RadioModel>();

  Future<void> getRadioAudio() async {
    try {
      print("this is radio  ${audioPlayer.current.hasValue}");
      disposeMethod();
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {"menu_id": 32, "menu_type": "Radio"};
      final response = await _homeChopperService.radioAudioApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        radioModel.value = response.body;
        updateButton(button: BottomDisplay.radio);
        AppConst.bottomDisplay = BottomDisplay.radio;
        Get.find<BaseController>().mainStreamController.sink.add(true);
        await audioPlayer.open(
          Audio.liveStream("https://radio4.domint.net:9072/stream",
              // radioModel.value?.data?[0].song ?? '',
              metas: Metas(
                  title: radioModel.value?.data?[0].songName,
                  artist: radioModel.value?.data?[0].songName,
                  image: MetasImage(
                      path: radioModel.value?.data?[0].songImage ?? '',
                      type: ImageType.network))),
          autoStart: true,
          notificationSettings: NotificationSettings(
              nextEnabled: false, prevEnabled: false, stopEnabled: false),
          showNotification: true,
        );
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Radio Api error');
    }
  }
}
