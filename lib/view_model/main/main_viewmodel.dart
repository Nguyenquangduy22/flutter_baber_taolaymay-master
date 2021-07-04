

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

abstract class MainViewModel{
  void processLogin(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey);
  Future<LOGIN_STATE> checkLoginState(BuildContext context,bool fromLogin ,
      GlobalKey<ScaffoldState> scaffoldState);
}