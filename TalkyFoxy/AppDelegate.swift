//
//  AppDelegate.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()
    
    let callManager = CallManager()
    var providerDelegate: ProviderDelegate!
    
    class var shared: AppDelegate {
      return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        providerDelegate = ProviderDelegate(callManager: callManager)
        
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        return true
    }
    
    func displayIncomingCall(
      uuid: UUID,
      handle: String = "Foxy",
      hasVideo: Bool = false,
      completion: ((Error?) -> Void)?
    ) {
      providerDelegate.reportIncomingCall(
        uuid: uuid,
        handle: handle,
        hasVideo: hasVideo,
        completion: completion)
    }
}

