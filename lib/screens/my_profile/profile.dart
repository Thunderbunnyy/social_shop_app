import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/config/palette.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/screens/details/details_screen.dart';
import 'package:social_shop_app/screens/my_profile/modify_product.dart';
import 'package:social_shop_app/screens/my_profile/settings.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Future<User> _myUser;
  Future<ApiResponse> _userProducts;

  final picker = ImagePicker();

  ParseFileBase parseFile;
  PickedFile pickedFile;
  var displayPicture;

  @override
  void initState() {
    super.initState();
    _userProducts = userProducts();
  }

  static Future<T> popAndPushNamed<T extends Object, TO extends Object>(
      BuildContext context,
      String routeName, {
        TO result,
        Object arguments,
      }) {
    return Navigator.of(context).popAndPushNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
          future: Future.wait([getUser(), _userProducts]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: showLoading(),
              );
            }
            if (snapshot.hasData) {

              List<dynamic> products = snapshot.data[1].results;
              Product product = snapshot.data[1].result;

              User currentUser = snapshot.data[0];

              String currentUserName = currentUser.fullName;
              String userId = currentUser.objectId;
              ParseFile displayPicture = currentUser.displayPicture;

              var followers = currentUser.followers;
              var following = currentUser.following;

              // print(product);
              // print(currentUserName);
              // print(following);
              // print(followers);
              // print(displayPicture);

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    iconTheme: IconThemeData(color: Palette.coral),
                    // title: Text('My Profile',style: TextStyle(
                    //   color: Colors.black54,fontFamily: 'Montserrat'
                    // ),),
                    floating: true,
                    pinned: false,
                    backgroundColor: Color(0xffff),
                    expandedHeight: size.height * 0.3,
                    actions: [
                      IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Settings(),
                                ));
                          })
                    ],
                    flexibleSpace: Container(
                      child:FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      ParseUser currentUser = await ParseUser.currentUser() ;
                                      PickedFile pickedFile =
                                      await ImagePicker().getImage(
                                          source:
                                          ImageSource.gallery);

                                      if (kIsWeb) {
                                        ParseWebFile file = ParseWebFile(
                                            null,
                                            name: null,
                                            url: pickedFile.path);
                                        await file.download();

                                        parseFile = ParseWebFile(
                                            file.file,
                                            name: file.name);
                                      } else {
                                        parseFile = ParseFile(
                                            File(pickedFile.path));
                                      }

                                      setState(() {
                                        if (pickedFile != null) {
                                          currentUser.set(User.keyDisplayPicture, parseFile);
                                          currentUser.save();
                                          currentUser.update();
                                        }
                                      });
                                    },
                                    child: displayPicture.url == null
                                        ? CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar2.png'),
                                      radius: 50,
                                    )
                                        : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          displayPicture.url),
                                      radius: 50,
                                    )),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            currentUserName,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Montserrat',
                                                fontSize: 25),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Column(
                                                  children: [
                                                    followers == null
                                                        ? Text('0')
                                                        : Text(
                                                      '$followers',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black87,
                                                          fontFamily:
                                                          'Montserrat',
                                                          fontSize:
                                                          15),
                                                    ),
                                                    Text('Followers')
                                                  ],
                                                ),
                                                SizedBox(width: 20.0),
                                                Column(
                                                  children: [
                                                    followers == null
                                                        ? Text('0')
                                                        : Text(
                                                      '$following',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black87,
                                                          fontFamily:
                                                          'Montserrat',
                                                          fontSize:
                                                          15),
                                                    ),
                                                    Text('Following')
                                                  ],
                                                ),
                                                SizedBox(width: 20.0),
                                                Column(
                                                  children: [
                                                    product == null
                                                        ? Text('0')
                                                        : Text(
                                                      '${products.length}',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black87,
                                                          fontFamily:
                                                          'Montserrat',
                                                          fontSize:
                                                          15),
                                                    ),
                                                    Text('items')
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          final ParseUser user =
                                          await ParseUser
                                              .currentUser();
                                          user.logout(
                                              deleteLocalUserData: true);
                                          Navigator.pop(context, true);
                                        },
                                        child: Text('Edit Profile',style: TextStyle(color: Palette.coral),))
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product products = snapshot.data[1].results[index];
                        String id = products.objectId;
                        List<dynamic> images = products.images;

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
                          onLongPress: () {
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                Container(
                                  width: size.width,
                                  child: Card(
                                      child: Image.network(
                                        images[0].url,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Positioned(
                                  bottom: 170,
                                  left: 170,
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        return AlertDialog(
                                          title: Text('product''s settings'),
                                          content: ListView(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ModifyProductScreen(
                                                              productId: id,
                                                            ),
                                                      ));
                                                },
                                                child: Text('Modify Product'),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  //todo delete
                                                },
                                                child: Text('Delete Product'),
                                              )
                                            ],
                                          ),
                                        );

                                      },
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // SliverList(delegate: null,
                  //
                  // )
                ],
              );
            }
            return Container();

          }),
  );
  }

  Future<User> getUser() async {
    final User currentUser =
        await ParseUser.currentUser(customUserObject: User.clone());
    return currentUser;
  }

  Future<ApiResponse> userProducts() async {
    final User currentUser =
        await ParseUser.currentUser(customUserObject: User.clone());

    QueryBuilder<Product> products = QueryBuilder<Product>(Product())
      ..whereEqualTo('Owner_id', currentUser.objectId);

    return getApiResponse<Product>(await products.query());
  }
}
