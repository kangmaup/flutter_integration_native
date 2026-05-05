import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let callChannel = FlutterMethodChannel(
      name: "voip.method.channel",
      binaryMessenger: engineBridge.applicationRegistrar.messenger())

    callChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "makeCall" {
        if let args = call.arguments as? [String: Any],
           let phoneNumber = args["phoneNumber"] as? String {
          print("mau nelpon ke: \(phoneNumber)")
          if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print("Mantap Jadi, berhasil nelpon ke: \(phoneNumber)")
            result(true)
          } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Cannot make a call", details: nil))
          }
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Phone number is required", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
  }
}
