import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_shop_app/Providers/options_providers.dart';

class AlertForm extends StatefulWidget {
  @override
  _AlertFormState createState() => _AlertFormState();
}

class _AlertFormState extends State<AlertForm> {

  final formKey = GlobalKey<FormState>();
  TextEditingController optionNameController = new TextEditingController();

  List<dynamic> optionsList = [];

  List<Widget> _children = [];
  int _count = 0;

  bool _validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _validateAndSubmit() async {

    if (_validateAndSave()) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => AddProduct()),
      // );
      Navigator.pop(context);
    }else{
      print('lé');
    }
  }

  // ---------------------------adding new text Fields ---------------------
  void _add() {
    _children = List.from(_children)
      ..add(Consumer<OptionsProvider>(
        builder: (context, options, child) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: 'Enter Option Name',
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onFieldSubmitted: (String val) {
                optionsList.add(val);
                print(optionsList);
                options.optionsMap
                    .putIfAbsent(optionNameController.text.trim(), () => optionsList);
                options.setVisibility();
              },
            ),
          );
        },
      ));
    setState(() => ++_count);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StatefulBuilder(
      builder: (context, setState) {
        return Consumer<OptionsProvider>(
          builder: (context, options, child) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: Text("Add options"),
                scrollable: true,
                actions: <Widget>[
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        //----------------- Option title text field ----------------------------
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: optionNameController,
                                validator: (val) {
                                  if (val.isEmpty) return "Option is empty !";
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  hintText: 'Enter Option Title',
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {
                                _add();
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                        Container(
                            height: size.height * 0.6,
                            width: size.width * 0.9,
                            child: ListView(children: _children)),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print(options.optionsMap);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => AddProduct()),
                            // );
                            _validateAndSubmit();
                          },
                          child: Text('Add'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                            onPressed: (){

                          Navigator.pop(context);
                        }, child: Text('Cancel'))
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
