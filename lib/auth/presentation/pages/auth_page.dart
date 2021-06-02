import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_commerce/auth/domain/entities/user.dart';
import 'package:easy_commerce/auth/domain/repository/user_repository.dart';
import 'package:easy_commerce/auth/presentation/pages/registr_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Text(
                          'AUTHORIZATION',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          'Enter your login and password.',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  Column(children: [
                    //PHONE INPUT
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            focusNode: _phoneFocusNode,
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFFBFBFBF),
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            validator: (value) {
                              if (value.length > 10) {
                                return 'Max 10 digits';
                              }
                              if (value.length == 0) {
                                return 'required';
                              } else if (value.length < 10) {
                                return 'Enter full phone number';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: '9991234567',
                              contentPadding: EdgeInsets.all(11),
                              isDense: true,
                              prefix:
                                  Padding(padding: EdgeInsets.only(left: 6)),
                              prefixIconConstraints: BoxConstraints(
                                maxWidth: 42,
                                maxHeight: 25,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 13),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 2, color: Color(0xFFE0E0E0)),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '+7',
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        height: 34 / 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide:
                                    BorderSide(color: Color(0xFFBFBFBF)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide:
                                    BorderSide(color: Color(0xFFBFBFBF)),
                              ),
                            ),
                          ),
                          //PASSWORD INPUT
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              obscureText: true,
                              focusNode: _passwordFocusNode,
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFBFBFBF),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                                LengthLimitingTextInputFormatter(17),
                              ],
                              validator: (value) {
                                if (value.length > 16) {
                                  return 'Max 16 symbols';
                                }
                                if (value.length == 0) {
                                  return 'required';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.all(11),
                                isDense: true,
                                prefix:
                                    Padding(padding: EdgeInsets.only(left: 6)),
                                prefixIconConstraints: BoxConstraints(
                                  maxWidth: 32,
                                  maxHeight: 25,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(48),
                                  borderSide:
                                      BorderSide(color: Color(0xFFBFBFBF)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(48),
                                  borderSide:
                                      BorderSide(color: Color(0xFFBFBFBF)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: RichText(
                                text: TextSpan(
                                    text: "Haven't an account yet? ",
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: "Registration",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrPage()));
                                      },
                                  )
                                ])),
                          ),
                        ]),
                      ),
                    ),
                    //BUTTON NEXT
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
                                _formKey?.currentState?.validate() ?? false
                                    ? () async {
                                        bool found = false;
                                        await db.collection('users').get().then(
                                            (QuerySnapshot querySnapshot) {
                                          for (QueryDocumentSnapshot doc
                                              in querySnapshot.docs) {
                                            if (doc["Phone"] ==
                                                    int.tryParse(
                                                        _phoneController
                                                            .text) &&
                                                doc['Password'] ==
                                                    _passwordController.text) {
                                              RepositoryProvider
                                                          .of<UserRepository>(
                                                              context)
                                                      .setUser =
                                                  new User(
                                                      name: doc['FirstName'],
                                                      secondName:
                                                          doc['SecondName'],
                                                      thirdName:
                                                          doc['ThirdName'],
                                                      phone: doc['Phone']);
                                              Navigator.of(context)
                                                  .pushReplacementNamed('/nav');
                                              found = true;
                                              break;
                                            }
                                          }
                                        });

                                        if (found == false)
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Wrong login or password'),
                                          ));
                                      }
                                    : null,
                            child: Text(
                              'Login',
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
                  ]),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
