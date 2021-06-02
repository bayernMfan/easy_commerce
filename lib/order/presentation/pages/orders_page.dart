import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:easy_commerce/order/presentation/pages/orders_report_page.dart';
import 'package:easy_commerce/order/presentation/widgets/order_tile.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin<OrdersPage> {
  Query query = FirebaseFirestore.instance
      .collection('orders')
      .orderBy("Date", descending: true);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                  color: Color(0xFF29058D),
                  textColor: Colors.white,
                  onPressed: () async {
                    final List<DateTime> picked =
                        await DateRangePicker.showDatePicker(
                            context: context,
                            initialFirstDate: (new DateTime.now())
                                .subtract(new Duration(days: 7)),
                            initialLastDate: new DateTime.now(),
                            firstDate: new DateTime(2015),
                            lastDate: new DateTime(DateTime.now().year + 2));
                    if (picked != null && picked.length == 2) {
                      setState(() {
                        query = FirebaseFirestore.instance
                            .collection('orders')
                            .where("Date",
                                isGreaterThanOrEqualTo: picked.first,
                                isLessThanOrEqualTo: picked.last
                                    .add(Duration(hours: DateTime.now().hour)))
                            .orderBy("Date", descending: true);
                      });
                    }
                  },
                  child: new Text("Choose date period")),
              MaterialButton(
                  child: Text("Create report"),
                  color: Color(0xFF29058D),
                  textColor: Colors.white,
                  onPressed: () async {
                    File file = await _createAndSavePDF(query);

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => OrdersReportPage(file: file)));
                  })
            ],
          ),
        ),
        Expanded(
          child: Padding(
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
                        return OrderTile(map: querySnapshot.docs[index].data());
                      });
                }),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => false;

  Future _createAndSavePDF(Query query) async {
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    } else {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('The report is creating')));
        List<Map<String, dynamic>> res = await query
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());
        Directory downloadsDirectory =
            await DownloadsPathProvider.downloadsDirectory;

        final pdf = pw.Document();

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) => pw.Center(
              child: pw.ListView.builder(
                  itemBuilder: (pw.Context context, int index) => pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("-------ORDER-------"),
                            pw.Text(
                                "Date: ${DateFormat('yyyy MM dd kk mm').format(DateTime.fromMicrosecondsSinceEpoch((res[index]["Date"] as Timestamp).microsecondsSinceEpoch))}"),
                            pw.Text("Credits ${res[index]["Credentials"]}"),
                            pw.Text("Comment ${res[index]["Comments"]}"),
                            pw.Text(
                                "Artcile ${res[index]["Positions"]["Article"]}"),
                            pw.Text(
                                "Count ${res[index]["Positions"]["Count"]}"),
                            pw.Text("Address ${res[index]["ShopAddress"]}"),
                          ]),
                  itemCount: res.length),
            ),
          ),
        );

        final file = await File(
                '${downloadsDirectory.path}/report_${DateFormat('yyyy-MM-dd–kk-mm').format(DateTime.now())}.pdf')
            .writeAsBytes(await pdf.save())
          ..path;
        OpenFile.open(file.path);
        //return file;
        //return await file.writeAsBytes(await pdf.save());
      } else
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unavalable to save file')));
    }
  }
}
