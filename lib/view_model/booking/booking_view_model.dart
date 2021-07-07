

import 'package:flutter/material.dart';
import 'package:flutter_baber_taolaymay/model/barber_model.dart';
import 'package:flutter_baber_taolaymay/model/city_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_baber_taolaymay/model/salon_model.dart';

abstract class BookingViewModel{
  //City
  Future<List<CityModel>> displayCities();
  void onSelectedCity(BuildContext context,CityModel cityModel);
  bool isCitySelected(BuildContext context,CityModel cityModel);

  //Salon
  Future<List<SalonModel>> displaySalonByCity(String cityName);
  void onSelectedSalon(BuildContext context,SalonModel salonModel);
  bool isSalonSelected(BuildContext context,SalonModel salonModel);

  //Barber
  Future<List<BarberModel>> displayBarbersBySalon(SalonModel salonModel);
  void onSelectedBarber(BuildContext context,BarberModel barberModel);
  bool isBarberSelected(BuildContext context,BarberModel barberModel);

  //Time slot
  Future<int> displayMaxAvailableTimeslot(DateTime dt);
  Future<List<int>> displayTimeSlotOfBarber(BarberModel barberModel,String date);
  bool isAvailableForTapTimeSlot(int maxTime,
      int iindex,
      List<int> listTimeSlot);
  void onSelectedTimeSlot(BuildContext context,int index);
  Color displayColorTimeSlot(BuildContext context,
      List<int> listTimeSlot,
      int index,
      int maxTimeSlot);

  void confirmBooking(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey);


}