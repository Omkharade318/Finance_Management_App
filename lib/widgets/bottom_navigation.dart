import 'package:finance/screens/add.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/statistics.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {

  int indexColor = 0;
  List screen = [
    Home(),
    Statistics(),
    Home(),
    Statistics(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexColor],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddScreen()));
        },
        backgroundColor: Color(0xff368983),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  indexColor = 0;
                });
              },
              child: Icon(
                Icons.home,
                size: 34,
                color: indexColor == 0 ? Color(0xff368983) : Colors.grey,
              ),
            ),

            GestureDetector(
              onTap: (){
                setState(() {
                  indexColor = 1;
                });
              },
              child: Icon(
                Icons.bar_chart_outlined,
                size: 34,
                color: indexColor == 1 ? Color(0xff368983) : Colors.grey,
              ),
            ),

            GestureDetector(
              onTap: (){
                setState(() {
                  indexColor = 2;
                });
              },
              child: Icon(
                Icons.account_balance_wallet_outlined,
                size: 34,
                color: indexColor == 2 ? Color(0xff368983) : Colors.grey,
              ),
            ),

            GestureDetector(
              onTap: (){
                setState(() {
                  indexColor = 3;
                });
              },
              child: Icon(
                Icons.person_4_outlined,
                size: 34,
                color: indexColor == 3 ? Color(0xff368983) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
