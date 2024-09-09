import UIKit
import Flutter
import GoogleMaps
import FirebaseCore



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
     UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       }
    GMSServices.provideAPIKey("AIzaSyCv_XLgyHqS2JvGPGWVyttaSU_SlbNDoA0")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
