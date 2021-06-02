// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';

// class OrdersReportPage extends StatefulWidget {
//   OrdersReportPage({Key key, this.file}) : super(key: key);
//   final File file;

//   @override
//   _OrdersReportPageState createState() => _OrdersReportPageState();
// }

// class _OrdersReportPageState extends State<OrdersReportPage> {
//   bool _isLoading = true;
//   PDFDocument document;

//   @override
//   void initState() {
//     super.initState();
//     loadDocument();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Просмотр отчета'),
//         ),
//         body: Center(
//           child: _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : PDFViewer(
//                   document: document,
//                   zoomSteps: 1,
//                   //uncomment below line to preload all pages
//                   lazyLoad: false,
//                   // uncomment below line to scroll vertically
//                   scrollDirection: Axis.vertical,

//                   //uncomment below code to replace bottom navigation with your own
//                   /* navigationBuilder:
//                       (context, page, totalPages, jumpToPage, animateToPage) {
//                     return ButtonBar(
//                       alignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(Icons.first_page),
//                           onPressed: () {
//                             jumpToPage()(page: 0);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             animateToPage(page: page - 2);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_forward),
//                           onPressed: () {
//                             animateToPage(page: page);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.last_page),
//                           onPressed: () {
//                             jumpToPage(page: totalPages - 1);
//                           },
//                         ),
//                       ],
//                     );
//                   }, */
//                 ),
//         ),
//       ),
//     );
//   }

//   void loadDocument() async {
//     document = await PDFDocument.fromFile(widget.file);

//     setState(() => _isLoading = false);
//   }
// }
