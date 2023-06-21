import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final controller;
  final labelText;
  final validator;
  final keboardtype;
  final icon;
  const CustomTextFieldWidget(
      {Key key,
      this.controller,
      this.labelText,
      this.validator,
      this.keboardtype,
      this.icon})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: TextFormField(
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: labelText,
          prefixIcon: icon,
          labelStyle: new TextStyle(
            color: Colors.grey,
            fontFamily: "Poppins-Regular",
            fontSize: 12,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
        ),
        controller: controller,
        keyboardType: keboardtype,
        validator: validator,
      ),
    );
  }
}
