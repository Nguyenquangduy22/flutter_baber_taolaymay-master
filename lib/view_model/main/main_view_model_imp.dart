

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_baber_taolaymay/ui/components/user_widgets/register_dialog.dart';
import 'package:flutter_baber_taolaymay/utils/utils.dart';
import 'package:flutter_baber_taolaymay/view_model/main/main_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/state_management.dart';

class MainViewModelImp implements MainViewModel{
  @override
  Future<LOGIN_STATE> checkLoginState(BuildContext context,bool fromLogin ,
      GlobalKey<ScaffoldState> scaffoldState) async {
    if(!context.read(forceReload).state){
      await Future.delayed(Duration(seconds: fromLogin == true ? 0 : 3))
          .then((value) => {
        FirebaseAuth.instance.currentUser
            .getIdToken()
            .then((token) async {
          //Force reload state
          context.read(forceReload).state = true;

          //If get token , we print it
          print('$token');
          context.read(userToken).state = token;
          //Check user in FireStore
          CollectionReference userRef = FirebaseFirestore.instance.collection('user');
          DocumentSnapshot snapshotUser = await userRef
              .doc(FirebaseAuth.instance.currentUser.phoneNumber)
              .get();

          if(snapshotUser.exists)
          {
            // And because user already login , we will start new screen
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
          else
          {
            showRegisterDialog(context,userRef,scaffoldState);
          }

        })
      });
    }

    return FirebaseAuth.instance.currentUser != null ? LOGIN_STATE.LOGGED : LOGIN_STATE.NOT_LOGIN;

  }

  @override
  processLogin(BuildContext context,GlobalKey<ScaffoldState> scaffoldState) {
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      FirebaseAuthUi.instance()
          .launchAuth([
        AuthProvider.phone()
      ]).then((firebaseUser) async{
        // Refesh state
        context
            .read(userLogged)
            .state = FirebaseAuth.instance.currentUser;
        //ScaffoldMessenger.of(scaffoldState.currentContext).showSnackBar(
        //SnackBar(content: Text('Login success ${FirebaseAuth.instance.currentUser.phoneNumber}')));
        //Start new screen
        await checkLoginState(context,true,scaffoldState);


      }).catchError((e){
        if(e is PlatformException)
          if(e.code == FirebaseAuthUi.kUserCancelledError)
            ScaffoldMessenger.of(scaffoldState.currentContext).showSnackBar(
                SnackBar(content: Text('${e.message}')));
          else
            ScaffoldMessenger.of(scaffoldState.currentContext).showSnackBar(
                SnackBar(content: Text('OMG error')));


      });// user not login , show Icons.login
    }
    else{ // user already login , start home page

    }
  }
  
}