import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';

class RadioScreen extends GetView<RadioController> {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RadioController>(
        initState: (state) {
          controller.getRadioAudio();
        },
        init: controller,
        builder: (controller) {
          return Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.blackBackgroundScreen,
                    ),
                    fit: BoxFit.cover)),
            child: StreamBuilder(
                stream: controller.audioPlayer.realtimePlayingInfos,
                builder: (context, snapshot) {
                  print(controller.audioPlayer.isPlaying.value);
                  return Column(
                    children: [
                      10.verticalSpace,
                      const AppTextWidget(
                        txtTitle: 'Ala Jaza Live Radio',
                        fontSize: 18,
                        txtColor: AppColors.white,
                      ),
                      10.verticalSpace,
                      Flexible(
                        flex: 5,
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 360.h),
                          padding: EdgeInsets.only(
                            left: 15.h,
                            top: 15.h,
                            right: 15.h,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                              color: AppColors.textFormFieldColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  controller.radioModel.value?.data?[0]
                                              .songImage !=
                                          null
                                      ? CachedNetworkImageWidget(
                                          height: 300.h,
                                          image: controller.radioModel.value
                                                  ?.data?[0].songImage ??
                                              "")
                                      : Container(
                                          height: 300.h, child: AppLoder()),
                                  Positioned(
                                    bottom: 0,
                                    left: 10,
                                    right: 0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AppTextWidget(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                txtTitle: controller
                                                        .radioModel
                                                        .value
                                                        ?.data?[0]
                                                        .songName ??
                                                    '',
                                                txtColor: AppColors.white,
                                              ),
                                              const AppTextWidget(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w800,
                                                  txtColor: AppColors.white,
                                                  txtTitle:
                                                      "POWERED BY:DURISIMO APP STORE"),
                                            ],
                                          ),
                                        ),
                                        50.horizontalSpace,
                                        Icon(
                                          Icons.headphones,
                                          color:
                                              AppColors.textFormFieldTextColor,
                                          size: 35.r,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              5.verticalSpace,
                              Container(
                                height: 20.h,
                                width: double.maxFinite,
                                margin: EdgeInsets.only(
                                    left: 20.w, right: 20.w, bottom: 10.h),
                                // decoration: BoxDecoration(color: AppColors.darkgrey),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2.5,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 0.0),
                                  ),
                                  child: Slider(
                                    value: 0.85,
                                    min: 0.0,
                                    activeColor: AppColors.appButton,
                                    inactiveColor:
                                        AppColors.textFormFieldTextColor,
                                    max: 1,
                                    onChanged: (value) {},
                                    onChangeEnd: (value) {
                                      controller.audioPlayer.seek(Duration(
                                          milliseconds: value.toInt()));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      100.verticalSpace,
                      InkWell(
                        onTap: () async {
                          await controller.audioPlayer.playOrPause();
                          controller.update();
                        },
                        child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                                color: AppColors.white, shape: BoxShape.circle),
                            child: Icon(
                              controller.audioPlayer.isPlaying.value ?? false
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40.r,
                              color: AppColors.black,
                            )),
                      ),
                      const Spacer(
                        flex: 2,
                      )
                    ],
                  );
                }),
          );
        });
  }
}
