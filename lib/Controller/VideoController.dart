import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/LiveVideoModel.dart';
import 'package:new_music_app/Utils/Models/SponsorBannerDataModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoController extends BaseController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late DatabaseReference messagesRef;
  StreamSubscription<DatabaseEvent>? messagesSubscription;
  late HomeChopperService _homeChopperService;
  int paginationInt = 1;
  Rxn<VideoCategoryDataModel> videoCategoryDataModel =
      Rxn<VideoCategoryDataModel>();

  VideoController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  @override
  onInit() async {
    super.onInit();

    await videoCategoryApi();
  }

  Future<void> videoCategoryApi() async {
    showLoader(true);
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {
        'menu_id': AppConst.menuId,
        "menu_type": AppConst.menuType,
        "limit": 7,
        'page': paginationInt
      };
      final response = await _homeChopperService.videoCategoryApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        videoCategoryDataModel.value = response.body;
        update();
      }
      showLoader(false);
    } catch (e) {
      showLoader(false);
      log('', error: e.toString(), name: 'Video Category Api Error');
    }
  }

  Rxn<VideoCategoryDataListModel> videoCategoryDataListModel =
      Rxn<VideoCategoryDataListModel>();

  Future<void> videoCategoryListApi({required int categoryId}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {
        'menu_id': AppConst.menuId,
        'category_id': categoryId,
        'category_for': 'Videos',
        'limit': 15,
        'page': 1
      };
      final response = await _homeChopperService.videoCategoryItemsApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        videoCategoryDataListModel.value = response.body;
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Video Category List Api error');
    }
  }

  Future<bool?> addRemoveFavoriteVideoApi(
      {dynamic? menuId, int? videoId}) async {
    try {
      final queryParameters = {'type': 'AddRemoveFavouriteVideos'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "videos_id": videoId
      };
      final response = await _homeChopperService.addRemoveFavouritesVideoApi(
          param: param, queryParameters: queryParameters);
      if (response.body?.status == 200) {
        Utility.showSnackBar(response.body?.message, isError: false);
        return response.body?.favouritesStatus ?? false;
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
        return null;
      }
    } catch (e) {
      log('', name: 'Add Remove Favorite Video', error: e.toString());
      rethrow;
    }
  }
}
