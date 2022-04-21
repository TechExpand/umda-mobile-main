import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/models/Cart.dart';

import '../../main.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context,listen: true );
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
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
}
