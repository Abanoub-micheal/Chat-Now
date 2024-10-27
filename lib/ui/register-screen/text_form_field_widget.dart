import 'package:flutter/material.dart';
import '../../my_theme.dart';

typedef Validator =String? Function(String?);
class TextFormFieldWidget extends StatelessWidget {
  Validator? validator ;
  String label;
  bool obscure;
  TextInputType? keyboardType;
  TextEditingController? controller;
  TextFormFieldWidget({super.key, this.keyboardType,this.validator,required this.label,this.obscure=false,this.controller});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(obscureText:obscure ,
      controller:controller ,
      keyboardType:keyboardType ,
      validator:validator,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:MyTheme.primaryColor ),),
        label: Text(
          label,
          style: TextStyle(color:MyTheme.greyColor),

        ),
      ),
    );
  }
}
