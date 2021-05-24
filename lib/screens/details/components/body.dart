import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/data/models/product.dart';

class DetailsBody extends StatelessWidget {
  final Product product;

  const DetailsBody({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
            Container(
                width: size.width,
                height: 200,
                // decoration: BoxDecoration(
                //   color: product.color,
                // ),
                child: ClipRRect(
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      //Image.asset(product.image[],fit: BoxFit.cover,),
                      //AssetImage('assets/images/m1.jpg'),
                      //AssetImage('assets/images/w1.jpg'),
                    ],
                    autoplay: false,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    showIndicator: true,
                    dotSize: 4.0,
                    indicatorBgPadding: 4.0,
                    dotBgColor: Colors.transparent,
                    dotColor: kAccentColor,
                  ),
                ),

            ),
            Row(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: 70,
                  // decoration: BoxDecoration(
                  //   color: product.color,
                  // ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(product.title,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .width,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(product.description,
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                            )),
                                      ),
                                      Text('price',
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                          )),
                                      IconButton(
                                          icon: SvgPicture.asset(
                                              "assets/icons/heart.svg"),
                                          onPressed: () {}),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ]
      )
    );

  }
}

