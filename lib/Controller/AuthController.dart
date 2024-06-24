import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/AuthChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Models/WalkthroughDataModel.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends BaseController {
  // RxString imageUrl = ''.obs;
  RxBool checkBox = false.obs;
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  CarouselController carouselController = CarouselController();
  late AuthChopperService _authChopperService;

  AuthController({required AuthChopperService authChopperService}) {
    _authChopperService = authChopperService;
  }

  Future<void> signUp(BuildContext context) async {
    UserPreference.setValue(
        key: PrefKeys.deviceType,
        value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
            ? "IOS"
            : "android");
    final param = {
      "name": nameController.text,
      "username": userNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "password": passwordController.text,
      "confirm_password": confirmPasswordController.text,
      "fcm_id": "null",
      "device": Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
          ? "iOS"
          : "Android",
      "image": imageUrl.value
    };
    try {
      final response = await _authChopperService.signUpApi(param: param);
      if (response.body?.statusCode == 200) {
        clearController();
        AppConst.currentTabIndex = 0;
        Get.offNamed(RoutesName.loginScreen);
        Utility.showSnackBar(
          response.body?.message,
        );
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Sign Up Api error');
    }
  }

  Future<void> signIn(BuildContext context) async {
    UserPreference.setValue(
        key: PrefKeys.deviceType,
        value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
            ? "IOS"
            : "android");
    try {
      final param = {
        "username": userNameController.text,
        "password": passwordController.text,
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "fcm_id": "null"
      };
      final response = await _authChopperService.signInApi(param: param);
      if (response.body?.status == 200) {
        UserPreference.setValue(
            key: PrefKeys.logInToken, value: response.body?.token);
        UserPreference.setValue(
            key: PrefKeys.email, value: response.body?.data?[0].email);
        UserPreference.setValue(
            key: PrefKeys.userId, value: response.body?.data?[0].userId);
        UserPreference.setValue(
            key: PrefKeys.password, value: passwordController.text);
        Get.offNamed(RoutesName.homeScreen);
        update();
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('', error: e.toString(), name: "Login error");
    }
  }

  Future<void> skipUser(BuildContext context, [bool liveVideo = false]) async {
    UserPreference.setValue(
        key: PrefKeys.deviceType,
        value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
            ? "IOS"
            : "android");
    showLoader(true);
    try {
      final param = {
        "fcm_id": "null",
        "device": UserPreference.getValue(key: PrefKeys.deviceType)
      };
      final response = await _authChopperService.skipUserApi(param: param);
      if (response.isSuccessful) {
        print(response.statusCode);
        UserPreference.setValue(
            key: PrefKeys.logInToken, value: response.body?.token);
        UserPreference.setValue(
            key: PrefKeys.userId, value: response.body?.userId);
        update();
        showLoader(false);
        if (liveVideo) {
          AppConst.currentTabIndex = 1;
          Get.offNamed(RoutesName.homeScreen);
        } else {
          AppConst.currentTabIndex = 0;
          Get.offNamed(RoutesName.homeScreen);
        }
      } else {
        showLoader(false);
        Utility.showSnackBar(response.body?.message);
      }
    } catch (e) {
      showLoader(false);
      log('', name: 'Skip User Api', error: e.toString());
    }
  }

  WalkthroughDataModel? walkthroughDataModel;
  RxInt pageIndex = 0.obs;

  Future<void> walkthroughApi() async {
    try {
      final response = await _authChopperService.walkthroughApi();
      if (response.isSuccessful) {
        walkthroughDataModel = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'Walkthrough Api Error', error: e.toString());
    }
  }

  void clearController() {
    nameController.clear();
    userNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
