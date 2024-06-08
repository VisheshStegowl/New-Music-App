import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart'
    as data;
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';

class DescriptionWidget extends StatefulWidget {
  final String videoDescription;
  final int videoId;
  final String? videoTitle;
  final data.Data? videoData;
  final List<data.Data> datas;

  const DescriptionWidget(
      {super.key,
      required this.videoDescription,
      this.videoTitle,
      this.videoData,
      required this.datas,
      required this.videoId});

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              const AppTextWidget(
                txtTitle: 'Description',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                txtColor: AppColors.white,
              ),
              5.verticalSpace,
              AppTextWidget(
                txtTitle: widget.videoDescription,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                txtColor: AppColors.white,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      widget.videoData?.favouritesStatus =
                          await Get.find<VideoController>()
                              .addRemoveFavoriteVideoApi(
                                  menuId: widget.videoData?.menuId ?? 0,
                                  videoId: widget.videoData?.videosId ?? 0);
                      setState(() {});
                    },
                    child: Icon(
                      widget.videoData?.favouritesStatus ?? false
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.videoData?.favouritesStatus ?? false
                          ? AppColors.appButton
                          : AppColors.white,
                      size: 29.r,
                    ),
                  ),
                  5.horizontalSpace,
                  const AppTextWidget(
                    txtTitle: 'Favorites',
                    txtColor: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              10.verticalSpace,
              const AppTextWidget(
                txtTitle: 'Suggested Videos',
                txtColor: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              if (widget.datas.length > 1)
                Expanded(
                  child: Container(
                    height: 300.h,
                    child: GridView.builder(
                      itemCount: widget.datas.length > 1
                          ? (widget.datas.length - 1)
                          : 1,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 15.h,
                        crossAxisSpacing: 15.w,
                        // crossAxisCount: 2,
                        maxCrossAxisExtent: 800.w,
                      ),
                      itemBuilder: (context, index) {
                        List<data.Data> videoData = [];
                        videoData.addAll(widget.datas);
                        videoData.removeWhere(
                            (element) => element.videosId == widget.videoId);

                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                PageRouteBuilder(pageBuilder: (_, __, ___) {
                              return VideoWatchScreen(
                                videoDescp:
                                    videoData[index].videosDescription ?? '',
                                videoTitle: videoData[index].videosName ?? '',
                                videoUrl: videoData[index].videosLink ?? '',
                                datas: widget.datas,
                                videoData: videoData[index],
                                videosId: videoData[index].videosId ?? 0,
                              );
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r)),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              children: [
                                CachedNetworkImageWidget(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  image: videoData[index].videosImage ?? '',
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.only(
                                    bottom: 15.h,
                                  ),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          stops: [0.6, 0.75, 0.8],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.transparent,
                                            AppColors.black.withOpacity(0.75),
                                            AppColors.black.withOpacity(0.89)
                                          ])),
                                  child: AppTextWidget(
                                    txtTitle: videoData[index].videosName ?? '',
                                    txtColor: AppColors.error,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              else
                const Flexible(
                  child: Center(
                    child: AppTextWidget(
                      txtTitle: 'No Data Found !!',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      txtColor: AppColors.white,
                    ),
                  ),
                ),
              20.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
