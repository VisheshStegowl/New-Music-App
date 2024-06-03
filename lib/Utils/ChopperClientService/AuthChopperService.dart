import "dart:io";

import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/Models/GeneralErrorModel.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Models/SignInModel.dart';
import 'package:new_music_app/Utils/Models/SkipUserDataModel.dart';
import 'package:new_music_app/Utils/Models/WalkthroughDataModel.dart';

part 'AuthChopperService.chopper.dart';

@ChopperApi()
abstract class AuthChopperService extends ChopperService {
  static AuthChopperService create({ChopperClient? client}) {
    return _$AuthChopperService(client);
  }

  // @Get(
  //      path: '/app-walkthrough/api/all',
  //      headers: {'Authorization': 'HelloWorld!'})
  //  Future<Response<WalkThroughModel>> walkThroughAPi();
  //
  @Post(path: 'signin')
  Future<Response<SignInModel>> signInApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'skipuser')
  Future<Response<SkipUserDataModel>> skipUserApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'signup')
  Future<Response<GeneralErrorModel>> signUpApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'forgotpassword')
  Future<Response<GeneralErrorModel>> forgotPassword(
      {@body required Map<String, dynamic> param});

  @Post(path: 'uploads')
  @multipart
  Future<Response<MerchandiseDataModel>> imageUpload(
      {@body required Map<String, File> param});

  @Get(path: 'walkthrough')
  Future<Response<WalkthroughDataModel>> walkthroughApi();
}
