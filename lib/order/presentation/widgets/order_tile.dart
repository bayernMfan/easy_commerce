
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
        child: Container(
          color: Color(0xFF29058D).withOpacity(0.9),
          child: ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            title: Text(
              map["Credentials"] ?? "Undefined",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            subtitle: Text(
              'Article ${map["Positions"]["Article"]} in count ${map["Positions"]["Count"]}. \nOrder date: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(map["Date"].microsecondsSinceEpoch))} \nAddress: ${map['ShopAddress']}',
              style: TextStyle(color: Colors.white, fontSize: 14),
              overflow: TextOverflow.fade,
            ),
            dense: true,
            //isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
