import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/config/palette.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';

Widget getUserInfo() {

  // Future<ApiResponse> getName() async {
  //   final User currentUser = await ParseUser.currentUser(customUserObject: User.clone());
  //   String username = currentUser.fullName;
  //
  // }
  Future<User> getUser() async {
    final User currentUser =
    await ParseUser.currentUser(customUserObject: User.clone());
    return currentUser;
  }
  return FutureBuilder<User>(
    future: getUser(),
    builder: (BuildContext context,
        AsyncSnapshot<User> snapshot) {

      Size size = MediaQuery.of(context).size;

      if (snapshot.hasData) {
        String currentUser = snapshot.data.fullName;

        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                          backgroundColor: Palette.lavender,
                          radius: 23,
                          child: Text('${currentUser[0]}',style: TextStyle(
                            color: Colors.white,fontSize: 20
                          ),),
                        ),
                SizedBox(width: 12.0,),
                      Text(currentUser,style: TextStyle(
                          color: Colors.black87,fontFamily: 'Montserrat'
                      ),)
              ],
            );

      } else {
        return Center(
          child: showLoading(),
        );
      }
    },
  );

}