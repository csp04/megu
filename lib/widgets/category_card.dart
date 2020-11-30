import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_list_app/widgets/card1.dart';
import 'package:todo_list_app/widgets/text_save_dialog.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final Color colorIndicator;
  final bool isTitleEditable;
  final Function onTap;
  final Function(String) onDialogSaved;

  const CategoryCard({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.colorIndicator,
    this.isTitleEditable = false,
    this.onTap,
    this.onDialogSaved,
  }) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card1(
      onTap: widget.onTap,
      colorIndicator: widget.colorIndicator,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Color(0xFF3D3D49),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    widget.subTitle,
                    style: TextStyle(
                      color: Color(0xFFB5B5BA),
                    ),
                  ),
                ),
              ],
            ),
            widget.isTitleEditable
                ? InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return TextSaveDialog(
                            labelText: 'Category',
                            text: widget.title,
                            onSave: widget.onDialogSaved,
                            color: widget.colorIndicator,
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FaIcon(
                        FontAwesomeIcons.pen,
                        color: Color(0xFFB5B5BA),
                        size: 16.0,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
