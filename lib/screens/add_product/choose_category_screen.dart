import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:social_shop_app/Providers/options_providers.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/category.dart';
import 'package:social_shop_app/data/models/sub_category.dart';
import 'package:social_shop_app/data/repositories/SubCategories/contract_provider_subcategory.dart';
import 'package:social_shop_app/data/repositories/categories/contract_provider_category.dart';

class ChooseCategory extends StatefulWidget {
  final CategoryProviderContract _categoryProvider;
  final SubCategoryProviderContract _subcategoryProvider;

  const ChooseCategory(this._categoryProvider, this._subcategoryProvider);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  // List<Category> categories = <Category>[];
  // final Category category = Category();
  //
  // List<SubCategory> subcategories = <SubCategory>[];
  // final SubCategory subCategory = SubCategory();

  // final List<CategoryViewModel> categories;
  //
  // ChooseCategory({this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Category'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
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
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (context, index) {
                    final Category categories = snapshot.data.results[index];
                    final String name = categories.name;
                    final id = categories.objectId;
                    return ExpansionTile(
                      title: Text(name),
                      children: [
                        FutureBuilder<ApiResponse>(
                            future: widget._subcategoryProvider.getByCategoryId(id),
                            builder: (BuildContext context,
                                AsyncSnapshot<ApiResponse> snapshot) {
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
                                    itemBuilder: (context, index) {
                                      final SubCategory subs = snapshot.data.results[index];
                                      final name = subs.name;
                                      final subid = subs.objectId;
                                      String value;
                                      return Consumer<OptionsProvider>(
                                        builder: (context, subcategory, child) => RadioListTile(
                                          title: Text(name),
                                          value: name,
                                          groupValue: value,
                                          onChanged: (String v) {
                                            subcategory.chosenSubcategory = name;
                                            print(subcategory.chosenSubcategory);
                                            print(subid);
                                            setState(() {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           AddProduct(subCategoryId: subid)),
                                              // );
                                              Navigator.pop(context,subid);
                                            });
                                          },
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                  child: Text('No Data'),
                                );
                              }
                            }),
                      ],
                    );
                  }),
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }


}
