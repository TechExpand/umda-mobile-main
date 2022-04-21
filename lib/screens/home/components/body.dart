import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/marketitems.dart';
import 'package:shop_app/screens/home/components/promotions.dart';
import 'package:shop_app/screens/home/components/regularitems.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            // SizedBox(height: getProportionateScreenWidth(10)),
            // DiscountBanner(),
            // Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            MarketItems(),
            SizedBox(height: getProportionateScreenWidth(30)),
            Promotions(),
            SizedBox(height: getProportionateScreenWidth(30)),
            RegularItems(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
