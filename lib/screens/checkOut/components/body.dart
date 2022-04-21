// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/controller/cartProvider.dart';
//
// import '../../../main.dart';
//
//
// class CheckOutBody extends StatefulWidget {
//   const CheckOutBody({Key? key}) : super(key: key);
//
//   @override
//   _CheckOutBodyState createState() => _CheckOutBodyState();
// }
//
// class _CheckOutBodyState extends State<CheckOutBody> {
//
//   List states =  [];
//   Map lga = {};
//
//   @override
//   void initState() {
//     getIt<CartProvider>().getAllBank().then((value){
//       setState(() {
//         states = value['states'];
//         lga = value['local_govt'];
//         print(lga);
//       });
//     });
//     // TODO: implement initState
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     CartProvider cartProvider = Provider.of<CartProvider>(context );
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left:20.0, bottom: 10,top:10),
//               child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text('State'
//                       '', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
//             ),
//             StatefulBuilder(
//               builder: (context, set) {
//                 return Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20, ),
//                     child: InkWell(
//                       onTap: states.length == 0 ?(){}:(){
//                         result = states;
//                         bankDialog(context, set);
//                         // set((){
//                         //   print('');
//                         // });
//                       },
//                       child: Container(
//                         height: 50,
//                         child: TextFormField(
//                           cursorColor: Color(0xC2141414),
//                           enabled: false,
//                           decoration: InputDecoration(
//                             isCollapsed: true,
//                             hintText: cartProvider.selectedLga==null?"Select State":
//                             cartProvider.selectedLga,
//                             hintStyle: TextStyle(color: Color(0xC2141414)),
//                             focusColor: Color(0xC2141414),
//                             border: UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
//
//                             ),
//                             focusedErrorBorder: UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
//                             ),
//                             focusedBorder:UnderlineInputBorder(
//                               borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ));
//               }
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left:20.0, bottom: 10,top:10),
//               child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text('L.G.A'
//                       '', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
//             ),
//             StatefulBuilder(
//                 builder: (context, set) {
//                   return Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 20, ),
//                       child: InkWell(
//                         onTap: states.length == 0||cartProvider.selectedLga==null?(){}:(){
//                           result2 = lga['${cartProvider.selectedLga}'];
//                           bankDialog2(context, set);
//                           // set((){
//                           //   print('');
//                           // });
//                         },
//                         child: Container(
//                           height: 50,
//                           child: TextFormField(
//                             cursorColor: Color(0xC2141414),
//                             enabled: false,
//                             decoration: InputDecoration(
//                               isCollapsed: true,
//                               hintText: cartProvider.selectedLga2==null?"Select L.G.A":
//                               cartProvider.selectedLga2,
//                               hintStyle: TextStyle(color: Color(0xC2141414)),
//                               focusColor: Color(0xC2141414),
//                               border: UnderlineInputBorder(
//                                 borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
//
//                               ),
//                               focusedErrorBorder: UnderlineInputBorder(
//                                 borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
//                               ),
//                               focusedBorder:UnderlineInputBorder(
//                                 borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ));
//                 }
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//   pay(context){
//     getIt<CartProvider>().getTotal(context)
//         .then((value){
//           // print('ddd');
//       print(value);
//
//             // noteDialog(value['data'], context);
//
//       CartProvider().setDeliveryFee(
//                 10.0
//             );
//     });
//   }
//
//
//   List result = [];
//   void searchBank(userInputValue) {
//     // BankProvider postRequestProvider =
//     // Provider.of<BankProvider>(context, listen: false);
//     result = states;
//     result = result.where((lga) => lga.toString()
//         .toLowerCase()
//         .contains(userInputValue.toLowerCase()))
//         .toList();
//   }
//
//
//   bankDialog(ctx, set) {
//     // BankProvider postRequestProvider =
//     // Provider.of<BankProvider>(context, listen: false);
//     showDialog(
//         context: context,
//         builder: (ctx) {
//           return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setStates) {
//
//
//               return AlertDialog(
//                 title: TextFormField(
//                   onChanged: (value) {
//                     setStates(() {
//                       searchBank(value);
//                     });
//                   },
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     labelText: 'Search State',
//                     labelStyle: TextStyle(color: Colors.black),
//                     disabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 0.0),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 0.0),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     border: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 0.0),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                   ),
//                 ),
//                 content: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(new Radius.circular(50.0)),
//                   ),
//                   height: 500,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           width: 300,
//                           height: 500,
//                           child: ListView.builder(
//                             itemCount:  result.length,
//                             itemBuilder: (context, index) {
//                               result.sort((a, b) {
//                                 var ad = a;
//                                 var bd = b;
//                                 var s = ad!.compareTo(bd!);
//                                 return s;
//                               });
//
//                               return InkWell(
//                                 onTap: () {
//                                   CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false );
//                                   Navigator.pop(context);
//                                   cartProvider
//                                       .changeSelectedLga(result[index]);
//
//                                 },
//                                 child: ListTile(
//                                   leading: CircleAvatar(
//                                     backgroundColor: Colors.orangeAccent
//                                         .withOpacity(0.6),
//                                     child: Text(
//                                         result[index].toString()
//                                             .substring(0, 2),
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600)),
//                                   ),
//                                   title: Text('${result[index]}',  style: TextStyle(
//                                       color: Color(0xFF333333),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600),),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }).then((v) {
//       set(() {});
//     });
//   }
//
//
//
//
//   List result2 = [];
//   void searchBank2(userInputValue) {
//     CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false );
//     result2 = lga['${cartProvider.selectedLga}'];
//     result2 = result2.where((lga) => lga.toString()
//         .toLowerCase()
//         .contains(userInputValue.toLowerCase()))
//         .toList();
//   }
//
//
//   bankDialog2(ctx, set) {
//     // BankProvider postRequestProvider =
//     // Provider.of<BankProvider>(context, listen: false);
//     showDialog(
//         context: context,
//         builder: (ctx) {
//           return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setStates) {
//
//
//               return AlertDialog(
//                 title: TextFormField(
//                   onChanged: (value) {
//                     setStates(() {
//                       searchBank(value);
//                     });
//                   },
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     labelText: 'Search LGA',
//                     labelStyle: TextStyle(color: Colors.black),
//                     disabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 0.0),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 0.0),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     border: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 0.0),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                   ),
//                 ),
//                 content: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(new Radius.circular(50.0)),
//                   ),
//                   height: 500,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           width: 300,
//                           height: 500,
//                           child: ListView.builder(
//                             itemCount:  result2.length,
//                             itemBuilder: (context, index) {
//                               result2.sort((a, b) {
//                                 var ad = a;
//                                 var bd = b;
//                                 var s = ad!.compareTo(bd!);
//                                 return s;
//                               });
//
//                               return InkWell(
//                                 onTap: () {
//                                   CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false );
//                                   Navigator.pop(context);
//                                   cartProvider
//                                       .changeSelectedLga2(result2[index]);
//                                   pay(context);
//                                 },
//                                 child: ListTile(
//                                   leading: CircleAvatar(
//                                     backgroundColor: Colors.orangeAccent
//                                         .withOpacity(0.6),
//                                     child: Text(
//                                         result2[index].toString()
//                                             .substring(0, 2),
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600)),
//                                   ),
//                                   title: Text('${result2[index]}',  style: TextStyle(
//                                       color: Color(0xFF333333),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600),),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }).then((v) {
//       set(() {});
//     });
//   }
//
// }
//
//
//
//
