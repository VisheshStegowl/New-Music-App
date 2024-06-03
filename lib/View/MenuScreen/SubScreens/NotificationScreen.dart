import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';

class NotificationScreen extends GetView<MenuPageController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppNavigationBar(
        defaultAppBar: AppBar(),
      ),
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppAssets.blackBackgroundScreen,
                ),
                fit: BoxFit.cover)),
        child: GetBuilder<MenuPageController>(initState: (state) {
          controller.notificationApi();
        }, builder: (context) {
          return Column(
            children: [
              const TitleBackButtonWidget(title: 'Notification'),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          isThreeLine: true,
                          title: AppTextWidget(
                            txtTitle: controller.notificationDataModel.value
                                    ?.data?[index].title ??
                                '',
                            txtColor: AppColors.appButton,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppTextWidget(
                                txtTitle: controller.notificationDataModel.value
                                        ?.data?[index].message ??
                                    '',
                                txtColor: AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                              AppTextWidget(
                                txtTitle: controller.notificationDataModel.value
                                        ?.data?[index].createdAt ??
                                    '',
                                txtColor: AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    );
                  })
            ],
          );
        }),
      ),
    ));
  }
}
