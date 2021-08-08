import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialogs {
  static bool isLoading = false;
  static Future<void> showProgressDialog(BuildContext context) async {
    if (!isLoading) {
      isLoading = true;
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              children: <Widget>[
                Center(
                  child: Container(
                      child:CircularProgressIndicator()),
                )
              ],
            ),
          );
        },
      );
    }
  }

  static void hideProgressDialog(BuildContext context) {
    if (isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
      isLoading = false;
    }
  }
}
