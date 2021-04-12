import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderInput extends StatefulWidget {
  OrderInput(
      {Key key,
      this.hint = 'hint',
      this.isNum = false,
      this.controller,
      this.onChanged})
      : super(key: key);
  final String hint;
  final bool isNum;
  final TextEditingController controller;
  final void Function() onChanged;

  @override
  _OrderInputState createState() => _OrderInputState();
}

class _OrderInputState extends State<OrderInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        widget.onChanged();
      },
      controller: widget.controller,
      keyboardType: widget.isNum ? TextInputType.number : TextInputType.text,
      cursorColor: Color(0xFFBFBFBF),
      inputFormatters: <TextInputFormatter>[
        if (widget.isNum) LengthLimitingTextInputFormatter(11),
        if (widget.isNum) FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      validator: (value) {
        if (value.length == 0) {
          return 'Заполните поле';
        }
        if (widget.isNum && value.length > 9) {
          return "Неверное поле";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20,
        //height: 34 / 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
        hintText: widget.hint,
        contentPadding: EdgeInsets.all(11),
        isDense: true,
        prefix: Padding(padding: EdgeInsets.only(left: 6)),
        prefixIconConstraints: BoxConstraints(
          maxWidth: 32,
          maxHeight: 25,
        ),
        // prefixIcon: Padding(
        //   padding: const EdgeInsetsDirectional.only(start: 13),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       border: Border(
        //         right: BorderSide(width: 2, color: Color(0xFFE0E0E0)),
        //       ),
        //     ),
        //     child: Align(
        //       alignment: Alignment.centerLeft,
        //       child: Text(
        //         '+',
        //         textHeightBehavior:
        //             TextHeightBehavior(applyHeightToFirstAscent: false),
        //         style: TextStyle(
        //           fontWeight: FontWeight.w400,
        //           fontSize: 20,
        //           height: 34 / 20,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: BorderSide(color: Color(0xFFBFBFBF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
