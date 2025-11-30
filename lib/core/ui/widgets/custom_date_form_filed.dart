import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomDateFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? datehintstyle;
  final String? label;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final void Function()? onTap;
  final void Function()? onDayTap;
  final void Function()? onMonthTap;
  final void Function()? onYearTap;

  const CustomDateFormField({
    super.key,
    this.controller,
    this.label,
    this.validator,
    this.datehintstyle,
    this.readOnly,
    this.onTap,
    this.onDayTap,
    this.onMonthTap,
    this.onYearTap,
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
    if (widget.controller != null) {
      final date = widget.controller!.text;
      final parts = date.split('-');
      if (parts.length == 3) {
        dayController.text = parts[2];
        monthController.text = parts[1];
        yearController.text = parts[0];
      }
    }
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller != null) {
        final date = widget.controller!.text;
        final parts = date.split('-');
        if (parts.length == 3) {
          dayController.text = parts[2];
          monthController.text = parts[1];
          yearController.text = parts[0];
        }
      }
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomFormField(
                hintStyleColor: widget.datehintstyle,
                controller: dayController,
                keyboardType: TextInputType.number,
                readOnly: widget.readOnly,
                onTap: widget.onDayTap ?? widget.onTap,
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
                  readOnly: widget.readOnly,
                  onTap: widget.onMonthTap ?? widget.onTap,
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
                  readOnly: widget.readOnly,
                  onTap: widget.onYearTap ?? widget.onTap,
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
