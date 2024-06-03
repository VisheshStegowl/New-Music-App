import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/LiveVideoModel.dart';
import 'package:new_music_app/Utils/Models/SponsorBannerDataModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class LiveVideoController extends GetxController {
  // late VideoPlayerController videoPlayerController;
  ScrollController scrollController = ScrollController();

  // ChewieController? chewieController;
  late DatabaseReference messagesRef;
  StreamSubscription<DatabaseEvent>? messagesSubscription;
  late HomeChopperService _homeChopperService;
  TextEditingController postMessageController = TextEditingController();
  String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String time = DateFormat('h:mm a').format(DateTime.now());

  LiveVideoController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  @override
  void onInit() async {
    super.onInit();
    await databaseInit();
    await liveVideoApi();

    // initializePlayer();
  }

  Future<void> sendMessage(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (postMessageController.text.isEmpty ||
        postMessageController.text == "") {
      Utility.showSnackBar("Please enter message first", isError: true);
    } else {
      await messagesRef.push().set(<String, String>{
        "comment": postMessageController.text,
        "commentByName": 'user',
        "commentImageURL": '',
        "type": 'user',
        "time": '$time',
        "commentDate": '$date'
      });
      postMessageController.clear();
      Future.delayed(const Duration(milliseconds: 500), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent ?? 0);
      });
      update();
    }
  }

  Rxn<SponsorBannerDataModel> sponsorBannerData = Rxn<SponsorBannerDataModel>();

  Future<void> sponsorBannerApi() async {
    try {
      final response = await _homeChopperService.sponsorBannerApi();
      if (response.isSuccessful) {
        sponsorBannerData.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'sponsor banner Api error');
    }
  }

  Future<void> shareBanner({required String url}) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      log('', name: 'url luncher error', error: e.toString());
    }
  }

  Future<void> likeLiveVideo() async {
    try {
      final queryParameters = {"type": "AddRemoveFavouriteVideos"};
      final param = {
        "menu_id": 31,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "videos_id": liveVideoModel.value?.data?[0].videosId ?? 0,
      };
      final response = await _homeChopperService.addRemoveFavouritesVideoApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Utility.showSnackBar(response.body?.message);
        print(
            "this is video count ${liveVideoModel.value?.data?[0].videoLikeCount}");
        liveVideoModel.value?.data?[0].favouritesStatus =
            response.body?.favouritesStatus;
        liveVideoModel.value?.data?[0].videoLikeCount =
            response.body?.favouritesStatus ?? false
                ? (liveVideoModel.value?.data?[0].videoLikeCount)!.toInt() + 1
                : (liveVideoModel.value?.data?[0].videoLikeCount)!.toInt() - 1;
        print(liveVideoModel.value?.data?[0].favouritesStatus);
        print(
            "bajdc abkslc lnca ${liveVideoModel.value?.data?[0].videoLikeCount}");
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Add Favorate Live Video');
    }
  }

  // Future<void> initializePlayer() async {
  //   await liveVideoApi();
  //   try {
  //     videoPlayerController =
  //         VideoPlayerController.networkUrl(Uri.parse(liveVideoUrl.value));
  //
  //     await Future.wait([
  //       videoPlayerController.initialize().then((value) {
  //         videoPlayerController.play();
  //         print(liveVideoUrl.value);
  //         update();
  //       }),
  //     ]);
  //
  //     chewieController = ChewieController(
  //       videoPlayerController: videoPlayerController,
  //       autoPlay: true,
  //       aspectRatio: null,
  //       looping: false,
  //       allowFullScreen: false,
  //       isLive: true,
  //       hideControlsTimer: const Duration(seconds: 1),
  //     );
  //
  //     update();
  //   } catch (e) {
  //     // initializePlayer();
  //     log('', name: 'video play error', error: e.toString());
  //   }
  // }

  Future<void> databaseInit() async {
    final FirebaseDatabase database =
        FirebaseDatabase.instanceFor(app: Firebase.app());
    messagesRef = FirebaseDatabase.instance.ref('User');

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    messagesSubscription =
        messagesRef.limitToLast(10).onChildAdded.listen((DatabaseEvent event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final FirebaseException error = o as FirebaseException;
      print('Error: ${error.code} ${error.message}');
    });
  }

  Rxn<LiveVideoModel> liveVideoModel = Rxn<LiveVideoModel>();
  RxString liveVideoUrl = ''.obs;

  Future<void> liveVideoApi() async {
    try {
      final param = {
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final queryParameters = {"menu_id": 31, "menu_type": "Videos"};
      final response = await _homeChopperService.liveVideoApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        liveVideoModel.value = response.body;
        liveVideoUrl.value = liveVideoModel.value?.data?[0].videosLink ?? '';
        AppConst.LiveUrl = liveVideoModel.value?.data?[0].videosLink ?? '';
        await sponsorBannerApi();
        update();
      }
    } catch (e) {
      log("", name: 'Live Video Api', error: e.toString());
    }
  }

  shareUrl(String url) async {
    await Share.share("Video Url:\n$url \n App Name: DJ Ala Jaza");
  }
}
