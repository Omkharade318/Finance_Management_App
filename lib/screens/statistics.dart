import 'package:finance/data/top.dart';
import 'package:finance/widgets/chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  List day = ['Day', 'Week', 'Month', 'Year'];
  int indexColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Statistics",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(4, (index){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                indexColor = index;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: indexColor == index ? Color.fromARGB(255, 47, 125, 121) : Colors.grey.shade300,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day[index],
                                style: TextStyle(
                                  color: indexColor == index ? Colors.grey.shade300 : Color.fromARGB(255, 47, 125, 121),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2
                              ),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                Icon(
                                    Icons.arrow_downward_sharp,
                                    color: Colors.grey
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Chart(),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Spending",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),

                          Icon(
                            Icons.swap_vert,
                            size: 25,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      leading: Image.asset(
                          'assets/images/${getterTop()[index].image!}',
                          height: 40
                      ),

                      title: Text(
                        getterTop()[index].name!,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      subtitle: Text(
                        getterTop()[index].time!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      trailing: Text(
                        getterTop()[index].fee!,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                childCount: getterTop().length,
              )
              )
            ],
          )
      ),
    );
  }

}