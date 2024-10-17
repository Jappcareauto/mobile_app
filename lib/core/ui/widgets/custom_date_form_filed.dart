import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomDateFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;

  CustomDateFormField({
    this.controller,
    this.label,
    this.validator,
  });

  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
        if (label != null) const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                controller: dayController,
                keyboardType: TextInputType.number,
                hintText: 'Day',
                validator: validator,
                maxLength: 2,
                onChanged: (_) => controller?.text =
                    '${yearController.text}-${monthController.text}-${dayController.text}',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomFormField(
                controller: monthController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                hintText: 'Month',
                validator: validator,
                onChanged: (_) => controller?.text =
                    '${yearController.text}-${monthController.text}-${dayController.text}',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomFormField(
                controller: yearController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                hintText: 'Year',
                validator: validator,
                onChanged: (_) => controller?.text =
                    '${yearController.text}-${monthController.text}-${dayController.text}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
