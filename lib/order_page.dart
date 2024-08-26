import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppb_proyek_akhir/boarding_pass.dart';

class OrderPage extends StatefulWidget {
  final String trainRouteID;
  const OrderPage({
    super.key,
    required this.trainRouteID,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late String trainRouteId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();

  // Inisialisasi fullName dengan nilai default kosong
  late String fullName = '';
  late String fromStationCode = '';
  late String fromStationName = '';
  late String destinationStationCode = '';
  late String destinationStationName = '';
  late String arrival = '';
  late String departure = '';
  late String bookingCode = '7BG55A';
  late String seatNumber = '11A';
  // DateFormat('dd MMMM y')
  //                                   .format(data['arrival'].toDate()

  @override
  void initState() {
    super.initState();
    trainRouteId = widget.trainRouteID;
    fetchRouteData();
    fetchUserData();
  }

// Text(fromStationCode),
//             Text(fromStationName),
//             Text('Destination'),
//             Text(destinationStationCode),
//             Text(destinationStationName),
//             Text(arrival),
//             Text(departure),

  Future<void> fetchRouteData() async {
    try {
      var snapshot =
          await _firestore.collection('Routes').doc(trainRouteId).get();
      setState(() {
        fromStationCode = snapshot.data()!['sourceStation']['stationCode'];
        fromStationName = snapshot.data()!['sourceStation']['stationName'];
        destinationStationCode =
            snapshot.data()!['destinationStation']['stationCode'];
        destinationStationName =
            snapshot.data()!['destinationStation']['stationName'];
        var arrivalTime = snapshot.data()!['arrival'];
        arrival = DateFormat('dd MMMM y').format(arrivalTime.toDate());
        var departureTime = snapshot.data()!['departure'];
        departure = DateFormat('dd MMMM y').format(departureTime.toDate());
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchUserData() async {
    try {
      var querySnapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: _auth.currentUser?.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];

        setState(() {
          fullName = documentSnapshot.data()['fullName'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String selectedOption = '';
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('From'),
            Text(fromStationCode),
            Text(fromStationName),
            const SizedBox(height: 24),
            const Text('Destination'),
            Text(destinationStationCode),
            Text(destinationStationName),
            const SizedBox(height: 24),
            Text('Arrival: $arrival'),
            Text('Departure $departure'),
            const SizedBox(height: 24),
            Text('Passenger: $fullName'),
            Text('Seat Number: $seatNumber'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const BoardingPass()),
                    ),
                  );
                },
                child: const Text('Order'))
          ],
        ),
      ),
    );
  }
}
