import 'package:flutter/material.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';

Widget similarItems(String subcategory, String productId) {
  return FutureBuilder<ApiResponse>(
    future: ProductProviderApi().similarProducts(subcategory,productId),
    builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
      Size size = MediaQuery.of(context).size;
      final orientation = MediaQuery.of(context).orientation;

      if (snapshot.hasData) {
        if (snapshot.data.success) {
          if (snapshot.data.result == null || snapshot.data.results.isEmpty) {
            return Container();
          }
        }
        return Container(
          height: size.height * 0.9,
          width: size.width * 0.9,
          child: GridView.builder(
              itemCount: snapshot.data.results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
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
        return Center(
          child: showLoading(),
        );
      }
    },
  );
}
