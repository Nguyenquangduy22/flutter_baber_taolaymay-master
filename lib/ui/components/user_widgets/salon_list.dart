
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baber_taolaymay/cloud_firestore/all_salon_ref.dart';
import 'package:flutter_baber_taolaymay/model/salon_model.dart';
import 'package:flutter_baber_taolaymay/state/state_management.dart';
import 'package:flutter_baber_taolaymay/view_model/booking/booking_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

displaySalon(BookingViewModel bookingViewModel,String cityName) {
  return FutureBuilder(
      future: bookingViewModel.displaySalonByCity(cityName),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else{
          var salons = snapshot.data as List<SalonModel>;
          if(salons.length == 0)
            return Center(
              child: Text('Cannot load Salon list'),


            );
          else
            return ListView.builder(
                key: PageStorageKey('keep'),
                itemCount: salons.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: ()=>
                    context.read(selectedSalon).state = salons[index],
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.home_outlined ,
                          color: Colors.blueAccent,
                        ),
                        trailing: context.read(selectedSalon).state.docId ==
                            salons[index].docId
                            ? Icon(Icons.check)
                            : null,
                        title: Text(
                          '${salons[index].name}',
                          style: GoogleFonts.robotoMono(),

                        ),
                        subtitle: Text(
                          '${salons[index].address}',
                          style: GoogleFonts.robotoMono(fontStyle: FontStyle.italic),

                        ),
                      ),
                    ),
                  );
                });
        }

      });

}