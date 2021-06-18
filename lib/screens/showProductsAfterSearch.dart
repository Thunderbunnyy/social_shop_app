import 'package:flutter/material.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';

class ShowProductsAfterSearchScreen extends StatefulWidget {
  final String id;
  final String name;

  const ShowProductsAfterSearchScreen({this.id, this.name});

  @override
  _ShowProductsAfterSearchScreenState createState() =>
      _ShowProductsAfterSearchScreenState();
}

class _ShowProductsAfterSearchScreenState
    extends State<ShowProductsAfterSearchScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.name}',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: FutureBuilder<ApiResponse>(
        future: ProductProviderApi().searchForProduct(widget.id),
        builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.success) {
              if (snapshot.data.result == null ||
                  snapshot.data.results.isEmpty) {
                return Container();
              }
            }

            return Container(
              height: size.height * 0.9,
              width: size.width * 0.9,
              child: GridView.builder(
                  itemCount: snapshot.data.results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 2 : 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  itemBuilder: (BuildContext context, int index) {
                    Product product = snapshot.data.results[index];

                    String title = product.title;
                    String price = product.price;
                    String username = product.owner;
                    List<dynamic> images = product.images;

                    return images[0] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              images[0].url,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container();
                  }),
            );
          } else {
            return showLoading();
          }
        },
      ),
    );
  }
}
