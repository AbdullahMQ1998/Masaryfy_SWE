import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';




  showIOSGeneralAlert(BuildContext context, String text){

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: Text(text),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Confirm'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ],
      ),
    );
  }





showErrorAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Make sure you have filled the required information"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


showGeneralErrorAlertDialog(BuildContext context, String title , String text) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



showEmailAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Make sure you have enter a vaild email"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



showAlertDialogForExpense(BuildContext context , bool shouldDelete,QueryDocumentSnapshot userInfoList, QueryDocumentSnapshot userExpenseList) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      //Here we Delete the current Expense

      double currentExpenseCost = double.parse(userExpenseList.get('expenseCost'));
      double currentTotalBudget = double.parse(userInfoList.get('userBudget'));
      double currentTotalExpense = double.parse(userInfoList.get('totalExpense'));
      double updatedTotalBudget = currentTotalBudget + currentExpenseCost;
      double updatedTotalExpense = currentTotalExpense - currentExpenseCost;

      userInfoList.reference.update({'userBudget': updatedTotalBudget.toString()});
      userInfoList.reference.update({'totalExpense': updatedTotalExpense.toString()});

      userExpenseList.reference.delete();

      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Expense"),
    content: Text("Would you like to delete the current expense?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



showAlertDialogForMonthlyBill(BuildContext context , bool shouldDelete,QueryDocumentSnapshot userInfo, QueryDocumentSnapshot userMonthlyBillList) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      //Here we Delete the current Expense

      double currentMonthlyBillCost = double.parse(userMonthlyBillList.get('billCost'));
      double currentTotalBudget = double.parse(userInfo.get('userBudget'));
      double currentTotalMonthlyBillCost = double.parse(userInfo.get('totalMonthlyBillCost'));
      double updatedTotalBudget = currentTotalBudget + currentTotalMonthlyBillCost;
      double updatedTotalMonthlyBillCost = currentTotalMonthlyBillCost - currentTotalMonthlyBillCost;

      userInfo.reference.update({'userBudget': updatedTotalBudget.toString()});
      userInfo.reference.update({'totalMonthlyBillCost': updatedTotalMonthlyBillCost.toString()});

      userMonthlyBillList.reference.delete();

      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Bill"),
    content: Text("Would you like to delete the current monthly bill?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}