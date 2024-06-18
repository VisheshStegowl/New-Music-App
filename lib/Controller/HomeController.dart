import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/FavoritesSongListModel.dart' as data;
import 'package:new_music_app/Utils/Models/FavouritesDataModel.dart';
import 'package:new_music_app/Utils/Models/HomeBannerModel.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends BaseController {
  late HomeChopperService _homeChopperService;
  late AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  Rxn<HomeBannerModel> banner = Rxn<HomeBannerModel>();
  Rxn<HomeDataModel> homeData = Rxn<HomeDataModel>();
  int paginationInt = 1;
  int maxPages = 0;

  HomeController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  late ScrollController scrollController;
  TextEditingController favoritesController = TextEditingController();

  RxInt bannerIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ["71777c03-19f7-45d7-9180-7ca6266beabb"]));
    if (audioPlayer.current.hasValue) {
      audioPlayer.pause();
    }
    if (Get.find<RadioController>().audioPlayer.current.hasValue) {
      Get.find<RadioController>().audioPlayer.pause();
    }
    await homeDataApi();
    await getBannerSliders();
  }

  @override
  Future<void> scrollListener() async {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (paginationInt < maxPages) {
          paginationInt = paginationInt + 1;
          await homeDataApi();
        }
      }
    }
  }

  Future<void> shareSong(
      {required String songName,
      required String artistName,
      required String songUrl,
      required int sharedValue}) async {
    try {
      await Share.share(
          "Song Name: $songName \n Song URL: $songUrl \n Artist Name: $artistName \n App Name: Ala Jaza");
      sharedValue++;
      update();
    } catch (e) {
      log('', name: 'Share Song Error');
    }
  }

  Future<void> getBannerSliders() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.bannerSlider(param: param);
      if (response.isSuccessful) {
        banner.value = response.body;
        log(banner.value?.data.toString() ?? '');
        update();
      }
    } catch (e) {
      log('', name: 'Home Banner error', error: e.toString());
    }
  }

  Future<void> homeDataApi() async {
    showLoader(true);
    try {
      final Map<String, dynamic> param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };

      final Map<String, dynamic> queryParameters = {
        'limit': 3,
        'page': paginationInt
      };
      print(paginationInt);
      final response = await _homeChopperService.homeDataApi(
          queryParameters: queryParameters, param: param);
      if (response.isSuccessful) {
        if (homeData.value != null) {
          homeData.value?.data?.addAll(response.body?.data ?? []);
        } else {
          homeData.value = response.body;
          maxPages = response.body?.lastPage ?? 1;
        }
        print("homeData ${homeData.value}");
        update();
        showLoader(false);
      }
      showLoader(false);
    } catch (e) {
      log('', name: 'Home Data Api', error: e.toString());
    }
  }

  RxList<AssestsSong> assetsSongs = <AssestsSong>[].obs;
  RxInt? currentSongIndex = 0.obs;

  Future<void> playSong(
      {required List<AssestsSong> assests, required int index}) async {
    showLoader(true);
    try {
      assetsSongs.replaceRange(0, assetsSongs.length, assests.toList());
      currentSongIndex?.value = index;
      disposeMethod();
      Get.find<BaseController>().mainStreamController.sink.add(true);
      AppConst.bottomDisplay = BottomDisplay.song;
      updateButton(button: BottomDisplay.song);
      // createPlaylist(assests: assests, index: index);
      Playlist playlist = Playlist();
      for (int i = 0; i < assests.length; i++) {
        playlist.add(Audio.network(assests[i].song.toString(),
            metas: Metas(
                image: MetasImage.network(assests[i].songImage ?? ''),
                title: assests[i].songName,
                artist: assests[i].songArtist)));
      }
      playlist.removeAtIndex(index);
      playlist.insert(
          0,
          Audio.network(assetsSongs[index].song.toString(),
              metas: Metas(
                  image: MetasImage.network(assetsSongs[index].songImage ?? ''),
                  title: assetsSongs[index].songName,
                  artist: assetsSongs[index].songArtist)));
      print("this is song ${AppConst.bottomDisplay}");
      Get.find<BaseController>().mainStreamController.sink.add(true);
      await audioPlayer.open(playlist,
          // Audio.network(assests[index].song.toString(),
          //     metas: Metas(
          //         image: MetasImage.network(assests[index].songImage ?? ''),
          //         title: assests[index].songName,
          //         artist: assests[index].songArtist)),
          autoStart: true,
          audioFocusStrategy: const AudioFocusStrategy.request(
              resumeOthersPlayersAfterDone: true),
          playInBackground: PlayInBackground.enabled,
          notificationSettings: NotificationSettings(
              stopEnabled: false,
              playPauseEnabled: true,
              nextEnabled: true,
              prevEnabled: true,
              customNextAction: (AssetsAudioPlayer player) {
                player.next(keepLoopMode: true, stopIfLast: false);
              },
              customPrevAction: (AssetsAudioPlayer player) {
                player.previous();
              },
              seekBarEnabled: true),
          showNotification: true);
      // audioPlayer.playlistPlayAtIndex(index);
      update();
      showLoader(false);
    } catch (e) {
      showLoader(false);
      log('', name: 'audio play error', error: e.toString());
    }
  }

  FavouritesDataModel? favouritesDataModel;

  Future<bool?> addRemoveFavourites(
      {required int menuId, required int songId, int? assestsDataIndex}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "song_id": songId
      };
      final queryParameters = {'type': 'AddRemoveSong'};
      final response = await _homeChopperService.addRemoveFavouritesApi(
          param: param, queryParameters: queryParameters);

      if (response.isSuccessful) {
        favouritesDataModel = response.body;
        if (assetsSongs.isNotEmpty) {
          assetsSongs[currentSongIndex?.value ?? 0].favouritesCount =
              favouritesDataModel?.favouritesCount;
          assetsSongs[currentSongIndex?.value ?? 0].favouritesStatus =
              favouritesDataModel?.favouritesStatus;

          Utility.showSnackBar(
            response.body?.message,
          );
          update();
          return favouritesDataModel?.favouritesStatus;
        } else {
          homeData.value?.data?[assestsDataIndex ?? 0].assests
              ?.firstWhere((element) => element.songId == songId)
              .favouritesStatus = response.body?.favouritesStatus;

          Utility.showSnackBar(
            response.body?.message,
          );
          update();
          return response.body?.favouritesStatus;
        }
        Utility.showSnackBar(
          response.body?.message,
        );
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Add and remove Favourites Api Error');
    }
  }

  Rxn<data.FavoriteSongListModel> favoriteSongListModel =
      Rxn<data.FavoriteSongListModel>();

  Future<void> getFavoritesList() async {
    try {
      final queryParameters = {
        'type': 'FavouritesSongsList',
        'limit': 15,
        'page': 1
      };
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.favoritesSongsApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        favoriteSongListModel.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'Get Favorite Song List Api error', error: e.toString());
    }
  }

  List<AssestsSong>? filterList;

  void searchFavorites(String value) async {
    if (filterList == null) {
      filterList = favoriteSongListModel.value?.data;
    }
    if (favoritesController.text != '') {
      favoriteSongListModel.value?.data = favoriteSongListModel.value?.data
          ?.where((element) =>
              element.songName
                  ?.toLowerCase()
                  .toString()
                  .contains(value.toString().toLowerCase()) ??
              false)
          .toList();
      update();
    } else {
      favoriteSongListModel.value = null;
      getFavoritesList();
    }
  }
}
