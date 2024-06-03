import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/LiveVideoController.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationScreen.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/LiveVideoWidget.dart';
import 'package:new_music_app/Utils/Widgets/TestVideo.dart';
import 'package:new_music_app/Utils/Widgets/VideoPlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class LiveVideoScreen extends GetView<LiveVideoController> {
  const LiveVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leadingWidth: 80.w,
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.h),
          child: const Divider(
            color: AppColors.appButton,
          ),
        ),
        leading: InkWell(
          onTap: () {
            AppConst.currentTabIndex = 0;
            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
              return const AppNavigationScreen();
            })).then((value) => null);
          },
          child: Row(
            children: [
              10.horizontalSpace,
              Icon(
                Icons.arrow_back_ios,
                size: 20.r,
                color: AppColors.white,
              ),
              const AppTextWidget(
                txtTitle: "Back",
                fontSize: 14,
                fontWeight: FontWeight.w800,
                txtColor: AppColors.white,
              )
            ],
          ),
        ),
        centerTitle: true,
        title: const AppTextWidget(
          txtTitle: '#ALAJAZAMUSICTV',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          txtColor: AppColors.white,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(AppAssets.liveIcon, width: 50.w, height: 25.h),
          )
        ],
      ),
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppAssets.blackBackgroundScreen,
                ),
                fit: BoxFit.cover)),
        child: GetBuilder<LiveVideoController>(
            init: controller,
            initState: (state) {},
            builder: (controller) {
              return (controller.liveVideoModel.value?.planstatus == 1)
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 175.h,
                          child: TestViewWidget(
                              // controller:
                              //     Get.find<LiveVideoController>().videoPlayerController,
                              // videoUrl:
                              //     Get.find<LiveVideoController>().liveVideoUrl.value ??
                              // ""
                              ),

                          //     VideoPlayerWidget(
                          //   isLive: true,
                          //   videoUrl:
                          //       // "https://cloudflare.streamgato.us:3901/live/somostopopointtvlive.m3u8" ??
                          //       Get.find<LiveVideoController>().liveVideoUrl.value,
                          // )
                        ),
                        const Divider(),
                        GetBuilder<LiveVideoController>(
                            init: controller,
                            builder: (controller) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.likeLiveVideo();
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.likeIcon,
                                            color: controller
                                                        .liveVideoModel
                                                        .value
                                                        ?.data?[0]
                                                        .favouritesStatus ??
                                                    false
                                                ? AppColors.appButton
                                                : AppColors.white,
                                            height: 25.h,
                                            width: 25.h,
                                          ),
                                          10.horizontalSpace,
                                          AppTextWidget(
                                            txtTitle: controller
                                                    .liveVideoModel
                                                    .value
                                                    ?.data?[0]
                                                    .videoLikeCount
                                                    .toString() ??
                                                '0',
                                            txtColor: AppColors
                                                .textFormFieldTextColor,
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.shareUrl(controller
                                              .liveVideoModel
                                              .value
                                              ?.data?[0]
                                              .videosLink ??
                                          '');
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.shareIcon,
                                            height: 25.h,
                                            width: 25.h,
                                          ),
                                          10.horizontalSpace,
                                          const AppTextWidget(
                                            fontSize: 16,
                                            txtTitle: 'Share',
                                            txtColor: AppColors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                        const Divider(),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 100.h,
                          child: CarouselSlider.builder(
                              itemCount: controller
                                      .sponsorBannerData.value?.data?.length ??
                                  1,
                              options: CarouselOptions(
                                initialPage: 0,
                                padEnds: false,
                                enlargeCenterPage: false,
                                viewportFraction: 1.2,
                                // autoPlayInterval: const Duration(seconds: 3),
                                autoPlay: true,
                              ),
                              itemBuilder: (context, index, realIndex) =>
                                  InkWell(
                                    onTap: () {
                                      controller.shareBanner(
                                          url: controller.sponsorBannerData
                                                  .value?.data?[index].link ??
                                              '');
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImageWidget(
                                        height: 80.h,
                                        width: MediaQuery.sizeOf(context).width,
                                        fit: BoxFit.cover,
                                        image:
                                            "${controller.sponsorBannerData.value?.data?[index].image ?? ''}",
                                      ),
                                    ),
                                  )),
                        ),
                        GetBuilder<LiveVideoController>(
                            init: controller,
                            initState: (state) {
                              Future.delayed(Duration(milliseconds: 1100), () {
                                controller.scrollController.jumpTo(controller
                                        .scrollController
                                        .position
                                        .maxScrollExtent ??
                                    0);
                                controller.update();
                              });
                            },
                            builder: (controller) {
                              return Flexible(
                                child: FirebaseAnimatedList(
                                  controller: controller.scrollController,
                                  key: const ValueKey<bool>(false),
                                  query: controller.messagesRef,
                                  shrinkWrap: false,
                                  reverse: false,
                                  itemBuilder: (BuildContext context,
                                      DataSnapshot snapshot,
                                      Animation<double> animation,
                                      int index) {
                                    if (snapshot.value == null) {
                                      return Container(
                                        child: const AppTextWidget(
                                          txtTitle: 'No Chat Found !!',
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: [
                                        ListTile(
                                          trailing: (snapshot.value
                                                          as Map)['type']
                                                      .toString()
                                                      .toLowerCase() !=
                                                  'user'
                                              ? Container(
                                                  height: 170.h,
                                                  width: 90.w,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 30.h,
                                                        width: 40.h,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child:
                                                            CachedNetworkImageWidget(
                                                          image: (snapshot.value
                                                                      as Map)[
                                                                  'commentImageURL']
                                                              .toString(),
                                                          height: 30.h,
                                                          width: 30.h,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 4,
                                                        child: AppTextWidget(
                                                            maxLine: 2,
                                                            txtTitle: (snapshot
                                                                            .value
                                                                        as Map)[
                                                                    'commentByName']
                                                                .toString(),
                                                            txtColor: AppColors
                                                                .appButton,
                                                            textAlign: TextAlign
                                                                .center),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .arrow_back_ios_outlined,
                                                      color: AppColors.white,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      (snapshot.value
                                                              as Map)['time']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                          leading: (snapshot.value
                                                          as Map)['type']
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'user'
                                              ? Container(
                                                  height: 90.h,
                                                  width: 50.w,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 30.h,
                                                        width: 30.h,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: (snapshot.value
                                                                            as Map)[
                                                                        'commentImageURL']
                                                                    .toString() !=
                                                                ''
                                                            ? CachedNetworkImageWidget(
                                                                image: (snapshot
                                                                            .value
                                                                        as Map)['commentImageURL']
                                                                    .toString(),
                                                                height: 30.h,
                                                                width: 30.h,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              )
                                                            : Image.asset(
                                                                AppAssets
                                                                    .alajazaLogo),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        child: AppTextWidget(
                                                            txtTitle: (snapshot
                                                                            .value
                                                                        as Map)[
                                                                    'commentByName']
                                                                .toString(),
                                                            txtColor: AppColors
                                                                .appButton,
                                                            textAlign: TextAlign
                                                                .center),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      (snapshot.value
                                                              as Map)['time']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 12),
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      color: AppColors.white,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              (snapshot.value as Map)['type']
                                                          .toString()
                                                          .toLowerCase() !=
                                                      'user'
                                                  ? Flexible(
                                                      flex: 3,
                                                      child: Text(
                                                        (snapshot.value as Map)[
                                                                'comment']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    )
                                                  : const Spacer(),
                                              (snapshot.value as Map)['type']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      'user'
                                                  ? Flexible(
                                                      flex: 3,
                                                      child: Text(
                                                        (snapshot.value as Map)[
                                                                'comment']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    )
                                                  : const Spacer(),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                        )
                                      ],
                                    );
                                    // }
                                    // return receiveCell(context, snapshot);
                                  },
                                ),
                              );
                            }),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(18.sp)),
                                  child: TextFormField(
                                    controller:
                                        controller.postMessageController,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        hintText: 'post a message',
                                        suffixIcon: AppButtonWidget(
                                          borderRadius: 14.sp,
                                          btnColor: AppColors.appButton,
                                          width: 70.w,
                                          onPressed: () {
                                            controller.sendMessage(context);
                                          },
                                          btnName: 'Post',
                                        )),
                                  )),
                            )),
                        20.verticalSpace,
                      ],
                    )
                  : UserPreference.getValue(key: PrefKeys.email) != null
                      ? AlertDialog.adaptive(
                          elevation: 10,
                          surfaceTintColor: AppColors.white,
                          backgroundColor: AppColors.black,
                          content: AppTextWidget(
                            txtTitle:
                                'Welcome to Ala Jaza Live Stream. Please Subscribe to watch our Live Stream',
                            txtColor: AppColors.appButton,
                            fontWeight: FontWeight.w500,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            AppButtonWidget(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 10.h),
                              onPressed: () {
                                if (UserPreference.getValue(
                                        key: PrefKeys.userId) !=
                                    null) {
                                  launchUrl(Uri.parse(
                                      "https://alajazamusic.com/alajazamusicadmin/payment/${UserPreference.getValue(key: PrefKeys.userId)}"));
                                }
                              },
                              btnName: "Get Your Plan",
                              btnColor: AppColors.appButton,
                            )
                          ],
                        )
                      : AlertDialog.adaptive(
                          elevation: 10,
                          surfaceTintColor: AppColors.white,
                          backgroundColor: AppColors.black,
                          content: const AppTextWidget(
                            txtColor: AppColors.appButton,
                            fontWeight: FontWeight.w500,
                            txtTitle: 'Please Login and subscribe to plan',
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            AppButtonWidget(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.w, vertical: 10.h),
                                onPressed: () {
                                  Get.toNamed(RoutesName.loginScreen);
                                },
                                btnColor: AppColors.appButton,
                                btnName: "Login")
                          ],
                        );
            }),
      ),
    );
  }
}
