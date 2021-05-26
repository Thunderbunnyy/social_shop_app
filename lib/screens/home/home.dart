import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/contract_provider_product.dart';
import 'package:social_shop_app/screens/details/details_screen.dart';

class Home extends StatefulWidget {
  final ProductProviderContract _productProvider;

  const Home(this._productProvider);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Product category = Product();

  // List<Product> products = [
  //   Product(
  //       id: "1",
  //       title: "Product loul",
  //       image: ["assets/images/taswira_1.png"],
  //       description: "sac zabour",
  //       price: "200 DT",
  //       //color: Color(0xFFC3E5E4),
  //       brand: "My Brand",
  //       options: {
  //         "colors": ["a7mer", "azre9", "ak7al"],
  //         "size": ["xs", "s", "L"]
  //       }),
  //   Product(
  //       id: "2",
  //       title: "product theni",
  //       image: ["assets/images/taswira_2.png"],
  //       description: "sac wahdekher zabour ",
  //       price: "200 DT",
  //       //color: Color(0xFFF7F0E4),
  //       brand: "My Brand",
  //       options: {
  //         "colors": ["a7mer", "azre9", "ak7al"],
  //         "size": ["xs", "s", "L"]
  //       }),
  //   Product(
  //       id: "3",
  //       title: "sablito",
  //       image: ["assets/images/sablito.jpg"],
  //       description: "sablito orange",
  //       price: "10000000 DT",
  //       //color: Color(0xFFF7F0E4),
  //       brand: "My Brand",
  //       options: {
  //         "flavor": ["fraise", "karmous", "choklata"],
  //       }),
  // ];

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
        future: widget._productProvider.getAll() ,
        builder:(BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
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
                  final Product products = snapshot.data.results[index];
                  final String title = products.title;
                  final String description = products.description;
                  final int price = products.price;
                  final List<ParseFile> image = products.images;
                  final id = products.objectId;
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
                            padding: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).copyWith().size.width,
                            height: 300,
                            // decoration: BoxDecoration(
                            //   color: product.options["colors"],
                            // ),
                            child: Container(
                              child : ClipRect(child: Image.file((image[0]).file,fit: BoxFit.cover,)),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              // Container(
                              //   width: MediaQuery.of(context).copyWith().size.width,
                              //   height: 66,
                              //   // decoration: BoxDecoration(
                              //   //   color: product.color,
                              //   // ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(left: 12.0),
                                              child: Text(title,
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                            Container(
                                              width: 400,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 12.0),
                                                    child: Text(description,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                              //),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                });
          }else {
            return Center(
              child: showLoading(),
            );
          }
          },
      ),
    );

  }

}
