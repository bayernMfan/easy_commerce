import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_commerce/auth/domain/entities/user.dart';
import 'package:easy_commerce/auth/domain/repository/user_repository.dart';
import 'package:easy_commerce/order/presentation/widgets/order_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOrderPage extends StatefulWidget {
  MakeOrderPage({Key key}) : super(key: key);

  @override
  _MakeOrderPageState createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage>
    with AutomaticKeepAliveClientMixin<MakeOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _commentsController = TextEditingController();
  final _articleController = TextEditingController();
  final _countController = TextEditingController();
  final db = FirebaseFirestore.instance;

  String _chosenValue;
  List<String> items = [];

  bool _isValid;
  @override
  void initState() {
    super.initState();
    _isValid = false;
    _getAdresses();
  }

  void _getAdresses() async {
    items = await db.collection('shops').orderBy('number').get().then((value) =>
        value.docs.map((e) => e.data()['address'].toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(48)),
                              child: Center(
                                child:
                                    // StreamBuilder<Object>(
                                    //   stream: db
                                    //       .collection('shops')
                                    //       .orderBy('number')
                                    //       .snapshots(),
                                    //   builder: (context, stream) {
                                    //     if (stream.connectionState ==
                                    //         ConnectionState.waiting) {
                                    //       return const Center(
                                    //           child: CircularProgressIndicator());
                                    //     }

                                    //     if (stream.hasError) {
                                    //       return Center(
                                    //           child: Text(stream.error.toString()));
                                    //     }
                                    //     QuerySnapshot querySnapshot = stream.data;
                                    //     List<String> items = querySnapshot.docs
                                    //         .map((e) =>
                                    //             e.data()['address'].toString())
                                    //         .toList();
                                    //     return
                                    DropdownButton<String>(
                                  focusColor: Colors.white,
                                  value: _chosenValue,
                                  //elevation: 5,
                                  style: TextStyle(color: Colors.white),
                                  iconEnabledColor: Colors.black,
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Choose your marketplace address",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      _chosenValue = value;
                                    });
                                  },
                                  //  );
                                  // },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: OrderInput(
                        hint: 'Comment',
                        controller: _commentsController,
                        onChanged: () {
                          setState(() {
                            _isValid = _formKey?.currentState?.validate();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              flex: 2,
                              child: OrderInput(
                                hint: 'Article',
                                isNum: true,
                                controller: _articleController,
                                onChanged: () {
                                  setState(() {
                                    _isValid =
                                        _formKey?.currentState?.validate();
                                  });
                                },
                              )),
                          Padding(padding: EdgeInsets.only(left: 16)),
                          Flexible(
                              flex: 1,
                              child: OrderInput(
                                hint: 'Count',
                                isNum: true,
                                controller: _countController,
                                onChanged: () {
                                  setState(() {
                                    _isValid =
                                        _formKey?.currentState?.validate();
                                  });
                                },
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(children: [
                        Expanded(
                          child: TextButton(
                            onPressed: _isValid && _chosenValue != null
                                ? () async {
                                    User user =
                                        RepositoryProvider.of<UserRepository>(
                                                context)
                                            .getUser;
                                    await db.collection('orders').add({
                                      'Credentials':
                                          '${user.name} ${user.secondName}',
                                      'ShopAddress': _chosenValue,
                                      'Comments': _commentsController.text,
                                      'Date': Timestamp.fromDate(
                                          new DateTime.now()),
                                      'Positions': {
                                        'Article':
                                            int.parse(_articleController.text),
                                        'Count':
                                            int.parse(_countController.text)
                                      }
                                    }).then((value) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Ваш заказ успешно доставлен!"),
                                        )));
                                  }
                                : null,
                            child: Text(
                              'Make an order',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  height: 34 / 20,
                                  color: Color(0xFFFFFFFF)),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) =>
                                      states.contains(MaterialState.disabled)
                                          ? Color.fromRGBO(41, 5, 141, 0.5)
                                          : Color(0xFF29058D),
                                ),
                                minimumSize:
                                    MaterialStateProperty.all(Size(100, 60)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
