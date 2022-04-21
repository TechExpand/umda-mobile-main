import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/CategoryList.dart';
import 'package:shop_app/models/StoreItem.dart';
import 'package:shop_app/utils/utils.dart' as utils;

class HomeProvider with ChangeNotifier {
  Map<String, dynamic> itemsss = Map();
  HomeProvider() {
    getData();
  }
  bool nointernet = false;
  List itemcategorylist = [];
  List<Category> itemcategorylistdata = [];
  List<StoreItem> itemcategorystoreitemlist = [];
  List<StoreItem> storeitemlist = [];
  List promotionslist = [];
  List<StoreItem> hotsaleslist = [];
  List<StoreItem> regularsaleslist = [];
  String errorText = '';
  bool loading = false;
  isLoading(loading) {
    loading = loading;
    notifyListeners();
  }

  getData() async {
    // function to send the code to the email
    // errorText = '';
    notifyListeners();
    try {
      loading = true;
      nointernet = false;
      notifyListeners();
      // AuthModel authModel = AuthModel(
      //     email: resetpinemailController.text) ;
      var url = Uri.parse('${utils.baseUrl}/indexapi/');
      //print(url) ;
      var response = await http.get(url);
      int statusCode = response.statusCode;
      var body = response.body;
      print(body);
      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        List errorlist = [];
        loading = false;
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          errorText = errorlist.toString();
          notifyListeners();
        });
      } else {
        itemsss = theResponse;
        //print(theResponse);
        itemcategorylist = theResponse['itemcategory'];
        List<Category> brandlist = itemcategorylist
            .map((e) => Category(
                  id: e['id'],
                  desc: '',
                  img: e['image'],
                  name: e['category_name'],
                ))
            .toList();

        itemcategorylistdata = brandlist;
        promotionslist = theResponse['promotions'];

        List hotsales1 = theResponse['hotsales'];
        List<StoreItem> data2 =
            hotsales1.map((e) => StoreItem.fromJson(e)).toList();
        hotsaleslist = data2;
        storeitemlist = data2;

        List regularsales1 = theResponse['regularsales'];

        List<StoreItem> regularsales2 =
            regularsales1.map((e) => StoreItem.fromJson(e)).toList();
        regularsaleslist = regularsales2;

        errorText = '';
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      print('there is errorrr');
      print(e);
      errorText = 'Unable to proceed';
      loading = false;
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        errorText = 'Connection Timeout';
        nointernet = true;
        notifyListeners();
        utils.showToast('Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        nointernet = true;
        notifyListeners();
        errorText = 'No Internet Connection';
        utils.showToast('No Internet Connection');
      } else {
        nointernet = true;
        notifyListeners();
        errorText = 'Unable Proceed';
        utils.showToast('Unable to Proceed');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  getCategoryData(int id) async {
    // function to send the code to the email
    // errorText = '';
    notifyListeners();
    try {
      loading = true;
      nointernet = false;
      notifyListeners();
      // AuthModel authModel = AuthModel(
      //     email: resetpinemailController.text) ;
      var url =
          Uri.parse('${utils.baseUrl}/indexapi/categorydata/?category=$id');
      print(url);
      var response = await http.get(url);
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      print(theResponse);
      loading = false;
      notifyListeners();
      if (statusCode >= 400) {
        List errorlist = [];
        loading = false;
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          errorText = errorlist.toString();
          notifyListeners();
        });
      } else {
        print(theResponse);
        List newdata = theResponse['data'];
        List<StoreItem> datalist =
            newdata.map((e) => StoreItem.fromJson(e)).toList();
        itemcategorystoreitemlist = datalist;
        print(itemcategorystoreitemlist[0].item_image1);

        //id: e['id'], item_english_name: e['item_english_name'], slug: e['slug'], description: e['description'], item_image1: e['item_image1'], e['item_image2']: '', asking_price: e['asking_price'], second_price: e['second_price'], last_price: e['last_price'], quantity_in_stock: e['quantity_in_stock'], food_class: e['food_class'], dietary_list: e['dietary_list'], numerical_quantity_coefficient: e['numerical_quantity_coefficient'], measuring_unit: e['measuring_unit'], other_description: e['other_description'], health_benefits: e['health_benefits'], preparation_method: e['preparation_method'], preservation_method: e['preservation_method'], disposal_method: e['disposal_method'], eat_before: e['eat_before'], item_views: e['item_views'], active: e['active'] )
        // ).toList();
        // itemcategorylistdata = brandlist;
        // promotionslist = theResponse['promotions'];
        // hotsaleslist = theResponse['hotsales'];
        // regularsaleslist = theResponse['regularsales'];
        errorText = '';

        loading = false;
        notifyListeners();
        // utils.showToast(themsg)
        // utils.showInSnackBar(context, 'Check your Email Address to verify');
        //utils.customDialog(context, 'Check your Email Address to verify');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Success(),
        //     ));
      }
    } catch (e) {
      print('errorrr');
      print(e);
      errorText = 'Unable to proceed';
      loading = false;
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        errorText = 'Connection Timeout';
        nointernet = true;
        notifyListeners();
        utils.showToast('Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        nointernet = true;
        notifyListeners();
        errorText = 'No Internet Connection';
        utils.showToast('No Internet Connection');
      } else {
        nointernet = true;
        notifyListeners();
        errorText = 'Unable Proceed';
        utils.showToast('Unable to Proceed');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  List homecards = []; // cards todisplay in home page
  String wallet = '0';
  bool walletshow = true;

  changeHomeCard(List cards) {
    homecards = cards;
    notifyListeners();
  }

  changeWallet(String walletvalue) {
    wallet = walletvalue;
    notifyListeners();
  }

  changeWalletShow() async {
    walletshow = !walletshow;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('walletshow', walletshow);
  }

  // Future getData() async{
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String wallet1 = prefs.getString('wallet');
  // bool walletshow1 = prefs.getBool('walletshow');
  // if(walletshow1!= null){
  //   walletshow = walletshow1;
  //   notifyListeners();
  // }
  // if (wallet1 != null){
  //   wallet = wallet1;
  //   notifyListeners();
  // }
  // }

}
