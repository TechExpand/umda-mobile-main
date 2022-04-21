import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/Seller/details_screen.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/StoreItem.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final StoreItem product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.item_english_name!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color:
                  //product.isFavourite ? Color(0xFFFFE6E6) :
                  Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color:
                  //product.isFavourite ? Color(0xFFFF4848) :
                  Color(0xFFDBDEE4),
              height: getProportionateScreenWidth(16),
            ),
          ),
        ),

        Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: Html(
              data: product.description!,
            )
            // Text(
            //   product.description!,
            //   maxLines: 3,
            // ),
            ),
        product.food_class==null||product.food_class==""?Container():Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Food Class: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data:  "${product.food_class}",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Dietary: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data: "${product.dietary_list}",

                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Health Benefit: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data: "${product.health_benefits}",

                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text('Preparation Method: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                      data:  "${product.preparation_method}",
                      ),
                    ),
                  ],
                ),


                Row(
                  children: [
                    Text('Disposal Method: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data: "${product.disposal_method}",
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
        product.food_class==null||product.food_class==""?Container():Row(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: Text(
               'Seller Information',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            // Spacer(),
            // IconButton(onPressed: (){
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => SellerScreen(storeItem: product),
            //     ),
            //   );
            // }, icon: Icon(Icons.arrow_forward_ios ))
            
          ],
        ),
        product.food_class==null||product.food_class==""?Container(): Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Store Name ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data:  "${product.food_class}",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Seller Name: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data: "${product.dietary_list}",

                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Address: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data: "${product.health_benefits}",

                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text('Phone: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data:  "${product.preparation_method}",
                      ),
                    ),
                  ],
                ),


                Row(
                  children: [
                    Text('State: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: Html(
                        data: "${product.disposal_method}",
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
        Container(
          height: 100,
        )
      ],
    );
  }
}
