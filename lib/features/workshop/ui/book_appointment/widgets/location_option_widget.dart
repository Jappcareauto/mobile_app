import 'package:flutter/material.dart';

class LocationOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationOption({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.orange.withValues(alpha: .2) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey,
          ),
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(icon, color: isSelected ? Colors.orange : Colors.black),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.orange : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
