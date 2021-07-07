

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baber_taolaymay/model/barber_model.dart';
import 'package:flutter_baber_taolaymay/model/salon_model.dart';
import 'package:flutter_baber_taolaymay/string/strings.dart';
import 'package:flutter_baber_taolaymay/view_model/booking/booking_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

displayBarber(BookingViewModel bookingViewModel,SalonModel salonModel) {
  return FutureBuilder(
      future: bookingViewModel.displayBarbersBySalon(salonModel),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else{
          var barbers = snapshot.data as List<BarberModel>;
          if(barbers.length == 0)
            return Center(
              child: Text(barberEmptyText),


            );
          else
            return ListView.builder(
                key: PageStorageKey('keep'),
                itemCount: barbers.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: ()=> bookingViewModel.onSelectedBarber(context, barbers[index]),
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.person ,
                          color: Colors.blueAccent,
                        ),
                        trailing: bookingViewModel.isBarberSelected(context, barbers[index])
                            ? Icon(Icons.check)
                            : null,
                        title: Text(
                          '${barbers[index].name}',
                          style: GoogleFonts.robotoMono(),

                        ),
                        subtitle: RatingBar.builder(
                          itemSize: 16,
                          allowHalfRating: true,
                          initialRating: barbers[index].rating,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          //onRatingUpdate: (value){}, null
                          ignoreGestures: true,
                          itemBuilder: (context,_) => Icon(Icons.star , color: Colors.amber[400],),
                          itemPadding: const EdgeInsets.all(4),

                        ),
                      ),
                    ),
                  );
                });
        }

      });
}