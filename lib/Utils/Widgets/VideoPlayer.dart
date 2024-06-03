import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool isLive;
  final bool canDispose;

  const VideoPlayerWidget(
      {required this.videoUrl,
      this.isLive = false,
      super.key,
      this.canDispose = false});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    if (widget.canDispose) {
      Get.find<VideoController>().videoPlayerController.dispose();
      Get.find<VideoController>().chewieController?.dispose();
      Get.find<VideoController>().chewieController = null;
    }
    super.dispose();
  }

  Future<void> initializePlayer() async {
    try {
      Get.find<VideoController>().videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      // ..initialize().then((value) {
      //   setState(() {});
      // });
      await Future.wait([
        Get.find<VideoController>()
            .videoPlayerController
            .initialize()
            .then((value) => setState(() {
                  Get.find<VideoController>().videoPlayerController.play();
                })),
      ]);

      Get.find<VideoController>().chewieController = ChewieController(
          videoPlayerController:
              Get.find<VideoController>().videoPlayerController,
          autoPlay: true,
          aspectRatio: null,
          looping: false,
          allowFullScreen: false,
          isLive: widget.isLive,
          hideControlsTimer: const Duration(seconds: 1),
          placeholder: AppLoder());
      setState(() {});
      WidgetsBinding.instance.addObserver(this);
    } catch (e) {
      initializePlayer();
      log('', name: 'video play error', error: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("video player ${widget.videoUrl}");
    return Center(
      child: Get.find<VideoController>().chewieController != null &&
              Get.find<VideoController>()
                  .chewieController!
                  .videoPlayerController
                  .value
                  .isInitialized
          ? Chewie(
              controller: Get.find<VideoController>().chewieController!,
            )
          : widget.isLive
              ? Image.asset(AppAssets.currentlyOffline)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.appButton),
                    SizedBox(height: 20.h),
                    Text('Loading'),
                  ],
                ),
    );
  }
}
