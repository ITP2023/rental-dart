import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import './customer_entry.dart';
import './staff_entry.dart';
import './model.dart';



Future<List<ReservationData>> fetchReservations() async {
  final response = await http.get(Uri.parse("http://localhost/api/get_reservations.php"));
  if (response.statusCode != 200) {
    throw Exception("failed to load");
  }

  final List<dynamic> raw = jsonDecode(response.body)["all"];
  
  List<ReservationData> all = List.empty(growable: true);
  for (int i = 0; i < raw.length; i++) {
    all.add(ReservationData.fromJSON(raw[i]));
  }
  return all;
}

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "StartPage",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true
      ),
      home: const MainScreen(),
    );
  }
}



class _MainScreenState extends State<MainScreen> {
  late Future<List<ReservationData>> _reservationData;
  bool _loggedIn = false;
  @override
  void initState() {
    super.initState();
    _reservationData = fetchReservations();
    _loggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_loggedIn) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: FutureBuilder<List<ReservationData>>(
        future: _reservationData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Err");
          }

          if (snapshot.hasData) {
            return Text(snapshot.data!.first.reservationID);
          }

          return const CircularProgressIndicator();
        },
      ),
    );
    }
    else {
      return EntryScreen();
    }
  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();

}



class EntryScreen extends StatelessWidget {
  const EntryScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                child: Image.asset("assets/images/ic_facebook.png")
              ),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const CustomerEntryScreen()
                    )
                  );
                }, 
                child: const Text(
                  "Login as Customer",
                  style: TextStyle(
                    color: Colors.white
                  )
                )
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const StaffEntryScreen()
                    )
                  );
                },
                child: const Text("Login as Staff", style: TextStyle(color: Colors.black),)
              )
            ],
          )
        ),
      ),
    );
  }
}