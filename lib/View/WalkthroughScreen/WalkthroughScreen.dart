import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/AuthController.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';

class WalkthroughScreen extends GetView<AuthController> {
  const WalkthroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthController>(
            init: controller..walkthroughApi(),
            builder: (controller) {
              return controller.walkthroughDataModel?.appData?.isNotEmpty ??
                      false
                  ? Stack(
                      children: [
                        Container(
                          constraints: const BoxConstraints.expand(),
                          width: double.maxFinite,
                          color: AppColors.black,
                          height: MediaQuery.sizeOf(context).height,
                          child: CarouselSlider(
                              carouselController: controller.carouselController,
                              options: CarouselOptions(
                                  onPageChanged: (index, _) {
                                    print(index);
                                    index = controller.pageIndex.value;
                                  },
                                  aspectRatio: 0.4,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1),
                              items: controller.walkthroughDataModel?.appData
                                  ?.map((e) => CachedNetworkImageWidget(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        image: e.appImage,
                                      ))
                                  .toList()

                              // },
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: AppButtonWidget(
                              width: 150.w,
                              onPressed: () {
                                if (controller.walkthroughDataModel?.appData
                                        ?.length ==
                                    controller.pageIndex.value) {
                                  UserPreference.setValue(
                                      key: PrefKeys.firstTime, value: false);
                                  Get.offAllNamed(RoutesName.loginScreen);
                                } else {
                                  controller.carouselController.nextPage();
                                }
                              },
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              btnName: controller.walkthroughDataModel?.appData
                                          ?.length ==
                                      controller.pageIndex.value
                                  ? 'ENTER'
                                  : "NEXT",
                              btnColor: AppColors.appButton,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          top: 10.h,
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(RoutesName.loginScreen);
                            },
                            child: const Row(
                              children: [
                                AppTextWidget(
                                  txtTitle: "SKIP INTRO",
                                  txtColor: AppColors.appButton,
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: AppColors.appButton,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : AppLoder();
            }),
      ),
    );
  }
}
