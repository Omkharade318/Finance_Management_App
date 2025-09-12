import 'package:finance/data/list_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/model/add_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var history;
  final box = Hive.box<AddData>('data');

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder( valueListenable: box.listenable(),
            builder: (context, value, child) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 320, child: _head()),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transaction History",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),

                            Text(
                              "See all",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  SliverList(delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        history = box.values.toList()[index];
                        return getList(history, index);
                      },
                      childCount: box.length
                  )
                  )
                ],
              );
            },),
      ),
    );
  }

  Widget getList(AddData history, int index){
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction){
          history.delete();
        },
        child:get(index, history)
    );
  }

  ListTile get(int index, AddData history){
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset("assets/images/${getter()[index].image!}", height: 40),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Text(
        "${day[history.dateTime.weekday -1]} ${history.dateTime.day}-${history.dateTime.month}-${history.dateTime.year}",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      trailing: Text(
        history.amount,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: history.IN == "Income" ? Colors.green : Colors.red
        ),
      ),
    );
  }

  Widget _head(){
    return Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    color: Color(0xFF368983),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    )
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 35,
                        left: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Color.fromRGBO(250, 250, 250, 0.1),
                            child: Icon(
                              Icons.notification_add_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromARGB(255, 224, 223, 233)
                            ),
                          ),

                          Text(
                            "Om Kharade",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white
                            ),
                          ),

                        ],
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),

          Positioned(
            top: 140,
            left: 37,
            child: Container(
              height: 178,
              width: 328,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(47, 125, 121, 0.3),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 6
                  )
                ],
                color: Color.fromARGB(255, 47, 125, 121),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Total Balance",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white
                            )
                        ),

                        Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Text(
                            "Rs 400",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.white,
                            )
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Color.fromARGB(255, 85, 145, 141),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),

                            SizedBox(width: 7),

                            Text(
                                "Income",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:Color.fromARGB(255, 216, 216, 216)
                                )
                            ),
                          ],
                        ),

                        SizedBox(height: 6),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Color.fromARGB(255, 85, 145, 141),
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),

                            SizedBox(width: 7),

                            Text(
                                "Expenses",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:Color.fromARGB(255, 216, 216, 216)
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Rs 200",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white
                            )
                        ),

                        Text(
                            "Rs 80",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]
    );
  }
}