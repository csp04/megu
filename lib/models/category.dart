import 'package:flutter/material.dart';

class Category {
  final int id;
  String title;
  final Color color;
  int taskCount;
  Category({
    this.id,
    this.title,
    this.color,
    this.taskCount,
  });
}

class DefaultCategory extends Category {
  DefaultCategory({
    id,
    title,
    color,
    taskCount,
  }) : super(
          id: id,
          title: title,
          color: color,
          taskCount: taskCount,
        );
}
