import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class FormInputDesign extends StatefulWidget {

  String label;
  String inputHint;
  TextEditingController controller;
  TextInputType textInputType;

  FormInputDesign({this.label, this.inputHint, @required this.controller, @required this.textInputType});

  @override
  _FormInputDesignState createState() => _FormInputDesignState();
}

class _FormInputDesignState extends State<FormInputDesign> {
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Color(0xff8f9db5),
              ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
          child: TextFormField(
            keyboardType: widget.textInputType,
            controller: widget.controller,
            obscureText: widget.label == 'Password' ? true : false,
            // this can be changed based on usage -
            // such as - onChanged or onFieldSubmitted
            onChanged: (value) {
              setState(() {
                if(value.length != 0) {
                  isSubmitted = true;
                } else {
                  isSubmitted = false;
                }
              });
            },
            style: TextStyle(
                fontSize: 19,
                color: Color(0xff0962ff),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: widget.inputHint,
              hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600),
              contentPadding:
              EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              focusColor: Color(0xff0962ff),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xff0962ff)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey[350],
                ),
              ),
              suffixIcon: isSubmitted == true
              // will turn the visibility of the 'checkbox' icon
              // ON or OFF based on the condition we set before
                  ? Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    checkBoxIcon,
                    height: 0.2,
                  ),
                ),
              )
                  : Visibility(
                visible: false,
                child: SvgPicture.asset(checkBoxIcon),
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
