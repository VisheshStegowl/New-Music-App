import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AnimatedBottomsheet.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/NoExistingPlayListFoundDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';

class SongViewList extends GetView<HomeController> {
  final String title;
  final int? assestsDataIndex;
  final List<AssestsSong>? assests;

  const SongViewList(
      {super.key, required this.title, this.assests, this.assestsDataIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
          appBar: AppNavigationBar(
            defaultAppBar: AppBar(),
          ),
          bottomNavigationBar: AnimatedBottomSheet(),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.blackBackgroundScreen,
                    ),
                    fit: BoxFit.cover)),
            child: GetBuilder<HomeController>(
                init: controller,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleBackButtonWidget(
                        title: title,
                      ),
                      Expanded(
                        child: assests?.length != 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount:
                                    assests?.length != 0 ? assests?.length : 0,
                                itemBuilder: (context, index) {
                                  if (assests?.length != 0) {
                                    return SongListWidget(
                                      gifWidget: Get.find<HomeController>()
                                              .audioPlayer
                                              .current
                                              .hasValue &&
                                          assests?[index].songName ==
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
                                          onFavorites: () async {
                                            if (assests?[index]
                                                    .favouritesStatus ??
                                                false) {
                                              Get.back();
                                              Utility.showSnackBar(
                                                  "This Song is already in Favorites",
                                                  isError: true);
                                            } else {
                                              Get.back();
                                              assests?[index]
                                                  .favouritesStatus = await Get
                                                      .find<HomeController>()
                                                  .addRemoveFavourites(
                                                      menuId: assests?[index]
                                                              .menuId ??
                                                          0,
                                                      songId: assests?[index]
                                                              .songId ??
                                                          0);
                                            }
                                          },
                                          onPlaylist: () {
                                            Get.back();
                                            Get.dialog(AddPlaylistDialog(
                                              menuId:
                                                  assests?[index].menuId ?? 0,
                                              songId:
                                                  assests?[index].songId ?? 0,
                                            ));
                                          },
                                        ));
                                      },
                                      onTap: () async {
                                        await controller.playSong(
                                            assests: assests ?? [],
                                            index: index);
                                        Navigator.push(context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) {
                                          return SongPlayScreen(
                                            menuId: assests?[index].menuId ?? 0,
                                            songId: assests?[index].songId ?? 0,
                                            // index: index ?? 0,
                                            // assests: assests,
                                          );
                                        }));
                                      },
                                      imageUrl: assests?[index].songImage ??
                                          assests?[index].categoryImage ??
                                          '',
                                      title: assests?[index].songName ??
                                          assests?[index].categoryName ??
                                          '',
                                      subTitle:
                                          assests?[index].songArtist ?? '',
                                    );
                                  } else {
                                    return const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: AppTextWidget(
                                            txtTitle: 'No Data Found !!',
                                            fontSize: 20,
                                            txtColor: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: AppTextWidget(
                                      txtTitle: 'No Data Found !!',
                                      fontSize: 20,
                                      txtColor: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                      )
                    ],
                  );
                }),
          ),
        )),
        Obx(() => Visibility(
            visible: controller.loader.value, child: const AppLoder())),
      ],
    );
  }
}
