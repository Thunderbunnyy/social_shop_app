import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/config/constants.dart';
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
  // static const String Share = 'Share';
  // static const String Report = 'Report';
  //
  // static const List<String> choices = <String>[
  //   Share,
  //   Report,
  //
  // ];
  //
  // void choiceAction(String choice) {
  //   if (choice == Share) {
  //     //todo share option
  //     print('share');
  //   } else if (choice == Report) {
  //     //todo report fonct
  //     print('report');
  //   }
  // }

  String chosenValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: FutureBuilder<ApiResponse>(
            future: ProductProviderApi().getById(widget.productId),
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

                Product product = snapshot.data.result;
                String title = product.title;
                String description = product.description;
                String price = product.price;
                Map<String, dynamic> options = product.options;
                String username = product.owner;
                print('$username');

                String optionKey = options.keys.elementAt(0);
                print(optionKey);
                //print('${options.values.toList()}');

                //List<dynamic> optionValues = options.values.toList();

                List<dynamic> images = product.images;

                return Column(children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.2 - 27,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                        ),
                      ),
                      Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 23.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(30.0),
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                      builder: DotSwiperPaginationBuilder(
                                          color: Colors.grey,
                                          activeColor: Colors.white,
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
                              icon: SvgPicture.asset("assets/icons/heart.svg"),
                              onPressed: () {
                                //todo likes
                              },
                            ),
                          ),

                          // Positioned(
                          //     bottom: 250,
                          //     left: 340,
                          //     right: 0,
                          //     top: 0,
                          //     child: PopupMenuButton<String>(
                          //       onSelected: choiceAction,
                          //         itemBuilder: (BuildContext context){
                          //             return choices.map((String choice) {
                          //               return PopupMenuItem<String>(
                          //                 value: choice,
                          //                 child: Text(choice),
                          //               );
                          //             }).toList();
                          //         }
                          //     ) ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text('a'),
                      ),
                      Text(username)
                    ],
                  ),
                  Text(title),
                  Text(price),
                  Divider(),
                  Text(description),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.keys.length,
                      itemBuilder: (BuildContext context, int index) {
                        String currentKey = options.keys.elementAt(index);
                        List<dynamic> valuesOfCurrent =
                            options.values.elementAt(index);
                        return Column(
                          children: [
                            Text(currentKey),
                            DropdownButton<dynamic>(
                              hint: Text('Choose an option'),
                              value : chosenValue,
                              onChanged: (newValue) {
                                setState(() {
                                  chosenValue = newValue;
                                });
                              },
                              items: valuesOfCurrent
                                  .map<DropdownMenuItem<dynamic>>(
                                      (dynamic value) =>
                                          DropdownMenuItem<dynamic>(
                                              value: value, child: Text(value)))
                                  .toList(),
                            ),
                          ],
                        );
                      })

                  // Positioned(
                  //   bottom: 0.0,
                  //   left: 0.0,
                  //   right: 0.0,
                  //   top: 0,
                  //   child: Container(
                  //     child: CarouselSlider(
                  //       items: [
                  //         for (var i = 0; i < images.length; i++)
                  //             Container(
                  //               width: size.width ,
                  //                 child: ClipRRect(
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(5)),
                  //                     child: Image.network(images[i].url,
                  //                           fit: BoxFit.fitWidth),
                  //
                  //                     )),
                  //       ],
                  //       options: CarouselOptions(
                  //         height: size.height * 0.9,
                  //           enlargeCenterPage: true,
                  //           scrollDirection: Axis.horizontal,
                  //           autoPlay: true,
                  //           enableInfiniteScroll: false),
                  //     ),
                  //   ),
                  // ),
                ]);
              } else {
                return Center(
                  child: showLoading(),
                );
              }
            }));
  }
}
