import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  @override 
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            ),
            onPressed: () {},
          ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  "Shopping Cart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                     ),
                     ),
                     SizedBox(height: 18.0),
                     CartItem(),
                     CartItem(),
                     CartItem(),
                     SizedBox(height: 21.0),
                     Divider(),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                         ),
                         Text(
                          "\u20b9 480,000",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                         ),
                       ],
                     ),
                     SizedBox(height: 4.0),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(
                          "Delivery Charge",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                         ),
                         Text(
                          "\u20b9 480,000",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                         ),
                       ],
                     ),
                     Divider(),
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                         ),
                         Text(
                          "\u20b9 480,000",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                         ),
                       ],
                     ),


                      SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: Text(
                              "Kursi Gaming",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 15.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 15.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\u20b9 12,000",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              ),
                          ),  
                        ],
                      ),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.cyan,
                        height: 50.0,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                          ),
                        child: Text("PROCEED TO CHECKOUT", style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        ),
                        SizedBox(height: 18.0),
                    ],  
                  ),
                ),
          //),
          ]
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.white,
     margin: EdgeInsets.symmetric(vertical: 8.0),
     child: Row(
       children: <Widget>[
     Container(
       width: 80.0,
       height: 80.0,
       decoration: BoxDecoration(
         color: Colors.grey[300],
         borderRadius: BorderRadius.circular(20.0),
       ),
         child: Center(
         child: Container(
           width: 60.0,
           height: 60.0,
           decoration: BoxDecoration(
             color: Colors.grey[300],
             //image: DecorationImage(
               //image: Images.assets('assets/images/kursigamingg.jpg'),
             //fit : BoxFit.scaleDown,    
           ), //borderRadius: BorderRadius.circular(20.0)
       ),
         ),
     ),
       ],
     ),  
     );
  }
}