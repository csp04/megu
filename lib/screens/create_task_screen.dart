import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/bloc/megu_bloc.dart';

import 'package:todo_list_app/constants/constants.dart';
import 'package:todo_list_app/models/category.dart';
import 'package:todo_list_app/models/datetime_holder.dart';
import 'package:todo_list_app/models/task.dart';
import 'package:todo_list_app/widgets/megu_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskScreen extends StatefulWidget {
  final Category category;

  const CreateTaskScreen({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool useDates = false;
  DateTimeHolder start =
      DateTimeHolder(date: DateTime.now(), time: TimeOfDay.now());

  DateTimeHolder end =
      DateTimeHolder(date: DateTime.now(), time: TimeOfDay.now());

  Task entry = Task();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Container _buildBody() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildCategoryTitle(),
                _buildForm(),
              ],
            ),
          ),
          MeguButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                if (useDates) {
                  entry.start = DateTime(
                    start.date.year,
                    start.date.month,
                    start.date.day,
                    start.time.hour,
                    start.time.minute,
                  );
                  entry.end = DateTime(
                    end.date.year,
                    end.date.month,
                    end.date.day,
                    end.time.hour,
                    end.time.minute,
                  );
                }
                context.read<MeguBloc>().add(AddTask(widget.category, entry));
                Navigator.of(context).pop();
              }
            },
            text: 'S A V E',
            textColor: Colors.white,
            backgroundColor: widget.category.color,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        'New task',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.headline6.fontSize,
          color: kAppBarTitleColor,
          letterSpacing: 0.0,
        ),
      ),
      centerTitle: true,
      leading: InkWell(
          borderRadius: BorderRadius.circular(200.0),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
          onTap: () => Navigator.of(context).pop()),
    );
  }

  Widget _buildForm() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
                onSaved: (v) => entry.title = v,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title cannot be empty.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                )),
            TextFormField(
                onSaved: (v) => entry.description = v,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                )),
            SizedBox(
              height: 14.0,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: useDates,
                      onChanged: (checked) {
                        setState(() => useDates = checked);
                      },
                    ),
                    Text('Set date and time',
                        style: TextStyle(
                          fontSize: 16.0,
                        ))
                  ],
                ),
                Row(
                  children: [
                    _buildDatePicker(label: 'Start', dateTime: start),
                    _buildDatePicker(label: 'End', dateTime: end),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker({String label, DateTimeHolder dateTime}) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MeguButton(
                  onPressed: () async {
                    final datePicked = await showDatePicker(
                      context: context,
                      initialDate: dateTime.date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );

                    if (datePicked != null && datePicked != dateTime.date) {
                      setState(() => dateTime.date = datePicked);
                    }
                  },
                  text: DateFormat('yyyy-MM-dd').format(dateTime.date),
                  textColor: Colors.white,
                  backgroundColor: widget.category.color,
                ),
                MeguButton(
                  onPressed: () async {
                    final timePicked = await showTimePicker(
                      context: context,
                      initialTime: dateTime.time,
                    );

                    if (timePicked != null && timePicked != dateTime.time) {
                      setState(() => dateTime.time = timePicked);
                    }
                  },
                  text: '${dateTime.time.hour}:${dateTime.time.minute}',
                  textColor: Colors.white,
                  backgroundColor: widget.category.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle() {
    return Row(
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
            fontSize: 16.0,
            color: kAppBarTitleColor,
            letterSpacing: 0.0,
          ),
        ),
      ],
    );
  }
}
