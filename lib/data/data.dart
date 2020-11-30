import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo_list_app/models/category.dart';
import 'package:todo_list_app/models/task.dart';

List<Category> categories = <Category>[
  DefaultCategory(
    id: 1,
    title: 'General',
    color: Color(0xFF3068DE),
  ),
  Category(
    id: 2,
    title: 'Meetings',
    color: Color(0xFFF65D27),
  ),
  Category(
    id: 3,
    title: 'Trip',
    color: Color(0xFF1DBCBF),
  ),
];

Map<int, List<Task>> tasks = {
  1: <Task>[
    Task(title: 'Morning exercise', description: 'Push ups\nCurl ups'),
    Task(title: 'Breakfast', description: 'Egg sandwich')..done(),
  ],
  2: <Task>[]
};

List<Color> darkAccents = Colors.accents
    .where((color) =>
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark)
    .toList();
