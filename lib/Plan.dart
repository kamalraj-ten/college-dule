import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Plan {
  String text, date;
  String id;

  Plan({@required this.text, this.date}){
    var uuid = Uuid();
    id = uuid.v1();
  }

  static List<Plan> plans = [
    Plan(text: "wow a great first event", date: "11-12-2020"),
    Plan(text: "wow a great second event", date: "12-12-2020"),
    Plan(text: "wow a great third event", date: "13-12-2020"),
    Plan(text: "wow a great fourth event", date: "14-12-2020"),
    Plan(text: "wow a great fifth event", date: "14-12-2020"),
    Plan(text: "wow a great sixth event", date: "14-12-2020"),
    Plan(text: "wow a great seventh event", date: "14-12-2020"),
    Plan(text: "wow a great eighth event", date: "14-12-2020"),
    Plan(text: "wow a great ninth event", date: "14-12-2020"),
  ];


  static void removePlan(String id) {
    plans.removeWhere((element) => element.id == id);
  }
}

class Schedule extends StatelessWidget {

  final text, date, id, onClick;

  Schedule({this.text, this.date, this.id, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: Text(
                          this.text,
                          style: TextStyle(fontSize: 20),
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                              color: Colors.purple,
                            )
                        ),
                        child: Text(this.date , style: TextStyle(
                          fontSize: 20,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        )),
                  ]
              )
          ),
          TextButton(onPressed: (){
            onClick(id);
          }, child: Icon(Icons.clear))],
      ),
    );
  }
}


class Schedules extends StatefulWidget {
  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {

  List<Plan> plans = Plan.plans;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Plan.plans.length,
        itemBuilder: (context, index) {
      return Schedule(text: plans[index].text, date: plans[index].date, id: plans[index].id, onClick: removePlan);
    });
  }

  void removePlan(String id) {
    setState(() {
      this.plans.removeWhere((element) => element.id == id);
    });
  }
}

