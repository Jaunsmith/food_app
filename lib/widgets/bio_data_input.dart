import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../utilities/dynamic_dimensions.dart';

class BioDataInput extends StatefulWidget {
  const BioDataInput({
    super.key,
    required this.hintText,
    required this.icons,
    required this.controller,
    required this.textInputType,
    this.isPassword = false,
  });

  final String hintText;
  final IconData icons;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;

  @override
  State<BioDataInput> createState() => _BioDataInputState();
}

class _BioDataInputState extends State<BioDataInput> {
  late bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: DynamicDimensions.size20,
        right: DynamicDimensions.size20,
        bottom: DynamicDimensions.size20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DynamicDimensions.size30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword ? _obscure : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icons, color: AppColors.mainColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DynamicDimensions.size30),
            borderSide: BorderSide(width: 1.0, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DynamicDimensions.size30),
            borderSide: BorderSide(width: 1.0, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DynamicDimensions.size30),
          ),
          suffixIcon:
              widget.isPassword
                  ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    child:
                        _obscure
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                  )
                  : null,
        ),
      ),
    );
  }
}
