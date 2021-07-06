import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String labelText;
  final bool isObscure;
  final String Function(String) textFieldValidator;

  const CustomTextField(
      {Key key,
      this.editingController,
      this.labelText,
      this.isObscure,
      this.textFieldValidator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: editingController,
      obscureText: isObscure,
      textAlign: TextAlign.start,
      autofocus: false,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white70,
        filled: true,
        contentPadding: EdgeInsets.all(14),
      ),
      validator: textFieldValidator,
    );
  }
}
