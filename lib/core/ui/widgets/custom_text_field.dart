import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_dimensions.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? hintStyleColor;
  final String? label;
  final FocusNode? focusNode;
  final String? hintText;
  final String? helperText;
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
  final int? maxLine;
  final Color? filColor;
  const CustomFormField({
    super.key,
    this.controller,
    this.filColor,
    this.label,
    this.maxLine,
    this.hintText,
    this.helperText,
    this.isPassword = false,
    this.isEnabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
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
    this.hintStyleColor,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = false;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.isPassword;

    // Listen for focus changes
    _focusNode.addListener(() {
      setState(() {}); // Rebuild the widget when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
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
          focusNode: _focusNode,
          maxLines: widget.maxLine ?? 1,
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
            fillColor: isFocused
                ? Get.theme.primaryColor
                    .withValues(alpha: .1) // Primary color when focused
                : Colors.white, // White when not focused
            counter: const SizedBox(),
            filled: true,
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            hintText: widget.hintText,
            helperText: widget.helperText,
            errorStyle: const TextStyle(color: Color(0XFFFF553B)),
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.hintStyleColor,
                ),
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
              borderSide: const BorderSide(color: Color(0xFFE5E2E1)),
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
