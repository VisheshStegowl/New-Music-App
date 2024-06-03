import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/Widget/PlayingIconCommonWidget.dart';

class SongPlayScreen extends StatelessWidget {
  final int songId;
  final int menuId;

  SongPlayScreen({
    super.key,
    required this.songId,
    required this.menuId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppNavigationBar(
            defaultAppBar: AppBar(),
          ),
          body: GetBuilder<HomeController>(
              init: Get.find<HomeController>(),
              builder: (controller) {
                return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AppAssets.blackBackgroundScreen,
                          ),
                          fit: BoxFit.cover)),
                  child: controller.audioPlayer.builderRealtimePlayingInfos(
                      builder: (context, snapshot) {
                    return snapshot.current?.audio.audio == null
                        ? const AppLoder()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                TitleBackButtonWidget(
                                  title: 'Now Playing'.toUpperCase(),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Container(
                                    height: 300.h,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 20.h),
                                    decoration: const BoxDecoration(
                                      color: AppColors.appButton,
                                    ),
                                    child: Container(
                                        color: AppColors.textFormFieldTextColor,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.h, vertical: 10.h),
                                        child: CachedNetworkImageWidget(
                                          image: snapshot.current?.audio.audio
                                                  .metas.image?.path ??
                                              controller
                                                  .assetsSongs[controller
                                                          .currentSongIndex
                                                          ?.value ??
                                                      0]
                                                  .songImage ??
                                              '',
                                        ))),
                                AppTextWidget(
                                  txtTitle: snapshot
                                          .current?.audio.audio.metas.title ??
                                      '',
                                  fontSize: 16,
                                  txtColor: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                AppTextWidget(
                                  txtTitle: snapshot
                                          .current?.audio.audio.metas.artist ??
                                      '',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  txtColor: AppColors.appButton,
                                ),
                                20.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // if (0 <
                                        //     controller
                                        //         .currentSongIndex!.value) {
                                        // controller.currentSongIndex?.value--;
                                        controller.audioPlayer.previous();
                                        // controller.playSong(
                                        //     assests:
                                        //         controller.assetsSongs ?? [],
                                        //     index: controller.currentSongIndex
                                        //             ?.value ??
                                        //         0);
                                        controller.update();
                                        // } else {
                                        //   Utility.showSnackBar(
                                        //     'last Song',
                                        //     isError: true,
                                        //   );
                                        // }
                                      },
                                      child: Image.asset(
                                        AppAssets.fastRewindImage,
                                        height: 30.h,
                                        width: 35.w,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.audioPlayer.playOrPause();
                                      },
                                      child: Image.asset(
                                        controller.audioPlayer.isPlaying.value
                                            ? AppAssets.playButtonImage
                                            : AppAssets.puaseButtonImage,
                                        height: 50.h,
                                        width: 55.w,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print(
                                            "this is index ${(controller.assetsSongs.length - 1) > controller.currentSongIndex!.value}");
                                        // if (controller.assetsSongs.length - 1 >
                                        //     controller
                                        //         .currentSongIndex!.value) {
                                        //   controller.currentSongIndex?.value++;
                                        controller.audioPlayer.next(
                                          stopIfLast: false,
                                        );
                                        //   controller.playSong(
                                        //       assests:
                                        //           controller.assetsSongs ?? [],
                                        //       index: controller.currentSongIndex
                                        //               ?.value ??
                                        //           0);
                                        // } else {
                                        //   Utility.showSnackBar(
                                        //     'last Song',
                                        //     isError: true,
                                        //   );
                                        // }
                                      },
                                      child: Image.asset(
                                        AppAssets.fastForwordImage,
                                        height: 30.h,
                                        width: 35.w,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                20.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PlayingIconCommonWidget(
                                      onTap: () {
                                        Get.find<HomeController>()
                                            .addRemoveFavourites(
                                                menuId: controller
                                                        .assetsSongs[controller
                                                                .currentSongIndex
                                                                ?.value ??
                                                            0]
                                                        .menuId ??
                                                    0,
                                                songId: controller
                                                        .assetsSongs[controller
                                                                .currentSongIndex
                                                                ?.value ??
                                                            0]
                                                        .songId ??
                                                    0);
                                      },
                                      isIcon: true,
                                      icon: controller
                                                  .assetsSongs[controller
                                                          .currentSongIndex
                                                          ?.value ??
                                                      0]
                                                  .favouritesStatus ??
                                              false
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      iconColor: AppColors.white,
                                      liked: controller
                                              .assetsSongs[controller
                                                      .currentSongIndex
                                                      ?.value ??
                                                  0]
                                              .favouritesStatus ??
                                          false,
                                      title: 'Favorite',
                                      subTitle:
                                          "${controller.assetsSongs[controller.currentSongIndex?.value ?? 0].favouritesCount != null ? controller.assetsSongs[controller.currentSongIndex?.value ?? 0].favouritesCount : 0}" ??
                                              '0',
                                    ),
                                    PlayingIconCommonWidget(
                                      onTap: () {
                                        Get.dialog(AddPlaylistDialog(
                                          menuId: menuId ?? 0,
                                          songId: songId ?? 0,
                                        ));
                                      },
                                      isIcon: false,
                                      image: AppAssets.addToPlaylist,
                                      imageHeight: 29,
                                      imageWidth: 26,
                                      title: 'Playlist',
                                      subTitle: '0',
                                    ),
                                    PlayingIconCommonWidget(
                                      onTap: () {
                                        controller.shareSong(
                                          songUrl: controller
                                                  .assetsSongs[controller
                                                          .currentSongIndex
                                                          ?.value ??
                                                      0]
                                                  .song ??
                                              '',
                                          songName: snapshot.current?.audio
                                                  .audio.metas.title ??
                                              '',
                                          artistName: snapshot.current?.audio
                                                  .audio.metas.artist ??
                                              '',
                                          sharedValue: controller
                                                  .assetsSongs[controller
                                                          .currentSongIndex
                                                          ?.value ??
                                                      0]
                                                  .totalShared ??
                                              0,
                                        );
                                        controller
                                            .assetsSongs[controller
                                                    .currentSongIndex?.value ??
                                                0]
                                            .totalShared = (controller
                                                .assetsSongs[controller
                                                        .currentSongIndex
                                                        ?.value ??
                                                    0]
                                                .totalShared!
                                                .toInt() +
                                            1);
                                      },
                                      isIcon: false,
                                      image: AppAssets.share,
                                      imageHeight: 29,
                                      imageWidth: 26,
                                      title: 'share',
                                      subTitle: controller
                                              .assetsSongs[controller
                                                      .currentSongIndex
                                                      ?.value ??
                                                  0]
                                              .totalShared
                                              .toString() ??
                                          '0',
                                    ),
                                    PlayingIconCommonWidget(
                                      isIcon: false,
                                      image: AppAssets.playsIcon,
                                      imageColor: AppColors.appButton,
                                      imageHeight: 29,
                                      imageWidth: 26,
                                      title: 'Plays',
                                      subTitle: controller
                                              .assetsSongs[controller
                                                      .currentSongIndex
                                                      ?.value ??
                                                  0]
                                              .totalPlayed
                                              .toString() ??
                                          '0',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                  }),
                );
              }),
        ),
        Obx(() => Visibility(
            visible: Get.find<HomeController>().loader.value,
            child: AppLoder()))
      ],
    ));
  }
}
