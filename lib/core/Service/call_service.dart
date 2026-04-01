import 'package:flutter/services.dart';

class CallService {
  static const MethodChannel _channel = MethodChannel('voip.method.channel');

  Future<void> makeCall(String phoneNumber) async {
    try {
      await _channel.invokeMethod('makeCall', {'phoneNumber': phoneNumber});
    } on PlatformException catch (e) {
      print("Failed to make call: '${e.message}'.");
    }
  }
}
