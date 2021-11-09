import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class RowTextWithTotal extends StatelessWidget {
  //this widget for the planning ahead and last Month Expense
  final String text;
  final String totalAmount;
  final Function onPress;

  RowTextWithTotal({this.text,this.totalAmount,this.onPress});


  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            child: HomeScreenTextWidget(
              text: "$text >",
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              padding: 20,
            ),
            onPressed: onPress,
          ),


          HomeScreenTextWidget(
            text: "$totalAmount SAR",
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey,
            padding: 20,
          ),
        ]);
  }
}

class HomeScreenTextWidget extends StatelessWidget {
  //this widget for the text in the green box.
  HomeScreenTextWidget(
      {this.text, this.fontSize, this.fontWeight, this.color, this.padding});

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class monthlyBillBubble extends StatelessWidget {
  //this widget for the squares which contains monthly bills
  monthlyBillBubble(this.billName, this.billCost, this.billDate,this.billIcon);

  final String billName;
  final String billCost;
  final String billDate;
  final IconData billIcon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(

        children: [
          Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[


                          monthlyBubbleTextStyle(
                          firstText: "", secondText: "$billName ", padding: 0, fontSize: 25,
                        ),

                         Icon(billIcon,
                         size: 25,
                           color: Colors.lightBlueAccent,
                         ),
                        ]
                      ),
                    ),
                    monthlyBubbleTextStyle(
                      firstText: "Cost: ",
                      secondText: "$billCost SAR",
                      padding: 1,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                    monthlyBubbleTextStyle(
                      firstText: "Date: ",
                      secondText: billDate,
                      fontSize: 15,
                      padding: 1,
                    ),


                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class monthlyBubbleTextStyle extends StatelessWidget {

  final String firstText;
  final String secondText;
  final double padding;
  final Color color;
  final double fontSize;



  monthlyBubbleTextStyle({this.firstText,this.secondText,this.padding,this.fontSize,this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(bottom: padding , right:padding ,),
      child: Row(
          children:[
            Text(firstText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold
              ),

            ),
            Text("$secondText",
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: color
              ),
            ),
          ]
      ),
    );
  }
}

class ExpensesBubble extends StatelessWidget {

  final String expenseName;
  final String expenseTotal;
  final IconData expenseIcon;
  final String expenseDate;
  final String expenseTime;
  final bool isLast;


  ExpensesBubble({this.expenseIcon,this.expenseName,this.expenseTotal,this.isLast,this.expenseTime,this.expenseDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.black12
            ),
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.only(
            topLeft: isLast? Radius.circular(10) : Radius.circular(0),
            topRight: isLast? Radius.circular(10) : Radius.circular(0),
          ),
          elevation: 0,
          color: Colors.white,

          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(expenseIcon,
                  size: 30,
                    color: Colors.purple,
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(expenseName,
                          style: TextStyle(
                              fontSize: 25
                          ),),
                        Text('$expenseDate $expenseTime',
                          style: TextStyle(
                              fontSize: 12
                          ),),

                      ]
                  ),
                ),
                Text(expenseTotal,
                  style: TextStyle(
                      fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.right,
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}


