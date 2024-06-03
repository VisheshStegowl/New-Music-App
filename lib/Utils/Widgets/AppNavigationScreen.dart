import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AnimatedBottomsheet.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/TestVideo.dart';

class AppNavigationScreen extends StatefulWidget {
  const AppNavigationScreen({super.key});

  @override
  State<AppNavigationScreen> createState() => _AppNavigationScreenState();
}

class _AppNavigationScreenState extends State<AppNavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isShow = false;

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<BaseController>(
          init: Get.find<BaseController>(),
          builder: (controller) {
            return Scaffold(
              appBar: AppNavigationBar(
                defaultAppBar: AppBar(),
              ),
              body: Column(
                children: [
                  Expanded(child: controller.tabs[AppConst.currentTabIndex]),
                ],
              ),
              bottomNavigationBar: AnimatedBottomSheet(),
            );
          }),
    );
  }
}
