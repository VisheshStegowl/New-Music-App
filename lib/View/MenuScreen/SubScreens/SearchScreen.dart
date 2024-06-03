import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppSearchField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/Widgets/SearchAlbumTab.dart';
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart'
    as data;

class SearchScreen extends GetView<MenuPageController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppNavigationBar(
              defaultAppBar: AppBar(),
            ),
            body: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        AppAssets.blackBackgroundScreen,
                      ),
                      fit: BoxFit.cover)),
              child: DefaultTabController(
                length: 3,
                child: GetBuilder<MenuPageController>(
                    init: controller,
                    builder: (controller) {
                      return Column(
                        children: [
                          const TitleBackButtonWidget(title: 'Search'),
                          5.verticalSpace,
                          AppSearchField(
                            onSearch: () async {
                              controller.showLoader(true);
                              await controller.songSearchApi();
                              await controller.albumSearchApi();
                              await controller.videoSearchApi();
                              controller.showLoader(false);
                            },
                            controller: controller.globalSearchController,
                            hintFontSize: 16,
                          ),
                          5.verticalSpace,
                          const Divider(
                            color: AppColors.error,
                          ),
                          InkWell(
                            onTap: () {
                              controller.searchSongResult.value?.data?.clear();
                              controller.globalSearchController.clear();
                              controller.update();
                            },
                            child: const Center(
                                child: AppTextWidget(
                              txtTitle: 'Clear Result',
                              txtColor: AppColors.error,
                            )),
                          ),
                          const Divider(
                            color: AppColors.error,
                          ),
                          if ((controller.searchSongResult.value?.data
                                      ?.isNotEmpty ??
                                  false) ||
                              (controller.searchVideoResult.value?.data
                                      ?.isNotEmpty ??
                                  false) ||
                              (controller.searchAlbumResult.value?.data
                                      ?.isNotEmpty ??
                                  false))
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: AppColors.textFormFieldTextColor,
                                  borderRadius: BorderRadius.circular(18.r)),
                              child: TabBar(
                                dividerColor: AppColors.transparent,
                                indicatorWeight: 0,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                    color: AppColors.appButton,
                                    borderRadius: BorderRadius.circular(18.r),
                                    border:
                                        Border.all(color: AppColors.appButton)),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                tabs: [
                                  Tab(
                                    text: "Songs",
                                  ),
                                  Tab(
                                    text: "Album",
                                  ),
                                  Tab(
                                    text: "Videos",
                                  )
                                ],
                              ),
                            ),
                          if (controller
                                  .searchSongResult.value?.data?.isNotEmpty ??
                              false)
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        20.verticalSpace,
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: controller.searchSongResult
                                                  .value?.data?.length ??
                                              0,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return SongListWidget(
                                              gifWidget: Get.find<
                                                          HomeController>()
                                                      .audioPlayer
                                                      .current
                                                      .hasValue &&
                                                  controller
                                                          .searchSongResult
                                                          .value
                                                          ?.data?[index]
                                                          .songName ==
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
                                                  onFavorites: () {
                                                    Get.find<HomeController>()
                                                        .addRemoveFavourites(
                                                            menuId: controller
                                                                    .searchSongResult
                                                                    .value
                                                                    ?.data?[
                                                                        index]
                                                                    .menuId ??
                                                                0,
                                                            songId: controller
                                                                    .searchSongResult
                                                                    .value
                                                                    ?.data?[
                                                                        index]
                                                                    .songId ??
                                                                0);
                                                    Get.back();
                                                  },
                                                  onPlaylist: () {
                                                    Get.back();
                                                    Get.dialog(
                                                        AddPlaylistDialog(
                                                      menuId: controller
                                                              .searchSongResult
                                                              .value
                                                              ?.data?[index]
                                                              .menuId ??
                                                          0,
                                                      songId: controller
                                                              .searchSongResult
                                                              .value
                                                              ?.data?[index]
                                                              .songId ??
                                                          0,
                                                    ));
                                                  },
                                                ));
                                              },
                                              onTap: () async {
                                                await Get.find<HomeController>()
                                                    .playSong(
                                                        assests: controller
                                                                .searchSongResult
                                                                .value
                                                                ?.data ??
                                                            [],
                                                        index: index);
                                                Navigator.push(context,
                                                    PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) {
                                                  return SongPlayScreen(
                                                    menuId: controller
                                                            .searchSongResult
                                                            .value
                                                            ?.data?[index]
                                                            .menuId ??
                                                        0,
                                                    songId: controller
                                                            .searchSongResult
                                                            .value
                                                            ?.data?[index]
                                                            .songId ??
                                                        0,
                                                    // index: index ?? 0,
                                                    // assests: assests,
                                                  );
                                                }));
                                              },
                                              imageUrl: controller
                                                      .searchSongResult
                                                      .value
                                                      ?.data?[index]
                                                      .songImage ??
                                                  controller
                                                      .searchSongResult
                                                      .value
                                                      ?.data?[index]
                                                      .categoryImage ??
                                                  '',
                                              title: controller
                                                      .searchSongResult
                                                      .value
                                                      ?.data?[index]
                                                      .songName ??
                                                  controller
                                                      .searchSongResult
                                                      .value
                                                      ?.data?[index]
                                                      .categoryName ??
                                                  '',
                                              subTitle: controller
                                                      .searchSongResult
                                                      .value
                                                      ?.data?[index]
                                                      .songArtist ??
                                                  '',
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SearchAlbumTab(),
                                  SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        GridView.builder(
                                          itemCount: controller
                                                  .searchVideoResult
                                                  .value
                                                  ?.data
                                                  ?.length ??
                                              0,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 10.h),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 0.7,
                                            mainAxisSpacing: 15.h,
                                            crossAxisSpacing: 15.w,
                                            crossAxisCount: 2,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            print(controller.searchVideoResult
                                                .value?.data?.length);
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) {
                                                  return VideoWatchScreen(
                                                    videosId: controller
                                                            .searchVideoResult
                                                            .value
                                                            ?.data?[index]
                                                            .videosId ??
                                                        0,
                                                    datas: controller
                                                                .searchVideoResult
                                                                .value
                                                                ?.data
                                                            as List<
                                                                data.Data> ??
                                                        [],
                                                    videoUrl: controller
                                                            .searchVideoResult
                                                            .value
                                                            ?.data?[index]
                                                            .videosLink ??
                                                        '',
                                                    videoDescp: controller
                                                        .searchVideoResult
                                                        .value
                                                        ?.data?[index]
                                                        .videosDescription,
                                                    videoTitle: controller
                                                        .searchVideoResult
                                                        .value
                                                        ?.data?[index]
                                                        .videosName,
                                                    videoData: controller
                                                            .searchVideoResult
                                                            .value
                                                            ?.data?[index]
                                                        as data.Data,
                                                  );
                                                }));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                clipBehavior: Clip.hardEdge,
                                                child: Stack(
                                                  children: [
                                                    CachedNetworkImageWidget(
                                                      width: double.maxFinite,
                                                      height: double.maxFinite,
                                                      image: controller
                                                              .searchVideoResult
                                                              .value
                                                              ?.data?[index]
                                                              .videosImage ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      padding: EdgeInsets.only(
                                                        bottom: 15.h,
                                                      ),
                                                      width: double.maxFinite,
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  stops: [
                                                                    0.6,
                                                                    0.75,
                                                                    0.8
                                                                  ],
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    AppColors
                                                                        .transparent,
                                                                    AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.75),
                                                                    AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.89)
                                                                  ])),
                                                      child: AppTextWidget(
                                                        txtTitle: controller
                                                                .searchVideoResult
                                                                .value
                                                                ?.data?[index]
                                                                .videosName ??
                                                            '',
                                                        txtColor:
                                                            AppColors.error,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      );
                    }),
              ),
            ),
          ),
          Obx(() =>
              Visibility(visible: controller.loader.value, child: AppLoder()))
        ],
      ),
    );
  }
}
