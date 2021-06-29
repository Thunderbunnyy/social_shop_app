import 'package:flutter/material.dart';
import 'package:social_shop_app/components/show_loading.dart';
import 'package:social_shop_app/data/base/api_response.dart';
import 'package:social_shop_app/data/models/product.dart';
import 'package:social_shop_app/data/repositories/products/provider_api_product.dart';
import 'package:stripe_payment/stripe_payment.dart';

class Cart extends StatefulWidget {

  final String id;

  const Cart({Key key, this.id}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
    name: 'Test User',
    cvc: '133',
    addressLine1: 'Address 1',
    addressLine2: 'Address 2',
    addressCity: 'City',
    addressState: 'CA',
    addressZip: '1337',
  );

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "pk_test_51J7TCgAnbW8iPnpgRdtuyi4zwvNyI8ynZ41fXR4v5iMwupiccO375EwUVelzwkEErk0nXjhgai9psV9zZWttyZb800VNEy8vgZ",
            // merchantId: "Test",
            // androidPayMode: 'test'
        )
    );
  }

  // Future<void> startPayment() async {
  //   PaymentMethod paymentMethod = PaymentMethod();
  //   paymentMethod = await StripePayment.paymentRequestWithCardForm(
  //     CardFormPaymentRequest()).then((PaymentMethod paymentMethod) {
  //       return paymentMethod;
  //   }).catchError((e){
  //     print(e);
  //   });
  //   startDirectCharge(paymentMethod);
  // }

  // Future<void> startDirectCharge(PaymentMethod paymentMethod) async{
  //   print("payment charge started");
  //
  //   final http.Response = await http.post(Uri.parse());
  //
  //   if(response.body !=null){
  //     f
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart',style: TextStyle(color: Colors.black54),),
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close_sharp),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<ApiResponse>(
        future: ProductProviderApi().getById(widget.id),
        builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot){
          if (snapshot.hasData){
            if (snapshot.data.success) {
              if (snapshot.data.result == null ||
                  snapshot.data.results.isEmpty) {
                return Container();
              }
            }

            Product product = snapshot.data.result;

            String title = product.title;
            String price = product.price;
            String username = product.owner;
            List<dynamic> images = product.images;
            //Map<String, dynamic> options = product.options;
            //todo sajel el option that the user chose

            //todo change to make it dynamic
            return Column(
                    children: [
                      ListTile(
                        title: Text(title),
                        leading: ClipRRect(
                          child: Image.network(
                            images[0].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        subtitle: Text(price,style: TextStyle(
                          color: Colors.red
                        ),),
                      ),
                      ListTile(
                        title: Text('Subtotal'),
                        trailing: Text('$price DT'),
                      ),
                      MaterialButton(
                          minWidth: size.width * 0.9,
                          shape: RoundedRectangleBorder(),
                          child: Text(
                            'Proceed With Checkout',
                            style: TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {

                          },
                          color: Colors.black)
                    ],
                  );

          }else{
            return showLoading();
          }
        },
      ),
    );
  }




}
