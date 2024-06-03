import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/Models/AddSongPlaylistDataModel.dart';
import 'package:new_music_app/Utils/Models/CreatePlayListModel.dart';
import 'package:new_music_app/Utils/Models/FavoritesSongListModel.dart';
import 'package:new_music_app/Utils/Models/FavouriteVideoModel.dart';
import 'package:new_music_app/Utils/Models/FavouritesDataModel.dart';
import 'package:new_music_app/Utils/Models/GeneralErrorModel.dart';
import 'package:new_music_app/Utils/Models/HomeBannerModel.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Models/LiveVideoModel.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Models/NotificationDataModel.dart';
import 'package:new_music_app/Utils/Models/PlayListDataModel.dart';
import 'package:new_music_app/Utils/Models/PlayListSongModel.dart';
import 'package:new_music_app/Utils/Models/RadioModel.dart';
import 'package:new_music_app/Utils/Models/SearchAlbumDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchSongDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchVideosDataModel.dart';
import 'package:new_music_app/Utils/Models/SignInModel.dart';
import 'package:new_music_app/Utils/Models/SocialMediaModel.dart';
import 'package:new_music_app/Utils/Models/SponsorBannerDataModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataModel.dart';
import 'package:new_music_app/Utils/Models/WalkthroughDataModel.dart';

part 'HomeChopperService.chopper.dart';

@ChopperApi()
abstract class HomeChopperService extends ChopperService {
  static HomeChopperService create({ChopperClient? client}) {
    return _$HomeChopperService(client);
  }

  @Post(path: 'bannerslider')
  Future<Response<HomeBannerModel>> bannerSlider(
      {@body required Map<String, dynamic> param});

  @Post(path: 'home')
  Future<Response<HomeDataModel>> homeDataApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'menuitems')
  Future<Response<VideoCategoryDataModel>> videoCategoryApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'categoryitems')
  Future<Response<VideoCategoryDataListModel>> videoCategoryItemsApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'menuitems')
  Future<Response<RadioModel>> radioAudioApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'menuitems')
  Future<Response<LiveVideoModel>> liveVideoApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<PlayListDataModel>> getPlayList(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favourites')
  Future<Response<FavouritesDataModel>> addRemoveFavouritesApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favouritevideos')
  Future<Response<FavouritesDataModel>> addRemoveFavouritesVideoApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favourites')
  Future<Response<FavoriteSongListModel>> favoritesSongsApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'profile')
  Future<Response<SignInModel>> getProfileApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<PlayListDataModel>> getPlayListApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<GeneralErrorModel>> removePlayList(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<CreatePlayListModel>> createPlayListApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlistsongs')
  Future<Response<PlayListSongModel>> playListSongApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favouritevideos')
  Future<Response<FavouriteVideoModel>> favouriteVideoApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlistsongs')
  Future<Response<AddSongPlaylistDataModel>> addSongToPlaylist(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlistsongs')
  Future<Response<GeneralErrorModel>> removeSongFromPlaylist(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'search')
  Future<Response<SearchSongDataModel>> searchSongs(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'search')
  Future<Response<SearchAlbumDataModel>> searchAlbum(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'search')
  Future<Response<SearchVideosDataModel>> searchVideos(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: 'merchandise')
  Future<Response<MerchandiseDataModel>> getMerchandiseApi();

  @Get(path: 'sponsor')
  Future<Response<SponsorBannerDataModel>> sponsorBannerApi();

  @Post(path: 'socialmedia')
  Future<Response<SocialMediaModel>> socialMediaApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'booking')
  Future<Response<GeneralErrorModel>> bookingApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'notifications')
  Future<Response<NotificationDataModel>> notificationApi(
      {@body required Map<String, dynamic> param});
}
