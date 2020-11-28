//
//  BotCoordinator.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import RxSwift

class BotCoordinator: Coordinator<Void> {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = BotViewModel()
        let viewController = BotView(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
}
