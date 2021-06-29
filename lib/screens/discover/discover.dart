import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/category.dart';
import 'package:social_shop_app/data/repositories/SubCategories/contract_provider_subcategory.dart';
import 'package:social_shop_app/data/repositories/SubCategories/provider_api_subcategory.dart';
import 'package:social_shop_app/data/repositories/categories/contract_provider_category.dart';
import 'package:social_shop_app/screens/discover/subcategories_screen.dart';

class Discover extends StatefulWidget {
  final CategoryProviderContract _categoryProvider;

  const Discover(this._categoryProvider);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  var images = [
    "assets/images/beauty products.jpg",
    "assets/images/home decor.jpg",
    "assets/images/kitchenware.jpg",
    "assets/images/accessories.jpg",
    "assets/images/clothes.jpg",
    "assets/images/shoes.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: FutureBuilder<ApiResponse>(
        future: widget._categoryProvider.getAll(),
        builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.success) {
              if (snapshot.data.result == null ||
                  snapshot.data.results.isEmpty) {
                return Center(
                  child: showLoading(),
                );
              }
            }
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: 'Search',
                        ),
                      )),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (context, index) {
                        final Category categories =
                            snapshot.data.results[index];
                        final String name = categories.name;
                        final id = categories.objectId;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubcategoriesScreen(
                                      id, SubCategoryProviderApi(), name),
                                ));
                          },
                          child: Card(
                            child: Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(images[index]),
                                      fit: BoxFit.cover)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                        // return Container(
                        //   height: size.height * 0.2,
                        //   decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //           image: AssetImage(images[index]),
                        //           fit: BoxFit.cover
                        //       )
                        //   ),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => SubcategoriesScreen(
                        //                 id, SubCategoryProviderApi(), name),
                        //           ));
                        //     },
                        //     child: Card(
                        //       child: Align(
                        //           alignment: Alignment.center,
                        //           child: Container(
                        //             // decoration: BoxDecoration(
                        //             //   image: DecorationImage(
                        //             //     image: AssetImage(images[index]),
                        //             //     fit: BoxFit.cover
                        //             //   )
                        //             // ),
                        //             child: Text(
                        //               name,
                        //               style: TextStyle(
                        //                   fontSize: 20.0, fontFamily: 'Montserrat'),
                        //             ),
                        //           )),
                        //     ),
                        //   ),
                        // );
                      }),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
