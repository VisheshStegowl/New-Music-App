import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/SocialMediaWebView.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/Widgets/SocialMdeisAppContainer.dart';

class SocialMediaScreen extends GetView<MenuPageController> {
  const SocialMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppNavigationBar(defaultAppBar: AppBar()),
      body: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            maxHeight: MediaQuery.of(context).size.height),
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppAssets.blackBackgroundScreen,
                ),
                fit: BoxFit.cover)),
        child: GetBuilder<MenuPageController>(initState: (state) {
          controller.socialMediaApi();
        }, builder: (controller) {
          return Column(
            children: [
              const TitleBackButtonWidget(title: "Social and Booking"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const BannerWidget(),
                      SocialMediaContainer(
                        icons: AppAssets.instagram,
                        title: "Instagram",
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      SocialMediaWebView(
                                          url: controller.socialMediaModel.value
                                                  ?.data?[0].instagramLink ??
                                              "",
                                          title: "Instagram")));
                        },
                      ),
                      20.verticalSpace,
                      SocialMediaContainer(
                        icons: AppAssets.twitter,
                        title: "Twitter",
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      SocialMediaWebView(
                                          url: controller.socialMediaModel.value
                                                  ?.data?[0].twitterLink ??
                                              "",
                                          title: "Twitter")));
                        },
                      ),
                      20.verticalSpace,
                      SocialMediaContainer(
                        icons: AppAssets.facebook,
                        title: "Facebook",
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      SocialMediaWebView(
                                          url: controller.socialMediaModel.value
                                                  ?.data?[0].facebookLink ??
                                              "",
                                          title: "Facebook")));
                        },
                      ),
                      20.verticalSpace,
                      SocialMediaContainer(
                        icons: AppAssets.earth,
                        title: "Other",
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      SocialMediaWebView(
                                          url: controller.socialMediaModel.value
                                                  ?.data?[0].otherLink ??
                                              "",
                                          title: "Others")));
                        },
                      ),
                      20.verticalSpace,
                      AppTextWidget(
                        txtTitle: "-Book Ala Jaza-",
                        txtColor: Colors.red,
                        fontSize: 20,
                      ),
                      25.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: AppTextFormField(
                          hintText: "Enter Your Name",
                          titleText: "Name",
                          hintTextColor: AppColors.textFormFieldTextColor,
                        ),
                      ),
                      25.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: AppTextFormField(
                          hintText: "Enter Email",
                          titleText: "Email",
                          hintTextColor: AppColors.textFormFieldTextColor,
                        ),
                      ),
                      25.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: AppTextFormField(
                          hintText: "Enter Phone",
                          titleText: "Phone",
                          hintTextColor: AppColors.textFormFieldTextColor,
                        ),
                      ),
                      25.verticalSpace,
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: AppTextFormField(
                            hintText: "",
                            titleText: "Comment",
                            titleTextColor: AppColors.white.withOpacity(0.5),
                            maxLine: null,
                            maxLength: null,
                          ),
                        ),
                      ),
                      25.verticalSpace,
                      AppButtonWidget(
                        onPressed: () {
                          controller.bookingApi();
                        },
                        btnName: 'Submit'.toUpperCase(),
                        fontWeight: FontWeight.w800,
                        padding: EdgeInsets.symmetric(
                            horizontal: 45.w, vertical: 10.h),
                        borderRadius: 10,
                        btnColor: AppColors.textFormFieldTextColor,
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}
