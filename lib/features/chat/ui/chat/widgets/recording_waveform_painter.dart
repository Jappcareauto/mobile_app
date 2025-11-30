import 'dart:math';

import 'package:flutter/material.dart';

/// Painter that draws a WhatsApp-like discrete vertical bars waveform.
///
/// Expects `waveformPoints` values in the range 0..1. Applies a perceptual
/// scaling (gamma) to make peaks more visible. Draws background bars using
/// [secondaryColor] then overlays a clipped foreground using [primaryColor]
/// according to [progress] (0..1).
class RecordingWaveformPainter extends CustomPainter {
  final List<double> waveformPoints;
  final double progress; // 0..1
  final Color primaryColor;
  final Color secondaryColor;
  final double animationValue; // 0..1, for subtle pulse if desired
  final bool isPlaying;

  /// Gamma used to perceptually scale linear amplitudes. Values <1 boost low
  /// amplitudes (e.g. 0.6..0.8). Set to 1.0 for linear mapping.
  final double gamma;

  const RecordingWaveformPainter({
    required this.waveformPoints,
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    this.animationValue = 0.0,
    this.isPlaying = false,
    this.gamma = 0.7,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (waveformPoints.isEmpty) return;

    final n = waveformPoints.length;
    // Visual parameters
    final gap = 2.0; // px gap between bars
    final totalGap = gap * (n - 1);
    final barWidth = max(1.0, (size.width - totalGap) / n);
    final radius = Radius.circular(barWidth / 2);

    // Precompute scaled heights (0..1) using perceptual gamma
    final scaled = waveformPoints.map((v) {
      final clamped = v.clamp(0.0, 1.0);
      // Apply gamma curve
      return pow(clamped, gamma).toDouble();
    }).toList(growable: false);

    final centerY = size.height / 2;

    final paintBg = Paint()..color = secondaryColor;
    final paintFg = Paint()..color = primaryColor;

    // Draw background bars
    for (var i = 0; i < n; i++) {
      final x = i * (barWidth + gap);
      final h = scaled[i] * size.height * 0.9; // keep a little vertical padding
      final rect = Rect.fromLTWH(x, centerY - h / 2, barWidth, h);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paintBg);
    }

    // Draw foreground clipped by progress
    final prog = progress.clamp(0.0, 1.0);
    if (prog > 0) {
      canvas.save();
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width * prog, size.height));

      // Slight pulse when recording (optional subtle alpha change)
      final alphaBoost = (0.15 * animationValue).clamp(0.0, 0.3);
      paintFg.color =
          primaryColor.withOpacity((1.0 - alphaBoost).clamp(0.25, 1.0));

      for (var i = 0; i < n; i++) {
        final x = i * (barWidth + gap);
        final h = scaled[i] * size.height * 0.9;
        final rect = Rect.fromLTWH(x, centerY - h / 2, barWidth, h);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paintFg);
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant RecordingWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.isPlaying != isPlaying ||
        oldDelegate.waveformPoints != waveformPoints ||
        oldDelegate.gamma != gamma ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor;
  }
}
