import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
part 'activeTicket_state.dart';
part 'activeTicket_event.dart';

class ActiveTicketBloc extends Bloc<ActiveTicketEvent, ActiveTicketState> {
  ActiveTicketBloc() : super(ActiveTicketInitial()) {
    var active;
    var todaydate;

    on<FetchActiveTicket>((event, emit) async {
      List ticketsnow = [];
      var error;
      emit(ActiveTicketLoading());
      try {
        DateTime days = DateTime.parse("${DateTime.now()}");
        if (days.day < 10) {
          todaydate = "${days.year}-${days.month}-0${days.day}";
        } else {
          todaydate = "${days.year}-${days.month}-${days.day}";
        }
        //  print(todaydate);

        User? user = await FirebaseAuth.instance.currentUser;
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        //  print(snapshot.data());

        if (snapshot.data()!['ticket'] != null) {
          for (int i = 0; i < snapshot.data()!['ticket'].length; i++) {
            DateTime dt1 = DateTime.parse("${snapshot.data()!['ticket'][i]['mydate']}");
            DateTime dt2 = DateTime.parse("$todaydate");
             print("I am movie day $dt1 ");
              print("I am today $dt2 ");
            // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(savedDateString);
            // DateTime dttime = DateTime.parse("${snapshot.data()!['ticket'][i]['time']}");
            DateTime dttime = DateFormat('hh:mm')
                .parse(snapshot.data()!['ticket'][i]['time']);
           
            String dttttime = DateFormat('hh:mm').format(dttime);
            print("I am movie time $dttttime ");

            // DateTime hours = DateFormat("hh:mm").parse(snapshot.data()!['ticket'][i]['time']);
            // print(t);
            String now = DateFormat('HH:mm').format(DateTime.now());
            DateTime dtnow = DateFormat("HH:mm").parse(now);
            print("I am now time $now ");

              int _doublenowhour = dtnow.hour ;
              print("I am moviehr ");
              print(_doublenowhour);
              int _doubletimehour = dttime.hour ;
              print("I am now timehr");
              print(_doubletimehour);
              int _doublenowminute = dtnow.minute ;
              int _doubletimeminute = dttime.minute ;
              int diff = _doubletimehour - _doublenowhour;
              print("I am  diff");
              print(diff);

            if (dt1.compareTo(dt2) >= 0) {
              if (dt1.compareTo(dt2) == 0){
              print(dttime.hour);
               if (diff >= 0) {
                 var item = snapshot.data()!['ticket'][i];
                    print("now is less than booking");
                  if (!ticketsnow.contains(item)) {
                    ticketsnow.add(snapshot.data()!['ticket'][i]);
                  }
               }
            }
            else{
               ticketsnow.add(snapshot.data()!['ticket'][i]);
            }
            }
            
          }
        } else {
          ticketsnow = [];
        }
        emit(ActiveTicketLoaded(ticketsnow));
      } catch (err) {
        print("I am error activeticket bloc");
        print(err);
        error = err.toString();
        emit(ActiveTicketError(error));
      }
    });
  }
}
