import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class TitleBackButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const TitleBackButtonWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: InkWell(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.backIcon,
              height: 20.h,
            ),
            10.horizontalSpace,
            AppTextWidget(
              txtTitle: title,
              fontSize: 16,
              txtColor: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
