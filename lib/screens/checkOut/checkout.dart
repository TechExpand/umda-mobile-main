import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import 'package:shop_app/screens/widgets/CustomCircular.dart';

import '../../main.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/checkoutCard.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  static String routeName = "/cart";

  List states = [];
  List dropoff = [];
  Map lga = {};

  var publicKey = 'pk_test_ce567bbe13275d6c0c3a065506f7c48f397dc633';
  final plugin = PaystackPlugin();

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime
        .now()
        .millisecondsSinceEpoch}';
  }

  paymentMethod(amount, email)async{
    Charge charge = Charge()
      ..amount = amount
      ..reference = _getReference()
      ..email = email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      // logo: Container(
      //     width: 50,
      //     height: 50,
      //     child: Image.asset(
      //       "assets/images/fybe2.png",
      //       fit: BoxFit.contain,
      //     ))
    );
    if (response.status) {
      print(response.reference);
      getIt<CartProvider>().getTotal(context)
          .then((value){
        getIt<CartProvider>().createOrder(
          payment_ref: response.reference,
          total_fee: amount,
          context: context
        );
        // noteDialog(value['data'], context);
        // print(value['data']['deliveryfee']);
      });
    }
  }
  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    CartProvider cartProvider =
    Provider.of<CartProvider>(context, listen: false);


    getIt<CartProvider>().getAllBank().then((value) {
      setState(() {
        states = value['states'];
        lga = value['local_govt'];
        print(lga);
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'State'
                      '',
                      style: TextStyle(
                        color: Color(0xFF141414).withOpacity(0.35),
                      ),
                    )),
              ),
              StatefulBuilder(builder: (context, set) {
                return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: InkWell(
                      onTap: states.length == 0
                          ? () {}
                          : () {
                              result = states;
                              bankDialog(context, set);
                              // set((){
                              //   print('');
                              // });
                            },
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          cursorColor: Color(0xC2141414),
                          enabled: false,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: cartProvider.selectedLga == null
                                ? "Select State"
                                : cartProvider.selectedLga,
                            hintStyle: TextStyle(color: Color(0xC2141414)),
                            focusColor: Color(0xC2141414),
                            border: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0x59141414), width: 2.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0x59141414), width: 2.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0x59141414), width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
              cartProvider.selectedLga == "Abuja"
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 10, top: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'L.G.A'
                            '',
                            style: TextStyle(
                              color: Color(0xFF141414).withOpacity(0.35),
                            ),
                          )),
                    ),
              cartProvider.selectedLga == "Abuja"
                  ? Container()
                  : StatefulBuilder(builder: (context, set) {
                      return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: InkWell(
                            onTap: states.length == 0 ||
                                    cartProvider.selectedLga == null
                                ? () {}
                                : () {
                                    result2 =
                                        lga['${cartProvider.selectedLga}'];
                                    bankDialog2(context, set);
                                  },
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                cursorColor: Color(0xC2141414),
                                enabled: false,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  hintText: cartProvider.selectedLga2 == null
                                      ? "Select L.G.A"
                                      : cartProvider.selectedLga2,
                                  hintStyle:
                                      TextStyle(color: Color(0xC2141414)),
                                  focusColor: Color(0xC2141414),
                                  border: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0x59141414), width: 2.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0x59141414), width: 2.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0x59141414), width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ));
                    }),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Drop Off (optional)'
                          '',
                      style: TextStyle(
                        color: Color(0xFF141414).withOpacity(0.35),
                      ),
                    )),
              ),
              StatefulBuilder(builder: (context, set) {
                return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: InkWell(
                      onTap: cartProvider.dropoff.length == 0
                          ? () {}
                          : () {
                        result3 = cartProvider.dropoff;
                        bankDialog3(context, set);
                      },
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          cursorColor: Color(0xC2141414),
                          enabled: false,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: cartProvider.selectedLga3 == null
                                ? "Select Drop off"
                                : cartProvider.selectedLga3,
                            hintStyle: TextStyle(color: Color(0xC2141414)),
                            focusColor: Color(0xC2141414),
                            border: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0x59141414), width: 2.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0x59141414), width: 2.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0x59141414), width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Address'
                      '',
                      style: TextStyle(
                        color: Color(0xFF141414).withOpacity(0.35),
                      ),
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    cartProvider.address = value;
                  },
                  // controller: getIt<AuthProvider>().registerconfirmpasswordController,
                  // onSaved: (newValue) => conform_password = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "address cannot be empty";
                    } else {}
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 0.55)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 0.55)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 0.55)),
                    // labelText: "Address",
                    hintText: "ring road bus stop",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.map_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Phone'
                      '',
                      style: TextStyle(
                        color: Color(0xFF141414).withOpacity(0.35),
                      ),
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  // controller: getIt<AuthProvider>().registerconfirmpasswordController,
                  // onSaved: (newValue) => conform_password = newValue,
                  onChanged: (value) {
                    cartProvider.phone = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone cannot be empty";
                    } else {}
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.55, color: Colors.black26)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.55, color: Colors.black26)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.55, color: Colors.black26)),
                    // labelText: "Address",
                    hintText: "8000000000",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Delivery Fee:\n",
                          children: [
                            TextSpan(
                              text: "₦${cartProvider.deliveryfee.toString()}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text:
                                  "₦${(cartProvider.cartTotal + cartProvider.deliveryfee).toString()}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "PAY",
                      press: () async {
                        if (cartProvider.address.isEmpty ||
                            cartProvider.selectedLga!.isEmpty ||
                            cartProvider.selectedLga2!.isEmpty ||
                            cartProvider.phone.isEmpty
                        // ||
                        // cartProvider.selectedLga3!.isEmpty
                        ) {
                          Fluttertoast.showToast(
                              msg: "Fields are required",
                          );
                        }else{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? email = prefs.getString('email');
                          CartProvider cartProvider = Provider.of<CartProvider>(context,listen: false );
                          paymentMethod(cartProvider.cartTotal.ceil()*100+cartProvider.deliveryfee.ceil()*100  , email);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    return AppBar(
      title: Column(
        children: [
          Text(
            "Check Out",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cartProvider.cartLengthTotal} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  pay(context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    getIt<CartProvider>().getTotal(context).then((value) {
      // print('ddd');
      cartProvider.deliveryuserregion = value['data']['deliveryuserregion'];
      cartProvider.setDeliveryFee(
          double.parse(value['data']['deliveryfee'].toString()));
      print(value);
      print('kkk');
    });
  }

  List result = [];

  void searchBank(userInputValue) {
    // BankProvider postRequestProvider =
    // Provider.of<BankProvider>(context, listen: false);
    result = states;
    result = result
        .where((lga) =>
            lga.toString().toLowerCase().contains(userInputValue.toLowerCase()))
        .toList();
  }

  List result3 = [];

  void searchBank3(userInputValue) {
    // BankProvider postRequestProvider =
    // Provider.of<BankProvider>(context, listen: false);
    result3 = dropoff;
    result3 = result3
        .where((dropoff) =>
        dropoff['address'].toString().toLowerCase().contains(userInputValue.toLowerCase()))
        .toList();
  }

  bankDialog3(ctx, set) {
    // BankProvider postRequestProvider =
    // Provider.of<BankProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return AlertDialog(
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(new Radius.circular(50.0)),
                  ),
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 500,
                          child: ListView.builder(
                            itemCount: result3.length,
                            itemBuilder: (context, index) {
                              result3.sort((a, b) {
                                var ad = a;
                                var bd = b;
                                var s = ad!.compareTo(bd!);
                                return s;
                              });

                              return InkWell(
                                onTap: () {
                                  CartProvider cartProvider =
                                  Provider.of<CartProvider>(context,
                                      listen: false);
                                  Navigator.pop(context);
                                  cartProvider.changeSelectedLga3(result3[index]['office_name']+" "+result3[index]['address']);
                                  cartProvider.changeSelectedLga3ID(result3[index]['id'].toString());

                                  // getIt<CartProvider>().getAllStates(cartProvider.selectedLga).then((value) {
                                  //   print(value);
                                  //   cartProvider.setDropoff(value);
                                  //   // setState(() {
                                  //   //   states = value['states'];
                                  //   //   lga = value['local_govt'];
                                  //   //   print(lga);
                                  //   // });
                                  // });

                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                    Colors.orangeAccent.withOpacity(0.6),
                                    child: Text(
                                        result3[index]['office_name']
                                            .toString()
                                            .substring(0, 2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  title: Text(
                                    '${result3[index]['office_name']}',
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          '${result3[index]['phone_number']}',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          '${result3[index]['address']}',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).then((v) {
      set(() {});
    });
  }



  bankDialog(ctx, set) {
    // BankProvider postRequestProvider =
    // Provider.of<BankProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return AlertDialog(
                title: TextFormField(
                  onChanged: (value) {
                    setStates(() {
                      searchBank(value);
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Search State',
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(new Radius.circular(50.0)),
                  ),
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 500,
                          child: ListView.builder(
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              result.sort((a, b) {
                                var ad = a;
                                var bd = b;
                                var s = ad!.compareTo(bd!);
                                return s;
                              });

                              return InkWell(
                                onTap: () {
                                  CartProvider cartProvider =
                                  Provider.of<CartProvider>(context,
                                      listen: false);
                                  Navigator.pop(context);
                                  cartProvider.changeSelectedLga(result[index]);
                                  cartProvider.selectedLga == "Abuja"
                                      ? cartProvider.setDeliveryFee(15000)
                                      : null;



                                  getIt<CartProvider>().getAllStates(cartProvider.selectedLga).then((value) {
                                    print(value);
                                     cartProvider.setDropoff(value);
                                    // setState(() {
                                    //   states = value['states'];
                                    //   lga = value['local_govt'];
                                    //   print(lga);
                                    // });
                                  });

                                  cartProvider.changeSelectedLga3ID('');
                                  cartProvider.changeSelectedLga3(null);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Colors.orangeAccent.withOpacity(0.6),
                                    child: Text(
                                        result[index]
                                            .toString()
                                            .substring(0, 2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  title: Text(
                                    '${result[index]}',
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).then((v) {
      set(() {});
    });
  }

  List result2 = [];

  void searchBank2(userInputValue) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    result2 = lga['${cartProvider.selectedLga}'];
    result2 = result2
        .where((lga) =>
            lga.toString().toLowerCase().contains(userInputValue.toLowerCase()))
        .toList();
  }

  bankDialog2(ctx, set) {
    // BankProvider postRequestProvider =
    // Provider.of<BankProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return AlertDialog(
                title: TextFormField(
                  onChanged: (value) {
                    setStates(() {
                      searchBank(value);
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Search LGA',
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(new Radius.circular(50.0)),
                  ),
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 500,
                          child: ListView.builder(
                            itemCount: result2.length,
                            itemBuilder: (context, index) {
                              result2.sort((a, b) {
                                var ad = a;
                                var bd = b;
                                var s = ad!.compareTo(bd!);
                                return s;
                              });

                              return InkWell(
                                onTap: () {
                                  CartProvider cartProvider =
                                      Provider.of<CartProvider>(context,
                                          listen: false);
                                  Navigator.of(context).pop();
                                  cartProvider
                                      .changeSelectedLga2(result2[index]);

                                  pay(context);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Colors.orangeAccent.withOpacity(0.6),
                                    child: Text(
                                        result2[index]
                                            .toString()
                                            .substring(0, 2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  title: Text(
                                    '${result2[index]}',
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).then((v) {
      set(() {});
    });
  }
}
