import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomDateFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? datehintstyle;
  final String? label;
  final String? Function(String?)? validator;

  const CustomDateFormField({
    super.key,
    this.controller,
    this.label,
    this.validator,
    this.datehintstyle,
  });

  @override
  State<CustomDateFormField> createState() => _CustomDateFormFieldState();
}

class _CustomDateFormFieldState extends State<CustomDateFormField> {
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                hintStyleColor: widget.datehintstyle,
                controller: dayController,
                keyboardType: TextInputType.number,
                hintText: 'Day',
                validator: (p0) =>
                    (int.tryParse(p0 ?? '0') ?? 0) > 31 ? "Invalid Day" : null,
                maxLength: 2,
                onChanged: (value) {
                  dayController.text = value;
                  widget.controller?.text =
                      '${yearController.text}-${monthController.text}-${dayController.text}';
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomFormField(
                  hintStyleColor: widget.datehintstyle,
                  controller: monthController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  hintText: 'Month',
                  validator: (p0) => (int.tryParse(p0 ?? '0') ?? 0) > 12
                      ? "Invalid Month"
                      : null,
                  onChanged: (value) {
                    monthController.text = value;
                    widget.controller?.text =
                        '${yearController.text}-${monthController.text}-${dayController.text}';
                  }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomFormField(
                  hintStyleColor: widget.datehintstyle,
                  controller: yearController,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  hintText: 'Year',
                  validator: (p0) =>
                      ((int.tryParse(p0 ?? '0') ?? 0) > DateTime.now().year ||
                              (int.tryParse(p0 ?? '0') ?? 0) <
                                  (DateTime.now().year - 100))
                          ? "Invalid Year"
                          : null,
                  onChanged: (value) {
                    yearController.text = value;
                    widget.controller?.text =
                        '${yearController.text}-${monthController.text}-${dayController.text}';
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
