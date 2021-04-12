import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
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
                          'АВТОРИЗАЦИЯ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          'Пожалуйста, введите ваш телефон и пароль.',
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
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFFBFBFBF),
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            validator: (value) {
                              if (value.length > 9) {
                                return 'Максимум 9 цифр';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.always,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(11),
                              isDense: true,
                              prefix:
                                  Padding(padding: EdgeInsets.only(left: 6)),
                              prefixIconConstraints: BoxConstraints(
                                maxWidth: 32,
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
                                      '+',
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
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFBFBFBF),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              autovalidateMode: AutovalidateMode.always,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
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
                          )
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
                                        await Navigator.pushReplacementNamed(
                                            context, '/nav');
                                      }
                                    : null,
                            child: Text(
                              'Войти',
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
