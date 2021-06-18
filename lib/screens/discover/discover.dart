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

  const Discover(this._categoryProvider) ;

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Discover',style: TextStyle(
          color: Colors.black54
        ),),
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

            return ListView.builder(
                scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (context, index){
                    final Category categories = snapshot.data.results[index];
                    final String name = categories.name;
                    final id = categories.objectId;
                    return Container(
                      height: size.height * 0.2 ,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubcategoriesScreen(id,SubCategoryProviderApi(),name),
                              ));
                        },
                        child: Card(
                          child:
                          Align(
                            alignment: Alignment.center,
                              child: Text(name,style: TextStyle(
                                fontSize: 20.0,fontFamily: 'Montserrat'
                              ),)),
                        ),
                      ),
                    );
                  }
              );

          }else{
            return Container();
          }
        },
      ),
    );
  }
}
