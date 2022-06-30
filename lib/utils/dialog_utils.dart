import 'package:flutter/material.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static  showCustomDialog(BuildContext context,
      {@required String title,
        String details,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        @required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(details),
            actions: <Widget>[
              Visibility(
                visible: false,
                child: FlatButton(
                  child: Text(okBtnText),
                  onPressed: okBtnFunction,
                ),
              ),
              FlatButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }
}