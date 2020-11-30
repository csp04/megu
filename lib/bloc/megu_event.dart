part of 'megu_bloc.dart';

@immutable
abstract class MeguEvent {}

class LoadCategories extends MeguEvent {}

class LoadTasks extends MeguEvent {
  final int id;

  LoadTasks(this.id);
}

class AddCategory extends MeguEvent {
  final Category category;
  AddCategory(this.category);
}

class UpdateCategory extends MeguEvent {
  final Category category;
  UpdateCategory(this.category);
}

class AddTask extends MeguEvent {
  final Category category;
  final Task task;

  AddTask(this.category, this.task);
}
