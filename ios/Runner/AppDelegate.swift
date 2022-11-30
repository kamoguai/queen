import UIKit
import Flutter
import live_flutter_plugin
import tencent_effect_flutter;



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      let instanse = XmagicProcesserFactory.init()
      TXLivePluginManager.register(customBeautyProcesserFactory: instanse)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
