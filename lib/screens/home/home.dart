import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Product> products = [
  //   Product(
  //       id: "1",
  //       title: "Product loul",
  //       image: ["assets/images/taswira_1.png"],
  //       description: "sac zabour",
  //       price: "200 DT",
  //       //color: Color(0xFFC3E5E4),
  //       brand: "My Brand",
  //       options: {
  //         "colors": ["a7mer", "azre9", "ak7al"],
  //         "size": ["xs", "s", "L"]
  //       }),
  //   Product(
  //       id: "2",
  //       title: "product theni",
  //       image: ["assets/images/taswira_2.png"],
  //       description: "sac wahdekher zabour ",
  //       price: "200 DT",
  //       //color: Color(0xFFF7F0E4),
  //       brand: "My Brand",
  //       options: {
  //         "colors": ["a7mer", "azre9", "ak7al"],
  //         "size": ["xs", "s", "L"]
  //       }),
  //   Product(
  //       id: "3",
  //       title: "sablito",
  //       image: ["assets/images/sablito.jpg"],
  //       description: "sablito orange",
  //       price: "10000000 DT",
  //       //color: Color(0xFFF7F0E4),
  //       brand: "My Brand",
  //       options: {
  //         "flavor": ["fraise", "karmous", "choklata"],
  //       }),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          new IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {}),
          new IconButton(
              icon: SvgPicture.asset("assets/icons/cart.svg"),
              onPressed: () {}),
        ],
      ),
      // body: ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: products.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return GestureDetector(
      //         onTap: () {
      //               Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => Details(
      //                   product: products[index],
      //                 ),
      //               ));
      //         },
      //         child: Card(
      //           child: Hero(
      //             tag: Text("hero 1 "),
      //             child: Column(children: <Widget>[
      //               Container(
      //                   padding: const EdgeInsets.only(top: 20.0),
      //                   width: MediaQuery.of(context).copyWith().size.width,
      //                   height: 300,
      //                   // decoration: BoxDecoration(
      //                   //   color: product.options["colors"],
      //                   // ),
      //                   child: Container(
      //                       child : ClipRect(child: Image.asset(products[index].image[0],fit: BoxFit.cover,)),
      //                         ),
      //                   ),
      //               Row(
      //                   children: <Widget>[
      //                     // Container(
      //                     //   width: MediaQuery.of(context).copyWith().size.width,
      //                     //   height: 66,
      //                     //   // decoration: BoxDecoration(
      //                     //   //   color: product.color,
      //                     //   // ),
      //                       Row(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: <Widget>[
      //                             Row(
      //                               children: <Widget>[
      //                                 Column(
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: <Widget>[
      //                                     Padding(
      //                                       padding: EdgeInsets.only(left: 12.0),
      //                                       child: Text(products[index].title,
      //                                           style: TextStyle(
      //                                             fontFamily: 'Rubik',
      //                                             fontWeight: FontWeight.bold,
      //                                           )),
      //                                     ),
      //                                     Container(
      //                                       width: 400,
      //                                         child: Row(
      //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                           children: <Widget>[
      //                                             Padding(
      //                                               padding: EdgeInsets.only(left: 12.0),
      //                                               child: Text(products[index].description,
      //                                                   style: TextStyle(
      //                                                     fontFamily: 'Rubik',
      //                                                   )),
      //                                             ),
      //                                             Text(products[index].price,
      //                                                 style: TextStyle(
      //                                                   fontFamily: 'Rubik',
      //                                                 )),
      //                                             IconButton(
      //                                                 icon: SvgPicture.asset(
      //                                                     "assets/icons/heart.svg"),
      //                                                 onPressed: () {}),
      //                                           ],
      //                                         ),
      //                                        ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ]),
      //                     //),
      //                   ],
      //                 ),
      //             ]),
      //           ),
      //         ),
      //       );
      //     }),
    );

  }

}
//
// class ItemCard extends StatelessWidget {
//   final Product product;
//
//   const ItemCard({
//     Key key,
//     this.product,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Container(
//           padding: const EdgeInsets.only(top: 20.0),
//           width: MediaQuery.of(context).copyWith().size.width,
//           height: 200,
//           // decoration: BoxDecoration(
//           //   color: product.options["colors"],
//           // ),
//           child: Container(child: Image.asset(product.image))),
//       Row(
//         children: <Widget>[
//           Container(
//             width: MediaQuery.of(context).copyWith().size.width,
//             height: 70,
//             // decoration: BoxDecoration(
//             //   color: product.color,
//             // ),
//             child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: 20.0),
//                             child: Text(product.title,
//                                 style: TextStyle(
//                                   fontFamily: 'Rubik',
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).copyWith().size.width,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 20.0),
//                                   child: Text(product.description,
//                                       style: TextStyle(
//                                         fontFamily: 'Rubik',
//                                       )),
//                                 ),
//                                 Text(product.price,
//                                     style: TextStyle(
//                                       fontFamily: 'Rubik',
//                                     )),
//                                 IconButton(
//                                     icon: SvgPicture.asset(
//                                         "assets/icons/heart.svg"),
//                                     onPressed: () {}),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ]),
//           ),
//         ],
//       ),
//     ]);
//   }
// }
