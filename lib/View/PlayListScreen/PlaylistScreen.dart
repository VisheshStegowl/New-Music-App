import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationScreen.dart';
import 'package:new_music_app/Utils/Widgets/AppSearchField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';
import 'package:new_music_app/View/PlayListScreen/PlayListSongScreen.dart';

import '../../Utils/Widgets/SongListWidget.dart';

class PlayListScreen extends GetView<PlayListController> {
  PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final TextEditingController controller = TextEditingController();
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppAssets.blackBackgroundScreen,
              ),
              fit: BoxFit.cover)),
      child: GetBuilder<PlayListController>(initState: (state) {
        controller.getPlayList();
      }, builder: (controller) {
        return Column(
          children: [
            const BannerWidget(),
            10.verticalSpace,
            AppSearchField(
              onChanged: (String value) {
                controller.searchPlaylist(controller.playListController.text);
              },
              controller: controller.playListController,
              onSearch: () {
                controller.searchPlaylist(controller.playListController.text);
              },
            ),
            30.verticalSpace,
            controller.playListModel.value?.data?.isNotEmpty ?? false
                ? ListView.builder(
                    itemCount:
                        controller.playListModel.value?.data?.length ?? 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SongListWidget(
                          onTap: () async {
                            // await controller.playListSongApi(controller
                            //         .playListModel
                            //         .value
                            //         ?.data?[index]
                            //         .playlistId ??
                            //     0);
                            AppConst.liveVideoUrl.value = false;
                            // controller.showLoader(true);
                            // Future.delayed(const Duration(seconds: 10));
                            // controller.showLoader(false);

                            // if (controller.playListSongModel.value?.data
                            //         ?.isNotEmpty ??
                            //     false) {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        PlayListSongScreen(
                                          playlistId: controller
                                                  .playListModel
                                                  .value
                                                  ?.data?[index]
                                                  .playlistId ??
                                              0,
                                        )));
                            print("object");
                            // }
                          },
                          onDelete: () {
                            Get.dialog(AlertDialog.adaptive(
                              backgroundColor: AppColors.black,
                              content: AppTextWidget(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                txtColor: AppColors.appButton,
                                txtTitle:
                                    'Are you sure you want to delete this playlist?',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AppButtonWidget(
                                        width: 100.w,
                                        btnColor: AppColors.appButton,
                                        onPressed: () {
                                          controller.deletePlayList(controller
                                                  .playListModel
                                                  .value
                                                  ?.data?[index]
                                                  .playlistId ??
                                              0);
                                        },
                                        btnName: "Yes"),
                                    AppButtonWidget(
                                        width: 100.w,
                                        btnColor: AppColors.appButton,
                                        onPressed: () {
                                          Get.back();
                                        },
                                        btnName: "No")
                                  ],
                                )
                              ],
                            ));
                            // controller.deletePlayList(controller.playListModel
                            //         .value?.data?[index].playlistId ??
                            //     0);
                          },
                          isPlayList: true,
                          imageUrl: "",
                          title: controller.playListModel.value?.data?[index]
                                  .playlistName ??
                              "",
                          subTitle: '');
                    })
                : InkWell(
                    onTap: () {
                      AppConst.currentTabIndex = 0;
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilder(
                      //         pageBuilder: (_, __, ___) =>
                      //             AppNavigationScreen()));

                      Get.find<BaseController>().update();
                    },
                    child: SizedBox(
                      height: 140,
                      width: 250,
                      child: Image.asset(
                        AppAssets.addToFavoritesButton,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
          ],
        );
      }),
    );
  }
}
