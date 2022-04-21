import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/controller/orderProvider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/order/OrderCart.dart';
import 'package:shop_app/screens/widgets/CustomCircular.dart';
import 'package:shop_app/screens/widgets/shimmerloading.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../../size_config.dart';




class OrderScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context,listen: true );
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Orders",
            style: TextStyle(color: Colors.black),
          ),

        ],
      ),
    );
  }
}





class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var cart;

  @override
  void initState() {
    getIt<OrderProvider>().getUserOrders().then((value){
      setState(() {
        cart = value;
      });
    });
    // TODO: implement initState
    super.initState();

  }

  double total = 0.0;

  calculateTotal(){
    for(var i in cart){
      total = double.parse(i['price'].toString())  * double.parse(i['quantity'].toString());
      getIt<CartProvider>().setCartTotal(total);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: cart==null? LoadingShimmer():cart.length==0?Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No Item Found'),
      ) :
      ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) => Stack(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) {
                      return CartOrderScreen(id: cart[index]['id'].toString(),);
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart[index]['address'].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "",
                                style: Theme.of(context).textTheme.bodyText1,
                              children: [
                                TextSpan(
                                    text: "${cart[index]['state'].toString()} ${cart[index]['local_government']}",
                                    style: Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "NGN${ cart[index]['total_fee'].toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, color: kPrimaryColor),
                              children: [
                                // TextSpan(
                                //     text: "${cart[index]['state'].toString()} ${cart[index]['local_government']}",
                                //     style: Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}







