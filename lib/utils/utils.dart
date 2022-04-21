import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String baseUrl = 'https://www.umda.mobi';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
final navigatorKey = GlobalKey<NavigatorState>();

void showInSnackBar(BuildContext context, String value) {
  //_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      //key: scaffoldKey,
      content: Text(value),
    ),
  );
}

Future customDialog(BuildContext context, String text) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 16,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              // mainAxisAlignment: Main,
              children: [
                Image.asset(
                  'assets/images/go.png',
                  height: MediaQuery.of(context).size.height / 5,
                ),
                SizedBox(
                  height: 13,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$text',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )),
                SizedBox(
                  height: 13,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

showMyDialog(BuildContext ctx, String image, String title, String text) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    builder: (BuildContext context) => SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            image,
            height: 110.0,
            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            title,
            style: _txtCustomHead,
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            text,
            style: _txtCustomSub,
          ),
        )),
      ],
    ),
  );
}

var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Custom Text Description for Dialog after user succes payment
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);

void showToast(themsg) {
  Fluttertoast.showToast(
      msg: themsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
