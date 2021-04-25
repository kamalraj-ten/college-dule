class ClubEvent {
  String event, email, username, date, college, department;

  ClubEvent(
      {this.event,
      this.email,
      this.date,
      this.college,
      this.department,
      this.username});

  Map<String, dynamic> toMap() {
    return {
      'event': this.event,
      'email': this.email,
      'username': this.username,
      'date': this.date,
      'college': this.college,
      'department': this.department
    };
  }

  ClubEvent.fromMap(Map map) {
    this.event = map['event'];
    this.email = map['email'];
    this.username = map['username'];
    this.date = map['date'];
    this.department = map['department'];
    this.college = map['college'];
  }
}
