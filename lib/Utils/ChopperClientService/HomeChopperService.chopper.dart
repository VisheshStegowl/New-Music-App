// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeChopperService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$HomeChopperService extends HomeChopperService {
  _$HomeChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = HomeChopperService;

  @override
  Future<Response<HomeBannerModel>> bannerSlider(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('bannerslider');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<HomeBannerModel, HomeBannerModel>($request);
  }

  @override
  Future<Response<HomeDataModel>> homeDataApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('home');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<HomeDataModel, HomeDataModel>($request);
  }

  @override
  Future<Response<VideoCategoryDataModel>> videoCategoryApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('menuitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<VideoCategoryDataModel, VideoCategoryDataModel>($request);
  }

  @override
  Future<Response<VideoCategoryDataListModel>> videoCategoryItemsApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('categoryitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<VideoCategoryDataListModel, VideoCategoryDataListModel>($request);
  }

  @override
  Future<Response<RadioModel>> radioAudioApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('menuitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<RadioModel, RadioModel>($request);
  }

  @override
  Future<Response<LiveVideoModel>> liveVideoApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('menuitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<LiveVideoModel, LiveVideoModel>($request);
  }

  @override
  Future<Response<PlayListDataModel>> getPlayList({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PlayListDataModel, PlayListDataModel>($request);
  }

  @override
  Future<Response<FavouritesDataModel>> addRemoveFavouritesApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favourites');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavouritesDataModel, FavouritesDataModel>($request);
  }

  @override
  Future<Response<FavouritesDataModel>> addRemoveFavouritesVideoApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favouritevideos');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavouritesDataModel, FavouritesDataModel>($request);
  }

  @override
  Future<Response<FavoriteSongListModel>> favoritesSongsApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favourites');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavoriteSongListModel, FavoriteSongListModel>($request);
  }

  @override
  Future<Response<SignInModel>> getProfileApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('profile');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SignInModel, SignInModel>($request);
  }

  @override
  Future<Response<PlayListDataModel>> getPlayListApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PlayListDataModel, PlayListDataModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> removePlayList({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<CreatePlayListModel>> createPlayListApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<CreatePlayListModel, CreatePlayListModel>($request);
  }

  @override
  Future<Response<PlayListSongModel>> playListSongApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlistsongs');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PlayListSongModel, PlayListSongModel>($request);
  }

  @override
  Future<Response<FavouriteVideoModel>> favouriteVideoApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favouritevideos');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavouriteVideoModel, FavouriteVideoModel>($request);
  }

  @override
  Future<Response<AddSongPlaylistDataModel>> addSongToPlaylist({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlistsongs');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<AddSongPlaylistDataModel, AddSongPlaylistDataModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> removeSongFromPlaylist({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlistsongs');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<SearchSongDataModel>> searchSongs({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('search');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SearchSongDataModel, SearchSongDataModel>($request);
  }

  @override
  Future<Response<SearchAlbumDataModel>> searchAlbum({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('search');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SearchAlbumDataModel, SearchAlbumDataModel>($request);
  }

  @override
  Future<Response<SearchVideosDataModel>> searchVideos({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('search');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SearchVideosDataModel, SearchVideosDataModel>($request);
  }

  @override
  Future<Response<MerchandiseDataModel>> getMerchandiseApi() {
    final Uri $url = Uri.parse('merchandise');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MerchandiseDataModel, MerchandiseDataModel>($request);
  }

  @override
  Future<Response<SponsorBannerDataModel>> sponsorBannerApi() {
    final Uri $url = Uri.parse('sponsor');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SponsorBannerDataModel, SponsorBannerDataModel>($request);
  }

  @override
  Future<Response<SocialMediaModel>> socialMediaApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('socialmedia');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SocialMediaModel, SocialMediaModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> bookingApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('booking');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<NotificationDataModel>> notificationApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('notifications');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<NotificationDataModel, NotificationDataModel>($request);
  }
}
