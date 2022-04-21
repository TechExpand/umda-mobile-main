import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/models/Cart.dart';

import '../../main.dart';
import '../../constants.dart';
import '../../main.dart';
import '../../size_config.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/screens/widgets/CustomCircular.dart';
import 'package:shop_app/screens/widgets/shimmerloading.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../../size_config.dart';


class CartOrderScreen extends StatelessWidget {
  var id;
  CartOrderScreen({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(id),
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





class Body extends StatefulWidget {
  var id;
  Body(this.id);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var cart;

  @override
  void initState() {
    getIt<CartProvider>().getOrderUserCart(widget.id).then((value){
      setState(() {
        cart = value;
        print(value);
        calculateTotal();
        getIt<CartProvider>().setCartTotalLength(cart.length);
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
      ) :ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) => Stack(
          children: [
            Padding(
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
                        child: Image.network(cart[index]['item']['item_image1']),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart[index]['item']['item_english_name'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: "\$${ cart[index]['price'].toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: kPrimaryColor),
                          children: [
                            TextSpan(
                                text: " x${cart[index]['quantity'].toString()}",
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      RoundedTxtBtn(
                        showShadow: false,
                        press: (){

                        },
                        txt: cart[index]['quantity'].toString(),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
