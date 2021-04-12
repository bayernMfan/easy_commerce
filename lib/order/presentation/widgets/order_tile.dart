import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key key, this.map}) : super(key: key);
  final Map<String, dynamic> map;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
          title: Text(
            map["Credentials"] ?? "Не известно",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          subtitle: Text(
              'Артикул ${map["Positions"]["Article"]} в количестве ${map["Positions"]["Count"]}. \nДата заказа: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(map["Date"].microsecondsSinceEpoch))}',
              style: TextStyle(color: Colors.white, fontSize: 14), overflow: TextOverflow.fade,),
          tileColor: Color.fromRGBO(41, 5, 141, 1),
          dense: true,
          isThreeLine: true,
        ),
      ),
    );
  }
}
