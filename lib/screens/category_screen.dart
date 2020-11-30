import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/bloc/megu_bloc.dart';

import 'package:todo_list_app/constants/constants.dart';
import 'package:todo_list_app/models/category.dart';
import 'package:todo_list_app/models/task.dart';
import 'package:todo_list_app/screens/create_task_screen.dart';
import 'package:todo_list_app/widgets/expander.dart';
import 'package:todo_list_app/widgets/megu_button.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    context.read<MeguBloc>().add(LoadTasks(widget.category.id));
    super.initState();
  }

  Widget _buildTask(Task task) {
    return _TaskOnExpander(task: task);
  }

  @override
  Widget build(BuildContext context) {
    var category = widget.category;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: InkWell(
                borderRadius: BorderRadius.circular(200.0),
                child: Icon(Icons.arrow_back_ios, color: Colors.black),
                onTap: () => Navigator.of(context).pop()),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: widget.category.color,
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    widget.category.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                      color: kAppBarTitleColor,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<MeguBloc>(context),
                    child: CreateTaskScreen(
                      category: category,
                    ),
                  ),
                )),
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                  color: widget.category.color,
                ),
              ),
              SizedBox(
                width: 4.0,
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: BlocBuilder<MeguBloc, MeguState>(
              buildWhen: (previous, current) => current is GetTasks,
              builder: (context, state) {
                if (state is GetTasks) {
                  var _tasks = state.tasks ?? <Task>[];
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var task = _tasks[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: _tasks.length == 1
                              ? BorderRadius.circular(20.0)
                              : index == 0
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    )
                                  : index == _tasks.length - 1
                                      ? BorderRadius.only(
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        )
                                      : null,
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: _buildTask(task),
                      );
                    }, childCount: _tasks.length),
                  );
                } else {
                  return SliverPadding(
                    padding: EdgeInsets.all(0.0),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _TaskOnExpander extends StatefulWidget {
  final Task task;

  _TaskOnExpander({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  __TaskOnExpanderState createState() => __TaskOnExpanderState();
}

class __TaskOnExpanderState extends State<_TaskOnExpander> {
  ExpanderController _controller = ExpanderController();

  @override
  Widget build(BuildContext context) {
    return Expander(
      controller: _controller,
      header: Row(
        children: [
          FaIcon(
            widget.task.isDone
                ? FontAwesomeIcons.solidCheckCircle
                : FontAwesomeIcons.circle,
            color: Color(0xFFC1C4C7),
          ),
          SizedBox(
            width: 14.0,
          ),
          Text(
            widget.task.title,
            style: TextStyle(
              fontSize: 16.0,
              color: widget.task.isDone ? Color(0xFFC1C4C7) : null,
              decoration:
                  widget.task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          top: 8.0,
          right: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                widget.task.description,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MeguButton(
                  onPressed: () => setState(
                    () {
                      widget.task.isDone
                          ? widget.task.undo()
                          : widget.task.done();
                      _controller.invoke();
                    },
                  ),
                  text: widget.task.isDone ? 'UNDO' : 'DONE',
                  textColor: widget.task.isDone ? Colors.grey : Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
