import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/config/palette.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/data/repositories/products/contract_provider_product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';

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

  Future<ApiResponse> moreProductsFromUser(String id) async {
    QueryBuilder<Product> products = QueryBuilder<Product>(Product())
      ..whereEqualTo('keyOwner', id);

    return getApiResponse<Product>(await products.query());
  }

  Future<ApiResponse> similarProducts(String subcategoryId) async {
    QueryBuilder<Product> products = QueryBuilder<Product>(Product())
      ..whereEqualTo('keySubcategoryId', subcategoryId);

    return getApiResponse<Product>(await products.query());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<ApiResponse>(
                future: ProductProviderApi().getById(widget.productId),
                builder: (BuildContext context,
                    AsyncSnapshot<ApiResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.success) {
                      if (snapshot.data.result == null ||
                          snapshot.data.results.isEmpty) {
                        return const Center(
                          child: Text('No Data'),
                        );
                      }
                    }

                    Product product = snapshot.data.result;
                    String title = product.title;
                    String description = product.description;
                    String price = product.price;
                    Map<String, dynamic> options = product.options;
                    username = product.owner;
                    userId = product.ownerId;
                    print('$username');

                    String optionKey = options.keys.elementAt(0);
                    print(optionKey);
                    //print('${options.values.toList()}');

                    //List<dynamic> optionValues = options.values.toList();

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
                                        padding:
                                            const EdgeInsets.only(top: 23.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 6.0)
                                              ]),
                                          height: size.height * 0.4,
                                          width: size.width * 0.9,
                                          child: Swiper(
                                            index: 0,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: Image.network(
                                                  images[index].url,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            },
                                            loop: false,
                                            autoplay: false,
                                            itemCount: images.length,
                                            scrollDirection: Axis.horizontal,
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
                                          icon: Icon(Icons.arrow_back_rounded),
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
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  // CircleAvatar(
                                  //   radius: 25.0,
                                  //   backgroundImage:
                                  //       AssetImage('assets/images/avatar1.png'),
                                  // ),
                                  Text(
                                    '$username -',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black54),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 14.0),
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87),
                                      ))
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
                            Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.only(left: 14.0, top: 8.0),
                                child: Text(
                                  '$price DT',
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.black87),
                                )),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: options.keys.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        String currentKey =
                                            options.keys.elementAt(index);
                                        List<dynamic> valuesOfCurrent =
                                            options.values.elementAt(index);
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '$currentKey :',
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      color: Colors.black87),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              width: size.width * 0.9,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  // border: Border.all(
                                                  //   color: Colors.black,
                                                  //   width: 1,
                                                  // ),
                                                  color: Colors.grey[200]),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: DropdownButton<dynamic>(
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black87),
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Choose an option',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black87),
                                                  ),
                                                  value: chosenValue,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      chosenValue = newValue;
                                                    });
                                                  },
                                                  items: valuesOfCurrent
                                                      .map<
                                                              DropdownMenuItem<
                                                                  dynamic>>(
                                                          (dynamic value) =>
                                                              DropdownMenuItem<
                                                                      dynamic>(
                                                                  value: value,
                                                                  child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .black87),
                                                                  )))
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                            ),
                            MaterialButton(
                                minWidth: size.width * 0.9,
                                shape: RoundedRectangleBorder(),
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black87),
                                ),
                                onPressed: () {},
                                color: Palette.lavender),
                            Divider(
                              thickness: 1,
                            ),

                            //todo more
                            Container(
                                padding: EdgeInsets.all(14.0),
                                alignment: Alignment.centerLeft,
                                child: Text(description,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black87))),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, top: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'More Items from $username :',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87),
                                ),
                              ),
                            ),
                          ]);
                  } else {
                    return Center(
                      child: showLoading(),
                    );
                  }
                }),
            FutureBuilder<ApiResponse>(
              future: moreProductsFromUser(userId),
              builder:
                  (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.success) {
                    if (snapshot.data.result == null ||
                        snapshot.data.results.isEmpty) {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          Container(
                        height: size.height * 0.18,
                        width: size.width * 0.9,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            Product product = snapshot.data.results[index];

                            String productId = product.objectId;
                            String title = product.title;
                            String price = product.price;
                            username = product.owner;
                            userId = product.ownerId;
                            List<dynamic> images = product.images;

                            return Column(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.3,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.network(images[0].url,
                                            fit: BoxFit.cover)),
                                  ),
                                  onTap: () {
                                    //Navigator.pop(context, productId);
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    username,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black26),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black87),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '$price DT',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black87),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 12);
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: showLoading(),
                  );
                }
              },
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Similar items :',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ),
            ),
            FutureBuilder<ApiResponse>(
              future: moreProductsFromUser(userId),
              builder:
                  (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.success) {
                    if (snapshot.data.result == null ||
                        snapshot.data.results.isEmpty) {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                  }
                  return SingleChildScrollView(
                      child: StatefulBuilder(
                          builder: (BuildContext context,
                                  StateSetter setState) =>
                              Container(
                                height: size.height * 0.9,
                                width: size.width * 0.9,
                                child: GridView.builder(
                                    itemCount: snapshot.data.results.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Product product =
                                          snapshot.data.results[index];

                                      String productId = product.objectId;
                                      String title = product.title;
                                      String price = product.price;
                                      username = product.owner;
                                      userId = product.ownerId;
                                      List<dynamic> images = product.images;

                                      return images[index].url == null
                                          ? Container()
                                          : ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Image.network(
                                                images[index].url,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                    }),
                              )));
                } else {
                  return Center(
                    child: showLoading(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
