


import 'package:flutter/cupertino.dart';
import 'package:flutter_baber_taolaymay/model/image_model.dart';
import 'package:flutter_baber_taolaymay/model/user_model.dart';


abstract class HomeViewModel {
  Future<UserModel> displayUserProfile(BuildContext context,String phoneNumber);
  Future<List<ImageModel>> displayBanner();
  Future<List<ImageModel>> displayLookbook();

  bool isStaff(BuildContext context);

}