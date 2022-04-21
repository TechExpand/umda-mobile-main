


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



bool shouldPop = false;

circularCustom(context)async{
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope (
          onWillPop: () async {
            return shouldPop;
          },
          child: Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            child:  Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 11,
                width: MediaQuery.of(context).size.width,
                child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  backgroundColor: Colors.white70,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        );
      });
}






