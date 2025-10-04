import 'package:flutter/material.dart';

class LocationPermissionPlaceholder extends StatelessWidget {
  final VoidCallback? onRequestPermission;
  final Color primaryColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;

  const LocationPermissionPlaceholder({
    super.key,
    this.onRequestPermission,
    this.primaryColor = const Color(0xFF2196F3),
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated location icon with pulsing effect
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 0.9 + (0.1 * value),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: .1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on_rounded,
                            size: 32,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onEnd: () {
                  // Loop the animation
                },
              ),
              SizedBox(height: 20),
              // Title
              Text(
                'Location Access Required',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 14),
              // Description
              Text(
                'To show your location on the map, we need access to your device\'s location services.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              // Request permission button
              if (onRequestPermission != null) ...[
                SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: onRequestPermission,
                  icon: const Icon(Icons.location_on, size: 20),
                  label: const Text(
                    'Enable Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),

                SizedBox(height: 8),
                // Privacy note
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Your privacy is important to us',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
