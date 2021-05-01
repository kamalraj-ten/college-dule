class ClubEvent {
  String event, email, uid, date, college, department;

  ClubEvent(
      {this.event,
      this.email,
      this.date,
      this.college,
      this.department,
      this.uid});

  Map<String, dynamic> toMap() {
    return {
      'event': this.event,
      'email': this.email,
      'date': this.date,
      'college': this.college,
      'department': this.department,
      'uid': this.uid
    };
  }

  ClubEvent.fromMap(Map map) {
    this.event = map['event'];
    this.email = map['email'];
    this.date = map['date'];
    this.department = map['department'];
    this.college = map['college'];
    this.uid = map['uid'];
  }
}
