import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/megu_button.dart';

class TextSaveDialog extends StatefulWidget {
  final String labelText;
  final String text;
  final Function(String) onSave;
  final Color color;
  TextSaveDialog({
    Key key,
    @required this.labelText,
    this.text,
    @required this.onSave,
    @required this.color,
  }) : super(key: key);

  @override
  _TextSaveDialogState createState() => _TextSaveDialogState();
}

class _TextSaveDialogState extends State<TextSaveDialog> {
  TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  onSave() {
    _formKey.currentState.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool canSave = widget.text != null && widget.text != '';

    return AlertDialog(
      content: StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  initialValue: widget.text,
                  decoration: InputDecoration(
                    hintText: widget.labelText,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  onSaved: (newValue) => widget.onSave(newValue),
                  onFieldSubmitted: (value) {
                    if (canSave) onSave();
                  },
                  onChanged: (value) => setState(() {
                    canSave = value != '';
                  }),
                ),
                SizedBox(
                  height: 12.0,
                ),
                MeguButton(
                  onPressed: canSave ? () => onSave() : null,
                  disabledBackgroundColor: Colors.grey[300],
                  backgroundColor: widget.color,
                  textColor: Colors.white,
                  text: 'SAVE',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
