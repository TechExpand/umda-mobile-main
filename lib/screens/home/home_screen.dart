import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/controller/homeProvider.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/widgets/shimmerloading.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: homeProvider.loading ? LoadingShimmer() : Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}