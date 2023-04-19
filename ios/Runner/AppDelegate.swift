import UIKit
import Flutter
import NetworkExtension
import os

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let vpnManagerChannel = FlutterMethodChannel.init(name: "com.sail_tunnel.sail/vpn_manager",
                                                   binaryMessenger: controller.binaryMessenger);
    let manager = VPNManager.shared()

    vpnManagerChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

        switch call.method {
        case "toggle":
            manager.loadVPNPreference() { error in
                guard error == nil else {
                    fatalError("load VPN preference failed: \(error.debugDescription)")
                }

                manager.enableVPNManager() { error in
                    guard error == nil else {
                        fatalError("enable VPN failed: \(error.debugDescription)")
                    }
                    manager.toggleVPNConnection() { error in
                        guard error == nil else {
                            fatalError("toggle VPN connection failed: \(error.debugDescription)")
                        }
                    }
                }
            }

            result(true)
            break
        case "getStatus":
            let status = manager.getStatus()
            
            switch status {
            case NEVPNStatus.disconnected:
                result(0)
            case NEVPNStatus.connecting:
                result(1)
            case NEVPNStatus.reasserting:
                result(4)
            case NEVPNStatus.disconnecting:
                result(5)
            case NEVPNStatus.connected:
                result(2)
            default:
                result(3)
            }
            
            break
        case "getConnectedDate":
            let connectedDate = manager.getConnectedDate()
            
            result(connectedDate?.timeIntervalSince1970)
            break
        case "getTunnelLog":
            let fm = FileManager.default

            guard let conf = fm.leafLogFile?.contents else {
                fatalError("get leaf log file contents fail")
            }
            
            result(conf)
            break
        case "getTunnelConfiguration":
            LeafAdapater.shared().getRuntimeConfiguration { conf in
                guard conf != nil else {
                    fatalError("get runtime VPN configuratioin failed")
                }
                
                result(conf)
            }
            break
        case "setTunnelConfiguration":
            guard let conf = call.arguments as? String else {
                fatalError("call arguments is empty")
            }
            LeafAdapater.shared().setRuntimeConfiguration(conf: conf) { error in
                guard error == nil else {
                    fatalError("set runtime configuration failed: \(error.debugDescription)")
                }
            }
        case "update":
            guard let conf = call.arguments as? String else {
                fatalError("call arguments is empty")
            }
            
            LeafAdapater.shared().update(conf: conf) { error in
                guard error == nil else {
                    fatalError("update tunnel failed: \(error.debugDescription)")
                }
            }
        default:
            result(FlutterMethodNotImplemented)
            return
        }
      })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
