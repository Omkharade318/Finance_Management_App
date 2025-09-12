import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/model/add_data.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final box = Hive.box<AddData>('data');

  final TextEditingController _amount = TextEditingController();
  final TextEditingController _explain = TextEditingController();
  
  DateTime date = DateTime.now();

  FocusNode ex = FocusNode();
  FocusNode amount = FocusNode();

  String? selectedItem;
  String? selectedItem2;

  final List<String> _item = [
    'Food',
    'Education',
    'Transfer',
    'Transportation',
  ];

  final List<String> _item2 = [
    "Income",
    "Expense",
  ];

  @override
  void initState() {
    super.initState();
    ex.addListener(() {
      setState(() {});
    });

    amount.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            backgroundContainer(context),

            Positioned(top: 120, child: mainContainer()),
          ],
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 350,
      child: Column(
        children: [
          SizedBox(height: 50),
          categoryDropdown(),

          SizedBox(height: 30),
          explainField(),

          SizedBox(height: 30),
          amountField(),

          SizedBox(height: 30),
          paymentCategory(),

          SizedBox(height: 30),
          dateTime(),

          Spacer(),
          save(),

          SizedBox(height: 20)

        ],
      ),
    );
  }

  GestureDetector save(){
    return GestureDetector(
      onTap: (){
        var add = AddData(
            selectedItem2!,
            selectedItem!,
            _explain.text,
            _amount.text,
            date
        );

        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFF368983)
        ),
        width: 120,
        height: 50,
        child: Text(
          "Save",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18
          ),
        ),
      ),
    );
  }

  Widget dateTime(){
    return  Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5))
      ),
      width: 300,
      child: TextButton(
          onPressed: () async{
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2024),
                lastDate: DateTime(2100)
            );

            if (newDate == null) return;
            setState(() {
              date = newDate;
            });
          },
          child: Text(
            "Date: ${date.day} / ${date.month} / ${date.year}",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black
            ),
          )
      ),
    );
  }
  Padding paymentCategory(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5)),
        ),
        child: DropdownButton<String>(
          value: selectedItem2,
          items: _item2
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Container(
                child: Row(
                  children: [
                    Text(e, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          )
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map(
                (e) => Container(
              child: Row(
                children: [
                  Text(e, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          )
              .toList(),
          hint: Text(
            "Payment",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xffC5C5C5),
            ),
          ),
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedItem2 = value!;
            });
          },
        ),
      ),
    );
  }

  Padding amountField() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount,
        controller: _amount,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          labelText: "Amount",
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade500,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.grey.shade400),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Color(0xff368983)),
          ),
        ),
      ),
    );
  }

  Padding explainField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        focusNode: ex,
        controller: _explain,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: "Explain",
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.grey.shade400),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Color(0xff368983)),
          ),

        ),
      ),
    );
  }

  Padding categoryDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffC5C5C5)),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          child: Image.asset('assets/images/${e}.png'),
                        ),

                        SizedBox(width: 10),

                        Text(e, style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map(
                (e) => Container(
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        child: Image.asset('assets/images/${e}.png'),
                      ),
                      SizedBox(width: 10),
                      Text(e, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              )
              .toList(),
          hint: Text(
            "Payment Name",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xffC5C5C5),
            ),
          ),
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedItem = value!;
            });
          },
        ),
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Color(0xFF368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),

                    Text(
                      "Adding",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                    Icon(Icons.attach_file_outlined, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
