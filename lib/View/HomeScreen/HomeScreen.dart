import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/View/HomeScreen/CategoryViewList.dart';
import 'package:new_music_app/View/HomeScreen/SongViewList.dart';
import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';
import 'package:new_music_app/View/HomeScreen/Widget/SongsGridView.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.blackBackgroundScreen,
                    ),
                    fit: BoxFit.cover)),
            child: GetBuilder<HomeController>(
                init: controller,
                initState: (state) {
                  controller.scrollController = ScrollController()
                    ..addListener(controller.scrollListener);
                },
                builder: (controller) {
                  return SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        const BannerWidget(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.homeData.value?.data?.length ?? 1,
                          itemBuilder: (context, index) {
                            if (controller.homeData.value?.data?.length != 0) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SongsGridView(
                                    titleOnTap: () {
                                      AppConst.liveVideoUrl.value = false;
                                      if (controller.homeData.value
                                              ?.data?[index].type ==
                                          "Music") {
                                        Get.find<AdService>().bannerAds = [];
                                        Navigator.push(context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) {
                                          return SongViewList(
                                            assestsDataIndex: index,
                                            title: controller.homeData.value
                                                    ?.data?[index].name ??
                                                '',
                                            assests: controller.homeData.value
                                                ?.data?[index].assests,
                                          );
                                        }));
                                      } else {
                                        controller.getCategoryList(
                                          context: context,
                                          id: controller.homeData.value
                                                  ?.data?[index].categoryId ??
                                              0,
                                        );
                                        // Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___){return CategoryViewList()}));
                                      }
                                    },
                                    title: controller.homeData.value
                                            ?.data?[index].name ??
                                        '',
                                    itemCount: controller.homeData.value
                                        ?.data?[index].assests?.length,
                                    type: controller
                                        .homeData.value?.data?[index].type,
                                    items: controller
                                        .homeData.value?.data?[index].assests,
                                  ),
                                ],
                              );
                            } else {
                              return const Column(
                                children: [AppLoder()],
                              );
                            }
                          },
                        )
                      ],
                    ),
                  );
                })),
        Obx(() => Visibility(
            visible: controller.loader.value, child: const AppLoder()))
      ],
    );
  }
}
