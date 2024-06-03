import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SelectImageDialog.dart';

class MyProfileScreen extends GetView<MenuPageController> {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            backgroundColor: AppColors.black,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 25.r,
                color: AppColors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(double.maxFinite, 0),
              child: Divider(
                color: AppColors.appButton,
              ),
            ),
            centerTitle: false,
            title: const AppTextWidget(
              txtTitle: "Account settings",
              fontSize: 18,
              txtColor: AppColors.white,
            ),
          ),
          body: GetBuilder<MenuPageController>(
              init: controller,
              builder: (controller) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      20.verticalSpace,
                      Stack(
                        children: [
                          Obx(() => CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                maxRadius: 70.h,
                                backgroundImage: Get.find<BaseController>()
                                            .imageUrl
                                            .value ==
                                        ''
                                    ? AssetImage(AppAssets.alajazaLogo)
                                    : NetworkImage(Get.find<BaseController>()
                                        .imageUrl
                                        .value) as ImageProvider,
                                // : AssetImage(AppAssets.alajazaLogo),
                                // width: 200.w,
                                // padding: EdgeInsets.symmetric(horizontal: 10.w),
                                // child: controller.imageUrl.value == ''
                                //     ? Image.asset(
                                //         AppAssets.alajazaLogo,
                                //         width: 150.w,
                                //       )
                                //     : CachedNetworkImageWidget(
                                //         image: controller.imageUrl.value,
                                //       ),
                              )),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                Get.dialog(UploadImageDialog()

                                    // UploadImageDialog()
                                    );
                              },
                              child: Icon(
                                Icons.edit,
                                size: 40.r,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      AppTextFormField(
                        hintText: "enter name",
                        titleText: "NAME",
                        controller: controller.nameController,
                      ),
                      10.verticalSpace,
                      AppTextFormField(
                        hintText: "enter user name",
                        titleText: "USERNAME",
                        controller: controller.userNameController,
                      ),
                      10.verticalSpace,
                      AppTextFormField(
                        controller: controller.emailController,
                        hintText: "",
                        titleText: "EMAIL",
                        readOnly: true,
                      ),
                      10.verticalSpace,
                      AppTextFormField(
                          controller: controller.phoneController,
                          hintText: "enter your phone number",
                          titleText: "PHONE NUMBER"),
                      25.verticalSpace,
                      AppButtonWidget(
                        onPressed: () {},
                        btnName: "Save",
                        width: double.maxFinite,
                        borderRadius: 15,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        btnColor: AppColors.textFormFieldTextColor,
                      ),
                      10.verticalSpace,
                      AppButtonWidget(
                        onPressed: () {
                          Get.toNamed(RoutesName.changePasswordScreen);
                        },
                        width: double.maxFinite,
                        borderRadius: 15,
                        btnName: "CHANGE PASSWORD",
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        margin: EdgeInsets.symmetric(horizontal: 20.h),
                        btnColor: AppColors.textFormFieldTextColor,
                      ),
                      5.verticalSpace,
                    ],
                  ),
                );
              }),
        ),
        Obx(() =>
            Visibility(visible: controller.pageLoder.value, child: AppLoder()))
      ],
    ));
  }
}
