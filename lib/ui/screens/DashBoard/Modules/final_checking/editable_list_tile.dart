import 'package:flutter/material.dart';
import 'package:soleoserp/models/common/final_checking_items.dart';

class EditableListTile extends StatefulWidget {
  final FinalCheckingItems model;
  final Function(FinalCheckingItems listModel) onChanged;
  EditableListTile({Key key, this.model, this.onChanged})
      : assert(model != null),
        super(key: key);

  @override
  _EditableListTileState createState() => _EditableListTileState();
}

class _EditableListTileState extends State<EditableListTile> {
  FinalCheckingItems model;

  bool _isEditingMode;

  TextEditingController _titleEditingController, _subTitleEditingController;

  @override
  void initState() {
    super.initState();
    this.model = widget.model;
    this._isEditingMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: titleWidget,
      subtitle: subTitleWidget,
      trailing: tralingButton,
    );
  }

  Widget get titleWidget {
    if (_isEditingMode) {
      _titleEditingController = TextEditingController(text: model.Item);
      return TextField(
        controller: _titleEditingController,
      );
    } else
      return Text(model.Item);
  }

  Widget get subTitleWidget {
    if (_isEditingMode) {
      _subTitleEditingController = TextEditingController(text: model.SerialNo);
      return TextField(
        controller: _subTitleEditingController,
      );
    } else
      return Text(model.SerialNo);
  }

  Widget get tralingButton {
    if (_isEditingMode) {
      return IconButton(
        icon: Icon(Icons.check),
        onPressed: saveChange,
      );
    } else
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: _toggleMode,
      );
  }

  void _toggleMode() {
    setState(() {
      _isEditingMode = !_isEditingMode;
    });
  }

  void saveChange() {
    this.model.Item = _titleEditingController.text;
    this.model.SerialNo = _subTitleEditingController.text;
    _toggleMode();
    if (widget.onChanged != null) {
      widget.onChanged(this.model);
    }
  }
}