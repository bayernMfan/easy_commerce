import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_commerce/order/presentation/widgets/order_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class MakeOrderPage extends StatefulWidget {
  MakeOrderPage({Key key}) : super(key: key);

  @override
  _MakeOrderPageState createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _creditsController = TextEditingController();
  final _commentsController = TextEditingController();
  final _articleController = TextEditingController();
  final _countController = TextEditingController();
  final db = FirebaseFirestore.instance;

  bool _isValid;
  @override
  void initState() {
    super.initState();
    _isValid = false;
  }

  @override
  Widget build(BuildContext context) {
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
                      child: OrderInput(
                        hint: 'Ваши ФИО',
                        controller: _creditsController,
                        onChanged: () {
                          setState(() {
                            _isValid = _formKey?.currentState?.validate();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: OrderInput(
                        hint: 'Комментарии',
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
                                hint: 'Артикул',
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
                                hint: 'Кол-во',
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
                            onPressed:
                                // () async {
                                //   print(Localizations.localeOf(context)
                                //       .languageCode);
                                //   await AppLocalization.load(
                                //       Localizations.localeOf(context));
                                //   print('LOADED');
                                //   print(AppLocalization.of(context).hello);
                                // },
                                _isValid
                                    ? () async {
                                        await db.collection('orders').add({
                                          'Credentials':
                                              _creditsController.text,
                                          'Comments': _commentsController.text,
                                          'Date': Timestamp.fromDate(
                                              new DateTime.now()),
                                          'Positions': {
                                            'Article': int.parse(
                                                _articleController.text),
                                            'Count':
                                                int.parse(_countController.text)
                                          }
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Отправили Ваш заказ!"),
                                        ));
                                      }
                                    : null,
                            child: Text(
                              'Сделать заказ',
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
}
