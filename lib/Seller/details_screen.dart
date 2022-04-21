import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/models/StoreItem.dart';
import 'package:shop_app/screens/widgets/CustomCircular.dart';

import '../../models/Product.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'components/top_rounded_container.dart';

class SellerScreen extends StatefulWidget {
  final StoreItem storeItem;

  const SellerScreen({Key? key, required this.storeItem}) : super(key: key);
  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  //static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(false,rating: 4.00),
      ),
      body: Body(product: widget.storeItem),
    );
  }
}

// class ProductDetailsArguments {
//   final StoreItem product;

//   ProductDetailsArguments({required this.product});
// }
