import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/components/build_image.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/contract_provider_product.dart';
import 'package:social_shop_app/screens/details/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  final ProductProviderContract _productProvider;

  const Home(this._productProvider);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          new IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {}),
          new IconButton(
              icon: SvgPicture.asset("assets/icons/cart.svg"),
              onPressed: () {}),
        ],
      ),
      body: FutureBuilder<ApiResponse>(
        future: widget._productProvider.getAll(),
        builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.success) {
              if (snapshot.data.result == null ||
                  snapshot.data.results.isEmpty) {
                return const Center(
                  child: Text('No Data'),
                );
              }
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int index) {
                  Product products = snapshot.data.results[index];
                  String title = products.title;
                  String description = products.description;
                  String price = products.price;
                  List<dynamic> image = products.images;
                  String id = products.objectId;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              productId: id,
                            ),
                          ));
                    },
                    child: Card(
                      child: Hero(
                        tag: Text("hero 1 "),
                        child: Column(children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).copyWith().size.width,
                            height: 300,
                            // decoration: BoxDecoration(
                            //   color: product.options["colors"],
                            // ),
                            child: Container(
                              child: //image != null ? buildImage(image[0]) : Container(),
                                  // image != null ? CachedNetworkImage(
                                  //   imageUrl: "${image[0].url}",
                                  //   placeholder: (context, url) => CircularProgressIndicator(),
                                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                                  // ) : Container()
                                  ClipRect(
                                      child: image != null
                                          ? Image.network(image[0].url,
                                              fit: BoxFit.cover,
                                              height: double.infinity)
                                          : Container()),
                            ),
                          ),
                              Container(
                                width: 400,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child: Text(title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    Text('$price DT',
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
                        ]),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: showLoading(),
            );
          }
        },
      ),
    );
  }
}
