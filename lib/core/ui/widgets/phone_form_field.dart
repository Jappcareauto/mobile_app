import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'custom_text_field.dart';

class CustomPhoneFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? initialCountryCode;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final void Function(CountryCode)? onCountryChange;
  final void Function(String)? onChanged;

  const CustomPhoneFormField(
      {super.key,
      required this.controller,
      this.label,
      this.hintText,
      this.initialCountryCode,
      this.isEnabled = true,
      this.validator,
      this.onCountryChange,
      this.onChanged,});

  @override
  _CustomPhoneFormFieldState createState() => _CustomPhoneFormFieldState();
}

class _CustomPhoneFormFieldState extends State<CustomPhoneFormField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryCodePicker(
        showFlag: false,
        initialSelection: widget.initialCountryCode??"+237",
        onChanged: (countryCode) {
          if (widget.onCountryChange != null) {
            widget.onCountryChange!(countryCode);
          }
        },
        textStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
      ),
        Expanded(
          child: CustomFormField(
            controller: widget.controller,
            label: widget.label,
            hintText: widget.hintText,
            keyboardType: TextInputType.phone,
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}