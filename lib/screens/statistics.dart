import 'package:finance/data/model/add_data.dart';
import 'package:finance/data/utility.dart';
import 'package:finance/widgets/chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  List day = ['Day', 'Week', 'Month', 'Year'];
  List time = [today(), week(), month(), year()];

  List<AddData> a =[];

  int indexColor = 0;

  ValueNotifier vn = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: vn,
                builder: (context, value, child) {
                  a = time[value];
                  return statistics();
                }
            )
        )
    );
  }

  CustomScrollView statistics(){
    return CustomScrollView(
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
                          vn.value = index;
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

              Chart(
                indexX: indexColor,
              ),

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
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset("assets/images/${a[index].name}.png", height: 40),
              ),
              title: Text(
                a[index].name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              subtitle: Text(
                "${a[index].dateTime.day} ${a[index].dateTime.month}-${a[index].dateTime.year}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              trailing: Text(
                "Rs ${a[index].amount}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: a[index].IN == "Income" ? Colors.green : Colors.red
                ),
              ),
            );
          },
          childCount: a.length,
        )
        )
      ],
    );
  }

}