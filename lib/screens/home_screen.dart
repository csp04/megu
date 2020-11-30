import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/bloc/megu_bloc.dart';
import 'package:todo_list_app/constants/constants.dart';
import 'package:todo_list_app/data/data.dart';

import 'package:todo_list_app/models/category.dart';
import 'package:todo_list_app/models/task.dart';
import 'package:todo_list_app/screens/category_screen.dart';
import 'package:todo_list_app/widgets/category_card.dart';
import 'package:todo_list_app/widgets/text_save_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<MeguBloc>().add(LoadCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            expandedHeight: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'MEGU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline6.fontSize,
                  color: kAppBarTitleColor,
                  letterSpacing: 0.0,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
            sliver: BlocBuilder<MeguBloc, MeguState>(
              buildWhen: (previous, current) => current is GetCategories,
              builder: (_, state) {
                if (state is GetCategories) {
                  var categories = state.categories;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var category = categories[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.0),
                          child: CategoryCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<MeguBloc>(context),
                                    child: CategoryScreen(
                                      category: category,
                                    ),
                                  ),
                                ),
                              );
                            },
                            title: category.title,
                            colorIndicator: category.color,
                            subTitle: (category.taskCount > 0
                                    ? '${category.taskCount}'
                                    : 'No') +
                                ' task' +
                                (category.taskCount > 1 ? 's' : ''),
                            isTitleEditable: !(category is DefaultCategory),
                            onDialogSaved: (v) {
                              var category = categories[index];
                              category.title = v;
                              context
                                  .read<MeguBloc>()
                                  .add(UpdateCategory(category));
                            },
                          ),
                        );
                      },
                      childCount: categories.length,
                    ),
                  );
                } else {
                  return SliverPadding(
                    padding: EdgeInsets.all(0.0),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          child: TextSaveDialog(
            labelText: 'Category',
            onSave: (newValue) => context.read<MeguBloc>().add(
                  AddCategory(
                    Category(
                      title: newValue,
                      id: context.read<MeguBloc>().getCategories().length + 1,
                      color: darkAccents[Random().nextInt(darkAccents.length)],
                    ),
                  ),
                ),
            color: Theme.of(context).accentColor,
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
