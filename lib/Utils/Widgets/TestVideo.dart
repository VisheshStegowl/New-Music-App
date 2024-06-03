import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/LiveVideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:video_player/video_player.dart';

class TestViewWidget extends StatefulWidget {
  const TestViewWidget({super.key});

  @override
  State<TestViewWidget> createState() => _TestViewWidgetState();
}

class _TestViewWidgetState extends State<TestViewWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    AppConst.bottomDisplay = BottomDisplay.video;
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(AppConst.LiveUrl));

      await Future.wait([
        _videoPlayerController.initialize().then((value) => setState(() {
              _videoPlayerController.play();
              AppConst.bottomDisplay = BottomDisplay.video;
              setState(() {});
            }))
      ]);

      _chewieController = ChewieController(
        materialProgressColors:
            ChewieProgressColors(bufferedColor: AppColors.appButton),
        cupertinoProgressColors: ChewieProgressColors(
          bufferedColor: AppColors.appButton,
        ),
        allowMuting: false,
        placeholder: Image.asset(AppAssets.currentlyOffline),
        autoInitialize: true,
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        allowPlaybackSpeedChanging: true,
        aspectRatio: null,
        looping: false,
        allowFullScreen: false,
        isLive: true,
        hideControlsTimer: const Duration(seconds: 1),
      );
      setState(() {
        AppConst.bottomDisplay = BottomDisplay.video;
        _videoPlayerController.play();
      });

      WidgetsBinding.instance.addObserver(this);
    } catch (e) {
      log('', name: 'video play error', error: e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AppConst.liveVideoUrl.value = false;
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    AppConst.bottomDisplay = BottomDisplay.none;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("video ${AppConst.LiveUrl}");
    return AppConst.bottomDisplay == BottomDisplay.video &&
            AppConst.currentTabIndex != 1
        ? SizedBox(
            height: 100.h,
            child: GetBuilder<LiveVideoController>(
                init: Get.find<LiveVideoController>(),
                builder: (controller) {
                  return Container(
                    color: AppColors.appButton,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            color: AppColors.black,
                            height: 110.h,
                            child: videoPlayer(context),
                            // LiveVideoWidget(
                            //   controller:
                            //       controller.videoPlayerController,
                            //   videoUrl:
                            //       controller.liveVideoUrl.value ??
                            //           '',
                            // ),
                          ),
                        ),
                        const Spacer(),
                        AppButtonWidget(
                          onPressed: () {
                            if (_videoPlayerController.value.isPlaying) {
                              _chewieController?.pause();
                              setState(() {});
                            } else {
                              _chewieController?.play();
                            }
                            setState(() {});
                          },
                          btnName: '',
                          btnColor: AppColors.appButton,
                          child: Icon(
                            _chewieController?.isPlaying ?? false
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: AppColors.white,
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        AppButtonWidget(
                          btnColor: AppColors.appButton,
                          onPressed: () {
                            if (_videoPlayerController.value.volume > 0) {
                              _videoPlayerController.setVolume(0);
                              setState(() {});
                            } else {
                              _videoPlayerController.setVolume(1);
                              setState(() {});
                            }
                          },
                          btnName: '',
                          child: Icon(
                            _videoPlayerController.value.volume > 0
                                ? Icons.volume_up
                                : Icons.volume_off,
                            color: AppColors.white,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                }))
        : videoPlayer(context);
  }

  Widget videoPlayer(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: _chewieController!,
            )
          : Image.asset(AppAssets.currentlyOffline),
    );
  }
}
