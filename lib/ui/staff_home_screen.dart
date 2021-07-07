




import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baber_taolaymay/cloud_firestore/all_salon_ref.dart';
import 'package:flutter_baber_taolaymay/cloud_firestore/banner_ref.dart';
import 'package:flutter_baber_taolaymay/cloud_firestore/lookbook_ref.dart';
import 'package:flutter_baber_taolaymay/cloud_firestore/user_ref.dart';
import 'package:flutter_baber_taolaymay/model/city_model.dart';
import 'package:flutter_baber_taolaymay/model/image_model.dart';
import 'package:flutter_baber_taolaymay/model/salon_model.dart';
import 'package:flutter_baber_taolaymay/model/user_model.dart';
import 'package:flutter_baber_taolaymay/state/state_management.dart';
import 'package:flutter_baber_taolaymay/string/strings.dart';
import 'package:flutter_baber_taolaymay/ui/components/staff_widgets/salon_list.dart';
import 'package:flutter_baber_taolaymay/utils/utils.dart';
import 'package:flutter_baber_taolaymay/view_model/staff_home/appoiment_list.dart';
import 'package:flutter_baber_taolaymay/view_model/staff_home/staff_home_view_model_imp.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'components/staff_widgets/city_list.dart';



class StaffHome extends ConsumerWidget{
  final staffHomeViewModel = StaffHomeViewModelImp();
  @override
  Widget build(BuildContext context, watch) {
    var currentStaffStep = watch(staffStep).state;
    var cityWatch = watch(selectedCity).state;
    var salonWatch = watch(selectedSalon).state;
    var dateWatch = watch(selectedDate).state;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFFDFDFDF),
          body: Center(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Color(0xFFDFDFDF),
              appBar: AppBar(
                title: Text(currentStaffStep == 1
                    ? SelectedCityText
                    : currentStaffStep == 2
                    ? SelectSalonText
                        : currentStaffStep == 3
                    ? YourAppoimentText
                        : StaffHomeText),
                backgroundColor: Color(0xFF383838),
              ),
              body: Column(children: [
                //Area
                Expanded(
                  child: currentStaffStep == 1
                      ? staffDisplayCity(staffHomeViewModel)
                      : currentStaffStep == 2
                        ? staffDisplaySalon(staffHomeViewModel,cityWatch.name) :
              currentStaffStep == 3 ? displayAppoiment(staffHomeViewModel,context)
                        : Container(),
                  flex : 10,
                ),
                //Button
                Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                  onPressed: currentStaffStep == 1
                                      ? null
                                      : ()=>context.read(staffStep).state--,
                                  child: Text(PreviousText),
                                )
                            ),
                            SizedBox(width: 20,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                  // If user not select city , button Next will be disable !
                                  onPressed: (currentStaffStep ==1 && context.read(selectedCity).state.name == null) ||
                                      (currentStaffStep == 2 &&
                                          context.read(selectedSalon).state.docId == null) ||
                                      currentStaffStep == 3
                                      ? null
                                      : () => context.read(staffStep).state++,
                                  child: Text(NextText),
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                )
              ],),
            ),
          ),

        ));
  }











}