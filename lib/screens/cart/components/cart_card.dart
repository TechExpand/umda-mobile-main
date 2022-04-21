// import 'package:flutter/material.dart';
// import 'package:shop_app/components/rounded_icon_btn.dart';
// import 'package:shop_app/controller/cartProvider.dart';
// import 'package:shop_app/models/Cart.dart';
//
// import '../../../constants.dart';
// import '../../../main.dart';
// import '../../../size_config.dart';
//
// class CartCard extends StatelessWidget {
//   const CartCard({
//     Key? key,
//     required this.cart,
//   }) : super(key: key);
//
//   final  cart;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//
//     return Row(
//       children: [
//         SizedBox(
//           width: 88,
//           child: AspectRatio(
//             aspectRatio: 0.88,
//             child: Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5F6F9),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Image.network(cart['item']['item_image1']),
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               cart['item']['item_english_name'].toString(),
//               style: TextStyle(color: Colors.black, fontSize: 16),
//               maxLines: 2,
//             ),
//             SizedBox(height: 10),
//             Text.rich(
//               TextSpan(
//                 text: "\$${ cart['price'].toString()}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600, color: kPrimaryColor),
//                 children: [
//                   TextSpan(
//                       text: " x${cart['quantity'].toString()}",
//                       style: Theme.of(context).textTheme.bodyText1),
//                 ],
//               ),
//             )
//           ],
//         ),
//         Spacer(),
//         Row(
//           children: [
//             RoundedIconBtnSize(
//               icon: Icons.add,
//               showShadow: true,
//               press: (){
//                 getIt<CartProvider>().increaseCart(cart['id']);
//
//                     // .then((value){
//
//                   // setState(() {
//                   //   cart = value;
//                   //   calculateTotal();
//                   //   getIt<CartProvider>().setCartTotalLength(cart.length);
//                   // });
//                 // });
//               },
//             ),
//             RoundedTxtBtn(
//               showShadow: false,
//               press: (){
//
//               },
//               txt: cart['quantity'].toString(),
//             ),
//             RoundedIconBtnSize(
//               icon: Icons.remove,
//               showShadow: true,
//               press: (){
//                 getIt<CartProvider>().decreaseCart(cart['id']);
//               },
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
