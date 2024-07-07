// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:admin/LoginUser/doctor_model.dart';
import 'package:admin/model/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class DoctorCounterPage extends StatefulWidget {
  const DoctorCounterPage({super.key});

  @override
  _DoctorCounterPageState createState() => _DoctorCounterPageState();
}

class _DoctorCounterPageState extends State<DoctorCounterPage> {
  int numberOfDoctors = 0; // عدد الأطباء
  int numberOfPatients = 0;
  int numberOfLab = 0;
  int numberOfPharmacy = 0;
  int analysis = 0;
  int treatment = 0;
  int numberOfDentaldoctorsAppointments = 0;
  int numbersOfDentaldoctors = 0;
  int numberOfCardiologistsAppointments = 0;
  int numbersOfCardiologists = 0;
  int numberOfPaediatriciansAppointments = 0;
  int numbersOfPaediatricians = 0;
  int numberOfophthalmologistsAppointments = 0;
  int numbersOfophthalmologists = 0;
  int numberOfOrthopedicdoctorsAppointments = 0;
  int numbersOfOrthopedicdoctors = 0;
  int numbers = 0;
  int sum = 0;
  // الدالة التي تقوم بجلب البيانات من Firestore
  Future<void> doctors() async {
    try {
      // جلب البيانات من Firestore
      final res = await FirebaseFirestore.instance.collection('Doctors').get();
      // حساب عدد الأطباء
      setState(() {
        numberOfDoctors = res.docs.length;
      });
      final Patients = await FirebaseFirestore.instance
          .collection('Patients')
          // .doc('Dentist')
          // .collection('Pending')
          // .where('patient.id',isEqualTo: 'dpTZZO5kuiS8FQnuqdyjv3b67k92')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfPatients = Patients.docs.length;
      });
      final Admins = await FirebaseFirestore.instance
          .collection('Admins')
        
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfLab = Admins.docs.length;
      });
      final Pharmacy = await FirebaseFirestore.instance
          .collection('pharmacy')
          
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfPharmacy = Pharmacy.docs.length;
      });
      final Analysis = await FirebaseFirestore.instance
          .collection('Analysis')
          
          .get();
      // حساب عدد الأطباء
      setState(() {
        analysis = Analysis.docs.length;
      });
      final pharmacy = await FirebaseFirestore.instance
          .collection('Pharmacy')
          
          .get();
      // حساب عدد الأطباء
      setState(() {
        treatment = pharmacy.docs.length;
      });
      final DentaldoctorsAppointments = await FirebaseFirestore.instance
          .collection('Appointments')
          .doc('Dentist')
          .collection('Pending')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfDentaldoctorsAppointments =
            DentaldoctorsAppointments.docs.length;
      });
      final DentaldoctorsNumbers = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('Special', isEqualTo: 'Dentist')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numbersOfDentaldoctors = DentaldoctorsNumbers.docs.length;
      });
      final CardiologistsAppointments = await FirebaseFirestore.instance
          .collection('Appointments')
          .doc('Cardiologist')
          .collection('Pending')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfCardiologistsAppointments =
            CardiologistsAppointments.docs.length;
      });
      final CardiologistsNumbers = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('Special', isEqualTo: 'Cardiologist')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numbersOfCardiologists = CardiologistsNumbers.docs.length;
      });
      final PaediatriciansAppointments = await FirebaseFirestore.instance
          .collection('Appointments')
          .doc('Paediatrician')
          .collection('Pending')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfPaediatriciansAppointments =
            PaediatriciansAppointments.docs.length;
      });
      final PaediatricianNumbers = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('Special', isEqualTo: 'Paediatrician')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numbersOfPaediatricians = PaediatricianNumbers.docs.length;
      });
      final ophthalmologistsAppointments = await FirebaseFirestore.instance
          .collection('Appointments')
          .doc('ophthalmologist')
          .collection('Pending')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfophthalmologistsAppointments =
            ophthalmologistsAppointments.docs.length;
      });
      final ophthalmologistNumbers = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('Special', isEqualTo: 'ophthalmologist')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numbersOfophthalmologists = ophthalmologistNumbers.docs.length;
      });
      final OrthopedicdoctorsAppointments = await FirebaseFirestore.instance
          .collection('Appointments')
          .doc('orthopedics')
          .collection('Pending')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numberOfOrthopedicdoctorsAppointments =
            OrthopedicdoctorsAppointments.docs.length;
      });
      final orthopedicsNumbers = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('Special', isEqualTo: 'orthopedics')
          .get();
      // حساب عدد الأطباء
      setState(() {
        numbersOfOrthopedicdoctors = orthopedicsNumbers.docs.length;
      });
    } catch (error) {
      // التعامل مع الأخطاء في حالة حدوثها
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    sum = numberOfCardiologistsAppointments +
        numberOfDentaldoctorsAppointments +
        numberOfOrthopedicdoctorsAppointments +
        numberOfPaediatriciansAppointments +
        numberOfophthalmologistsAppointments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Management Report',style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              // Text(
              //   'February, March and April',
              //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              // ),
              // Text(
              //   '$numberOfDoctors',
              //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              // ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                    DataColumn(label: Text('Total of Number',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Total of Appointments',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Doctors',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numberOfDoctors',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$sum',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Patients',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numberOfPatients',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$sum',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Lab',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numberOfLab',
                        style:
                            TextStyle(fontSize: 19
                            , fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$analysis',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Pharmacy',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numberOfPharmacy',
                        style:
                            TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$treatment',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dental doctors',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numbersOfDentaldoctors',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$numberOfDentaldoctorsAppointments',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Cardiologists',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numbersOfCardiologists',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$numberOfCardiologistsAppointments',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Paediatricians',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numbersOfPaediatricians',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$numberOfPaediatriciansAppointments',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('ophthalmologists',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numbersOfophthalmologists',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$numberOfophthalmologistsAppointments',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Orthopedic doctors',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        '$numbersOfOrthopedicdoctors',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '$numberOfOrthopedicdoctorsAppointments',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                  ],
                ),
              ),
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: doctors, // استدعاء الدالة عند الضغط على الزر
        tooltip: 'جلب البيانات',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
