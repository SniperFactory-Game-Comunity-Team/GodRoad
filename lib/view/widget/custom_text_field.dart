import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.textValidator,
      required this.textHint,
      this.obscure});
  final TextEditingController controller;
  final Function? textValidator;
  final String textHint;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextFormField(
          obscureText: obscure ?? false,
          controller: controller,
          decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 0.1,
                ),
              ),
              hintText: textHint,
              filled: true,
              fillColor: Colors.white),
          validator: (val) {
            return textValidator != null ? textValidator!(val!) : null;
          },
          autovalidateMode: AutovalidateMode.always),
    );
  }
}
