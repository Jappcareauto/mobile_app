import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_dimensions.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final bool isPassword;
  final bool isEnabled;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onSuffixIconTap;
  final bool obscureText;
  final void Function(String)? onChanged;
  final double borderRadius;
  final Color borderColor;
  final Color enabledBorderColor;
  final Color? focusedBorderColor;
  final double fontSize;
  final Color labelColor;
  final EdgeInsetsGeometry contentPadding;
  final int? maxLength;
  final bool forceUpperCase;

  const CustomFormField({
    Key? key,
    this.controller,
    this.label,
    this.hintText,
    this.isPassword = false,
    this.isEnabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefix,
    this.suffix,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.onChanged,
    this.borderRadius = AppDimensions.radiusSmall,
    this.borderColor = Colors.grey,
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor,
    this.fontSize = 12,
    this.labelColor = Colors.black,
    this.contentPadding = const EdgeInsets.all(12),
    this.maxLength,
    this.forceUpperCase = false,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
        if (widget.label != null) const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.isEnabled,
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          inputFormatters: widget.forceUpperCase
              ? [
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return newValue.copyWith(text: newValue.text.toUpperCase());
                  })
                ]
              : null,
          decoration: InputDecoration(
            counter: const SizedBox(),
            fillColor: Get.theme.primaryColor.withOpacity(.1),
            filled: true,
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            hintText: widget.hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            contentPadding: widget.contentPadding,
            prefixIcon: widget.prefix,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? FluentIcons.eye_24_regular
                          : FluentIcons.eye_off_24_regular,
                      color: Get.theme.unselectedWidgetColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : (widget.suffix != null
                    ? IconButton(
                        icon: widget.suffix!,
                        onPressed: widget.onSuffixIconTap,
                      )
                    : null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? Get.theme.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
