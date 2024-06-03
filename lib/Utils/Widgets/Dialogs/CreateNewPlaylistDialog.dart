import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/ExistingPlayListDialog.dart';

class CreateNewPlaylistDialog extends StatelessWidget {
  final int menuId;
  final int songId;

  const CreateNewPlaylistDialog(
      {super.key, required this.menuId, required this.songId});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
      backgroundColor: AppColors.black,
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: AppColors.transparent,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.textFormFieldTextColor)),
                  hintText: 'Playlist Name',
                  hintStyle: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                controller:
                    Get.find<PlayListController>().createPlayListController,
                validator: (value) {
                  if (value != null) {
                    return null;
                  } else {
                    return 'Please enter a Playlist Name';
                  }
                },
              ),
            )
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        AppButtonWidget(
            width: 130.w,
            btnColor: AppColors.appButton,
            onPressed: () async {
              if (_key.currentState?.validate() ?? false) {
                await Get.find<PlayListController>().createPlayList();
                await Get.find<PlayListController>().getPlayList();
                Get.dialog(ExistingPlayListDialog(
                  menuId: menuId,
                  songId: songId,
                ));
                // Get.dialog(widget)
              }
            },
            btnName: "Create Playlist"),
        30.verticalSpace,
        AppButtonWidget(
            width: 130.w,
            btnColor: AppColors.appButton,
            onPressed: () {
              Get.back();
            },
            btnName: "Cancel"),
      ],
    );
  }
}
