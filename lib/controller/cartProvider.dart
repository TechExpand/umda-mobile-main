import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/StoreItem.dart';
import 'package:shop_app/models/local_govt.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class CartProvider with ChangeNotifier {
  String baseUrl = 'https://www.umda.mobi/indexapi/getstatesdata/';
  String baseUrl2 = 'https://www.umda.mobi';

  List<BankInfo> allBankList = [];
  String? selectedLga;
  String? selectedLga3;
  String? selectedLga2;

  int cartLength = 1;
  double cartTotal = 0.0;
  int cartLengthTotal = 0;

  setCartLength(bool value) {
    if (value) {
      cartLength++;
    } else {
      if (cartLength <= 1) {
      } else {
        cartLength--;
      }
    }
    notifyListeners();
  }

  setCartTotal(value) {
    cartTotal = value;
    notifyListeners();
  }

  setCartTotalLength(value) {
    cartLengthTotal = value;
    notifyListeners();
  }

  Future<List> getUserCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http
        .get(Uri.parse('https://www.umda.mobi/cartapi/cart/'), headers: {
      "Content-type": "application/json",
      'Authorization': 'Token $token',
    });
    var body = json.decode(response.body);
    return body['results'];
  }

  Future<List> getOrderUserCart(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http.get(
        Uri.parse('https://www.umda.mobi/cartapi/cartordered/?orderid=$id'),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Token $token',
        });
    var body = json.decode(response.body);
    print(id);

    return body['results'];
  }

  Future addCart(StoreItem product, context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var upload = http.MultipartRequest(
          'POST', Uri.parse('https://www.umda.mobi/cartapi/cart/'));
      // var file = await http.MultipartFile.fromPath('file', path);
      // upload.files.add(file);
      upload.fields['item'] = product.id.toString();
      // upload.fields['firstName'] = firstName.toString();
      upload.fields['quantity'] = 1.toString();
      upload.headers['authorization'] = 'Token $token';

      final stream = await upload.send();
      var res = await http.Response.fromStream(stream);

      var body = jsonDecode(res.body);
      print(body.toString());
      if (res.statusCode <= 300) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "item added to cart",
        );
      }
      notifyListeners();
      // if (body['upldRes'] == 'true') {
      //   return true;
      // } else if (body['upldRes'] == 'false') {
      //
      //   return false;
      // }
    } catch (e) {
      return false;
    }
  }

  String deliveryuserregion = '';
  String deliverystate = '';
  String deliverylocalgovt = "";
  String totalamount = "";
  double deliveryfee = 0.0;
  String address = "";
  String phone = "";

  setDeliveryFee(double value) {
    deliveryfee = value;
    notifyListeners();
  }

  Future getTotal(context) async {
    try {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var upload = http.MultipartRequest(
          'POST', Uri.parse('https://www.umda.mobi/orderapi/getorderprice/'));
      // var file = await http.MultipartFile.fromPath('file', path);
      // upload.files.add(file);
      upload.fields['state'] = cartProvider.selectedLga.toString();
      upload.fields['local_government'] = cartProvider.selectedLga2.toString();
      upload.headers['authorization'] = 'Token $token';
      final stream = await upload.send();
      var res = await http.Response.fromStream(stream);
      var body = jsonDecode(res.body);
      // Navigator.pop(context);
      return body;
      notifyListeners();
      // if (body['upldRes'] == 'true') {
      //   return true;
      // } else if (body['upldRes'] == 'false') {
      //
      //   return false;
      // }
    } catch (e) {
      return false;
    }
  }

  Future createOrder({context, payment_ref, total_fee}) async {
    try {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? fullname = prefs.getString('fullname');
      var upload = http.MultipartRequest(
          'POST', Uri.parse('https://www.umda.mobi/orderapi/processorder/'));
      // var file = await http.MultipartFile.fromPath('file', path);
      // upload.files.add(file);
      upload.fields['fullname'] = fullname.toString();
      upload.fields['address'] = cartProvider.address.toString();
      upload.fields['phone_number'] = cartProvider.phone.toString();
      upload.fields['payment_ref'] = payment_ref.toString();
      upload.fields['state'] = cartProvider.selectedLga.toString();
      upload.fields['local_government'] = cartProvider.selectedLga2.toString();
      upload.fields['region'] = cartProvider.deliveryuserregion.toString();
      upload.fields['subtotal'] = cartProvider.cartTotal.toString();
      upload.fields['total_fee'] = total_fee.toString();
      upload.fields['delivery_fee'] = cartProvider.deliveryfee.toString();
      upload.fields['dropoff'] = cartProvider.selectedLga3ID.toString();
      upload.headers['authorization'] = 'Token $token';
      final stream = await upload.send();
      var res = await http.Response.fromStream(stream);
      print(res.body);
      print(res.body);
      print(res.body);

      var body = jsonDecode(res.body);
      // Navigator.pop(context);
      print(body);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return HomeScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
      Fluttertoast.showToast(
        msg: "${body['message'].toString()}",
      );
      return body;
    } catch (e) {
      return false;
    }
  }

  Future increaseCart(productID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var upload = http.MultipartRequest(
          'PATCH', Uri.parse('https://www.umda.mobi/cartapi/cart/'));
      // var file = await http.MultipartFile.fromPath('file', path);
      // upload.files.add(file);
      upload.fields['item'] = productID.toString();
      // upload.fields['firstName'] = firstName.toString();
      upload.fields['statusdata'] = 'add';
      upload.headers['authorization'] = 'Token $token';

      final stream = await upload.send();
      var res = await http.Response.fromStream(stream);

      var body = jsonDecode(res.body);
      print(body.toString());
      notifyListeners();
      // if (body['upldRes'] == 'true') {
      //   return true;
      // } else if (body['upldRes'] == 'false') {
      //
      //   return false;
      // }
    } catch (e) {
      return false;
    }
  }

  Future deleteCart(productID) async {
    print('ggg');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var upload = http.MultipartRequest('DELETE',
          Uri.parse('https://www.umda.mobi/cartapi/deletecart/$productID/'));
      // var file = await http.MultipartFile.fromPath('file', path);
      // upload.files.add(file);
      // upload.fields['item'] = productID.toString();
      // // upload.fields['firstName'] = firstName.toString();
      // upload.fields['statusdata'] = 'remove';
      upload.headers['authorization'] = 'Token $token';

      final stream = await upload.send();
      var res = await http.Response.fromStream(stream);
      var body = jsonDecode(res.body);
      print(body.toString());
      notifyListeners();
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> getAllBank() async {
    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Content-type": "application/json",
        // 'Authorization': 'Bearer $bearer',
      });

      var body1 = json.decode(response.body);
      print(body1);
      notifyListeners();
      return body1;
    } catch (e) {
      print(e);
      print('na error b tat');
    }
  }

  List<dynamic> dropoff = [];

  setDropoff(value) {
    dropoff = value;
    notifyListeners();
  }

  Future<dynamic> getAllStates(state) async {
    print("$baseUrl2/dropoffapi/dropoff/?state=$state");
    try {
      var response = await http.get(
          Uri.parse("$baseUrl2/dropoffapi/dropoff/?state=$state"),
          headers: {
            "Content-type": "application/json",
            // 'Authorization': 'Bearer $bearer',
          });

      var body1 = json.decode(response.body);
      notifyListeners();
      return body1['results'];
    } catch (e) {
      print(e);
      print('na error b tat');
    }
  }

  Future decreaseCart(productID) async {
    print('ggg');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var upload = http.MultipartRequest(
          'PATCH', Uri.parse('https://www.umda.mobi/cartapi/cart/'));
      // var file = await http.MultipartFile.fromPath('file', path);
      // upload.files.add(file);
      upload.fields['item'] = productID.toString();
      // upload.fields['firstName'] = firstName.toString();
      upload.fields['statusdata'] = 'remove';
      upload.headers['authorization'] = 'Token $token';

      final stream = await upload.send();
      var res = await http.Response.fromStream(stream);
      var body = jsonDecode(res.body);
      print(body.toString());
      notifyListeners();
      // if (body['upldRes'] == 'true') {
      //   return true;
      // } else if (body['upldRes'] == 'false') {
      //
      //   return false;
      // }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> searchAPI({searchquery, context, dropdownvalue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var response = await http.get(
          Uri.parse(
              "https://www.umda.mobi/indexapi/searchdata/?searchtype=$dropdownvalue&searchitem=$searchquery"),
          headers: {
            "Content-type": "application/json",
            'Authorization': 'Token $token',
          });

      var body1 = json.decode(response.body);
      print(body1);
      // List body = body1['data'];
      // List<BankInfo> bankLists = body.map((data) {
      //   return BankInfo.fromJson(data);
      // }).toList();
      // allBankList = bankLists;
      // print(allBankList);
      return body1['results'];
    } catch (e) {
      print(e);
      print('na error b tat');
    }
  }

  changeSelectedLga(String lga) {
    selectedLga = lga;
    notifyListeners();
  }

  changeSelectedLga3(lga) {
    selectedLga3 = lga;
    notifyListeners();
  }

  String? selectedLga3ID = "";
  changeSelectedLga3ID(String lga) {
    selectedLga3ID = lga;
    notifyListeners();
  }

  changeSelectedLga2(String lga) {
    selectedLga2 = lga;
    notifyListeners();
  }
}
