class Task {
  String title;
  String description;
  DateTime start;
  DateTime end;

  DateTime _created;
  DateTime get created => _created;

  DateTime _completedAt;

  DateTime get completedAt => _completedAt;

  Task({
    this.title,
    this.description,
    this.start,
    this.end,
  }) : _created = DateTime.now();

  bool get isDone => _completedAt != null;
  void done() => _completedAt = DateTime.now();
  void undo() => _completedAt = null;
}
