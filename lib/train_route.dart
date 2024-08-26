import 'package:cloud_firestore/cloud_firestore.dart';

class TrainRoute {
  final Map<String, dynamic> sourceStation;
  final Map<String, dynamic> destinationStation;
  final Timestamp departure;
  final Timestamp arrival;
  final int price;

  TrainRoute({
    required this.sourceStation,
    required this.destinationStation,
    required this.departure,
    required this.arrival,
    required this.price,
  });
}
