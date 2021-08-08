import 'package:flutter/material.dart';

import 'constants.dart';

class DialogUtil {
  static void showCustomDialog({
    @required BuildContext context,
    Function onAlertDialogOptionSelected,
    @required String strMessage,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext mContext) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              contentPadding: EdgeInsets.all(8.0),
              titlePadding: EdgeInsets.all(8.0),
              title: Padding(
                padding: const EdgeInsets.only(left: 8.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      APEX_ASSESSMENT,
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                  ],
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 8.5, right: 8.5),
                child: new Text(
                  strMessage,
                ),
              ),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      onAlertDialogOptionSelected();
                      Navigator.pop(mContext);
                    },
                    child: new Text(
                      'No',
                    )),
                new TextButton(
                    onPressed: () {
                      onAlertDialogOptionSelected();
                      Navigator.pop(mContext);
                    },
                    child: new Text(
                      'Yes',
                    )),
              ],
            ),
          );
        });
  }
}
