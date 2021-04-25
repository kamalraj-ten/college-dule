import 'package:collegedule/event.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {

  final ClubEvent clubEvent;
  final onClick;

  Schedule({this.clubEvent, this.onClick});

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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          this.clubEvent.event,
                          style: TextStyle(fontSize: 20),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                              color: Colors.purple,
                            )
                        ),
                        child: Text(this.clubEvent.date , style: TextStyle(
                          fontSize: 20,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey,
                        )
                      ),
                      child: Text(
                        this.clubEvent.username,
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ]
              )
          ),
          TextButton(onPressed: (){
            onClick();
          }, child: Icon(Icons.clear))],
      ),
    );
  }
}