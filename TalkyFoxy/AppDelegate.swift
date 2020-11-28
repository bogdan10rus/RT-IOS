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
        
        setupAppearance()
        
        return true
    }
    

    private func setupAppearance() {
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1490196078, alpha: 1)
        UITabBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
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

