part of 'megu_bloc.dart';

@immutable
abstract class MeguState {}

class MeguInitial extends MeguState {}

class GetCategories extends MeguState {
  final List<Category> categories;
  GetCategories(this.categories);
}

class GetTasks extends MeguState {
  final List<Task> tasks;

  GetTasks(this.tasks);
}
