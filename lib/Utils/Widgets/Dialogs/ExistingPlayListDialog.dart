import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class ExistingPlayListDialog extends StatelessWidget {
  final int menuId;
  final int songId;

  const ExistingPlayListDialog({
    super.key,
    required this.menuId,
    required this.songId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.black,
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      title: const Center(
        child: AppTextWidget(
          txtTitle: 'Choose Playlist',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          txtColor: AppColors.white,
        ),
      ),
      content: Container(
        // height: MediaQuery.sizeOf(context).height,
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxHeight: 400.h,
        ),
        child: GetBuilder<PlayListController>(
            init: Get.find<PlayListController>(),
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                        itemCount: Get.find<PlayListController>()
                                .playListModel
                                .value
                                ?.data
                                ?.length ??
                            1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              AppButtonWidget(
                                onPressed: () {
                                  Get.find<PlayListController>()
                                      .addSongToPlaylist(
                                          menuId: menuId,
                                          songId: songId,
                                          playlistId:
                                              Get.find<PlayListController>()
                                                      .playListModel
                                                      .value
                                                      ?.data?[index]
                                                      .playlistId ??
                                                  0);
                                },
                                width: double.maxFinite,
                                btnColor: AppColors.black,
                                btnName: Get.find<PlayListController>()
                                        .playListModel
                                        .value
                                        ?.data?[index]
                                        .playlistName ??
                                    '',
                              ),
                              if (Get.find<PlayListController>()
                                      .playListModel
                                      .value!
                                      .data
                                      ?.length !=
                                  index + 1)
                                Divider()
                            ],
                          );
                        }),
                  )
                ],
              );
            }),
      ),
      actions: [
        AppButtonWidget(
          onPressed: () {
            Get.back();
          },
          btnName: 'Cancel',
          btnColor: AppColors.appButton,
          width: double.maxFinite,
        )
      ],
    );
  }
}
