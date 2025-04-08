import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';

/// Service for detecting shake gestures using the device's accelerometer.
class ShakeService {
  /// The threshold value for detecting a shake gesture. If the acceleration
  /// exceeds this value, it is considered a shake.
  static const double shakeThreshold = 12.0;

  /// The delay (in milliseconds) between detecting consecutive shakes.
  static const int shakeDelay = 1000;

  /// A subscription to the accelerometer events.
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  /// The time of the last detected shake gesture.
  DateTime _lastShakeTime = DateTime.now();

  /// Starts listening for shake gestures and triggers the [onShake] callback
  /// when a shake gesture is detected.
  ///
  /// [onShake] is the callback that gets triggered after shake is detected.
  void startListening(void Function() onShake) {
    _accelerometerSubscription = accelerometerEvents.listen((
      AccelerometerEvent event,
    ) {
      double acceleration = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );

      if (acceleration > shakeThreshold) {
        final DateTime now = DateTime.now();
        if (now.difference(_lastShakeTime).inMilliseconds > shakeDelay) {
          _lastShakeTime = now;
          onShake();
        }
      }
    });
  }

  /// Stops listening for shake gestures.
  void stopListening() {
    _accelerometerSubscription?.cancel();
  }
}
