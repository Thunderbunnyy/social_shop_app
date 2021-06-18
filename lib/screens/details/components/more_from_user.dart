import 'package:flutter/material.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';

Widget moreFromUser(String username, String productId){

  return FutureBuilder<ApiResponse>(
    future: ProductProviderApi().moreProductsFromUser(username,productId),
    builder: (BuildContext context,
        AsyncSnapshot<ApiResponse> snapshot) {

      Size size = MediaQuery.of(context).size;

      if (snapshot.hasData) {
        if (snapshot.data.success) {
          if (snapshot.data.result == null ||
              snapshot.data.results.isEmpty) {
            return Container();
          }
        }
        return SingleChildScrollView(
          padding: EdgeInsets.only(top: 12),
          scrollDirection: Axis.horizontal,
          child: Container(
            height: size.height * 0.18,
            width: size.width * 0.9,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = snapshot.data.results[index];

                String title = product.title;
                String price = product.price;
                String username = product.owner;

                List<dynamic> images = product.images;

                return Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        height: size.height * 0.1,
                        width: size.width * 0.3,
                        child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                            child: snapshot.data != null
                                ? Image.network(images[0].url,
                                fit: BoxFit.cover)
                                : Container()),
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
                            fontSize: 12, color: Colors.black26),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 12, color: Colors.black87),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$price DT',
                        style: TextStyle(
                            fontSize: 12, color: Colors.black87),
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
        );
      } else {
        return Center(
          child: showLoading(),
        );
      }
    },
  );

}