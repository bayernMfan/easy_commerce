import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_commerce/order/presentation/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Query query = FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<Object>(
          stream: query.snapshots(),
          builder: (context, stream) {
            if (stream.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (stream.hasError) {
              return Center(child: Text(stream.error.toString()));
            }

            QuerySnapshot querySnapshot = stream.data;
            return ListView.builder(
                itemCount: querySnapshot.size,
                itemBuilder: (context, index) {
                  print(querySnapshot.docs[index].data().runtimeType);
                  return OrderTile(map: querySnapshot.docs[index].data());
                });
          }),
    );
  }
}
