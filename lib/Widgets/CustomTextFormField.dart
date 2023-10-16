import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final controller;
  final labelText;
  final validator;
  final keboardtype;
  final icon;
  final saved;
  final inialValue;
  final maxline;
  final counter;
  final focusNode;
  final action;
  final change;
  const CustomTextFieldWidget(
      {Key key,
      this.saved,
      this.controller,
      this.labelText,
      this.validator,
      this.keboardtype,
      this.icon,
      this.inialValue,
      this.maxline,
      this.counter,
      this.focusNode,
      this.action,
      this.change})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: TextFormField(
        focusNode: focusNode,
        textInputAction: action,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: labelText,
          hintText: inialValue,
          counterText: counter,
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
        maxLength: maxline,
        controller: controller,
        keyboardType: keboardtype,
        validator: validator,
        onSaved: saved,
        onChanged: change,
      ),
    );
  }
}
