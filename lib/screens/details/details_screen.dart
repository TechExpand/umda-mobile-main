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

class DetailsScreen extends StatefulWidget {
  final StoreItem storeItem;

  const DetailsScreen({Key? key, required this.storeItem}) : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
        child: CustomAppBar(rating: 4.00),
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.zero,
        height: 110,
        child:TopRoundedContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.15,
            right: SizeConfig.screenWidth * 0.15,
            bottom: getProportionateScreenWidth(15),
            // top: getProportionateScreenWidth(15),
          ),
          child: DefaultCartButton(
            text: "Add To Cart",
            press: () {
              circularCustom(context);
              cartProvider.addCart(widget.storeItem, context);
            },
          ),
        ),
      ),),
      body: Body(product: widget.storeItem),
    );
  }
}

// class ProductDetailsArguments {
//   final StoreItem product;

//   ProductDetailsArguments({required this.product});
// }
