import 'package:flutter/material.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/sub_category.dart';
import 'package:social_shop_app/data/repositories/SubCategories/contract_provider_subcategory.dart';
import 'package:social_shop_app/screens/showProductsAfterSearch.dart';

class SubcategoriesScreen extends StatefulWidget {

    final String categoryId;
    final String categoryName;
    final SubCategoryProviderContract _subcategoryProvider;

  const SubcategoriesScreen(this.categoryId, this._subcategoryProvider, this.categoryName);

  @override
  _SubcategoriesScreenState createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName}',style: TextStyle(
            color: Colors.black54
        ),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: FutureBuilder<ApiResponse>(
          future: widget._subcategoryProvider.getByCategoryId(widget.categoryId),
          builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
            if (snapshot.hasData){
              if (snapshot.data.success) {
                if (snapshot.data.result == null ||
                    snapshot.data.results.isEmpty) {
                  return Center(
                    child: showLoading(),
                  );
                }
              }

              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (context, index) {
                    final SubCategory subs = snapshot.data.results[index];
                    final name = subs.name;
                    final subid = subs.objectId;
                    return ListTile(
                        title: Text(name),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowProductsAfterSearchScreen(id : subid,name: name),
                              ));
                        },

                      );
                  }, separatorBuilder: (BuildContext context, int index) { return Divider(); },);

            }else{
              return Container();
            }

          }
      ),
    );


  }
}
