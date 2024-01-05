import 'dart:developer';

import 'package:flutter/material.dart';

class CustomTextFieldShade extends StatelessWidget {
  final controller;
  final labelText;
  final validator;
  final keboardtype;
  final icon;
  final height, width;
  final maxline;
  final counter;
  final saved;
  const CustomTextFieldShade({
    Key key,
    this.saved,
    this.controller,
    this.labelText,
    this.validator,
    this.keboardtype,
    this.icon,
    this.height,
    this.width,
    this.maxline,
    this.counter,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10.0,
            color: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: labelText,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              border: InputBorder.none,
              prefixIcon: icon,
              labelStyle: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins-Regular",
                fontSize: 12,
              ),
              counterText: counter),
          maxLength: maxline,
          controller: controller,
          keyboardType: keboardtype,
          validator: validator,
          onSaved: saved,
        ),
      ),
    );
  }
}
