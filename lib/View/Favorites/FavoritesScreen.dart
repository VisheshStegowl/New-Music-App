import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppSearchField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationScreen.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';
import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';

class FavoritesScreen extends GetView<HomeController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController(
        homeChopperService:
            AppChopperClient().getChopperService<HomeChopperService>()));
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.blackBackgroundScreen,
                  ),
                  fit: BoxFit.cover)),
          child: GetBuilder<HomeController>(
              initState: (state) => controller.getFavoritesList(),
              builder: (controller) {
                return Column(
                  children: [
                    const BannerWidget(),
                    10.verticalSpace,
                    AppSearchField(
                      controller: controller.favoritesController,
                      onChanged: (String value) {
                        controller.searchFavorites(value);
                      },
                      onSearch: () {
                        controller.searchFavorites(
                            controller.favoritesController.text);
                      },
                    ),
                    10.verticalSpace,
                    if (controller
                            .favoriteSongListModel.value?.data?.isNotEmpty ??
                        false)
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.favoriteSongListModel.value
                                    ?.data?.length ??
                                1,
                            itemBuilder: (context, index) {
                              return SongListWidget(
                                  gifWidget: Get.find<HomeController>()
                                          .audioPlayer
                                          .current
                                          .hasValue &&
                                      controller.favoriteSongListModel.value
                                              ?.data?[index].songName ==
                                          Get.find<HomeController>()
                                              .audioPlayer
                                              .current
                                              .value
                                              ?.audio
                                              .audio
                                              .metas
                                              .title,
                                  onOptionTap: () {
                                    Get.dialog(SongAddToDialog(
                                      favoritesScreen: true,
                                      onFavorites: () async {
                                        Get.back();
                                        controller
                                            .favoriteSongListModel
                                            .value
                                            ?.data?[index]
                                            .favouritesStatus = await Get.find<
                                                HomeController>()
                                            .addRemoveFavourites(
                                                menuId: controller
                                                        .favoriteSongListModel
                                                        .value
                                                        ?.data?[index]
                                                        .menuId ??
                                                    0,
                                                songId: controller
                                                        .favoriteSongListModel
                                                        .value
                                                        ?.data?[index]
                                                        .songId ??
                                                    0);

                                        controller
                                            .favoriteSongListModel.value?.data
                                            ?.removeWhere((element) =>
                                                element.favouritesStatus ==
                                                false);
                                      },
                                      onPlaylist: () {
                                        Get.back();
                                        Get.dialog(AddPlaylistDialog(
                                          menuId: controller
                                                  .favoriteSongListModel
                                                  .value
                                                  ?.data?[index]
                                                  .menuId ??
                                              0,
                                          songId: controller
                                                  .favoriteSongListModel
                                                  .value
                                                  ?.data?[index]
                                                  .songId ??
                                              0,
                                        ));
                                      },
                                    ));
                                  },
                                  onTap: () async {
                                    await controller.playSong(
                                        assests: controller
                                                .favoriteSongListModel
                                                .value
                                                ?.data as List<AssestsSong> ??
                                            [],
                                        index: index);
                                    Navigator.push(context, PageRouteBuilder(
                                        pageBuilder: (_, __, ___) {
                                      return SongPlayScreen(
                                        menuId: controller.favoriteSongListModel
                                                .value?.data?[index].menuId ??
                                            0,
                                        songId: controller.favoriteSongListModel
                                                .value?.data?[index].songId ??
                                            0,
                                        // index: index ?? 0,
                                        // assests: assests,
                                      );
                                    }));
                                  },
                                  imageUrl: controller.favoriteSongListModel
                                          .value?.data?[index].songImage ??
                                      '',
                                  title: controller.favoriteSongListModel.value
                                          ?.data?[index].songName ??
                                      '',
                                  subTitle: controller.favoriteSongListModel
                                          .value?.data?[index].songArtist ??
                                      '');
                            }),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          AppConst.currentTabIndex = 0;
                          Get.find<BaseController>().update();
                        },
                        child: SizedBox(
                          height: 140.h,
                          width: 250.w,
                          child: Image.asset(
                            AppAssets.addToFavoritesButton,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  ],
                );
              }),
        ),
        Obx(() =>
            Visibility(visible: controller.loader.value, child: AppLoder()))
      ],
    );
  }
}
