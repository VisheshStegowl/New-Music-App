import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/FavouriteVideoModel.dart';
import 'package:new_music_app/Utils/Models/NotificationDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchAlbumDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchSongDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchVideosDataModel.dart';
import 'package:new_music_app/Utils/Models/SignInModel.dart';
import 'package:new_music_app/Utils/Models/SocialMediaModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class MenuPageController extends BaseController {
  TextEditingController globalSearchController = TextEditingController();
  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingEmailController = TextEditingController();
  TextEditingController bookingCommentController = TextEditingController();
  TextEditingController bookingPhoneController = TextEditingController();
  RxBool pageLoder = false.obs;

  void showPageLoader(bool value) {
    pageLoder.value = value;
    update();
  }

  late HomeChopperService _homeChopperService;

  MenuPageController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  RxString url = ''.obs;

  Future<String> getMerchandiseApi() async {
    try {
      final response = await _homeChopperService.getMerchandiseApi();
      if (response.isSuccessful) {
        url.value = response.body?.link ?? '';
        update();
        return url.value;
      } else {
        return '';
      }
    } catch (e) {
      log('', name: 'Get Merchandise Api error', error: e.toString());
      return '';
    }
  }

  SignInModel? signInModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> getProfileApi() async {
    showPageLoader(true);
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {'type': 'ProfileDetails'};
      final response = await _homeChopperService.getProfileApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        signInModel = response.body;
        nameController =
            TextEditingController(text: signInModel?.data?[0].name);
        userNameController =
            TextEditingController(text: signInModel?.data?[0].username);
        emailController =
            TextEditingController(text: signInModel?.data?[0].email);
        phoneController =
            TextEditingController(text: signInModel?.data?[0].phone ?? '0');
        Get.find<BaseController>().imageUrl.value =
            signInModel?.data?[0].image ?? '';

        update();
        // showPageLoader(false);
      }

      showPageLoader(false);
    } catch (e) {
      log('', error: e.toString(), name: 'Profile Api Error');
      showPageLoader(false);
    }
  }

  Rxn<FavouriteVideoModel> favouriteVideoModel = Rxn<FavouriteVideoModel>();

  Future<void> favouriteVideoApi() async {
    try {
      final queryParameters = {
        'type': 'FavouriteVideosList',
        'limit': 15,
        "page": 1
      };
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.favouriteVideoApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        favouriteVideoModel.value = response.body;
        print(response.statusCode);
        update();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      log('', name: 'Favourite Video Api error', error: e.toString());
    }
  }

  Rxn<SocialMediaModel> socialMediaModel = Rxn<SocialMediaModel>();

  Future<void> socialMediaApi() async {
    try {
      final param = {
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.socialMediaApi(param: param);
      if (response.isSuccessful) {
        socialMediaModel.value = response.body;
      }
    } catch (e) {
      log('', name: 'SocialMedia Api error', error: e.toString());
    }
  }

  Rxn<SearchSongDataModel> searchSongResult = Rxn<SearchSongDataModel>();

  Future<void> songSearchApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "search": globalSearchController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "type": "songs"
      };
      final queryParameters = {"limit": 50, "page": 1};
      final response = await _homeChopperService.searchSongs(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        searchSongResult.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'search song error api', error: e.toString());
    }
  }

  Rxn<SearchAlbumDataModel> searchAlbumResult = Rxn<SearchAlbumDataModel>();

  Future<void> albumSearchApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "search": globalSearchController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "type": "album"
      };
      final queryParameters = {"limit": 50, "page": 1};
      final response = await _homeChopperService.searchAlbum(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        searchAlbumResult.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'search song error api', error: e.toString());
    }
  }

  Rxn<SearchVideosDataModel> searchVideoResult = Rxn<SearchVideosDataModel>();

  Future<void> videoSearchApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "search": globalSearchController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "type": "videos"
      };
      final queryParameters = {"limit": 50, "page": 1};
      final response = await _homeChopperService.searchVideos(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        searchVideoResult.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'search song error api', error: e.toString());
    }
  }

  Future<void> bookingApi() async {
    try {
      final param = {
        "comment": bookingCommentController.text,
        "email": bookingEmailController.text,
        "name": bookingNameController.text,
        "phone": bookingPhoneController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.bookingApi(param: param);
      if (response.isSuccessful) {
        Utility.showSnackBar(response.body?.message);
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Booking Api');
    }
  }

  Rxn<NotificationDataModel> notificationDataModel =
      Rxn<NotificationDataModel>();

  Future<void> notificationApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final response = await _homeChopperService.notificationApi(param: param);
      if (response.isSuccessful) {
        notificationDataModel.value = response.body;
        Utility.showSnackBar(response.body?.message);
        update();
      }
    } catch (e) {
      log('', name: 'Notification Api error');
    }
  }
}
