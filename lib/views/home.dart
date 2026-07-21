import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/available.dart';
import 'package:flutter_application_2/views/booked.dart';
import 'package:flutter_application_2/views/bookingHistoy.dart';
import 'package:flutter_application_2/views/dashboard.dart';
import 'package:flutter_application_2/views/home.dart' as body;

var screens = [Dashboard(), TenantsPage(), RentPaymentsPage(), MaintenanceReports()];


  
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
        backgroundColor: const Color(0xFF006978),
        items: <Widget>[
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.payments, size: 30),
          Icon(Icons.report_sharp ,size: 30),
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