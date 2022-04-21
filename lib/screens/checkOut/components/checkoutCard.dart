// import 'dart:io';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/components/default_button.dart';
// import 'package:shop_app/controller/cartProvider.dart';
// import 'package:shop_app/screens/checkOut/checkout.dart';
// import 'package:shop_app/screens/widgets/CustomCircular.dart';
//
// import '../../../constants.dart';
// import '../../../main.dart';
// import '../../../size_config.dart';
// class CheckoutCardPAge extends StatefulWidget {
//   var cart;
//   CheckoutCardPAge({
//     cart,
//   });
//   @override
//   _CheckoutCardPAgeState createState() => _CheckoutCardPAgeState();
// }
//
//
//
// class _CheckoutCardPAgeState extends  State<CheckoutCardPAge> {
//
//
//
//
//   pay(context){
//     getIt<CartProvider>().getTotal(context)
//         .then((value){
//       noteDialog(value['data'], context);
//        print(value['data']['deliveryfee']);
//     });
//   }
//
//   paymentMethod(amount, email)async{
//     Charge charge = Charge()
//       ..amount = amount
//       ..reference = _getReference()
//       ..email = email;
//     CheckoutResponse response = await plugin.checkout(
//       context,
//       method: CheckoutMethod.card,
//       charge: charge,
//       // logo: Container(
//       //     width: 50,
//       //     height: 50,
//       //     child: Image.asset(
//       //       "assets/images/fybe2.png",
//       //       fit: BoxFit.contain,
//       //     ))
//     );
//     if (response.status) {
//       print(response.reference);
//       getIt<CartProvider>().getTotal(context)
//           .then((value){
//         // noteDialog(value['data'], context);
//         // print(value['data']['deliveryfee']);
//       });
//     }
//   }
//
//
//
//   noteDialog(data, context) {
//     showDialog(
//         context: context,
//         builder: (ctx) {
//           return BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//             child: AlertDialog(
//               elevation: 6,
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                   BorderRadius.all(Radius.circular(32.0))),
//               content: Container(
//                 height: 220,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Delivery FEE!:',
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 color: Colors.orange,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Container(
//                             // width: MediaQuery.of(context).size.width *
//                             //     0.63,
//                             padding:
//                             EdgeInsets.only(top: 15, bottom: 15),
//                             child:  SelectableText(
//                               '\$${data["deliveryfee"]}',
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 height: 1.3,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total Amount:',
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 color: Colors.orange,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Container(
//                             // width: MediaQuery.of(context).size.width *
//                             //     0.63,
//                             padding:
//                             EdgeInsets.only(top: 15, bottom: 15),
//                             child:  Text(
//                               '\$${data["totalamount"]}',
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 height: 1.3,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width *
//                             0.63,
//                         padding:
//                         EdgeInsets.only(top: 15, bottom: 15),
//                         child:  Text(
//                           'Do you want to continue?',
//                           style: TextStyle(
//                             fontSize: 16,
//                             height: 1.3,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black54,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       ButtonBar(
//                           alignment: MainAxisAlignment.center,
//                           children: [
//                             Material(
//                               borderRadius: BorderRadius.circular(26),
//                               elevation: 2,
//                               child: Container(
//                                 height: 35,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color:  Colors.orange),
//                                     borderRadius:
//                                     BorderRadius.circular(26)),
//                                 child: FlatButton(
//                                   onPressed: () async{
//                                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                                     String? email = prefs.getString('email');
//                                     Navigator.pop(context);
//                                     CartProvider cartProvider = Provider.of<CartProvider>(context,listen: false );
//                                     paymentMethod(int.parse(cartProvider.cartTotal.ceil().toString()) * 100 , email);
//                                   },
//                                   color:  Colors.orange,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.circular(26)),
//                                   padding: EdgeInsets.all(0.0),
//                                   child: Ink(
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius.circular(
//                                             26)),
//                                     child: Container(
//                                       constraints: BoxConstraints(
//                                           maxWidth: 190.0,
//                                           minHeight: 53.0),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "Yes",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight:
//                                             FontWeight.bold,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Material(
//                               borderRadius: BorderRadius.circular(26),
//                               elevation: 2,
//                               child: Container(
//                                 height: 35,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color:  Colors.orange),
//                                     borderRadius:
//                                     BorderRadius.circular(26)),
//                                 child: FlatButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   color:  Colors.orange,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.circular(26)),
//                                   padding: EdgeInsets.all(0.0),
//                                   child: Ink(
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius.circular(
//                                             26)),
//                                     child: Container(
//                                       constraints: BoxConstraints(
//                                           maxWidth: 190.0,
//                                           minHeight: 53.0),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "No",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight:
//                                             FontWeight.bold,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                     ],
//                   ),
//               ),
//             ),
//           );
//         });
//   }
//
//
//   var publicKey = 'pk_test_ce567bbe13275d6c0c3a065506f7c48f397dc633';
//   final plugin = PaystackPlugin();
//
//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }
//     return 'ChargedFrom${platform}_${DateTime
//         .now()
//         .millisecondsSinceEpoch}';
//   }
//
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     plugin.initialize(publicKey: publicKey);
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     CartProvider cartProvider = Provider.of<CartProvider>(context,listen: true );
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: getProportionateScreenWidth(15),
//         horizontal: getProportionateScreenWidth(30),
//       ),
//       // height: 174,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -15),
//             blurRadius: 20,
//             color: Color(0xFFDADADA).withOpacity(0.15),
//           )
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: getProportionateScreenHeight(20)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//
//
//                 Column(
//                   children: [
//                     Text.rich(
//                       TextSpan(
//                         text: "Delivery Fee:\n",
//                         children: [
//                           TextSpan(
//                             text: "₦${cartProvider.deliveryfee.toString()}",
//                             style: TextStyle(fontSize: 16,
//                                 fontFamily: 'Roboto',
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text.rich(
//                       TextSpan(
//                         text: "Total:\n",
//                         children: [
//                           TextSpan(
//                             text: "₦${(cartProvider.cartTotal + cartProvider.deliveryfee).toString()}",
//                             style: TextStyle(fontSize: 16,
//                                 fontFamily: 'Roboto',
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: getProportionateScreenWidth(190),
//                   child: DefaultButton(
//                     text: "PAY",
//                     press: () async{
//                       circularCustom(context);
//                       pay(context);
//
//
//                       // Navigator.push(
//                       //   context,
//                       //   PageRouteBuilder(
//                       //     pageBuilder:
//                       //         (context, animation, secondaryAnimation) {
//                       //       r
//                       //       eturn Checkout();
//                       //     },
//                       //     transitionsBuilder: (context, animation,
//                       //         secondaryAnimation, child) {
//                       //       return FadeTransition(
//                       //         opacity: animation,
//                       //         child: child,
//                       //       );
//                       //     },
//                       //   ),
//                       // );
//
//
//
//
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
