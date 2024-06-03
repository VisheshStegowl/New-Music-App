import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Router/GetxRouter.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/LiveVideoWidget.dart';
import 'package:new_music_app/View/HomeScreen/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await UserPreference.initSharedPrefs();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD_b7XK7Iadop8O17z9EbfrS5cgZMlwysE",
        appId: "1:909695087850:ios:f40709d3a6ee3deb6b5393",
        messagingSenderId: "909695087850",
        projectId: "alajazamobileapp-80452",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD_b7XK7Iadop8O17z9EbfrS5cgZMlwysE",
        appId: "1:909695087850:android:5ee31fb67ace874f6b5393",
        messagingSenderId: "909695087850",
        projectId: "alajazamobileapp-80452",
      ),
    );
  }
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  if (UserPreference.getValue(key: PrefKeys.firstTime) == null) {
    UserPreference.setValue(key: PrefKeys.firstTime, value: true);
  }

  runApp(const MyMusicMainApp());
}

class MyMusicMainApp extends StatefulWidget {
  const MyMusicMainApp({super.key});

  @override
  State<MyMusicMainApp> createState() => _MyMusicMainAppState();
}

class _MyMusicMainAppState extends State<MyMusicMainApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserPreference.setValue(
        key: PrefKeys.deviceType,
        value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
            ? "IOS"
            : "android");
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, _) {
          return GetMaterialApp(
            theme: ThemeData(indicatorColor: AppColors.appButton),
            title: 'New Music App',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: generateRoute,
            initialRoute: RoutesName.splashScreen,
          );
        });
  }
}
