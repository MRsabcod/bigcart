import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {

  final TextEditingController controller;
  final String title;
  EmailField({required this.controller, required this.title});

  static String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        validator: (currentValue){
          var nonNullable = currentValue ?? "";
          if(nonNullable.isEmpty){
            return "Email field can't be empty!";
          }else if(!regExp.hasMatch(nonNullable)){
            return "Please enter valid email address";
          }return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            prefixIcon: Icon(Icons.email_outlined),
            hintStyle: const TextStyle(
                fontFamily: "Poppins"
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)))
    );
  }
}
class PasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String title;
  PasswordField({required this.controller, required this.title});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        validator: (currentValue){
          var nonNullable = currentValue ?? "";
          if(nonNullable.isEmpty){
            return "Password field can't be empty!";
          }
          return null;
        },
        obscureText: obscureText,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.title,
            prefixIcon: Icon(Icons.lock_outline),
            hintStyle: const TextStyle(
                fontFamily: "Poppins"
            ),
            suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(obscureText?Icons.visibility: Icons.visibility_off,)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)))
    );
  }
}
class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  PhoneField({required this.controller, required this.title});

  static String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.phone,
        controller: controller,
        validator: (currentValue) {
          var nonNullable = currentValue ?? "";
          if (nonNullable.isEmpty) {
            return "Contact field can't be empty!";
          }else if (!regExp.hasMatch(nonNullable)) {
            return 'Please enter valid mobile number';
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: title,
            prefixIcon: Icon(Icons.phone),
            hintStyle: const TextStyle(fontFamily: "Poppins"),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))));
  }
}