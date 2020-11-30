import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list_app/data/data.dart';
import 'package:todo_list_app/models/category.dart';
import 'package:todo_list_app/models/task.dart';

part 'megu_event.dart';
part 'megu_state.dart';

class MeguBloc extends Bloc<MeguEvent, MeguState> {
  MeguBloc() : super(MeguInitial());

  List<Category> getCategories() {
    for (var c in categories) {
      if (tasks.containsKey(c.id)) {
        c.taskCount = tasks[c.id].length;
      } else
        c.taskCount = 0;
    }

    return categories;
  }

  @override
  Stream<MeguState> mapEventToState(
    MeguEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield GetCategories(getCategories());
    } else if (event is AddCategory) {
      categories.add(event.category);
      yield GetCategories(getCategories());
    } else if (event is UpdateCategory) {
      yield GetCategories(getCategories());
    } else if (event is LoadTasks) {
      yield GetTasks(tasks[event.id]);
    } else if (event is AddTask) {
      var _tasks = tasks[event.category.id] ??= <Task>[];
      _tasks.insert(0, event.task);

      yield GetTasks(tasks[event.category.id]);
      yield GetCategories(getCategories());
    }
  }
}
