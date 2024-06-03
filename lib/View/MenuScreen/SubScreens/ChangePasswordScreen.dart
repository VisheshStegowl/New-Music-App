import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.h),
          child: Divider(
            color: AppColors.appButton,
          ),
        ),
        toolbarHeight: 70.h,
        leadingWidth: 70.w,
        backgroundColor: AppColors.black,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.r,
                color: AppColors.white,
              ),
            ),
            AppTextWidget(
              txtTitle: 'Back',
              txtColor: AppColors.white,
              fontSize: 16,
            )
          ],
        ),
        centerTitle: true,
        title: const AppTextWidget(
          txtTitle: "Change Password",
          fontSize: 18,
          txtColor: AppColors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: Column(
          children: [
            30.verticalSpace,
            Image.asset(
              AppAssets.alajazaLogo,
              width: 300.w,
              height: 100.h,
            ),
            50.verticalSpace,
            AppTextFormField(
              hintText: 'Enter Current Password',
              titleText: "Current Password",
              titleTextColor: AppColors.white.withOpacity(0.6),
              hintTextColor: AppColors.textFormFieldTextColor,
            ),
            30.verticalSpace,
            AppTextFormField(
              textInputAction: TextInputAction.done,
              hintText: "Enter New password",
              titleText: 'NEW PASSWORD',
              titleTextColor: AppColors.white.withOpacity(0.6),
              obscureText: true,
              hintTextColor: AppColors.textFormFieldTextColor,
              suffixWidget: InkWell(
                onTap: () {},
                child: true
                    ? Transform.flip(
                        flipX: true,
                        child: Icon(Icons.visibility_off,
                            size: 35.r,
                            color: AppColors.textFormFieldTextColor),
                      )
                    : Icon(Icons.remove_red_eye,
                        size: 35.r, color: AppColors.textFormFieldTextColor),
              ),
            ),
            30.verticalSpace,
            AppTextFormField(
              textInputAction: TextInputAction.done,
              hintText: "Enter New password",
              titleText: 'NEW PASSWORD',
              titleTextColor: AppColors.white.withOpacity(0.6),
              obscureText: true,
              hintTextColor: AppColors.textFormFieldTextColor,
              suffixWidget: InkWell(
                onTap: () {},
                child: true
                    ? Transform.flip(
                        flipX: true,
                        child: Icon(Icons.visibility_off,
                            size: 35.r,
                            color: AppColors.textFormFieldTextColor),
                      )
                    : Icon(Icons.remove_red_eye,
                        size: 35.r, color: AppColors.textFormFieldTextColor),
              ),
            ),
            60.verticalSpace,
            AppButtonWidget(
              onPressed: () {},
              btnName: "Submit",
              width: double.maxFinite,
              borderRadius: 12,
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              btnColor: AppColors.textFormFieldTextColor,
            ),
          ],
        ),
      ),
    ));
  }
}
