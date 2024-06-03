// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthChopperService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthChopperService extends AuthChopperService {
  _$AuthChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthChopperService;

  @override
  Future<Response<SignInModel>> signInApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('signin');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SignInModel, SignInModel>($request);
  }

  @override
  Future<Response<SkipUserDataModel>> skipUserApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('skipuser');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SkipUserDataModel, SkipUserDataModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> signUpApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('signup');
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
  Future<Response<GeneralErrorModel>> forgotPassword(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('forgotpassword');
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
  Future<Response<MerchandiseDataModel>> imageUpload(
      {required Map<String, File> param}) {
    final Uri $url = Uri.parse('uploads');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MerchandiseDataModel, MerchandiseDataModel>($request);
  }

  @override
  Future<Response<WalkthroughDataModel>> walkthroughApi() {
    final Uri $url = Uri.parse('walkthrough');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WalkthroughDataModel, WalkthroughDataModel>($request);
  }
}
