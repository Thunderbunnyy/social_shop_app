import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:social_shop_app/Providers/options_providers.dart';
import 'package:social_shop_app/components/build_image.dart';
import 'package:social_shop_app/config/constants.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/models/user.dart';
import 'package:social_shop_app/data/repositories/SubCategories/provider_api_subcategory.dart';
import 'package:social_shop_app/data/repositories/categories/provider_api_category.dart';
import 'package:social_shop_app/data/repositories/products/contract_provider_product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';
import 'package:social_shop_app/screens/add_product/alert_form.dart';
import 'package:social_shop_app/screens/add_product/choose_category_screen.dart';

class AddProduct extends StatefulWidget {
  //final String subCategoryId;
  final ProductProviderContract productProvider;

  AddProduct({Key key, this.productProvider}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var formKey = GlobalKey<FormState>();

  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescController = TextEditingController();

  List<dynamic> imageList = [];

  OptionsProvider provider;

  //File _pickedImage;

  Map<int, dynamic> files = {0: null, 1: null, 2: null, 3: null, 4: null};

  String _errorMessage;
  Map<dynamic, dynamic> map;
  String subid = '';

  final Product product = Product();
  ParseFileBase parseFile;
  PickedFile pickedFile;

  void updateInformation(String information) {
    setState(() => subid = information);
  }

  void moveToChooseCategory() async {
    final information = await Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ChooseCategory(
                CategoryProviderApi(), SubCategoryProviderApi())));
    updateInformation(information);
  }

  bool _validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate() && map.isNotEmpty && subid != null) {
      form.save();
      return true;
    }else if (subid == null){
      Fluttertoast.showToast(
        msg: "Please add a category",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0, // Also possible "TOP" and "CENTER"
      );
    }
    else if (map?.isEmpty ?? true){
      Fluttertoast.showToast(
        msg: "Please add at least one image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0, // Also possible "TOP" and "CENTER"
      );
    }
    return false;
  }

  Future<void> _validateAndSubmit() async {
    if (_validateAndSave()) {
      try {
        final User currentUser =
            await ParseUser.currentUser(customUserObject: User.clone());
        product.set(keyTitle, productNameController.text.trim());
        product.set(keyDescription, productDescController.text.trim());
        product.set(keyPrice, productPriceController.text.trim());
        product.set(keyOptions, map);
        product.set(keyOwner, currentUser.username);
        product.set(keyOwnerId, currentUser.objectId);
        product.set(keySubcategoryId, subid);

        ParseResponse response = await product.save();
        //ApiResponse response = await ProductProviderApi().create(product);

        if (response.success) {
          //todo reset provider
          print(product);
          print('sahit');
        } else {
          setState(() {
            print('lé');
            _errorMessage = response.error.toString();
          });
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text('Sell Something'),
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/cancel.svg"),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          //----------------mta3 el images--------------------
          Container(
            //20% of height
            height: size.height * 0.2,
            child: Stack(children: [
              Container(
                height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36))),
              ),

              //--------------------horiz scroll-------------------
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 17),
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12),
                            Container(
                              height: 185.0,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: files.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () async {
                                    PickedFile pickedFile = await ImagePicker()
                                        .getImage(source: ImageSource.gallery);

                                    if (kIsWeb) {
                                      ParseWebFile file = ParseWebFile(null,
                                          name: null, url: pickedFile.path);
                                      await file.download();
                                      parseFile = ParseWebFile(file.file,
                                          name: file.name);
                                    } else {
                                      parseFile =
                                          ParseFile(File(pickedFile.path));
                                    }
                                    setState(() {
                                      if (pickedFile != null) {
                                        product.set(keyImages, imageList);
                                        files[index] = parseFile;
                                        imageList.add(parseFile);
                                        print('list of images : $imageList');
                                        print(' list of files : $files');
                                      }
                                    });
                                  },
                                  child: Container(
                                      height: 185.0,
                                      width: 185.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: files[index] == null
                                          ? Container(
                                              child: Icon(
                                              Icons.add_a_photo,
                                              size: 50,
                                            ))
                                          : Stack(children: [
                                              Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                  child: files[index] == null
                                                      ? Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(color: Colors.red),
                                                    ),
                                                          child: Icon(
                                                            Icons.add_a_photo,
                                                            size: 50,
                                                          ),
                                                        )
                                                      : buildImage(
                                                          files[index]),
                                                ),
                                              ),
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.red[600],
                                                child: IconButton(
                                                  icon: Icon(Icons.clear,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    files.removeWhere(
                                                        (key, value) =>
                                                            key == index);
                                                    imageList.removeAt(index);
                                                    print(files);
                                                    print(imageList);
                                                  },
                                                ),
                                              )
                                            ])),
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 12);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ]),
          ),

          //-------------------fields---------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) return "Please add a Title";
                          return null;
                        },
                        controller: productNameController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            hintText: 'Title ',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            alignLabelWithHint: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          controller: productDescController,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please add a description";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              hintText:
                                  'Description : mention any details about your product and shipping',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              alignLabelWithHint: true,
                              hintMaxLines: 50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val.isEmpty) return "Please add the Price";
                            return null;
                          },
                          controller: productPriceController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              hintText: 'Price ',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              alignLabelWithHint: true),
                        ),
                      ),

                      //----------------------- Categories ----------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: StatefulBuilder(builder: (context, builder) {
                          return Container(
                            height: size.height * 0.07,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: Colors.transparent, width: 2.0)),
                            child: TextButton(
                              onPressed: () {
                                moveToChooseCategory();
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Selector<OptionsProvider, String>(
                                    selector: (_, provider) => provider.chosenSubcategory,
                                    builder: (context, chosenSubcategory, child) {
                                  // return chosenSubcategory == null ?
                                  // Fluttertoast.showToast(
                                  //   msg: "Please add a category",
                                  //   toastLength: Toast.LENGTH_SHORT,
                                  //   gravity: ToastGravity.CENTER,
                                  //   timeInSecForIosWeb: 1,
                                  //   backgroundColor: Colors.red,
                                  //   textColor: Colors.white,
                                  //   fontSize: 16.0,
                                  // ):
                                    return Text(
                                    'Category : $chosenSubcategory',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          );
                        }),
                      ),

                      //------------------ Add specs according to the product----------------------------
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: TextButton(
                            child: Text(
                              'Add Options',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                        side:
                                            BorderSide(color: kAccentColor)))),
                            onPressed: () {
                              //------ Add Options ------------
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertForm();
                                  });
                            },
                          ),
                        ),
                      ),

                      //--------------------- added options ----------------------
                      Consumer<OptionsProvider>(
                          builder: (context, options, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Visibility(
                              visible: options.isVisible,
                              child: SizedBox(
                                  width: size.width * 0.9,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: options.optionsMap.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      map = options.optionsMap;
                                      String key = map.keys.elementAt(index);
                                      List values = map.values.elementAt(index);
                                      return new Column(
                                        children: <Widget>[
                                          new ListTile(
                                            title: new Text("$key"),
                                            subtitle: Container(
                                              height: size.height * 0.05,
                                              width: size.width * 0.9,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                children: List<Widget>.generate(
                                                    values.length,
                                                    // place the length of the array here
                                                    (int index) {
                                                  return Chip(
                                                    label: Text(
                                                        '${values[index]}'),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          new Divider(
                                            height: 2,
                                          ),
                                        ],
                                      );
                                    },
                                  ))),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _validateAndSubmit();
              },
              child: Text('Add'))
        ],
      ),
    );
  }
}
