// import 'dart:async';
// import 'dart:ui';
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_element, prefer_const_constructors, file_names, camel_case_types


import 'package:admin/Admin/All%20Patient.dart';
import 'package:admin/Admin/RegisterDoctor.dart';
import 'package:admin/Admin/report.dart';
import 'package:admin/Admin/All%20Doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';





class AdminScreen extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<AdminScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
  
    

    // Center(child: Text('New Appointment')),
    DoctorCounterPage(),
    RegisterDoctor(),
    AllDoctors(),
    AllPatient(),
    // NotesView(),
    // Treatment(),
    // DoctorProfile()
    
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }


  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GNav(
                  curve: Curves.easeOutExpo,
                  rippleColor: Colors.grey,
                  hoverColor: Colors.grey,
                  haptic: true,
                  tabBorderRadius: 20,
                  gap: 5,
                  activeColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.blue.withOpacity(0.7),
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  tabs: [
                    
                  
                    GButton(
                      iconSize: 28,
                      icon: _selectedIndex == 2
                          ? Icons.report
                          : Icons.report_gmailerrorred,
                      text: 'Report',
                    ),

                    GButton(
                      iconSize: _selectedIndex != 0 ? 28 : 25,
                      icon: _selectedIndex == 0
                          ? Icons.app_registration
                          : Icons.app_registration,
                      text: 'Register Doctor',
                    ),
                    GButton(
                      iconSize: _selectedIndex != 0 ? 28 : 25,
                      icon: _selectedIndex == 0
                          ? Icons.update
                          : Icons.update,
                      text: 'All Doctors',
                    ),
                      GButton(
                      iconSize: _selectedIndex != 0 ? 28 : 25,
                      icon: _selectedIndex == 0
                          ? Icons.update
                          : Icons.update,
                      text: 'All Patients',
                    ),
                    // GButton(
                    //   iconSize: _selectedIndex != 0 ? 28 : 25,
                    //   icon: _selectedIndex == 0
                    //       ? Icons.details
                    //       : Icons.details,
                    //   text: 'Details User',
                    // ),
                    //  GButton(
                    //   iconSize: _selectedIndex != 0 ? 28 : 25,
                    //   icon: _selectedIndex == 0
                    //       ? Icons.local_pharmacy
                    //       : Icons.local_pharmacy_outlined,
                    //   text: 'Details User',
                    // ),
                    // GButton(
                    // iconSize: 29,
                    //   icon: _selectedIndex == 3
                    //       ? Icons.people_alt_outlined  
                    //       : Icons.people,
                    //   text: 'profile',
                    // ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: _onItemTapped,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
