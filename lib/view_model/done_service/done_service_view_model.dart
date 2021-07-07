

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baber_taolaymay/model/booking_model.dart';
import 'package:flutter_baber_taolaymay/model/service_model.dart';

abstract class DoneServiceViewModel{
  Future<BookingModel> displayDetailBooking(BuildContext context,int timeSlot);
  Future<List<ServiceModel>> displayServices(BuildContext context);
  void finishService(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey);
  double calculateTotalPrice(List<ServiceModel> serviceSelected);
  bool isDone(BuildContext context);
  void onSelectedchip(BuildContext context,bool isSelected,ServiceModel e);

}