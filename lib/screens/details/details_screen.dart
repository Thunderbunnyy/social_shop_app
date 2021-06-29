import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/config/palette.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';
import 'package:social_shop_app/screens/details/components/more_from_user.dart';
import 'package:social_shop_app/screens/details/components/similar_items.dart';
import 'package:social_shop_app/screens/payment/cart.dart';

class Details extends StatefulWidget {
  final String productId;

  //final ProductProviderContract productProvider;

  const Details({Key key, this.productId}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String chosenValue;
  String userId;
  String username;
  String subcategory;
  String productId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<ApiResponse>(
                      future: ProductProviderApi().getById(widget.productId),
                      builder: (BuildContext context,
                          AsyncSnapshot<ApiResponse> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.success) {
                            if (snapshot.data.result == null ||
                                snapshot.data.results.isEmpty) {
                              return Container();
                            }
                          }
                          Product product = snapshot.data.result;

                          String title = product.title;
                          String description = product.description;
                          String price = product.price;
                          Map<String, dynamic> options = product.options;

                            productId = product.objectId;
                            subcategory = product.subcategory;
                            username = product.owner;
                            userId = product.ownerId;

                          //String optionKey = options.keys.elementAt(0);

                          List<dynamic> images = product.images;

                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: size.height * 0.2 - 27,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 23.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 6.0)
                                                  ]),
                                              height: size.height * 0.4,
                                              width: size.width * 0.9,
                                              child: Swiper(
                                                index: 0,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      images[index].url,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                                loop: false,
                                                autoplay: false,
                                                itemCount: images.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                pagination: SwiperPagination(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                    builder:
                                                        DotSwiperPaginationBuilder(
                                                            color: Colors.grey,
                                                            activeColor:
                                                                Colors.white,
                                                            size: 3.0,
                                                            activeSize: 8.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 250,
                                            left: 0,
                                            right: 340,
                                            top: 0,
                                            child: IconButton(
                                              color: Colors.white,
                                              icon: Icon(
                                                  Icons.arrow_back_rounded),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )),
                                        Positioned(
                                            bottom: 250,
                                            left: 340,
                                            right: 0,
                                            top: 0,
                                            child: IconButton(
                                              color: Colors.white,
                                              icon: Icon(Icons.share),
                                              onPressed: () {
                                                //todo share
                                              },
                                            )),
                                        Positioned(
                                          bottom: 0,
                                          left: 340,
                                          right: 0,
                                          top: 300,
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                                "assets/icons/heart.svg"),
                                            onPressed: () {
                                              //todo likes
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // CircleAvatar(
                                      //   radius: 25.0,
                                      //   backgroundImage:
                                      //       AssetImage('assets/images/avatar1.png'),
                                      // ),
                                      Align(
                                        child: Text(
                                          '$username',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,fontFamily: 'Montserrat'),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                              title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black87,fontFamily: 'Montserrat'),
                                            ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$price DT',
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.black87),
                                          ),)
                                    ],
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(left: 14.0),
                                //     child: Text(
                                //       title,
                                //       style: TextStyle(
                                //           fontSize: 20,
                                //           color: Colors.black87),
                                //     ),
                                //   ),
                                // ),

                                options == null ? Container() : StatefulBuilder(
                                  builder: (BuildContext context,
                                          StateSetter setState) =>
                                      ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: options.keys.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String currentKey =
                                                options.keys.elementAt(index);
                                            List<dynamic> valuesOfCurrent =
                                                options.values.elementAt(index);
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '$currentKey :',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.black87),
                                                      ),
                                                    ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 50,
                                                    width: size.width * 0.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        // border: Border.all(
                                                        //   color: Colors.black,
                                                        //   width: 1,
                                                        // ),
                                                        color: Colors.grey[200]),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child:
                                                          DropdownButton<dynamic>(
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black87),
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Choose an option',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black87),
                                                        ),
                                                        value: chosenValue,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            chosenValue =
                                                                newValue;
                                                          });
                                                        },
                                                        items: valuesOfCurrent
                                                            .map<
                                                                    DropdownMenuItem<
                                                                        dynamic>>(
                                                                (dynamic
                                                                        value) =>
                                                                    DropdownMenuItem<
                                                                            dynamic>(
                                                                        value:
                                                                            value,
                                                                        child:
                                                                            Text(
                                                                          value,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              color:
                                                                                  Colors.black87),
                                                                        )))
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: MaterialButton(
                                      minWidth: size.width * 0.9,
                                      shape: RoundedRectangleBorder(),
                                      child: Text(
                                        'Add To Cart',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black87),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Cart(id : productId),
                                            ));
                                      },
                                      color: Palette.lavender),
                                ),
                                Divider(
                                  thickness: 1,
                                ),

                                Container(
                                    padding: EdgeInsets.all(25.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(description,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87))),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'More from $username :',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black87),
                                    ),
                                  ),
                                ),
                                moreFromUser(username, productId),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Similar items :',
                                      style: TextStyle(fontSize: 20, color: Colors.black87),
                                    ),
                                  ),
                                ),
                                similarItems(subcategory,productId)
                              ]);
                        } else {
                          return Center(
                            child: showLoading(),
                          );
                        }
                      }),
      ),
    );
  }
}
