class ClubEvent {
  String event, email, uid, college, department, club;
  DateTime date;

  ClubEvent(
      {this.event,
      this.email,
      this.date,
      this.college,
      this.department,
      this.uid,
      this.club});

  Map<String, dynamic> toMap() {
    return {
      'event': this.event,
      'email': this.email,
      'date': this.date,
      'college': this.college,
      'department': this.department,
      'uid': this.uid,
      'club': this.club
    };
  }

  ClubEvent.fromMap(Map map) {
    this.event = map['event'];
    this.email = map['email'];
    this.date = map['date'].toDate();
    this.department = map['department'];
    this.college = map['college'];
    this.uid = map['uid'];
    this.club = map['club'];
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}

class FriendEvent {
  String event, uid;
  DateTime date;

  FriendEvent({this.event, this.uid, this.date});

  FriendEvent.fromMap(Map<String, dynamic> map) {
    this.event = map['event'];
    this.uid = map['uid'];
    this.date = map['date'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {'event': this.event, 'uid': this.uid, 'date': this.date};
  }
}
