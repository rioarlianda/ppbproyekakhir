import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String uid;
  final String passenger;
  final String bookingCode;
  final String seatNumber;
  final Map<String, dynamic> sourceStation;
  final Map<String, dynamic> destinationStation;
  final Timestamp departure;
  final Timestamp arrival;

  Ticket({
    required this.uid,
    required this.passenger,
    required this.bookingCode,
    required this.seatNumber,
    required this.sourceStation,
    required this.destinationStation,
    required this.departure,
    required this.arrival,
  });
}
