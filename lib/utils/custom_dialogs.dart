import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogs {

static void showCustomCupertinoDialog(BuildContext context, {String title = 'Oops!', String subtitle = 'Please try again!'}){
  showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
}


}