import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/CreatePlayListModel.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Models/PlayListDataModel.dart' as data;
import 'package:new_music_app/Utils/Models/PlayListSongModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class PlayListController extends BaseController {
  late HomeChopperService _homeChopperService;

  PlayListController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  TextEditingController playListController = TextEditingController();
  TextEditingController createPlayListController = TextEditingController();
  TextEditingController playListSongController = TextEditingController();
  Rxn<data.PlayListDataModel> playListModel = Rxn<data.PlayListDataModel>();

  Future<void> getPlayList() async {
    try {
      final queryParameters = {'type': 'PlaylistList'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.getPlayListApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        playListModel.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'Get PlayList  Api error', error: e.toString());
    }
  }

  Rxn<CreatePlayListModel> createPlayListModel = Rxn<CreatePlayListModel>();

  List<data.Data>? filterPlaylist;

  void searchPlaylist(String value) {
    if (filterPlaylist == []) {
      filterPlaylist = playListModel.value?.data;
    }
    if (playListController.text != '') {
      playListModel.value?.data = playListModel.value?.data
          ?.where((element) =>
              element.playlistName
                  ?.toLowerCase()
                  .toString()
                  .contains(value.toString().toLowerCase()) ??
              false)
          .toList();
      update();
    } else {
      playListModel.value = null;
      getPlayList();
    }
  }

  List<AssestsSong>? filterPlaylistSong;

  void searchPlaylistSong(String value, int id) {
    if (filterPlaylistSong == []) {
      filterPlaylistSong = playListSongModel.value?.data ?? [];
    }
    if (playListSongController.text != '') {
      playListSongModel.value?.data = playListSongModel.value?.data
          ?.where((element) =>
              element.songName
                  ?.toLowerCase()
                  .toString()
                  .contains(value.toString().toLowerCase()) ??
              false)
          .toList();
      update();
    } else {
      playListSongModel.value = null;
      playListSongApi(id);
    }
  }

  Future<void> createPlayList() async {
    try {
      showLoader(true);
      final queryParameters = {'type': 'PlaylistAdd'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "playlist_name": createPlayListController.text
      };
      final response = await _homeChopperService.createPlayListApi(
          param: param, queryParameters: queryParameters);
      if (response.body?.status == 200) {
        createPlayListModel.value = response.body;
        update();
        createPlayListController.clear();
        showLoader(false);
        Get.back();
        Get.back();
        Utility.showSnackBar(response.body?.message);
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
        showLoader(false);
      }
      showLoader(false);
    } catch (e) {
      showLoader(false);
      log('', name: 'Create PlayList Api error', error: e.toString());
    }
  }

  Future<void> deletePlayList(int id) async {
    try {
      final queryParameters = {'type': 'PlaylistRemove'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "playlist_id": id
      };
      final response = await _homeChopperService.removePlayList(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        playListModel.value?.data
            ?.removeWhere((element) => element.playlistId == id);
        Get.back();
        Utility.showSnackBar(response.body?.message);

        print(response.body?.message);
        update();
      }
    } catch (e) {
      log('', name: 'Delete PlayList Api', error: e.toString());
    }
  }

  Rxn<PlayListSongModel> playListSongModel = Rxn<PlayListSongModel>();

  Future<void> playListSongApi(int id) async {
    try {
      final queryParameters = {
        'type': 'PlaylistSongsList',
        'limit': 15,
        "page": 1
      };
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "playlist_id": id
      };
      final response = await _homeChopperService.playListSongApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        playListSongModel.value = response.body;
        print(response.statusCode);
        update();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      log('', name: 'Song List Api error', error: e.toString());
    }
  }

  Future<void> addSongToPlaylist(
      {required int menuId,
      required int songId,
      required int playlistId}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "song_id": songId,
        "playlist_id": playlistId
      };
      final queryParameters = {'type': 'AddPlaylistSongs'};
      final response = await _homeChopperService.addSongToPlaylist(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Get.back();
        Utility.showSnackBar(response.body?.message);
      }
    } catch (e) {
      log('', name: 'Add Playlist Song Api error', error: e.toString());
    }
  }

  Future<void> removeSongFromPlaylist(
      {required int playlistId, required int songId}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "playlist_id": playlistId,
        "song_id": songId
      };
      final queryParameters = {'type': 'RemovePlaylistSongs'};
      final response = await _homeChopperService.removeSongFromPlaylist(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Get.back();
        playListSongApi(playlistId);

        Utility.showSnackBar(response.body?.message);
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('', name: 'remove song from playlist error', error: e.toString());
    }
  }
}
