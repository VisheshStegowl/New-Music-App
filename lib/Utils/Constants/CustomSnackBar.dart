import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

import 'package:new_music_app/Utils/Styling/AppColors.dart';

///Custom SnackBar
class Utility {
  static void showSnackBar(String? msg, {bool isError = false}) {
    Get.showSnackbar(
      GetSnackBar(
        maxWidth: 600.w,
        messageText: AppTextWidget(
            txtTitle: msg ?? '',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            maxLine: 3,
            txtColor: AppColors.white),
        borderRadius: 10.r,
        duration: const Duration(milliseconds: 1000),
        margin: EdgeInsets.all(8.r),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Color(isError ? 0xffF72A1E : 0xff5BDF6F),
      ),
    );
  }
}
