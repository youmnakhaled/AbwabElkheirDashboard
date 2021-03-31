import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Size deviceSize;
  final TextEditingController controller;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final Function suffixOnTap;
  final bool obscureText;
  final String labelText;
  final bool search;
  final Function onChanged;

  const TextFieldWidget({
    this.deviceSize,
    this.controller,
    this.prefixIconData,
    this.suffixIconData,
    this.suffixOnTap,
    this.onChanged,
    this.obscureText = false,
    this.labelText,
    this.search = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: search
              ? deviceSize.width * 0.2
              : deviceSize.width * 0.3 < 250
                  ? 250
                  : deviceSize.width * 0.3,
          margin: EdgeInsets.all(deviceSize.height * 0.01),
          child: Theme(
            data: ThemeData(primaryColor: Colors.black26),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                textAlign: TextAlign.left,
                onChanged: onChanged != null ? onChanged : null,
                obscureText: obscureText,
                controller: controller,
                // ignore: missing_return
                validator: (String value) {
                  if (labelText == "Email") {
                    if (!value.contains("@") ||
                        !value.contains(".") ||
                        value.isEmpty) {
                      return "Please enter a valid email address.";
                    }
                  } else if (labelText == "Username") {
                    if (value.length < 4 || value.isEmpty) {
                      return "Username must be 4 characters or more.";
                    }
                  } else if (labelText == "Password") {
                    if (value.isEmpty || value.length < 8) {
                      return "Password must be 8 characters or more.";
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  prefixIcon: Icon(
                    prefixIconData,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      suffixIconData,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    onPressed: suffixOnTap,
                  ),
                  labelText: labelText,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                style: TextStyle(color: Colors.black87),
                cursorColor: ConstantColors.purple,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
