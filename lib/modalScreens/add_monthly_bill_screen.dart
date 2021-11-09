import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/home_screen.dart';

class AddMonthlyBillScreen extends StatefulWidget {
  final Function addMonthlyBill;
  final User loggedUser;
  final List<QueryDocumentSnapshot> userInfo;

  AddMonthlyBillScreen(this.addMonthlyBill, this.loggedUser, this.userInfo);

  @override
  _AddMonthlyBillScreenState createState() => _AddMonthlyBillScreenState();
}

class _AddMonthlyBillScreenState extends State<AddMonthlyBillScreen> {
  String monthlyBillName;
  String monthlyBillCost;
  // ignore: non_constant_identifier_names
  int monthlyBill_Id;
  DateTime selectedDate = DateTime.now();
  bool isEnabled = false;
  String formattedDate;
  String formattedTime;
  double currentTotalMonthlyBill;
  double currentTotalIncome;
  final _fireStore = FirebaseFirestore.instance;
  String dropdownValue = 'Phone';

  bool checkNullorSpace() {
    if (monthlyBillName != null &&
        monthlyBillName != '' &&
        monthlyBillCost != null &&
        monthlyBillCost != '' &&
        formattedDate != null &&
        formattedDate != '' &&
        formattedTime != null &&
        formattedTime != '') {
      return true;
    } else {
      return false;
    }
  }


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        isEnabled = true;
        print(selectedDate);
      });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: Column(
          children: [
            Text(
              'Add Monthly Bill',
              style: TextStyle(
                  color: Color(0xff50c878),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 20, bottom: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        monthlyBillName = text;
                      });
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Bill name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        monthlyBillCost = value;
                      });
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Bill cost',
                      suffixText: 'SAR',
                      suffixStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 10,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1,
                    color: Color(0xff50c878),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Rent',
                    'Water',
                    'Internet',
                    'Phone',
                    'Electric',
                    'installment',
                  ]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ]),
            ),

            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text(isEnabled? formattedDate : 'Select Bill Date',
                style:
                TextStyle(color: Colors.white
                    , fontWeight: FontWeight.bold),
              ),
              color: Color(0xff50c878),
            ),

            FlatButton(
              onPressed: () {

                formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                formattedTime = DateFormat().add_jm().format(selectedDate);

                if (checkNullorSpace()) {
                  //Update MonthlyIncome.
                  currentTotalIncome = double.parse(widget.userInfo[0].get('monthlyIncome'));
                  currentTotalIncome -= double.parse(monthlyBillCost);
                  widget.userInfo[0].reference.update({'monthlyIncome': currentTotalIncome.toString()});


                  //Update The total for monthly bills
                  currentTotalMonthlyBill = double.parse(widget.userInfo[0].get('totalMonthlyBillCost'));
                  currentTotalMonthlyBill += double.parse(monthlyBillCost);
                  widget.userInfo[0].reference.update({'totalMonthlyBillCost': currentTotalMonthlyBill.toString()});


                  //Update the ID for the bills
                  monthlyBill_Id = widget.userInfo[0].get('expenseNumber');
                  monthlyBill_Id += 1;
                  widget.userInfo[0].reference.update({'expenseNumber': monthlyBill_Id});

                  _fireStore.collection('monthly_bills').add({
                    'email': widget.loggedUser.email,
                    'billCost': monthlyBillCost,
                    'billDate': formattedDate,
                    'billName': monthlyBillName,
                    'bill_ID': monthlyBill_Id,
                    'billIcon': dropdownValue,
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  Alert(
                          context: context,
                          title: "ERROR",
                          desc:
                              "Make sure you have filled the required information")
                      .show();
                }
              },
              child: Text(
                'Add',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              color: Color(0xff50c878),
            ),
          ],
        ),
      ),
    );
  }
}