import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/View/CameraScreen.dart';
import 'package:new_music_app/View/Favorites/FavoritesScreen.dart';
import 'package:new_music_app/View/HomeScreen/HomeScreen.dart';
import 'package:new_music_app/View/LiveVideoScreen/LiveVideoScreen.dart';
import 'package:new_music_app/View/MenuScreen/MenuScreen.dart';
import 'package:new_music_app/View/PlayListScreen/PlaylistScreen.dart';
import 'package:new_music_app/View/RadioScreen/RadioScreen.dart';
import 'package:new_music_app/View/VideoScreen/VideoListScreen.dart';
import 'package:new_music_app/View/VideoScreen/player.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class BaseController extends GetxController {
  late CameraController cameraController;
  StreamController<bool> mainStreamController = StreamController.broadcast();
  StreamController<bool> backGroundStreamController =
      StreamController.broadcast();
  MiniplayerController miniplayerController = MiniplayerController();

  updateButton({required BottomDisplay button}) {
    AppConst.bottomDisplay = button;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    backGroundStreamController.sink.add(false);
  }

  void disposeMethod() {
    if (Get.find<HomeController>().audioPlayer.current.hasValue) {
      Get.find<HomeController>().audioPlayer.pause();
      Get.find<HomeController>().audioPlayer.dispose();
      Get.find<HomeController>().audioPlayer = AssetsAudioPlayer();
    }
    if (Get.find<RadioController>().audioPlayer.current.hasValue) {
      Get.find<RadioController>().audioPlayer.pause();
      Get.find<RadioController>().audioPlayer.dispose();
      Get.find<RadioController>().audioPlayer = AssetsAudioPlayer();
    }
  }

  RxString imageUrl = ''.obs;
  RxBool bottomBar = false.obs;
  RxBool loader = false.obs;

  void showLoader(bool value) {
    loader.value = value;
    update();
  }

  double bottomSheetHeight = 0.04;
  bool isLiveOn = false;

  RxInt currentTabIndex = 0.obs;
  final List<Widget> tabs = [
    const HomeScreen(),
    const LiveVideoScreen(),
    const RadioScreen(),
    const VideoListScreen(),
    const FavoritesScreen(),
    PlayListScreen(),
    const MenuScreen(),
  ];
  File? file;
  MerchandiseDataModel? merchandiseDataModel;

  Future<void> imageUpload() async {
    try {
      if (file?.path != null) {
        final response = http.MultipartRequest(
            "POST",
            Uri.parse(
                "https://alajazamusic.com/alajazamusicadmin/api/uploads"));
        response.files.add(await http.MultipartFile.fromPath(
          'image',
          file?.path ?? '',
        ));
        final streamedResponse = await response.send();
        if (streamedResponse.statusCode == 200) {
          final responseString =
              await streamedResponse.stream.transform(utf8.decoder).join();
          final decodedBody = jsonDecode(responseString);
          merchandiseDataModel = MerchandiseDataModel.fromJson(decodedBody);
          imageUrl.value = merchandiseDataModel?.link ?? decodedBody['url'];
          print("image ${imageUrl.value}");
          update();

          print(decodedBody);
        }
      } else {
        Get.back();
        Utility.showSnackBar('Something went wrong in Upload Image',
            isError: true);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getFile() async {
    var status = await Permission.mediaLibrary.status;
    if (status.isDenied) {
      status = await Permission.mediaLibrary.request();
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    if (result != null) {
      File files = File(result.files.single.path ?? '');

      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: files.path ?? '', aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(lockAspectRatio: false),
      ]);
      file = File(croppedFile?.path ?? '');
      await imageUpload();
      print(file);
      update();
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      Utility.showSnackBar("error in picking file", isError: true);
    }
  }

  Future<void> getCameraImage() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.image, withData: true);
    XFile? result = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.camera,
    );
    print(result);
    if (result != null) {
      File files = File(result.path ?? '');

      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: files.path ?? '', aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(lockAspectRatio: false),
      ]);
      file = File(croppedFile?.path ?? '');
      await imageUpload();
      print(file);
      update();
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      Utility.showSnackBar("error in picking file", isError: true);
    }
  }

  Future<void> getCameraFile(BuildContext context) async {
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    CameraDescription backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);

    PermissionStatus status = await Permission.camera.status;
    status = await Permission.camera.request();

    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TakePictureScreen(
                  frontCamera: frontCamera,
                  rearCamera: backCamera,
                )));

    // PickedFile? result = await ImagePicker.platform.pickImage(
    //     source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
  }

  Future<void> takeCameraPicture(String path) async {
    if (path != null) {
      File files = File(path ?? '');

      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: files.path ?? '', aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(lockAspectRatio: false),
      ]);
      file = File(croppedFile?.path ?? '');
      await imageUpload();
      Get.back();
      print(file);
      update();
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      Utility.showSnackBar("error in picking file", isError: true);
    }
  }
}
