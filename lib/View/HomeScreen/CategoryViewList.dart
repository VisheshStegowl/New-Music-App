import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AnimatedBottomsheet.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongViewList.dart';

class CategoryViewList extends GetView<HomeController> {
  const CategoryViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
          appBar: AppNavigationBar(
            defaultAppBar: AppBar(),
          ),
          bottomNavigationBar: AnimatedBottomSheet(),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.blackBackgroundScreen,
                    ),
                    fit: BoxFit.cover)),
            child: GetBuilder<HomeController>(
                init: controller,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleBackButtonWidget(
                        title: controller.viewAllCategoryDataModel?.data?[0]
                                .parentCategoryName ??
                            '',
                      ),
                      Expanded(
                          child: GridView.builder(
                              itemCount: controller
                                  .viewAllCategoryDataModel?.data?.length,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing: 10.w),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await controller.getCategorySongList(
                                        title: controller
                                                .viewAllCategoryDataModel
                                                ?.data?[index]
                                                .categoryName ??
                                            '',
                                        id: controller.viewAllCategoryDataModel
                                                ?.data?[index].categoryId ??
                                            0,
                                        context: context);
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                SongViewList(
                                                  title: controller
                                                          .viewAllCategoryDataModel
                                                          ?.data?[index]
                                                          .categoryName ??
                                                      '',
                                                  assests: controller
                                                          .categoriesSongDataModel
                                                          ?.data ??
                                                      [],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 120.h,
                                        width: 120.w,
                                        child: CachedNetworkImageWidget(
                                          fit: BoxFit.cover,
                                          image: controller
                                              .viewAllCategoryDataModel
                                              ?.data?[index]
                                              .categoryImage,
                                        ),
                                      ),
                                      2.verticalSpace,
                                      AppTextWidget(
                                        txtTitle: controller
                                                .viewAllCategoryDataModel
                                                ?.data?[index]
                                                .parentCategoryName ??
                                            '',
                                        txtColor: AppColors.white,
                                        fontSize: 10,
                                        maxLine: 1,
                                      ),
                                      5.verticalSpace,
                                      AppTextWidget(
                                        txtTitle: controller
                                                .viewAllCategoryDataModel
                                                ?.data?[index]
                                                .categoryName ??
                                            '',
                                        txtColor: AppColors.white,
                                        fontSize: 10,
                                        maxLine: 1,
                                      )
                                    ],
                                  ),
                                );
                              }))
                    ],
                  );
                }),
          ),
        )),
        Obx(() => Visibility(
            visible: controller.loader.value, child: const AppLoder())),
      ],
    );
  }
}
