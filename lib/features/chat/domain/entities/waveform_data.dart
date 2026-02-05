import 'dart:typed_data';

class WaveformData {
  final Float32List samples;
  final int sampleRate;
  final Duration duration;
  final double maxAmplitude;
  final double minAmplitude;

  WaveformData({
    required this.samples,
    required this.sampleRate,
    required this.duration,
    required this.maxAmplitude,
    required this.minAmplitude,
  });

  /// Get normalized samples between 0 and 1
  List<double> getNormalizedSamples({int? count}) {
    final result = <double>[];
    final step = count != null ? samples.length / count : 1;

    for (var i = 0.0; i < samples.length; i += step) {
      final index = i.floor();
      if (index >= samples.length) break;
      final sample = samples[index];
      final normalized =
          (sample - minAmplitude) / (maxAmplitude - minAmplitude);
      result.add(normalized);
    }

    return result;
  }

  /// Create a WaveformData instance from raw PCM samples
  static WaveformData? fromPcmSamples({
    required Float32List samples,
    required int sampleRate,
    required Duration duration,
  }) {
    if (samples.isEmpty) return null;

    double maxAmp = samples[0];
    double minAmp = samples[0];

    for (final sample in samples) {
      if (sample > maxAmp) maxAmp = sample;
      if (sample < minAmp) minAmp = sample;
    }

    return WaveformData(
      samples: samples,
      sampleRate: sampleRate,
      duration: duration,
      maxAmplitude: maxAmp,
      minAmplitude: minAmp,
    );
  }
}

class WaveformProcessor {
  /// Process audio file to generate waveform data
  static Future<WaveformData?> processAudio({
    required String path,
    required int samplingRate,
    required int samplingFrameLength,
  }) async {
    try {
      // TODO: Implement audio processing using FFT or similar technique
      // For now, return dummy data for testing
      final dummyData = Float32List.fromList(List.generate(
        100,
        (i) => (i % 2 == 0 ? 1.0 : -1.0) * (i / 100),
      ));

      return WaveformData(
        samples: dummyData,
        sampleRate: samplingRate,
        duration: const Duration(seconds: 1),
        maxAmplitude: 1.0,
        minAmplitude: -1.0,
      );
    } catch (e) {
      return null;
    }
  }
}
