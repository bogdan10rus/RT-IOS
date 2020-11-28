//
//  DictionaryCoordinator.swift
//  TalkyFoxy
//
//  Created by Bogdan on 27.11.2020.
//

import RxSwift

class DictionaryCoordinator: Coordinator<Void> {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = DictionaryViewModel()
        let viewController = DictionaryView(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
}
