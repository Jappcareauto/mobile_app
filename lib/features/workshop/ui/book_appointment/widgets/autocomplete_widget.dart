import 'package:flutter/material.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';

class AutocompleteField extends StatelessWidget {
  final String? hintText;
  final List<PlacePrediction> predictions;
  final Function(String) onSelected;
  final Function(String) onChanged;
  final TextEditingController controller;

  const AutocompleteField(
      {super.key,
      this.hintText,
      required this.onSelected,
      required this.predictions,
      required this.controller,
      required this.onChanged});

  // void _onChanged(String input) {
  //   _debounce?.cancel();
  //   if (input.isEmpty) {
  //     setState(() => _predictions = []);
  //     return;
  //   }
  //   _debounce = Timer(const Duration(milliseconds: 300), () async {
  //     final results = await fetchAutocomplete(input);
  //     setState(() => _predictions = results);
  //   });
  // }

  // @override
  // void dispose() {
  //   _debounce?.cancel();
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(hintText: hintText ?? 'Search address'),
        ),
        // 5.2 Suggestions dropdown
      ],
    );
  }
}
