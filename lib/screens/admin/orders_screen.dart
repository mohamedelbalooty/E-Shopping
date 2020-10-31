import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raia_rgon/models/order.dart';
import 'package:raia_rgon/services/store.dart';
import '../../consestsnt.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KmainColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 10.0,
        title: Text(
          'Order Page',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: KwhiteColor,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('there is no orders'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.documents) {
              orders.add(Order(
                documentId: doc.documentID,
                address: doc.data[KAddress],
                totalPrice: doc.data[KTotalPrice],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: orders[index].documentId);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    decoration: BoxDecoration(
                      color: KsecondColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Totall Price = \$${orders[index].totalPrice}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address is ${orders[index].address}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
