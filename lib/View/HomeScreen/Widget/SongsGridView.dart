import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';

class SongsGridView extends StatelessWidget {
  final EdgeInsets? titlePadding;
  final String title;
  final Function()? titleOnTap;
  final Function()? songOnTap;
  final int? itemCount;
  final List? items;

  const SongsGridView(
      {super.key,
      this.titlePadding,
      required this.title,
      this.titleOnTap,
      this.itemCount,
      this.items,
      this.songOnTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  txtTitle: title,
                  txtColor: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                InkWell(
                  onTap: titleOnTap ?? () {},
                  child: const AppTextWidget(
                    fontSize: 14,
                    txtTitle: "View All",
                    fontWeight: FontWeight.w600,
                    txtColor: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Flexible(
            child: Container(
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints(maxHeight: 190.h, minHeight: 160.h),
                child: GridView.builder(
                    itemCount: itemCount != 0 ? itemCount : 1,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      // mainAxisExtent: 100.w,
                      maxCrossAxisExtent: 500.w,
                      childAspectRatio: 1.3,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (itemCount != 0) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: songOnTap ??
                                  () {
                                    AppConst.liveVideoUrl.value = false;
                                    Get.find<HomeController>().playSong(
                                        assests:
                                            items as List<AssestsSong> ?? [],
                                        index: index);
                                    Navigator.push(context, PageRouteBuilder(
                                        pageBuilder: (_, __, ___) {
                                      return SongPlayScreen(
                                        menuId: items?[index].menuId ?? 0,
                                        songId: items?[index].songId ?? 0,
                                        // index: index ?? 0,
                                        // assests: items as List<AssestsSong>,
                                      );
                                    }));
                                  },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 120.h,
                                    width: 120.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.grey,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: CachedNetworkImageWidget(
                                      fit: BoxFit.cover,
                                      image:
                                          "${items?[index].songImage ?? items?[index].categoryImage}",
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      (Get.find<HomeController>()
                                                  .audioPlayer
                                                  .current
                                                  .hasValue &&
                                              items?[index].songName ==
                                                  Get.find<HomeController>()
                                                      .audioPlayer
                                                      .current
                                                      .value
                                                      ?.audio
                                                      .audio
                                                      .metas
                                                      .title)
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 30.r,
                                      color: AppColors.appButton,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            3.verticalSpace,
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: AppTextWidget(
                                  fontSize: 12,
                                  maxLine: 2,
                                  txtTitle: items?[index].songName ??
                                      items?[index].categoryName ??
                                      '',
                                  txtColor: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            3.verticalSpace,
                            Flexible(
                              child: Container(
                                width: 130,
                                child: AppTextWidget(
                                  fontSize: 11,
                                  maxLine: 2,
                                  txtTitle: items?[index].songArtist ?? '',
                                  txtColor: AppColors.error,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            3.verticalSpace
                          ],
                        );
                      } else {
                        return const Center(
                          child: AppTextWidget(
                            txtTitle: "No Data Found !",
                            txtColor: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                    })),
          )
        ],
      ),
    );
  }
}
