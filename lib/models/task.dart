class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? reminder;
  String? repeat;
  Task(
      {this.color,
      this.isCompleted,
      this.note,
      this.startTime,
      this.endTime,
      this.title,
      this.reminder,
      this.repeat,
      this.date});

  Task.fromJson(Map<String, dynamic> json) {
    id:json['id'];
    title:json['title'];
    note:json['note'];
    isCompleted:json['isCompleted'];
    date:json['date'];
    startTime:json['startTime'];
    endTime:json['endTime'];
    color:json['color'];
    reminder:json['reminder'];
    repeat:json['repeat'];

    
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'reminder': reminder,
      'repeat': repeat
    };
  }
}
