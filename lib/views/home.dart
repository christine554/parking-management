import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/available.dart';
import 'package:flutter_application_2/views/booked.dart';
import 'package:flutter_application_2/views/bookingHistoy.dart';
import 'package:flutter_application_2/views/dashboard.dart';
import 'package:flutter_application_2/views/home.dart' as body;

var screens = [Dashboard(), Bookedslots(), Availableslots(), BookingHistory()];
  
int position=0;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.book_online, size: 30),
          Icon(Icons.event_available_outlined, size: 30),
          Icon(Icons.history ,size: 30),
        ],
        onTap: (index) {
          setState(() {
            position=index;
          });
          //Handle button tap
        },
        
      ),
    body:body. screens[position],
    );
  }
}