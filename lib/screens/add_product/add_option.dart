import 'package:social_shop_app/singletons/data.dart';

import 'add_product.dart';
import 'package:flutter/material.dart';

class AddOption extends StatefulWidget {

  @override
  _AddOptionState createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;

  // var optionsMap = appData.optionsMap;
  static List<String> optionsList = [null];


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // option textfield
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: 'Enter your option title'
                    ),
                    validator: (v){
                      if(v.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Text('Add Options', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                ..._getOptions(),
                SizedBox(height: 40,),
                TextButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                          }

                          // optionsMap.update(_nameController.text,
                          //         (optionsList) => optionsList,
                          //   ifAbsent: () => optionsList
                          // );

                          //optionsMap.putIfAbsent(_nameController.text, () => optionsList);

                          //print('fel add options $optionsList');
                          appData.isVisible = true;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddProduct()),
                          );
                        },
                        child: Text('Submit'),

                      )
              ],
            ),
          ),
        ),
    );
  }

  /// get options text-fields
  List<Widget> _getOptions(){
    List<Widget> optionTextFields = [];
    for(int i=0; i<optionsList.length; i++){
      optionTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: OptionTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButton(i == optionsList.length-1, i),
              ],
            ),
          )
      );
    }
    return optionTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          optionsList.insert(0, null);
        }
        else optionsList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }

}

class OptionTextFields extends StatefulWidget {
  final int index;
  OptionTextFields(this.index);
  @override
  _OptionTextFieldsState createState() => _OptionTextFieldsState();
}

class _OptionTextFieldsState extends State<OptionTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _AddOptionState.optionsList[widget.index] ?? '';

    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) {
        _AddOptionState.optionsList[widget.index] = v;
      } ,
      onFieldSubmitted: (val){
        setState(() {
        //  List<String> list = _AddOptionState.optionsList ;
          //appData.optionsMap.putIfAbsent(_nameController.text, () => list.add(val));
          //appData.optionsMap.putIfAbsent(_nameController.text, () => _AddOptionState.optionsList);
          appData.optionsMap[_nameController.text].add(val);
        });
      },
      decoration: InputDecoration(
          hintText: 'Enter your option\'s name'
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}