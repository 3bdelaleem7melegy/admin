import 'dart:async';
import 'dart:developer';
import 'package:admin/LoginUser/doctor_model.dart';
import 'package:admin/model/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AllPatient extends StatefulWidget {
  const AllPatient({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AllPatient> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _doctorName = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  int todayAppointmentsCount = 0;
  int allAppointmentsCount = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String searchName = '';

  void _fetchAppointmentCounts() async {
    // Fetch today's appointments count
    QuerySnapshot todaySnapshot =
        await FirebaseFirestore.instance.collection('Patients').get();
    setState(() {
      todayAppointmentsCount = todaySnapshot.size;
    });

    // Fetch all appointments count
    // QuerySnapshot allSnapshot = await FirebaseFirestore.instance
    //     .collection('Doctors')
    //     .get();
    // setState(() {
    //   allAppointmentsCount = allSnapshot.size;
    // });
  }

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _doctorName = TextEditingController();
    _fetchAppointmentCounts();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _message;
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    if (hour >= 5 && hour < 12) {
      _message = 'Good Morning';
    } else if (hour >= 12 && hour <= 17) {
      _message = 'Good Afternoon';
    } else {
      _message = 'Good Evening';
    }

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/UserProfile');
              },
              icon: Icon(
                Icons.people,
                size: 30,
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    _message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Patients ($todayAppointmentsCount)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by ID',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchName = value;
                      });
                    },
                  ),
                ),
                Expanded(child: _buildAppointmentStream(searchName)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentStream(String value) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('Patients');

    if (value.isNotEmpty) {
      query = query
          // .where('name', isGreaterThanOrEqualTo: value)
          // .where('name', isLessThan: value + 'z')
       .where('id', isGreaterThanOrEqualTo: value).where('id', isLessThan: value + 'z');
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Appointments',
                style: TextStyle(fontSize: 30),
              ),
            );
          } else {
            final data = snapshot.data!.docs
                .map((e) => Patient.formJson(e.data()))
                .toList();
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 100),
                  child: Text(
                    "Hello Dr. ${user.displayName}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: AppointmentsWidgetList(appointments: data)),
              ],
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}

class AppointmentsWidgetList extends StatelessWidget {
  const AppointmentsWidgetList({super.key, required this.appointments});
  final List<Patient> appointments;

  @override
  Widget build(BuildContext context) {
    log(appointments.map((e) => e.id).toString());

    return ListView.separated(
      separatorBuilder: (context, i) => SizedBox(
        height: 10,
      ),
      itemCount: appointments.length,
      itemBuilder: (context, i) => Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Id: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          appointments[i].id,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Patient Name: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          appointments[i].name,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'phone: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          appointments[i].phoneNumber,
                          style: TextStyle(fontSize: 15),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            FirebaseFirestore.instance
                                .collection('Patients')
                                .doc(appointments[i].id)
                                .delete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
