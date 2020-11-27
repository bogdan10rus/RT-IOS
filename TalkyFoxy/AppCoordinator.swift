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
        
        coordinate(to: tasksListCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
        
        tabBarController.viewControllers = [tasksListNavigationController]

        return Observable.never()
    }
}

