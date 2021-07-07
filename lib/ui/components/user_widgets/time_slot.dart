

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baber_taolaymay/cloud_firestore/all_salon_ref.dart';
import 'package:flutter_baber_taolaymay/model/barber_model.dart';
import 'package:flutter_baber_taolaymay/state/state_management.dart';
import 'package:flutter_baber_taolaymay/utils/utils.dart';
import 'package:flutter_baber_taolaymay/view_model/booking/booking_view_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

displayTimeSlot(BookingViewModel bookingViewModel,BuildContext context, BarberModel barberModel) {
  var now = context.read(selectedDate).state;
  return Column(
    children: [
      Container(
        color: Color(0xFF008577),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(children: [
                      Text('${DateFormat.MMMM().format(now)}',style: GoogleFonts.robotoMono(color: Colors.white54),),
                      Text('${now.day}',style: GoogleFonts.robotoMono(color: Colors.white , fontWeight: FontWeight.bold,fontSize: 22)),
                      Text('${DateFormat.EEEE().format(now)}',style: GoogleFonts.robotoMono(color: Colors.white54),),
                    ],),),)),
            GestureDetector(onTap: (){
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(), // Fix can't select current date
                  maxTime: now.add(Duration(days: 31)),
                  onConfirm: (date) => context.read(selectedDate).state = date); // next time you can choose is 31 days next
            },child: Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.calendar_today,color: Colors.white,),
              ),
            ),)
          ],
        ),
      ),
      Expanded(
        child: FutureBuilder(
          future: getMaxAvailableTimeSlot(context.read(selectedDate).state),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);
            else{
              var maxTimeSlot = snapshot.data as int;
              return FutureBuilder(
                future: getTimeSlotOfBarber(
                  barberModel,
                  DateFormat('dd_MM_yyyy')
                      .format(context.read(selectedDate).state),),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else{
                    var listTimeSlot = snapshot.data as List<int>;
                    return GridView.builder(
                      key: PageStorageKey('kepp'),
                        itemCount: TIME_SLOT.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3
                        ),
                        itemBuilder: (context,index)=> GestureDetector(
                          onTap:bookingViewModel.isAvailableForTapTimeSlot(maxTimeSlot, index, listTimeSlot)
                              ? null
                              : () {
                            bookingViewModel.onSelectedTimeSlot(context, index);
                          },
                          child: Card(
                            color:  bookingViewModel.displayColorTimeSlot(context, listTimeSlot , index, maxTimeSlot),
                            child: GridTile(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${TIME_SLOT.elementAt(index)}'),
                                    Text( listTimeSlot.contains(index)
                                        ? 'Full'
                                        : maxTimeSlot > index
                                        ? 'Not Available'
                                        :'Available')
                                  ],
                                ),
                              ),
                              header:  context.read(selectedTime).state ==
                                  TIME_SLOT.elementAt(index) ? Icon(Icons.check) : null,
                            ),),
                        ));
                  }
                },
              );
            }
          },
        ) ,
      )

    ],
  );

}