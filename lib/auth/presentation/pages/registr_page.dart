import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:easy_commerce/auth/domain/entities/user.dart';
import 'package:easy_commerce/auth/domain/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrPage extends StatefulWidget {
  RegistrPage({Key key}) : super(key: key);

  @override
  _RegistrPageState createState() => _RegistrPageState();
}

class _RegistrPageState extends State<RegistrPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _secondNameFocusNode = FocusNode();
  final _thirdNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _rePasswordFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _thirdNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final db = FirebaseFirestore.instance;

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
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            BackButton(
                              color: Colors.grey,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'REGISTRATION',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          'Enter your personal data.',
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
                          //Name
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              focusNode: _firstNameFocusNode,
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFBFBFBF),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                                LengthLimitingTextInputFormatter(31),
                              ],
                              validator: (value) {
                                if (value.length > 30) {
                                  return 'Max 30 symbols';
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
                                hintText: 'First name',
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
                          //second name
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              focusNode: _secondNameFocusNode,
                              controller: _secondNameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFBFBFBF),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                                LengthLimitingTextInputFormatter(31),
                              ],
                              validator: (value) {
                                if (value.length > 30) {
                                  return 'Max 30 symbols';
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
                                hintText: 'Second name',
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
                          //3rd name
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              focusNode: _thirdNameFocusNode,
                              controller: _thirdNameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFBFBFBF),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(31),
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              validator: (value) {
                                if (value.length > 30) {
                                  return 'Max 30 symbols';
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
                                hintText: 'Last name',
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
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
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
                                if (int.tryParse(value) == null) {
                                  return 'Only digits allowed';
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
                                hintText: 'Phone',
                                contentPadding: EdgeInsets.all(11),
                                isDense: true,
                                prefix:
                                    Padding(padding: EdgeInsets.only(left: 6)),
                                prefixIconConstraints: BoxConstraints(
                                  maxWidth: 42,
                                  maxHeight: 25,
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 13),
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
                          //repeat password
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              obscureText: true,
                              focusNode: _rePasswordFocusNode,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFBFBFBF),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                                LengthLimitingTextInputFormatter(17),
                              ],
                              validator: (value) {
                                if (value.length > 16) {
                                  return 'Max 16 digits';
                                }
                                if (value.length == 0) {
                                  return 'required';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords are not equal';
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
                                hintText: 'Repeat password',
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
                        ]),
                      ),
                    ),
                    //BUTTON NEXT
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(children: [
                        Expanded(
                          child: TextButton(
                            onPressed: _formKey?.currentState?.validate() ??
                                    false
                                ? () async {
                                    bool isUnique = true;
                                    await db
                                        .collection('users')
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      for (QueryDocumentSnapshot doc
                                          in querySnapshot.docs) {
                                        if (doc["Phone"] ==
                                            int.tryParse(
                                                _phoneController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'User with this logins already exists, try again or return to authorization.'),
                                          ));
                                          isUnique = false;
                                          break;
                                        }
                                      }
                                    });
                                    if (isUnique) {
                                      db.collection('users').add({
                                        'FirstName': _nameController.text,
                                        'SecondName':
                                            _secondNameController.text,
                                        'ThirdName': _thirdNameController.text,
                                        'Phone':
                                            int.tryParse(_phoneController.text),
                                        'Password':
                                            '${sha256.convert(utf8.encode(_passwordController.text))}'
                                      }).then((value) {
                                        RepositoryProvider.of<UserRepository>(
                                                context)
                                            .setUser = new User(
                                          name: _nameController.text,
                                          secondName:
                                              _secondNameController.text,
                                          thirdName: _thirdNameController.text,
                                          phone: int.tryParse(
                                              _phoneController.text),
                                        );
                                        Navigator.of(context)
                                            .pushReplacementNamed('/nav');
                                      });
                                    }
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
