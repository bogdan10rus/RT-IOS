//
//  AppCoordinator.swift
//  TalkyFoxy
//
//  Created by Egor on 27.11.2020.
//

import RxSwift

class AppCoordinator: Coordinator<Void> {
    private let window: UIWindow
    private let tabBarController = UITabBarController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        
        let tasksListNavigationController = UINavigationController()
        let tasksListCoordinator = TasksListCoordinator(navigationController: tasksListNavigationController)
        
        let dictionaryNavigationController = UINavigationController()
        let dictionaryCoordinator = DictionaryCoordinator(navigationController: dictionaryNavigationController)
        
        let botNavigationController = UINavigationController()
        let botCoordinator = BotCoordinator(navigationController: botNavigationController)
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        
        coordinate(to: tasksListCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
        
        coordinate(to: dictionaryCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
        
        coordinate(to: botCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
        
        coordinate(to: profileCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
        
        tabBarController.viewControllers = [
            tasksListNavigationController,
            dictionaryNavigationController,
            botNavigationController,
            profileNavigationController]

        return Observable.never()
    }
}

