import UIKit
import Flutter
// import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // let mapsKey: String? = Bundle.main.object(forInfoDictionaryKey:"googleMapsApiKey") as? String

    // GMSServices.provideAPIKey(mapsKey ?? "")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
