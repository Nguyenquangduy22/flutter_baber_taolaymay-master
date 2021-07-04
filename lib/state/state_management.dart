

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_baber_taolaymay/model/barber_model.dart';
import 'package:flutter_baber_taolaymay/model/booking_model.dart';
import 'package:flutter_baber_taolaymay/model/city_model.dart';
import 'package:flutter_baber_taolaymay/model/salon_model.dart';
import 'package:flutter_baber_taolaymay/model/service_model.dart';
import 'package:flutter_baber_taolaymay/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userLogged = StateProvider((ref) => FirebaseAuth.instance.currentUser);
final userToken = StateProvider((ref) => '');
final forceReload = StateProvider((ref) => false);

final userInformation = StateProvider((ref) => UserModel());

//Booking state
final currentStep = StateProvider((ref) =>1);
final selectedCity = StateProvider((ref) => CityModel());
final selectedSalon = StateProvider((ref) => SalonModel());
final selectedBarber = StateProvider((ref) => BarberModel());
final selectedDate = StateProvider((ref) => DateTime.now());
final selectedTimeSlot = StateProvider((ref) => -1);
final selectedTime = StateProvider((ref) => '');

//Delete Booking
final deleteFlagRefresh = StateProvider((ref) => false);

//Staff
final staffStep = StateProvider((ref) => 1);
final selectedBooking = StateProvider((ref) => BookingModel());
final selectedServices = StateProvider((ref) => List<ServiceModel>.empty(growable: true));